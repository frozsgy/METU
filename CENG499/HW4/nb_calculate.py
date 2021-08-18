from nb import *


def read_file(file_name):
    with open(file_name) as f:
        return map(lambda x: x.replace('\n', ''), f.readlines())


def cleanup(data):
    # 65-90, 97-122
    # TODO -- the following might be a bit costly, idk, to check
    word_list = data.split()
    ascii_filter = lambda x: 64 < ord(x) < 91 or 96 < ord(x) < 123
    empty_and_vocab_filter = lambda x: x != ''
    return list(filter(empty_and_vocab_filter, [''.join(filter(ascii_filter, word)) for word in word_list]))


def run_nb():
    from datetime import datetime
    start = datetime.now()
    print(f"Started at: {start}")
    print("Reading files...")
    train_data = read_file('hw4_data/sentiment/train_data.txt')
    train_labels = list(read_file('hw4_data/sentiment/train_labels.txt'))
    test_data = read_file('hw4_data/sentiment/test_data.txt')
    test_labels = list(read_file('hw4_data/sentiment/test_labels.txt'))
    print("Reading files completed.")

    print("Applying cleanup...")
    train_data_cleaned = list(map(cleanup, train_data))
    test_data_cleaned = list(map(cleanup, test_data))
    print("Cleanup completed.")

    print("Generating vocabulary...")
    vocab = vocabulary(train_data_cleaned)
    print(f"Vocabulary with {len(vocab)} words created.")
    print("Estimating pi...")
    pi = estimate_pi(train_labels)
    print(f"Pi estimated: {pi}")
    print("Calculating theta...")
    theta = estimate_theta(train_data_cleaned, train_labels, vocab)
    print(f"Theta calculated.")
    test_results = test(theta, pi, vocab, test_data_cleaned)
    correct = 0
    for i, result in enumerate(test_results):
        r = sorted(result, reverse=True)
        if test_labels[i] == r[0][1]:
            correct += 1
    total = len(test_labels)
    print(f"Accuracy: {correct/total:.3f}")
    end = datetime.now()
    print(f"Ended at: {end}")
    print(f"Total time: {end - start}")


if __name__ == '__main__':
    run_nb()