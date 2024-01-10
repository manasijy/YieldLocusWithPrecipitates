(I) ITC2euler

ITCtoeuler: This program calculates euler angles phi1, phi, phi2 for the given ideal texture component {hkl}<uvw>

Input: ideal texture component {hkl}<uvw> as string 'h k l u v w'

output: euler angles phi1, phi, phi2

(II) singleX_DC_function
This function calculates the direction cosine matrix for a single orientation.

(III) e_xtal_miller

e_xtal_miller: This program transforms the external strain to the crystal reference frame.

Input: This program asks for the external strain as input.It aslo asks the crystal orientation with respect to the external reference frame in hkl uvw format.

Output: This program gives out the strain tensor in the crystal reference frame. 


(IV) e_xtal_euler

e_xtal_euler: This program calculates the strain tensor in crystal reference frame.

Input: This program askes for external strain condition. It also asks for the text file containing orientation of the crystal in the euler angle format.

Output: The strain tensor in the crystal reference frame is given out in matrix form on the matlab prompt screen.The strain tensor is calculated for the three choices of the x axis of the external strain: RD, TD and 45 from RD. 

(V) tranform_e_function
This function takes external strain and direction cosine matrix as input and calculates the strain matrix in the crystal frame of reference.

(VI) maxwork_function
This function calculates maximum work of plastic deformation by slip. It takes strain matrix in the crystal frame of reference as input and calculates the sum of shears on active slip systems.

(VII) calculate_M_function
This fumction calculates taylor factor of a polycrystal (given orientation file) using Bishop-Hill method. It takes BHfile as input

(VIII) yield_locus functions:
Single_crystal_YL_BH_stress_state_method - this one is to plot YL for a single crystal using Bishop-Hill stress states
Single_crystal_YL_Taylor_factor_method - plots YL for a single crystal but uses taylor factor calculation for each strain state
Polycrystal_YL_XY_Section_envelop2D - XY section of YL for a polycrystal
Polycrystal_YL_SigmaX_Y_Section_making - It is not plotting only envelope but showing how the YL is generated using planes (lines in 2D)
Poly_crystal_YL_3D and Polycrystal_YL_3D_Quadrant_visulaization - This is again to visualize the YL in 3D using shear stress axis too, the values on the shear stress axis are kind of independent. So, these 3D sections are just for visulaization and should not be used for any research in as is condition.

(IX) .txt files
Cube, goss, Q, R etc files have only single orientations, files such as Cube_100 and others have orientations distributed around the ideal component in some misorentation angle range (15 degrees in most cases). Similarly sol2k and sol500 also have 2000 and 500 orientations respectively. These also represent the format of orientation data to be given as input to the yield locus programs.
