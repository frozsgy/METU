import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class SIS {
    private static String fileSep = File.separator;
    private static String lineSep = System.lineSeparator();
    private static String space = " ";

    private List<Student> studentList = new ArrayList<>();

    public SIS() {
        processOptics();
    }

    private void processOptics() {
        // This method gets the list of files under the input folder
        // and then parses each input file to read them as optics.
        Stream<Path> paths = null;
        try {
            // try to reach the input folder, if else fail silently
            paths = Files.list(Paths.get("input"));
        } catch (IOException ignored) {
        }
        // if the path is not null, that means the folder exists
        // this part was required to overcome possible null pointer exceptions
        assert paths != null;
        // parse the stream
        paths.forEach(p -> {
                    try {
                        // the following line may throw an IO error, thus the try block was required
                        List<String> student = Files.lines(p).collect(Collectors.toList());
                        // since the optics have a specific format, I parse them line-by-line.
                        String[] id = student.get(0).split(space);
                        String[] semester = student.get(1).split(space);
                        String[] type = student.get(2).split(space);
                        String[] answers = student.get(3).split(space);

                        // Parse fields related to the identity of the student
                        int studentId = Integer.parseInt(id[id.length - 1]);
                        String lastName = id[id.length - 2];
                        // since a student might have more than a name, I had to trim the id array accordingly.
                        String[] names = Arrays.stream(id).limit(id.length - 2).toArray(String[]::new);

                        // if a student with the same student id has already been added to the studentList,
                        // we do not need to add them to the list. to ensure that, I implemented a count check.
                        long count = studentList.stream().filter(e -> e.getStudentID() == studentId).count();
                        Student currentStudent;
                        if (count == 0) {
                            // insert student
                            currentStudent = new Student(names, lastName, studentId);
                            studentList.add(currentStudent);
                        } else {
                            // get student object
                            currentStudent = studentList.stream().filter(e -> e.getStudentID() == studentId).limit(1)
                                    .collect(Collectors.toList()).get(0);
                        }

                        // Parse course details
                        int courseCode = Integer.parseInt(semester[1]);
                        int year = Integer.parseInt(semester[0]);
                        int credit = Integer.parseInt(semester[2]);

                        // Parse answers
                        // by counting the T, E and F fields, it is possible to know the grade.
                        long trueCount = answers[0].chars().map(e -> (char) e).filter(e -> e == 'T').count();
                        long falseCount = answers[0].chars().map(e -> (char) e).filter(e -> e == 'F').count();
                        long emptyCount = answers[0].chars().map(e -> (char) e).filter(e -> e == 'E').count();
                        // first I calculate how many points each question makes, then multiple the correct ones with
                        // that value to generate the grade of the student.
                        double perQuestion = 100.0 / (trueCount + falseCount + emptyCount);
                        double grade = perQuestion * trueCount;

                        // after calculation, I create the Course object with the calculated and parsed values,
                        // and add it to the taken courses list.
                        Course c = new Course(courseCode, year, type[0], credit, grade);
                        currentStudent.getTakenCourses().add(c);
                    } catch (IOException ignored) {
                    }
                }
        );

    }

    public double getGrade(int studentID, int courseCode, int year) {
        /*
        Returns student’s overall grade for the course offered in the year. The overall grade is
        0.25 x Midterm1 + 0.25 x Midterm2 + 0.5 x Final.
        Example Returned Double Value:  72.5
         */

        // To get the grade of a specific student, I first need the student object.
        // I used a filter to match the student ID and then get the student object through this stream.
        Student currentStudent = studentList.stream().filter(e -> e.getStudentID() == studentID).limit(1)
                .collect(Collectors.toList()).get(0);
        // By filtering the taken courses of the student according to the course code, I was able to get
        // a stream that includes all copies of the course id.
        Stream<Course> courseStream = currentStudent.getTakenCourses().stream()
                .filter(e -> e.getCourseCode() == courseCode).filter(e -> e.getYear() == year);
        // I filter the stream to match the exam types with Midterm*. Since each midterm has 0.25 points,
        // summing them and multiplying with 0.25 was enough.
        double mtSum = courseStream.filter(e -> e.getExamType().startsWith("Midterm"))
                .map(Course::getGrade).reduce(0.0, Double::sum);
        // Since reduce consumes the stream, I had to recreate the stream to get the final grade.
        courseStream = currentStudent.getTakenCourses().stream().filter(e -> e.getCourseCode() == courseCode)
                .filter(e -> e.getYear() == year);
        // I filter the stream to match the exam type with Final this time.
        double finalResult = courseStream.filter(e -> e.getExamType().equals("Final")).map(Course::getGrade)
                .reduce(0.0, Double::sum);
        // Return the calculated value as the grade.
        return mtSum * 0.25 + finalResult * 0.5;
    }

    public void updateExam(int studentID, int courseCode, String examType, double newGrade) {
        /*
        Updates student’s exam. Other method calls should be affected after calling this method (i.e., the old grade
        is not considered anymore). The student can take the same course in different years. If that is the case,
        the most recent one’s exam grade will be updated.
         */

        // To update the grade of a specific student, I first need the student object.
        // I used a filter to match the student ID and then get the student object through this stream.
        Student currentStudent = studentList.stream().filter(e -> e.getStudentID() == studentID).limit(1)
                .collect(Collectors.toList()).get(0);
        // Afterwards, I filter the taken courses stream with the course code, exam type. And then I sort the exams
        // according to the year, descending. Finally, I limit the size to 1 to update the very recent one only.
        // Then, I update the grade accordingly.
        currentStudent.getTakenCourses().stream().filter(e -> e.getCourseCode() == courseCode)
                .filter(e -> e.getExamType().equals(examType)).sorted((e1, e2) -> e2.getYear() - e1.getYear()).limit(1)
                .forEach(course -> course.setGrade(newGrade));
    }

    public void createTranscript(int studentID) {
        /*
        Prints the transcript of the student.
        Example Output (separated by a space; sorted by a year then a course code):
        20101
        2360119 DD
        5710111 AA
        20102
        2360119 BB
        2360120 CB
        ...
        20132
        5710492 BA
        CGPA: 3.52
        For score to letter grade conversion (i.e., 92 → AA), use our university’s  course credit system. CGPA
        calculation is basically weighted average of 2 letter grades where the weights are the course credits. Finally,
        if the student took the same course before, only the most recent one contributes to the CGPA calculation.
         */

        // I created the array of letter grades and their weight values to use while calculating the letter grades
        // which I will use by applying an integer division to grade by 5.
        String[] letterGrades = {"FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FD", "FD", "DD", "DC", "CC", "CB", "BB", "BA", "AA", "AA"};
        double[] letterGradesWeight = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.0};
        // To update the grade of a specific student, I first need the student object.
        // I used a filter to match the student ID and then get the student object through this stream.
        Student currentStudent = studentList.stream().filter(e -> e.getStudentID() == studentID).limit(1)
                .collect(Collectors.toList()).get(0);
        // To generate a transcript, I get all the enrolled semesters of the student. I achieved this through using
        // distinct on the year value of the courses, and then I sorted them.
        Stream<Integer> semesters = currentStudent.getTakenCourses().stream().map(Course::getYear).distinct().sorted();

        // Afterwards, I mapped each semester to the <SEMESTER>\n<GRADES-STREAM> format.
        // The <GRADES-STREAM> format is calculated through filtering the taken courses of the student using the year,
        // and then taking each distinct course code value, and then mapping this to the letter grade value,
        // which is calculated using the getGrade method, and mapped to the respective letter grade by using the array.
        // I used a rounding, and then integer division to get the array indices.
        // Finally, I append a newline character to each course, and then print them.
        semesters.map(
                e -> e + "\n" + currentStudent.getTakenCourses().stream().filter(f -> f.getYear() == e)
                        .map(Course::getCourseCode).distinct().sorted()
                        .map(f -> f + " " + letterGrades[(int) (Math.round(getGrade(studentID, f, e)) / 5)] + "\n")
                        .collect(Collectors.joining()))
                .forEach(System.out::print);

        // After completing the transcript print step, I needed to calculate the CGPA of the student.
        // For that, I first get the taken courses sorted by year from the most recent to the oldest one.
        // After getting the distinct course codes, I get the most recently taken version of each course,
        // and then use the course code to calculate letter grade, and use the weight of this grade to multiply it
        // by the credit to calculate the total value of this course.
        // Finally I sum all these values to get the total weighted grades sum.

        double sumCredits = currentStudent.getTakenCourses().stream().sorted((e1, e2) -> e2.getYear() - e1.getYear())
                .map(Course::getCourseCode).distinct()
                .map(e -> currentStudent.getTakenCourses().stream().sorted((e1, e2) -> e2.getYear() - e1.getYear())
                        .filter(f -> f.getCourseCode() == e).limit(1)
                        .map(g -> letterGradesWeight[(int) (Math.round(getGrade(studentID, e, g.getYear())) / 5)] * g.getCredit())
                        .reduce(0.0, Double::sum)).reduce(0.0, Double::sum);


        // To calculate the CGPA, I need to know the total sum of credits taken. To achieve this, I get taken courses
        // of a student, and apply a distinct filter. Afterwards, I limit each course to a single entry
        // to avoid having multiple copies due to different exams. And finally I map each course to its credit,
        // and sum them using a reduce to get the total credits value.
        int totalCredits = currentStudent.getTakenCourses().stream().map(Course::getCourseCode).distinct()
                .map(e -> currentStudent.getTakenCourses().stream().filter(f -> f.getCourseCode() == e).limit(1)
                        .map(Course::getCredit).reduce(0, Integer::sum))
                .reduce(0, Integer::sum);

        // By dividing each value, I get the CGPA and print accordingly.
        double gpa = sumCredits / totalCredits;
        System.out.printf("CGPA: %.2f\n", gpa);
    }

    public void findCourse(int courseCode) {
        /*
        Prints the years when the course was offered as well as the number of registered students.
        Example Output (separated by a space; sorted by a year):
        20181 44
        20182 40
        20191 51
         */


        // First I generate a student stream using the student list.
        Stream<Student> studentStream = studentList.stream();

        // From the student stream, I get taken courses of each student, and then filter using the course code and exam
        // type "Final" to avoid having 3 copies for each student. After that, I collect each students count as a List.
        // Finally, I flatten the stream to have a stream that holds values similar to the following:
        // 20201 20201 20191 20181 20201
        // And then I collect this stream to a list, to avoid recreating this stream while counting occurrences.

        List<Integer> years = studentStream.map(e ->
                e.getTakenCourses().stream()
                        .filter(f -> f.getCourseCode() == courseCode)
                        .filter(f -> f.getExamType().equals("Final"))
                        .map(Course::getYear).collect(Collectors.toList()))
                .flatMap(Collection::stream).collect(Collectors.toList());

        // I convert the list of years to a stream, get distinct elements, sort, and then map each year to the count
        // for each year using the same list. Finally print the registered values for each year.
        years.stream().distinct().sorted()
                .map(e -> e + " " + years.stream().filter(f -> f.equals(e)).count())
                .forEach(System.out::println);
    }

    public void createHistogram(int courseCode, int year) {
        /*
        Prints the grade histogram of the registered students in the course offered in the year.
        Example Output (separated by a space; sorted by a bin value):
        0-10 0
        10-20 5
        20-30 2
        30-40 3
        40-50 1
        50-60 10
        60-70 3
        70-80 6
        80-90 1
        90-100 2
        The former value in the bin value is inclusive, while the latter is exclusive.
        As an example, 10-20 means [10, 20).
         */


        // I stored the labels of the bins as a String array for ease of use.
        String[] labels = {"0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", "80-90", "90-100"};

        // First I generate a student stream using the student list.
        Stream<Student> studentStream = studentList.stream();

        // After that, I mapped each student to the bin that they are in. To achieve this,
        // I created a stream of taken courses for that student, then filtered the stream by year and course code,
        // and limit this stream by 1 to remove multiple copies due to different exams. If this stream produces 1
        // element only, that means the student has taken that course. In that case, I map that student to the bin.
        // If the count is 0, I map the student to an empty string, which will be removed later.
        Stream<String> bins = studentStream.map(e -> {
                    if (e.getTakenCourses().stream().filter(f -> f.getYear() == year)
                            .filter(f -> f.getCourseCode() == courseCode).limit(1).count() == 1) {
                        double grade = getGrade(e.getStudentID(), courseCode, year);
                        return labels[(int) grade / 10];
                    } else {
                        return "";
                    }
                }
        );

        // Then, I concatenate the bins stream and a stream of labels, to ensure that each bin exists in the stream once.
        List<String> binsList = Stream.concat(Arrays.stream(labels), bins).collect(Collectors.toList());

        // Later, I get distinct elements from the stream, sort them, and remove empty strings.
        // Afterwards, I map each label to the count of the student in the bin, and subtract 1 due to 1-based indexing
        // that I achieved at the previous step. Finally, I print everthing.
        binsList.stream().distinct().sorted().filter(e -> !e.equals(""))
                .map(e -> e + " " + (binsList.stream().filter(f -> f.equals(e)).count() - 1))
                .forEach(System.out::println);


    }

}