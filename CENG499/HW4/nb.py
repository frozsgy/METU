from math import log


def vocabulary(data):
    """
    Creates the vocabulary from the data.
    :param data: List of lists, every list inside it contains words in that sentence.
                 len(data) is the number of examples in the data.
    :return: Set of words in the data
    """
    return set([y for x in data for y in x])
    

def estimate_pi(train_labels):
    """
    Estimates the probability of every class label that occurs in train_labels.
    :param train_labels: List of class names. len(train_labels) is the number of examples in the training data.
    :return: pi. pi is a dictionary. Its keys are class names and values are their probabilities.
    """
    pi = dict()
    total = len(train_labels)
    for label in train_labels:
        current = pi.get(label, 0)
        pi[label] = current + 1
    for key, value in pi.items():
        pi[key] = value / total
    return pi
    
    
def estimate_theta(train_data, train_labels, vocab):
    """
    Estimates the probability of a specific word given class label using additive smoothing with smoothing constant 1.
    :param train_data: List of lists, every list inside it contains words in that sentence.
                       len(train_data) is the number of examples in the training data.
    :param train_labels: List of class names. len(train_labels) is the number of examples in the training data.
    :param vocab: Set of words in the training set.
    :return: theta. theta is a dictionary of dictionaries. At the first level, the keys are the class names. At the
             second level, the keys are all the words in vocab and the values are their estimated probabilities given
             the first level class name.
    """
    smoothing_constant = 1
    word_count = len(vocab)
    dp_occurrences = {}
    dp_all = {}
    theta_dict = {}
    for label in train_labels:
        filtered = map(lambda x: x[1], filter(lambda x: train_labels[x[0]] == label, enumerate(train_data)))
        filtered_list = list(filtered)
        temp_dict = {}
        for word in vocab:
            dp_key = f"{label}-{word}"
            if dp_key in dp_occurrences.keys():
                occurrences = dp_occurrences[dp_key]
            else:
                occurrences = sum(map(lambda x: x.count(word), filtered_list))
                dp_occurrences[dp_key] = occurrences
            if label in dp_all.keys():
                all_count = dp_all[label]
            else:
                all_count = sum(map(lambda x: len(x), filtered_list))
                dp_all[label] = all_count
            theta = (smoothing_constant + occurrences) / (word_count + all_count)
            temp_dict[word] = theta
        theta_dict[label] = temp_dict
    return theta_dict


def test(theta, pi, vocab, test_data):
    """
    Calculates the scores of a test data given a class for each class. Skips the words that are not occurring in the
    vocabulary.
    :param theta: A dictionary of dictionaries. At the first level, the keys are the class names. At the second level,
                  the keys are all of the words in vocab and the values are their estimated probabilities.
    :param pi: A dictionary. Its keys are class names and values are their probabilities.
    :param vocab: Set of words in the training set.
    :param test_data: List of lists, every list inside it contains words in that sentence.
                      len(test_data) is the number of examples in the test data.
    :return: scores, list of lists. len(scores) is the number of examples in the test set. Every inner list contains
             tuples where the first element is the score and the second element is the class name.
    """
    scores = []
    for data in test_data:
        filtered_words = list(filter(lambda x: x in vocab, data))
        scores_temp = []
        for pi_class in pi.keys():
            pi_value = pi[pi_class]
            theta_value = sum([log(theta[pi_class][word]) for word in filtered_words])
            scores_temp.append((log(pi_value) + theta_value, pi_class))
        scores.append(scores_temp)
    return scores

