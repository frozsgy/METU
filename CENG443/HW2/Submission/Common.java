package project.utility;


import project.parts.Base;
import project.parts.Part;

import java.lang.reflect.Field;
import java.util.Random;

public class Common {
    public static Random random = new Random();

    public static synchronized Object get(Object object, String fieldName) {
        // TODO
        // This function retrieves (gets) the private field of an object by using reflection
        // In case the function needs to throw an exception, throw this: SmartFactoryException( "Failed: get!" )

        // reflection examples modified from https://www.baeldung.com/java-reflection
        try {
            // try to get the field
            Field field = object.getClass().getDeclaredField(fieldName);
            field.setAccessible(true);
            return field.get(object);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            throw new SmartFactoryException("Failed: get!");
        }
    }

    public static synchronized void set(Object object, String fieldName, Object value) {
        // TODO
        // This function modifies (sets) the private field of an object by using reflection
        // In case the function needs to throw an exception, throw this: SmartFactoryException( "Failed: set!" )

        // reflection examples modified from https://www.baeldung.com/java-reflection
        try {
            // try to set the field to the given value
            Field field = object.getClass().getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(object, value);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            throw new SmartFactoryException("Failed: set!");
        }
    }

    public static Base baseFactory(int nextSerialNo) {
        // Factory that generates a new base and returns that base
        return new Base(nextSerialNo);
    }

    public static Part partFactory(String name) throws Exception {
        // Since Class.forName works with fully-qualified names, I had to hardcode the package information as below.
        String prefix = "project.parts.";
        switch (name) {
            case "Builder":
            case "Fixer":
            case "Inspector":
            case "Supplier":
            case "Logic":
                prefix += "logics.";
                break;
            case "Camera":
            case "Gripper":
            case "MaintenanceKit":
            case "Welder":
            case "Payload":
                prefix += "payloads.";
                break;
        }

        // Return a new instance of the part
        // the following lines can throw 5 different exceptions, and they are caught in the callee
        // in the Factory.java file.
        Class<?> namedClass = Class.forName(prefix + name);
        return (Part) namedClass.getConstructor().newInstance();

    }


}