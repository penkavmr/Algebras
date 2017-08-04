class Maths(object):
    @staticmethod
    def deltaij(i, j):
        return int(i == j)

    @staticmethod
    def sgn(x):
        return 1 if (x & 1) else -1;

