#!/usr/bin/env sage
##===========================  test.sage  ============================##

#def set_var(


# attempt to solve summation with multiple indices:
def seq_solve(N):

    # declare all x variables:
    for i_0 in range(N):
        for i_1 in range(N):
            for i_2 in range(N):
                var( 'x_' + str(i_0) +
                    '_' + str(i_1) +
                    '_' + str(i_2))

    # TEST: set some x variables:
    #x_0_0_0 = 11
    #for i_0 in range(N):
        #for i_1 in range(N):
            #for i_2 in range(N):
                #print(eval( 'x_' + str(i_0) +
                    #'_' + str(i_1) +
                    #'_' + str(i_2)))
    var( 's' )
    #sum(eval('x_0_0_' + str(s)) * x_1_1_1, s, 0, N-1)

    equations=[]

    for l in range(N):
        for k in range(N):
            for j in range(N):
                for I in range(N):
                    for m in range(N):
                        equations+=[ eval('x_'+str(I)+'_'+str(j)+'_'+str(m)+' * '+
                            'x_'+str(m)+'_'+str(k)+'_'+str(l)+' - '+
                            'x_'+str(I)+'_'+str(k)+'_'+str(m)+' * '+
                            'x_'+str(I)+'_'+str(m)+'_'+str(l)) ]

    return list(set(equations))
