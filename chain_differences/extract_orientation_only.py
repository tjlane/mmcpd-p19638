import re
import sys
import numpy as np

"""
This script takes a CrystFEL streamfile, finds the orientation and corresponding polar angles (phi and theta) for every indexed chunk
and prints out csv lists for the two angles. 

Usage: python extract_orientation_only.py {}.stream
"""

def extract_vector(vec_name, search_string):

    v = re.search(r"{} = (-?\+?\d+\.\d+)\s+(-?\+?\d+\.\d+)\s+(-?\+?\d+\.\d+)".format(vec_name), 
                  search_string.strip())

    v_star = [ float(v.group(n)) for n in range(1,4) ]
    v_star = np.array(v_star)
    assert v_star.shape == (3,)

    return v_star


def calc_crystal_setting(a_star, b_star, c_star):

    A_star = np.column_stack((a_star, b_star, c_star))
    A = np.linalg.inv(A_star)

    assert A.shape == (3,3)

    return A


def calc_caxis_angles(a_star, b_star, c_star):

    #make indexing matrix from three vectors, invert it and transpose it
    phi = np.linspace(0, 2*np.pi,50)
    theta = np.linspace(0,np.pi,50)
    phi, theta = np.meshgrid(phi, theta)

    A_star = np.column_stack((a_star, b_star, c_star))
    print(a_star)
    A = np.linalg.inv(A_star)

    #extract the 3rd row of matrix (c-axis vector)
    c_vec = A[2, :]
    c_unit = c_vec / np.linalg.norm(c_vec)
    
    #find spherical coordinates (TH and PH) of c-axis in laboratory frame
    PH = np.arctan2(c_unit[1],c_unit[0])
    TH = np.arctan2(np.sqrt(c_unit[0]**2+c_unit[1]**2),c_unit[2])
    print('CHECK CUNIT', c_unit)
    print('CHECK PH' , PH)
    print('CHECK TH', TH)
 
    if PH < 0:
        PH = 2*np.pi + PH
    
    #look up value of Z for PH and TH (Z(0) is theta and Z(1) is phi)
    #assign that as the photolysis value for the chunk
    p_index = np.digitize(PH, phi[0,:])
    t_index = np.digitize(TH, theta[:,0])

    return TH, PH


def main():

    with open(sys.argv[1], 'r') as f:

        #initialize variables
        A_matrices = []
        line = f.readline()
        cnt = 1

        while line:
            
        #only select the indexed ones
            if line.strip() != '----- End chunk -----':
            
            #extract orientation matrix
                if line.strip()[0:5] == 'astar':   
                    a_star = extract_vector('astar', line)

                if line.strip()[0:5] == 'bstar':   
                    b_star = extract_vector('bstar', line)
    
                if line.strip()[0:5] == 'cstar':   
                    c_star = extract_vector('cstar', line)
                
            else: # --> end of chunk!
                    
                xtal_A = calc_crystal_setting(a_star,
                                              b_star,
                                              c_star)
                A_matrices.append(xtal_A)
                    
            line = f.readline()
            cnt += 1

    

    A_matrices = np.array(A_matrices)
    
    print(A_matrices.shape)
    print('successfully processed {} lines, found {} crystals'.format(cnt, A_matrices.shape[0]))

    np.save('crystal_Amatrices.npy', A_matrices)


if __name__ == '__main__':
    main()

