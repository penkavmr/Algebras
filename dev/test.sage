#!/usr/bin/env sage
##===========================  test.sage  ============================##

# attempt to solve summation with multiple indices:
def seq_solve(N):

    # declare all x variables:
    for i_0 in range(N):
        for i_1 in range(N):
            for i_2 in range(N):
                for i_3 in range(N):
                    var( 'x_' + str(i_0) +
                        '_' + str(i_1) +
                        '_' + str(i_2) +
                        '_' + str(i_3))

    # TEST: set some x variables:
    x_0_0_0_1 = 11
    x_0_0_1_1 = 22

    # TEST: print x variables:
    for i_0 in range(N):
        for i_1 in range(N):
            for i_2 in range(N):
                for i_3 in range(N):
                    print(eval( 'x_' + str(i_0) +
                        '_' + str(i_1) +
                        '_' + str(i_2) +
                        '_' + str(i_3)))

