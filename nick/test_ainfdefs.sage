#!/usr/bin/env sage
import os

# set up testing environment by parsing ainfdefs into regular python
os.system('sage --preparse ainfdefs.sage')
os.system('mv ainfdefs.sage.py ainfdefs.py')
from ainfdefs import *

print "Testing ainfdefs.sage..."

##============================  Test Cases  ==============================##
# Each test case should test a single piece of functionality

def caseDeltaij():
    assert (deltaij(1,1) == 1), \
        "deltaij(1,1) should be 1"

    assert (deltaij(1,-2) == 0), \
        "deltaij(1,-2) should be 0"

def caseSgn():
    assert (Sgn(4) == 1), \
        "Sgn(4) should be 1"

    assert (Sgn(5) == -1), \
        "Sgn(5) should be -1"

def caseMultTbas():
    assert (mult_tbas([1,2,3],[7,8,9]) == [1,2,3,7,8,9]), \
        "mult_tbas([1,2,3],[7,8,9]) should be [1,2,3,7,8,9]"

    assert (mult_tbas([],[0]) == [0]), \
        "mult_tbas([],[0]) should be [0]"

# wtf is up with the Maple version of parity_tbas()?  It requires a positive
# integer as input.  Need to ask Michael about this...
def caseParityTbas():
    assert (parity_tbas(ONE) == 0), \
        "parity_tbas(ONE) should be 0"

    assert (parity_tbas([1,2,3]) == 1), \
        "parity_tbas([1,2,3]) should be 1"

    assert (parity_tbas([1,2]) == 0), \
        "parity_tbas([1,2]) should be 0"

def caseAddCoef():
    assert (add_coef(2,5) == 7), \
        "add_coef(2,5) should be 7"

    assert (add_coef(0,-3) == -3), \
        "add_coef(0,-3) should be -3"

def caseMultCoef():
    assert (mult_coef(1,4) == 4), \
        "mult_coef(1,4) should be 4"

    assert (mult_coef(2,-3) == -6), \
        "mult_coef(2,-3) should be -6"

def caseMultCoefNum():
    assert (mult_coef_num(2,4) == 8), \
        "mult_coef_num(2,4) should be 8"

    assert (mult_coef_num(9,0) == 0), \
        "mult_coef_num(9,0) should be 0"

def caseMkNumCoef():
    assert(mk_num_coef(3) == mult_coef_num(ONECOEF,3)), \
        "mk_num_coef(3) should be mult_coef_num(ONECOEF,3)"

def caseParityCoef():
    assert(parity_coef(3) == 0), \
        "parity_coef(3) should be 0"

def casePntCoef():
    assert(pnt_coef(42) == 42), \
        "pnt_coef(42) should be 42"

def caseMkTmon():
    assert(mk_tmon([1,2,3]) == [[1, 2, 3], 1]), \
        "mk_tmon([1,2,3]) should be [[1, 2, 3], 1]"

    assert(mk_tmon([1,2,3],4) == [[1, 2, 3], 4]), \
        "mk_tmon([1,2,3],4) should be [[1, 2, 3], 4]"

    assert(mk_tmon([1,2],0) == [[], 0]), \
        "mk_tmon([1,2],0) should be [[], 0]"

def caseParityTmon():
    assert(parity_tmon([[1,2,3],2]) == 1), \
        "parity_tmon([[1,2,3],2]) should be 1"

    assert(parity_tmon([[1,2],1]) == 0), \
        "parity_tmon([[1,2],1]) should be 0"

def caseDegreeTmon():
    assert(degree_tmon([[1,2],2]) == 2), \
        "degree_tmon([[1,2],2]) should be 2"

    assert(degree_tmon([[1,2,3,4],5]) == 4), \
        "degree_tmon([[1,2,3,4],5]) should be 4"

def caseLmultTmonCoef():
    assert(lmult_tmon_coef(2,[[1,2,3],1]) == [[1,2,3],2]), \
        "lmult_tmon_coef(2,[[1,2,3],1]) should be [[1,2,3],2]"

    assert(lmult_tmon_coef(3,[[1,2],4]) == [[1,2],12]), \
        "lmult_tmon_coef(3,[[1,2],4]) should be [[1,2],12]"

def caseRmultTmonCoef():
    assert(rmult_tmon_coef([[1,2,3],1],2) == [[1,2,3],2]), \
        "rmult_tmon_coef([[1,2,3],1],2) should be [[1,2,3],2]"

    assert(rmult_tmon_coef([[1,2],4],3) == [[1,2],12]), \
        "rmult_tmon_coef([[1,2],4],3) should be [[1,2],12]"

def caseCombTens():
    assert(comb_tens([[[1,2,3],6]]) == [[[1,2,3],6]]), \
        "comb_tens([[[1,2,3],6]]) should be [[[1,2,3],6]]"

    assert(comb_tens([[[1,2],2],[[2,3],5],[[1,2],4]]) == [[[1,2],6],[[2,3],5]]), \
        "comb_tens([[[1,2],2],[[2,3],5],[[1,2],4]]) is incorrect"

    assert(comb_tens([[[1,3],2],[[],0]]) == [[[1,3],2]]), \
        "comb_tens([[[1,3],2],[[],0]]) should be [[[1,3],2]]"



##============================  Test Suites  =============================##
# This is where you assemble groups of test cases to be run
# Each test suite contains 1 or more test cases - there may a setup or
# tear-down in between

def suiteInitialTests():
    caseDeltaij()
    caseSgn()
    caseMultTbas()
    caseParityTbas()
    caseAddCoef()
    caseMultCoef()
    caseMultCoefNum()
    caseMkNumCoef()
    caseParityCoef()
    casePntCoef()
    caseMkTmon()
    caseParityTmon()
    caseDegreeTmon()
    caseLmultTmonCoef()
    caseRmultTmonCoef()
    caseCombTens()


##============================  Test Runner  =============================##
# This is where the tests are actually run
# Run the test suites in the try body below

try:
    # Test suites go here!
    suiteInitialTests()

    # Tests all pass :)
    print "High five! All tests pass!"
except AssertionError as err:
    # Some test failed :(
    print err

# tear down testing environment
os.system('rm ainfdefs.py ainfdefs.pyc test_ainfdefs.sage.py')

