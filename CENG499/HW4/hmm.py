import numpy as np


def forward(A, B, pi, O):
    """
    Calculates the probability of an observation sequence O given the model(A, B, pi).
    :param A: state transition probabilities (NxN)
    :param B: observation probabilities (NxM)
    :param pi: initial state probabilities (N)
    :param O: sequence of observations(T) where observations are just indices for the columns of B (0-indexed)
        N is the number of states,
        M is the number of possible observations, and
        T is the sequence length.
    :return: The probability of the observation sequence and the calculated alphas in the Trellis diagram with shape
             (N, T) which should be a numpy array.
    """

    a = [[None for _ in O] for _ in pi]

    for i, pi_item in enumerate(pi):
        a[i][0] = pi_item * B[i][O[0]]

    for t, o_item in enumerate(O):
        if t == 0:
            continue
        for j in range(len(pi)):
            sigma = sum(map(lambda x: x[1][j] * a[x[0]][t - 1], enumerate(A)))
            a[j][t] = B[j][o_item] * sigma
    probability = sum(map(lambda x: x[-1], a))
    return probability, np.array(a)


def viterbi(A, B, pi, O):
    """
    Calculates the most likely state sequence given model(A, B, pi) and observation sequence.
    :param A: state transition probabilities (NxN)
    :param B: observation probabilities (NxM)
    :param pi: initial state probabilities(N)
    :param O: sequence of observations(T) where observations are just indices for the columns of B (0-indexed)
        N is the number of states,
        M is the number of possible observations, and
        T is the sequence length.
    :return: The most likely state sequence with shape (T,) and the calculated deltas in the Trellis diagram with shape
             (N, T). They should be numpy arrays.
    """

    d = [[p * B[i][O[0]]] + [0 for _ in range(len(O)-1)] for i, p in enumerate(pi)]

    winning_edges = []

    for t in range(1, len(O)):
        winning_edges.append([[-1 for _ in A] for _ in B])
        for j, bj in enumerate(B):
            b = bj[O[t]]
            max_val = float('-inf')
            winner = -1
            for i, ai in enumerate(A):
                curr = ai[j] * d[i][t - 1]
                if curr > max_val:
                    max_val = curr
                    winner = i
            winning_edges[t - 1][j] = winner
            d[j][t] = b * max_val

    last_column = list(map(lambda x: x[-1], d))
    max_d = last_column.index(max(last_column))

    route = [max_d]
    current = max_d
    walk = len(winning_edges) - 1
    while walk != -1:
        prev = winning_edges[walk][current]
        route.append(prev)
        current = prev
        walk -= 1

    return np.array(route[::-1]), np.array(d)





