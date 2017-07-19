#!/usr/bin/env sage

import os
##===========================  test_ainfdefs.sage  ===========================##
# This script tests the functions in `ainfdefs.sage` against the expected
# return values from the original Maple code.

# set up testing environment by parsing ainfdefs into regular python
#os.system('sage --preparse ainfdefs.sage')
#os.system('mv ainfdefs.sage.py ainfdefs.py')
#from ainfdefs import *

load('ainfdefs.sage')
print "Testing ainfdefs.sage..."

##=============================  functions  ==============================##
# All functions to be tested go here as list entries with the format:
#   [function_name, (arg1, arg2, ... ), return_value]
functions = [
    # basics
    [deltaij, (1,1), 1],
    [deltaij, (1,-2), 0],
    [parity_elem, 22, 1],
    [parity_elem, -5, 0],
    [Sgn, 4, 1],
    [Sgn, 5, -1],
    # printing
    [pnt_coef, 42, 42],
    # coefficients
    [add_coef, (2,5), 7],
    [add_coef, (0,-3), -3],
    [mk_num_coef, 3, mult_coef_num(ONECOEF,3)],
    [mult_coef, (1,4), 4],
    [mult_coef, (2,-3), -6],
    [mult_coef_num, (2,4), 8],
    [mult_coef_num, (9,0), 0],
    [parity_coef, 3, 0],
    # basis
    [mult_tbas, ([1,2,3],[7,8,9]), [1,2,3,7,8,9]],
    [mult_tbas, ([],[0]), [0]],
    [parity_tbas, ONE, 0],
    [parity_tbas, [1,2,3], 1],
    [parity_tbas, [1,2], 0],
    # tensor monomials
    [degree_tmon, [[1,2],2], 2],
    [degree_tmon, [[1,2,3,4],5], 4],
    [lmult_tmon_coef, (2,[[1,2,3],1]), [[1,2,3],2]],
    [lmult_tmon_coef, (3,[[1,2],4]), [[1,2],12]],
    [mk_tmon, [1,2,3], [[1,2,3],1]],
    [mk_tmon, ([1,2,3],4), [[1,2,3],4]],
    [mk_tmon, ([1,2],0), [[],0]],
    [parity_tmon, [[1,2,3],2], 1],
    [parity_tmon, [[1,2],1], 0],
    [rmult_tmon_coef, ([[1,2,3],1],2), [[1,2,3],2]],
    [rmult_tmon_coef, ([[1,2],4],3), [[1,2],12]],
    # tensors
    [add_tens, ([[[1,2],7]],[[[3,4],2]]), [[[1,2],7],[[3,4],2]]],
    [comb_tens, ([[[1,2,3],6]]), [[[1,2,3],6]]],
    [comb_tens, ([[[1,2],2],[[2,3],5],[[1,2],4]]), [[[1,2],6],[[2,3],5]]],
    [comb_tens, ([[[1,3],2],[[],0]]), [[[1,3],2]]],
    [cutoff_tens, (ZEROTENS,666), ZEROTENS],
    [cutoff_tens, ([[[1,2],3],[[1,2,3],4]],2), [[[1,2],3]]],
    [lmult_tens_coef, (7,[[[1,2],5]]), [[[1,2],35]]],
    [lmult_tens_coef, (3,[[[1,2],2],[[1,3],3]]), [[[1,2],6],[[1,3],9]]],
    [mk_tens, ([[1,2],3]), [[[1,2],3]]],
    [mult_tens, ([[[1,2],3]],[[[4,5],6]]), [[[1,2,4,5],18]]],
    [mult_tens, ([[[1,2],3],[[3,4],5]],[[[4,5],6],[[7,9],11]]),
        [[[1,2,4,5],18],[[1,2,7,9],33],[[3,4,4,5],30],[[3,4,7,9],55]]],
    [mult_tens_num, (3,[[[1,2],7]]), [[[1,2],21]]],
    [mult_tens_num, (3,[[[1,2],7],[[1,3],3]]), [[[1,2],21],[[1,3],9]]],
    [rmult_tens_coef, ([[[1,3],2]],7), [[[1,3],14]]],
    [rmult_tens_coef, ([[[1,2],3],[[1,3],4]],2), [[[1,2],6],[[1,3],8]]],
    # coderivation basis
    [mk_cbase, ([1,2,3],4), [[1,2,3],4]],
    [parity_cbase, ([[1,2,3],4]), 0],
    [set_PARITY, 2, 2],
    [parity_cbase, ([[1,2,3],2]), 1],
    [set_PARITY, 0, 0],
    [apply_cbase_tbas, ([[1,2,3],4],[1,2,3]), [[[4],1]]],
    [apply_cbase_tbas, ([[1,2,3],7],[4,5,6]), ZEROTENS],
    [apply_cbase_tmon, ([[1,2,3],4],[[1,2,3],5]), [[[4],5]]],
    [apply_cbase_tmon, ([[1,2],3],[[1,3],4]), ZEROTENS],
    [apply_cbase_tens, ([[1,2],3],[[[1,2],4],[[1,3],4],[[1,2],7]]), [[[3],11]]],
    [apply_cbase_tens, ([[1,2],3],[[[4,5],7]]), ZEROTENS],
    # coderivation monomials
    [mk_cmon, ([[1,2],3]), [[[1,2],3],1]],
    [mk_cmon, ([[3,4],5],6), [[[3,4],5],6]],
    [mk_cmon, ([],7), [[],7]],
    [parity_cmon, ([[[1,3],3],1]), 1],
    [set_PARITY, 2, 2],
    [parity_cmon, ([[[1,3],3],1]), 0],
    [set_PARITY, 0, 0],
    [apply_cmon_tens, ([[[1,2],3],5],[[[1,2],3],[[4,5],6]]), [[[3],15]]],
    [apply_cmon_tens, ([[[1,2],3],5],[[[1,2],4],[[6,7],8]]), [[[3],20]]],
    [apply_cmon_tens, ([[[1,2],3],5],[[[1,2],4],[[1,2],9]]), [[[3],65]]],
    [lmult_cmon_coef, (3,[[[1,2],3],4]), [[[1,2],3],12]],
    [rmult_cmon_coef, ([[[1,2],3],4],7), [[[1,2],3],28]],
    [mult_cmon_num, (7,[[[1,2],3],5]), [[[1,2],3],35]],



    [mk_coder, ([[[1,2,],3],4]), [[[[1,2],3],4]]],
    [add_coder, ([[[[1,2],3],4]],[[[[5,6],7],8]]),
        [[[[1,2],3],4],[[[5,6],7],8]]],
    [parity_coder, ([[[[1,2],3],4],[[[5,6],7],8]]), 1],
    [set_PARITY, 4, 4],
    [parity_coder, ([[[[1,2],3],4],[[[5,6],7],8]]), -1],
    [set_PARITY, 0, 0],
    [comb_coder, ([[[[1,2],3],4],[[[1,2],3],5]]), [[[[1,2],3],9]]],
    [comb_coder, ([[[[1,2],3],4],[[[1,2],3],7],[[[5,6],7],8]]),
        [[[[1,2],3],11],[[[5,6],7],8]]],
    [ad, ([[[[1,2],3],4]],[[[[6,7],8],9]],[[[[1,2],3],4]]),
        [[[[1,2],3],8],[[[6,7],8],9]]],
    [ad, ([],[[[[1,2],3],4]],[]), [[[[1,2],3],4]]]
]

##===============================  tests  ================================##
# This code tests all the functions in the test list.
def testFunc(func, x, y):
    if isinstance(x, tuple):
        assert (func(*x) == y), func.__name__ + "(" + \
            ','.join(map(str, x)) + ") != " + str(y)
    else:
        assert (func(x) == y), func.__name__ + "(" + \
            str(x) + ") != " + str(y)

def testFunctions():
    for func in functions:
        testFunc(*func)

try:
    testFunctions()
    # Tests all pass :)
    print ""
    print "High five! All tests pass!"
except AssertionError as err:
    # Some test failed :(
    print err

# tear down testing environment
os.system('rm -f ainfdefs.py ainfdefs.pyc test_ainfdefs.sage.py')

