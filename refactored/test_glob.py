from glob import Maths

##====================== Test Cases ======================##
# Each test case should test a single case of functionality.

## suiteMathsDeltaij
def caseDeltaijDifferent():
    assert(Maths.deltaij(3, -3) == 0), \
        "deltaij(3, -3) should be 0"
    assert(Maths.deltaij(5, 4) == 0), \
        "deltaij(5, 4) should be 0"

def caseDeltaijSame():
    assert(Maths.deltaij(0, 0) == 1), \
        "deltaij(0, 0) should be 1"

##====================== Test Suites ======================##
# This is where you assemble groups of test cases to be run
# Each test suite contains 1 or more test cases - there may
# be a setup or tear-down in between

def suiteMathsDeltaij():
    caseDeltaijDifferent()
    caseDeltaijSame()

##====================== Test Runner ======================##
# This is where the tests are actually done
# Run the test suites in the try body below

try:
    # Test suites go here!
    suiteMathsDeltaij()

    # Tests all pass :)
    print "High five! All tests pass!"
except AssertionError as err:
    # Some test failed :(
    print err

