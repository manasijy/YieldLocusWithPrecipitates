%%  This program transforms the external strain to the xtal reference frame

fprintf('Please enter strain condition \n For plane strain input 1 \n For axisymmetric strain inpur 2 \n For any other strain condition enter 3 \n')
 

y = input('');
         
 switch y
     case 1 
             e_ext= [1,0,0;0,0,0;0,0,-1];
     case 2 
             e_ext= [1,0,0;0,-0.5,0;0,0,-0.5]; 
     case 3
             prompt = 'Please enter the external strain matrix : e11 e12 e13 e21 e22 e23 e31 e32 e33\n';
             e_ext = input(prompt);
     otherwise
             warning('Unexpected choice entered. Taylor factor can not be calculated.');
             break;
 end
 
 

fprintf('PLEASE ENTER h k l u v w of the crystal\n')
O= input('');         % crystal_orientation array
XO = sscanf(O,'%f');


h=XO(1);
k=XO(2);
l=XO(3);
u=XO(4);
v=XO(5);
w=XO(6);
t1=k*w-l*v;
t2=l*u-h*w;
t3=h*v-k*u;
RD = [h,k,l,u,v,w,t1,t2,t3];
A = singleX_DC_function(RD)  ;  
[e_crystal]= transform_e_function(e_ext,A);

disp(e_crystal)