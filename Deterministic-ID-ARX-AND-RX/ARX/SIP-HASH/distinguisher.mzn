% MIT License


% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

int: RD;
constraint assert(RD >= 0, "Invalid value for RD: " ++
         "RD must be greater than or equal to 0");

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
% ____            _             _     _                 
% |  _ \    ___   | |_    __ _  | |_  (_)   ___    _ __  
% | |_) |  / _ \  | __|  / _` | | __| | |  / _ \  | '_ \ 
% |  _ <  | (_) | | |_  | (_| | | |_  | | | (_) | | | | |
% |_| \_\  \___/   \__|  \__,_|  \__| |_|  \___/  |_| |_|
                                                        

array[0..63] of int: left_rotate_13 = array1d(0..63, [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);
array[0..63] of int: left_rotate_17 = array1d(0..63, [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
array[0..63] of int: left_rotate_32 = array1d(0..63, [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]);
array[0..63] of int: left_rotate_16 = array1d(0..63, [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
array[0..63] of int: left_rotate_21 = array1d(0..63, [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);



array[0..63] of int: right_rotate_13 = array1d(0..63, [51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50]);
array[0..63] of int: right_rotate_17 = array1d(0..63, [47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46]);
array[0..63] of int: right_rotate_32 = array1d(0..63, [32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]);
array[0..63] of int: right_rotate_16 = array1d(0..63, [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]);
array[0..63] of int: right_rotate_21 = array1d(0..63, [43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42]);



% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  _____                                                _      ____                         _                    _           _         
% |  ___|   ___    _ __  __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% | |_     / _ \  | '__| \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% |  _|   | (_) | | |     \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |_|      \___/  |_|      \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
       
                                                                                                                               
int: k = 64;
array[0..RD, 0..63] of var -1..1: xu0;
array[0..RD, 0..63] of var -1..1: xu1;
array[0..RD, 0..63] of var -1..1: xu2;
array[0..RD, 0..63] of var -1..1: xu3;

array[0..(RD - 1), 0..63] of var -1..1: yu0;
array[0..(RD - 1), 0..63] of var -1..1: yu1;
array[0..(RD - 1), 0..63] of var -1..1: yu2;
array[0..(RD - 1), 0..63] of var -1..1: yu3;

array[0..(RD - 1), 0..63] of var -1..1: zu0;
array[0..(RD - 1), 0..63] of var -1..1: zu1;
array[0..(RD - 1), 0..63] of var -1..1: zu2;
array[0..(RD - 1), 0..63] of var -1..1: zu3;


array[0..(RD - 1), 0..63] of var -1..1: wu0;
array[0..(RD - 1), 0..63] of var -1..1: wu1;
array[0..(RD - 1), 0..63] of var -1..1: wu2;
array[0..(RD - 1), 0..63] of var -1..1: wu3;


array[0..(RD - 1), 0..63] of var -1..1: vu0;
array[0..(RD - 1), 0..63] of var -1..1: vu1;
array[0..(RD - 1), 0..63] of var -1..1: vu2;
array[0..(RD - 1), 0..63] of var -1..1: vu3;


array[0..(RD - 1), 0..63] of var -1..1: mu0;
array[0..(RD - 1), 0..63] of var -1..1: mu1;
array[0..(RD - 1), 0..63] of var -1..1: mu2;
array[0..(RD - 1), 0..63] of var -1..1: mu3;


array[0..(RD - 1), 0..63] of var -1..1: nu0;
array[0..(RD - 1), 0..63] of var -1..1: nu1;
array[0..(RD - 1), 0..63] of var -1..1: nu2;
array[0..(RD - 1), 0..63] of var -1..1: nu3;

array[0..(RD - 1), 0..63] of var -1..1: pu0;
array[0..(RD - 1), 0..63] of var -1..1: pu3;


array[0..(RD - 1), 0..63] of var -1..1: c;
array[0..(RD - 1), 0..64] of var -1..1: c1;
array[0..(RD - 1), 0..63] of var -1..1: d;
array[0..(RD - 1), 0..64] of var -1..1: d1;
array[0..(RD - 1), 0..63] of var -1..1: f;
array[0..(RD - 1), 0..64] of var -1..1: f1;
array[0..(RD - 1), 0..63] of var -1..1: g;
array[0..(RD - 1), 0..64] of var -1..1: g1;



% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     yu0[round, i] = xu0[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zu0[round, i] = xu0[round, i] 
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wu0[round, i] = zu0[round, left_rotate_13[i]]
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    c[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(xu1[round, i], yu0[round, i], c[round, i], yu1[round, i], c[round, i - 1], c1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(xu1[round, 0], yu0[round, 0], c[round, 0], yu1[round, 0], c1[round, 64], c1[round, 0])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zu1[round, i] = yu1[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wu1[round, i] = yu1[round, i] 
);


% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(wu0[round, i], zu1[round, i], vu0[round, i])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     mu0[round, i] = vu0[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     nu0[round, i] = vu0[round, i] 
);


% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    pu0[round, i] = mu0[round, left_rotate_17[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     yu3[round, i] = xu3[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zu3[round, i] = xu3[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    d[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(xu2[round, i], yu3[round, i], d[round, i], yu2[round, i], d[round, i - 1], d1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(xu2[round, 0], yu3[round, 0], d[round, 0], yu2[round, 0], d1[round, 64], d1[round, 0])
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wu2[round, i] = yu2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zu2[round, i] = yu2[round, i] 
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wu3[round, i] = zu3[round, left_rotate_16[i]]
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(wu3[round, i], zu2[round, i], vu3[round, i])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     mu3[round, i] = vu3[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     nu3[round, i] = vu3[round, i] 
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    pu3[round, i] = nu3[round, left_rotate_21[i]]
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    vu2[round, i] = wu1[round, left_rotate_32[i]]
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    f[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(wu2[round, i], nu0[round, i], f[round, i], vu1[round, i], f[round, i - 1], f1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(wu2[round, 0], nu0[round, 0], f[round, 0], vu1[round, 0], f1[round, 64], f1[round, 0])
);


% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    g[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(vu2[round, i], mu3[round, i], g[round, i], mu2[round, i], g[round, i - 1], g1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(vu2[round, 0], mu3[round, 0], g[round, 0], mu2[round, 0], g1[round, 64], g1[round, 0])
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     nu2[round, i] = mu2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xu1[(round + 1), i] = mu2[round, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(pu3[round, i], nu2[round, i], xu3[(round + 1), i])
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     mu1[round, i] = vu1[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     nu1[round, i] = vu1[round, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(pu0[round, i], mu1[round, i], xu0[(round + 1), i])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    xu2[(round + 1), i] = nu1[round, left_rotate_32[i]]
);


constraint sum(i in 0..(k - 1)) (xu0[0, i] + xu1[0, i] + xu2[0, i] + xu3[0, i]) != 0;
%constraint sum(i in 0..(k - 1)) (xul[3, i] + xur[3, i]) >= -60;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                   _                                    _      ____                         _                    _           _         
% | __ )    __ _    ___  | | __ __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% |  _ \   / _` |  / __| | |/ / \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% | |_) | | (_| | | (__  |   <   \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |____/   \__,_|  \___| |_|\_\   \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
                                                                                                                                             

array[0..RD, 0..63] of var -1..1: xd0;
array[0..RD, 0..63] of var -1..1: xd1;
array[0..RD, 0..63] of var -1..1: xd2;
array[0..RD, 0..63] of var -1..1: xd3;

array[0..(RD - 1), 0..63] of var -1..1: yd0;
array[0..(RD - 1), 0..63] of var -1..1: yd1;
array[0..(RD - 1), 0..63] of var -1..1: yd2;
array[0..(RD - 1), 0..63] of var -1..1: yd3;

array[0..(RD - 1), 0..63] of var -1..1: zd0;
array[0..(RD - 1), 0..63] of var -1..1: zd1;
array[0..(RD - 1), 0..63] of var -1..1: zd2;
array[0..(RD - 1), 0..63] of var -1..1: zd3;


array[0..(RD - 1), 0..63] of var -1..1: sd0;
array[0..(RD - 1), 0..63] of var -1..1: sd1;
array[0..(RD - 1), 0..63] of var -1..1: sd2;
array[0..(RD - 1), 0..63] of var -1..1: sd3;


array[0..(RD - 1), 0..63] of var -1..1: pd0;
array[0..(RD - 1), 0..63] of var -1..1: pd1;
array[0..(RD - 1), 0..63] of var -1..1: pd2;
array[0..(RD - 1), 0..63] of var -1..1: pd3;


array[0..(RD - 1), 0..63] of var -1..1: rd0;
array[0..(RD - 1), 0..63] of var -1..1: rd1;
array[0..(RD - 1), 0..63] of var -1..1: rd2;
array[0..(RD - 1), 0..63] of var -1..1: rd3;


array[0..(RD - 1), 0..63] of var -1..1: qd0;
array[0..(RD - 1), 0..63] of var -1..1: qd1;
array[0..(RD - 1), 0..63] of var -1..1: qd3;


array[0..(RD - 1), 0..63] of var -1..1: wd0;
array[0..(RD - 1), 0..63] of var -1..1: wd2;
array[0..(RD - 1), 0..63] of var -1..1: wd3;


array[0..(RD - 1), 0..63] of var -1..1: cl;
array[0..(RD - 1), 0..64] of var -1..1: cl1;
array[0..(RD - 1), 0..63] of var -1..1: dl;
array[0..(RD - 1), 0..64] of var -1..1: dl1;
array[0..(RD - 1), 0..63] of var -1..1: fl;
array[0..(RD - 1), 0..64] of var -1..1: fl1;
array[0..(RD - 1), 0..63] of var -1..1: gl;
array[0..(RD - 1), 0..64] of var -1..1: gl1;



% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    yd2[round, i] = xd2[(round + 1), right_rotate_32[i]]
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     yd1[round, i] = xd1[(round + 1), i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zd1[round, i] = xd1[(round + 1), i] 
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zd2[round, i] = yd2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wd2[round, i] = yd2[round, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(xd0[(round + 1), i], zd2[round, i], yd0[round, i])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zd0[round, i] = yd0[round, right_rotate_17[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wd0[round, i] = zd0[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     rd0[round, i] = zd0[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    fl[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..63)
(
   bit_addition(wd0[round, i], wd2[round, i], fl[round, i], rd2[round, i], fl[round, i - 1], fl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(wd0[round, 0], wd2[round, 0], fl[round, 0], rd2[round, 0], fl1[round, 64], fl1[round, 0])
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(xd3[(round + 1), i], yd1[round, i], yd3[round, i])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zd3[round, i] = yd3[round, right_rotate_21[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wd3[round, i] = zd3[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     rd3[round, i] = zd3[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    gl[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(zd1[round, i], wd3[round, i], gl[round, i], rd1[round, i], gl[round, i - 1], gl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(zd1[round, 0], wd3[round, 0], gl[round, 0], rd1[round, 0], gl1[round, 64], gl1[round, 0])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    pd1[round, i] = rd1[round, right_rotate_32[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     qd1[round, i] = pd1[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     sd1[round, i] = pd1[round, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(rd0[round, i], qd1[round, i], pd0[round, i])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    qd0[round, i] = pd0[round, right_rotate_13[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     sd0[round, i] = qd0[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xd0[round, i] = qd0[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    cl[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(sd0[round, i], sd1[round, i], cl[round, i], xd1[round, i], cl[round, i - 1], cl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(sd0[round, 0], sd1[round, 0], cl[round, 0], xd1[round, 0], cl1[round, 64], cl1[round, 0])
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     pd2[round, i] = rd2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     sd2[round, i] = rd2[round, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(rd3[round, i], pd2[round, i], pd3[round, i])
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    qd3[round, i] = pd3[round, right_rotate_16[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     sd3[round, i] = qd3[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xd3[round, i] = qd3[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    dl[round, 63] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(sd2[round, i], sd3[round, i], dl[round, i], xd2[round, i], dl[round, i - 1], dl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(sd2[round, 0], sd3[round, 0], dl[round, 0], xd2[round, 0], dl1[round, 64], dl1[round, 0])
);


constraint sum(i in 0..63) (xd0[RD, i] + xd1[RD, i] + xd2[RD, i] + xd3[RD, i]) != 0;
%constraint sum(i in 0..(k - 1))(xdl[2, i] + xdr[2, i]) >= -62;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                         _                    _           _              __                     ____                   _                        _   _          _     _                 
%  / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___     / _|   ___    _ __     / ___|   ___    _ __   | |_   _ __    __ _    __| | (_)   ___  | |_  (_)   ___    _ __  
% | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|   | |_   / _ \  | '__|   | |      / _ \  | '_ \  | __| | '__|  / _` |  / _` | | |  / __| | __| | |  / _ \  | '_ \ 
% | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \   |  _| | (_) | | |      | |___  | (_) | | | | | | |_  | |    | (_| | | (_| | | | | (__  | |_  | | | (_) | | | | |
%  \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/   |_|    \___/  |_|       \____|  \___/  |_| |_|  \__| |_|     \__,_|  \__,_| |_|  \___|  \__| |_|  \___/  |_| |_|
                                                                                                                                                                                              
array[0..RD, 0..63] of var 0..1: contradict0;
constraint forall(round in 0..RD, i in 0..63)
(
    contradict0[round, i] = bool2int(xu0[round, i] + xd0[round, i] == 1)
);
array[0..RD, 0..63] of var 0..1: contradict1;
constraint forall(round in 0..RD, i in 0..63)
(
    contradict1[round, i] = bool2int(xu1[round, i] + xd1[round, i] == 1)
);

array[0..RD, 0..63] of var 0..1: contradict2;
constraint forall(round in 0..RD, i in 0..63)
(
    contradict2[round, i] = bool2int(xu2[round, i] + xd2[round, i] == 1)
);
array[0..RD, 0..63] of var 0..1: contradict3;
constraint forall(round in 0..RD, i in 0..63)
(
    contradict3[round, i] = bool2int(xu3[round, i] + xd3[round, i] == 1)
);

array[0..RD, 0..255] of var 0..1: contradict;
constraint forall(round in 0..RD, i in 0..63)
(
    contradict[round, i] = contradict0[round, i]
);
constraint forall(round in 0..RD, i in 64..127)
(
    contradict[round, i] = contradict1[round, i - 64]
);

constraint forall(round in 0..RD, i in 128..191)
(
    contradict[round, i] = contradict2[round, i - 128]
);

constraint forall(round in 0..RD, i in 192..255)
(
    contradict[round, i] = contradict3[round, i - 192]
);

constraint sum(round in 0..RD, i in 0..255)(contradict[round, i]) >= 1;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                           _       ____   _                _                      
% / ___|   ___   __ _  _ __  ___ | |__   / ___| | |_  _ __  __ _ | |_  ___   __ _  _   _ 
% \___ \  / _ \ / _` || '__|/ __|| '_ \  \___ \ | __|| '__|/ _` || __|/ _ \ / _` || | | |
%  ___) ||  __/| (_| || |  | (__ | | | |  ___) || |_ | |  | (_| || |_|  __/| (_| || |_| |
% |____/  \___| \__,_||_|   \___||_| |_| |____/  \__||_|   \__,_| \__|\___| \__, | \__, |
%                                                                           |___/  |___/ 
% Search strategy
%ann: search_ann;
%search_ann = seq_search([
 %   int_search([yul[RD - 1, i] | i in 0..(k - 1)], indomain_median, complete)]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################

%  ___    _         _                 _     _                    _____                          _     _                 
%  / _ \  | |__     (_)   ___    ___  | |_  (_) __   __   ___    |  ___|  _   _   _ __     ___  | |_  (_)   ___    _ __  
% | | | | | '_ \    | |  / _ \  / __| | __| | | \ \ / /  / _ \   | |_    | | | | | '_ \   / __| | __| | |  / _ \  | '_ \ 
% | |_| | | |_) |   | | |  __/ | (__  | |_  | |  \ V /  |  __/   |  _|   | |_| | | | | | | (__  | |_  | | | (_) | | | | |
%  \___/  |_.__/   _/ |  \___|  \___|  \__| |_|   \_/    \___|   |_|      \__,_| |_| |_|  \___|  \__| |_|  \___/  |_| |_|
%                 |__/                                                                                                   

solve minimize sum(i in 0..63)(xu0[0, i] + xu1[0, i] + xu2[0, i] + xu3[0, i] + xd0[RD, i] + xd1[RD, i] + xd2[RD, i] + xd3[RD, i]);
% solve :: restart_constant(10000)
%       :: search_ann minimize sum(i in 0..63)(xu[0, i]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%     _          _       _   _   _     _                                         _    __  __   ___    ____  
%    / \      __| |   __| | (_) | |_  (_)   ___    _ __       __ _   _ __     __| |   \ \/ /  / _ \  |  _ \ 
%   / _ \    / _` |  / _` | | | | __| | |  / _ \  | '_ \     / _` | | '_ \   / _` |    \  /  | | | | | |_) |
%  / ___ \  | (_| | | (_| | | | | |_  | | | (_) | | | | |   | (_| | | | | | | (_| |    /  \  | |_| | |  _ < 
% /_/   \_\  \__,_|  \__,_| |_|  \__| |_|  \___/  |_| |_|    \__,_| |_| |_|  \__,_|   /_/\_\  \___/  |_| \_\
                                                                                                           
predicate bit_addition(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: y0, var -1..1: y1, var -1..1: y2) = 
    
    if (x0 == 0 /\ x1 == 0 /\ x2 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 0)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 1) then (y0 == 1 /\ y1 == 1 /\ y2 == 1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
    else (y0 == -1 /\ y1 == -1 /\ y2 == -1)
    endif
;

predicate exclusive_or(var -1..1: a, var -1..1: b, var -1..1: c) =

    if (a == 0 /\ b == 0) then (c == 0)
    elseif (a == 0 /\ b == 1) then (c == 1)
    elseif (a == 1 /\ b == 0) then (c == 1)
    elseif (a == 1 /\ b == 1) then (c == 0)
    else (c = -1)
    endif
;

 
 
 
 
 
 
 
 
 

 
 
 
 
 
 



