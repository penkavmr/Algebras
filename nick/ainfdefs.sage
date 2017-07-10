##=============================  ainfdefs.sage  ==============================##
'''
Work in progress; this script is a rewriting of the 'ainfdefs.mws' Maple14
code in the sage/python programming language.

All functions currently mirror the maple14 versions as much as possible.
Function names have been copied verbatim with the exception of:
    maple14  |  sage
    ---------+--------
    sgn         Sgn

NOTE:
The work here is primarily a learning exercise in Maple and Sage.  The final
intention is to fully convert this code to an object oriented system.
Because M. Penkava is already familiar with the Maple named functions and
operations, the intention is for the converted code to follow these
conventions as much as possible possible.

OBJECTS:
A Base is represented by a list.
A Tensor Monomial is represented by a list containing a base and a coefficient.
A Tensors is represented by a list of tensor monomials.
'''


##=============================  VARIABLES  ==============================##
# Subject to change for each space tested over (ie. ZEROCOEF is not always 0)
PARITY = 0
DIMENSION = 1
ODD = 1
EVEN = 0
ONE=[]
ZEROCOEF=0
ONECOEF=1

TMON_BASE=0  # index of the base in a tensor monomial
TMON_COEF=1  # index of the coefficient in a tensor monomial

ONETMON=[ONE,ONECOEF]
ZEROTMON=[ONE,ZEROCOEF]

ZEROTENS=[]
ONETENS=[ONETMON]


##==========================  basic Functions  ===========================##
# equality tester
#   ~ in python, we can simply use `(A==B)+0` to obtain desired result
def deltaij(i,j):
    return (i == j) + 0

# parity tester
def parity_elem(i):
    if i<=PARITY:
        return 0
    else:
        return 1

# (-1)^i
def Sgn(i):
    ##return 1 if (i & 1) else -1
     return (-1) ** (i % 2)


##==========================  Basis Functions  ===========================##
# multiply bases for a vector space
def mult_tbas(base1,base2):
    return base1+base2

# parity of basis elements
def parity_tbas(base):
    if base == ONE:
        return 0
    else:
        s = 0
        for t in base:
            s += parity_elem(t)
        return mod(s,2)


##=======================  Coefficient Functions  ========================##
# add
def add_coef(a,b):
    return a+b

# multipy
def mult_coef(a,b):
    return a*b

# multipy a coefficient by a number
def mult_coef_num(coef,num):
    return coef*num

# convert a number to a coefficient
def mk_num_coef(a):
    return mult_coef_num(ONECOEF,a)

# simple rule for the parity of a coefficient
def parity_coef(c):
    return 0

# print normal coefficient
def pnt_coef(a):
    print(a)
    return a


##=====================  Tensor Monomial Functions  ======================##
# construct a tensor monimial; base = [ [base], coefficient ]
def mk_tmon(base, coef=ONECOEF):
    if coef == ZEROCOEF:
        return ZEROTMON
    else:
        return [base,coef]

# parity of a tensor monomial
def parity_tmon(tmon):
    return parity_tbas(tmon[TMON_BASE]) + parity_coef(tmon[TMON_COEF]) % 2

# degree of a tensor monomial
def degree_tmon(tmon):
    return len(tmon[TMON_BASE])

# WTF are there two different functions for right and left multiplication?
# A single function with cases would be cleaner.  (but perhaps slower?)

# The original Maple code for this is incorrect:
# multiply a tensor monimial by a coefficient on the left
def lmult_tmon_coef(coef,tmon):
    return mk_tmon(tmon[TMON_BASE], mult_coef(coef, tmon[TMON_COEF]))

# multiply tensor monimial by a coefficient on the right
def rmult_tmon_coef(tmon,coef):
    return mk_tmon(tmon[TMON_BASE],mult_coef(coef,tmon[TMON_COEF]))


##==========================  Tensor Functions  ==========================##

# multipy a tensor by a number
def mult_tens_num(num,tens):
    return rmult_tens_coef(tens,mk_num_coef(num))

# multiply a tensor on the left by a coefficient
def lmult_tens_coef(ceof,tens):
    if tens==ZEROTENS:
        return ZEROTENS
    else:
        res=ZEROTENS
        for i in range(len(tens)):
            res=add_tens(res,mk_tens(lmult_tmon_coef(coef,tens[i])))
        return comb_tens(res)

# multiply a tensor on the right by a coefficient
def rmult_tens_coef(tens,coef):
    if tens==ZEROTENS:
        return ZEROTENS
    else:
        res=ZEROTENS
        for i in range(len(tens)):
            res=add_tens(res,mk_tens(rmult_tmon_coef(tens[i],coef)))
        return comb_tens(res)

# takes in a list of tensor monomials and combines like terms
def comb_tens(tens_list):
    # This is from the original Maple code, but doesn't make any sense!
    # This function takes in a list of tensors, not a single tensor.
    if tens_list==ZEROTENS or tens_list==ZEROTMON:
        return ZEROTENS
    tens_counted=[]
    tens_result=[]
    for tens in tens_list:
        if tens[TMON_BASE] not in tens_counted:
            tens_counted+=[tens[TMON_BASE]]
            coef=0
            for tens2 in tens_list:
                if tens2[TMON_BASE]==tens[TMON_BASE]:
                    coef+=tens2[TMON_COEF]
            if coef != ZEROCOEF:
                tens_result+=[[tens[TMON_BASE], coef]]
    return tens_result



