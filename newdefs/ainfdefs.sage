#!/usr/bin/env sage

##=============================  ainfdefs.sage  ==============================##
"""
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
A Tensor is represented by a list of tensor monomials.
A Coderivation Base is represented by a list containing a list and an index.
A Coderivation Monomial is represented by a list containing a coderivation base
    and a coefficient.
A Coderivation is represented by a list of coderivation monomials.
"""

##==========================  GLOBAL VARIABLES  ==========================##
# Subject to change for each space tested over (ie. ZEROCOEF is not always 0)
PARITY = 0
DIMENSION = 1
ODD = 1
EVEN = 0
ONE = []
ZEROCOEF = 0
ONECOEF = 1

TMON_BASE = 0  # index of the base in a tensor monomial
TMON_COEF = 1  # index of the coefficient in a tensor monomial

ONETMON = [ONE,ONECOEF]
ZEROTMON = [ONE,ZEROCOEF]

ZEROTENS = []
ONETENS = [ONETMON]

CBASE_LIST = 0   # index of list in a coderivation
CBASE_INDEX = 1  # index of index in a coderivation

CMON_BASE = 0  # index of the base in a coderivation monomial
CMON_COEF = 1  # index of the coefficient in a coderivation monomial

ZEROCODER = []

##======================  getters and setters  =======================##
# These functions are NOT part of the original Maple code.
# To modify the value of global variables in this module, these functions
# must be used.
def get_DIMENSION():
    return DIMENSION

def set_DIMENSION(dimension):
    global DIMENSION
    DIMENSION = dimension
    return DIMENSION

def get_EVEN():
    return EVEN

def set_EVEN(even):
    global EVEN
    EVEN = even
    return EVEN

def get_ODD():
    return ODD

def set_ODD(odd):
    global ODD
    ODD = odd
    return ODD

def get_PARITY():
    return PARITY

def set_PARITY(parity):
    global PARITY
    PARITY = parity
    return PARITY


##==========================  basic Functions  ===========================##
# equality tester
def deltaij(i,j):
    return (i == j) + 0

# parity tester
def parity_elem(i):
    if i<=PARITY:
        return 0
    return 1

# (-1)^i
def Sgn(i):
    return (-1) ** (Integer(i) % 2)


##=======================  Coefficient Functions  ========================##
# add
def add_coef(a,b):
    return a+b

# convert a number to a coefficient
def mk_num_coef(a):
    return mult_coef_num(ONECOEF,a)

# multipy
def mult_coef(a,b):
    return a*b

# multipy a coefficient by a number
def mult_coef_num(coef,num):
    return coef*num

# simple rule for the parity of a coefficient
def parity_coef(c):
    return 0


##==========================  Basis Functions  ===========================##
# multiply bases for a vector space
def mult_tbas(base1,base2):
    return base1+base2

# parity of basis elements
def parity_tbas(base):
    if base == ONE:
        return 0
    s = 0
    for t in base:
        s += parity_elem(t)
    return mod(s,2)


##=====================  Tensor Monomial Functions  ======================##
# WTF are there two different functions for right and left multiplication?
# A single function with cases would be cleaner.  (but perhaps slower?)

# degree of a tensor monomial
def degree_tmon(tmon):
    return len(tmon[TMON_BASE])

# multiply a tensor monimial by a coefficient on the left
def lmult_tmon_coef(coef,tmon):
    return mk_tmon(tmon[TMON_BASE], mult_coef(coef, tmon[TMON_COEF]))
    # the original Maple code for this is incorrect

# construct a tensor monimial; base = [ [base], coefficient ]
def mk_tmon(base, coef=ONECOEF):
    if coef == ZEROCOEF:
        return ZEROTMON
    return [base,coef]

# parity of a tensor monomial
def parity_tmon(tmon):
    return parity_tbas(tmon[TMON_BASE]) + parity_coef(tmon[TMON_COEF]) % 2

# multiply tensor monimial by a coefficient on the right
def rmult_tmon_coef(tmon,coef):
    return mk_tmon(tmon[TMON_BASE],mult_coef(coef,tmon[TMON_COEF]))


##==========================  Tensor Functions  ==========================##
def add_tens(ten1, ten2):
    return ten1 + ten2

# takes in a list of tensor monomials and combines like terms
def comb_tens(tens_list):
    if tens_list == ZEROTENS or tens_list == ZEROTMON:
        return ZEROTENS
    tens_counted = []
    tens_result = ZEROTENS
    for tens in tens_list:
        if tens[TMON_BASE] not in tens_counted:
            tens_counted += [tens[TMON_BASE]]
            coef = ZEROCOEF
            for tens2 in tens_list:
                if tens2[TMON_BASE] == tens[TMON_BASE]:
                    coef = add_coef(tens2[TMON_COEF], coef)
            if coef != ZEROCOEF:
                tens_result = add_tens(tens_result, [[tens[TMON_BASE], coef]])
    return tens_result

# remove all monomials of degree less than or equal cutoff value from a tensor
def cutoff_tens(tens,cutoff):
    tens_result = ZEROTENS
    if tens != ZEROTENS:
        for tmon in tens:
            if degree_tmon(tmon) <= cutoff:
                tens_result = add_tens(tens_result, mk_tens(tmon))
    return tens_result

# multiply a tensor on the left by a coefficient
def lmult_tens_coef(coef,tens):
    if tens == ZEROTENS:
        return ZEROTENS
    res = ZEROTENS
    for i in range(len(tens)):
        res = add_tens(res,mk_tens(lmult_tmon_coef(coef,tens[i])))
    return comb_tens(res)

def mk_tens(tmon):
    return [tmon]

# multiply tensors
def mult_tens(tens1, tens2):
    tens_result = ZEROTENS
    for tmon1 in tens1:
        for tmon2 in tens2:
            tens_result = add_tens(tens_result,
              mk_tens(mk_tmon(mult_tbas(tmon1[TMON_BASE], tmon2[TMON_BASE]),
              mult_coef(tmon1[TMON_COEF], tmon2[TMON_COEF]))))
    return comb_tens(tens_result)

# multipy a tensor by a number
def mult_tens_num(num,tens):
    return rmult_tens_coef(tens,mk_num_coef(num))

# multiply a tensor on the right by a coefficient
def rmult_tens_coef(tens,coef):
    if tens == ZEROTENS:
        return ZEROTENS
    res = ZEROTENS
    for i in range(len(tens)):
        res = add_tens(res,mk_tens(rmult_tmon_coef(tens[i],coef)))
    return comb_tens(res)


##=========================  Printing Functions  =========================##
# print normal coefficient
def pnt_coef(a):
    print(a)
    return a

# pnt_tbase, pnt_tmon, and pnt_tens all simply display their given objects
# using the symbol 'e' along with subscripts to represent basis elements.
# They are not referenced anywhere else in ainfdefs.mws, so for now they have
# been left out of the Sage code.


##====================  Coderivation Basis Functions  ====================##
def mk_cbase(lst, index):
    cbase_result = [None] * 2
    cbase_result[CBASE_LIST] = lst
    cbase_result[CBASE_INDEX] = index
    return cbase_result

def parity_cbase(cbas):
    return (parity_elem(cbas[CBASE_INDEX]) + parity_tbas(cbas[CBASE_LIST])) % 2

# apply a coderivation base to a tensor base
def apply_cbase_tbas(cbas, tbas):
    if tbas == ONE:
        return ZEROTENS
    res = ZEROTENS
    J = cbas[CBASE_LIST]
    j = cbas[CBASE_INDEX]
    otbas = []
    for k in range(len(tbas)-len(J)+1):
        if k > 0:
            coef = deltaij(J,tbas[k:k+len(J)]) * Sgn(parity_tbas(tbas[0:k-1]) *
                parity_cbase(cbas))
            otbas = tbas[0:k-1]
        else:
            coef = deltaij(J,tbas[k:k+len(J)]) * Sgn(parity_tbas(tbas) *
                parity_cbase(cbas))
            otbas = []
        otbas = otbas + [j] + tbas[k+len(J):len(tbas)-1]
        res = add_tens(res,mk_tens(mk_tmon(otbas,coef)))
    return comb_tens(res)

# apply a coderivation base to a tensor monomial
def apply_cbase_tmon(cbas, tmon):
    return rmult_tens_coef(apply_cbase_tbas(cbas, tmon[TMON_BASE]),
        tmon[TMON_COEF])

# apply a coderivation base to a tensor
def apply_cbase_tens(cbas, tens):
    res = ZEROTENS
    for tmon in tens:
        res = add_tens(res, apply_cbase_tmon(cbas, tmon))
    return comb_tens(res)


##==================  Coderivation Monomial Functions  ===================##
def mk_cmon(cbas, coef=ONECOEF):
    return [cbas, coef]

def parity_cmon(cmon):
    return (parity_cbase(cmon[CMON_BASE]) + parity_coef(cmon[CMON_COEF])) % 2

def apply_cmon_tens(cmon, tens):
    return apply_cbase_tens(cmon[CMON_BASE],
        lmult_tens_coef(cmon[CMON_COEF], tens))

def lmult_cmon_coef(coef, cmon):
    return mk_cmon(cmon[CMON_BASE], mult_coef(coef, cmon[CMON_COEF]))
    # the original Maple code for this appears to be flawed

def rmult_cmon_coef(cmon, coef):
    return lmult_cmon_coef(coef, cmon)

def mult_cmon_num(num, cmon):
    return lmult_cmon_coef(mult_coef_num(ONECOEF, num), cmon)


##=======================  Coderivation Functions  =======================##
def mk_coder(cmon):
    return [cmon]

def add_coder(coder1, coder2):
    return coder1 + coder2

def parity_coder(coder):
    if coder == ZEROCODER:
        return 0
    parity = parity_cmon(coder[0])
    for cmon in coder:
        if parity_cmon(cmon) != parity:
            print 'ERROR: parity of coderivation in not well defined'
            return -1  # returns -1 on error
    return parity

# multiply a coderivation
def lmult_coder_coef(a, coder):
    coder_result = ZEROCODER
    for cmon in coder:
        coder_result = coder_result + [lmult_cmon_coef(a,cmon)]
    return comb_coder(coder_result)

def rmult_coder_coef(coder, a):
    return lmult_coder_coef(a, coder)

def mult_coder_num(a, coder):
    return lmult_coder_coef(mult_coef_num(ONECOEF, a), coder)

# simplify a coderivation by combining like terms
def comb_coder(coder):
    if coder == ZEROCODER:
        return ZEROCODER
    cbas_counted = []
    coder_result = ZEROCODER
    for cmon in coder:
        if cmon[CMON_BASE] not in cbas_counted:
            cbas_counted += [cmon[CMON_BASE]]
            coef = ZEROCOEF
            for cmon2 in coder:
                if cmon2[CMON_BASE] == cmon[CMON_BASE]:
                    coef = add_coef(cmon2[CMON_COEF], coef)
            if coef != ZEROCOEF:
                coder_result = add_coder(coder_result,
                    mk_coder(mk_cmon(cmon[CMON_BASE], coef)))
    return coder_result

# add any number of coderivations together
def ad(*args):
    coder = ZEROCODER
    for arg in args:
        coder = coder + arg
    return comb_coder(coder)

# apply a coderivation to a tensor
def apply_coder_tens(coder, tens):
    tens_result = ZEROTENS
    for cmon in coder:
        tens_result = tens_result + apply_cmon_tens(cmon, tens)
    return comb_tens(tens_result)


##=======================  Coderivation Brackets  ========================##
# composition of two coderivation bases
def comp_cbase(cbas1, cbas2):
    J = cbas1[CBASE_LIST]
    j = cbas1[CBASE_INDEX]
    K = cbas2[CBASE_LIST]
    k = cbas2[CBASE_INDEX]
    coder_result = ZEROCODER
    for i in range(len(J)):
        coder_result = coder_result + [mk_cmon([J[:i]+K+J[i+1:],j],
        mk_num_coef(deltaij(J[i],k) * Sgn(parity_tbas(J[i:]) *
        parity_cbase(cbas2))))]
    return comb_coder(coder_result)

# composition of two coderivation monomials
def comp_cmon(cmon1, cmon2):
    cbas1 = cmon1[CMON_BASE]
    cbas2 = cmon2[CMON_BASE]
    coef1 = cmon1[CMON_COEF]
    coef2 = cmon2[CMON_COEF]
    num = Sgn(Integer(parity_coef(coef1) * parity_cbase(cbas2)))
    coef = mult_coef(coef1, coef2)
    coef = mult_coef_num(coef, num)
    res = comp_cbase(cbas1, cbas2)
    return rmult_coder_coef(res, coef)

# composition of two coderivations
def comp_coder(coder1, coder2):
    result = ZEROCODER
    for cmon1 in coder1:
        for cmon2 in coder2:
            result = add_coder(result, comp_cmon(cmon1, cmon2))
    return comb_coder(result)

# bracket of two coderivation bases
def brack_cbase(cbas1, cbas2):
    res1 = comp_cbase(cbas1, cbas2)
    res2 = comp_cbase(cbas2, cbas1)
    num = Sgn(parity_cbase(cbas1) * parity_cbase(cbas2) + 1)
    return comb_coder(add_coder(res1, mult_coder_num(num, res2)))

# bracket of two coderivation monomials
def brack_cmon(cmon1, cmon2):
    res1 = comp_cmon(cmon1, cmon2)
    res2 = comp_cmon(cmon2, cmon1)
    num = Sgn(parity_cmon(cmon1) * parity_cmon(cmon2) + 1)
    return comb_coder(add_coder(res1, mult_coder_num(num, res2)))

# bracket of two coderivations
def brack_coder(coder1, coder2):
    result = ZEROCODER
    for cmon1 in coder1:
        for cmon2 in coder2:
            result = add_coder(result, brack_cmon(cmon1, cmon2))
    return comb_coder(result)


##============================  Exponentials  ============================##
# exponential of two coderivations
def adm(mu, delta, m):
    if m==0:
        return delta
    elif m<0:
        print 'ERROR: adm() requires a non-negative integer power'
        return -1  # returns -1 on error
    else:
        return brack_coder(mu,adm(mu,delta,m-1))





