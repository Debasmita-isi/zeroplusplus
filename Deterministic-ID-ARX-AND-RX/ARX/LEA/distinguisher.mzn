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
                                                        

array[0..31] of int: left_rotate_9 = array1d(0..31, [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8]);
array[0..31] of int: left_rotate_5 = array1d(0..31, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4]);
array[0..31] of int: left_rotate_3 = array1d(0..31, [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2]);

array[0..31] of int: right_rotate_9 = array1d(0..31, [23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]);
array[0..31] of int: right_rotate_5 = array1d(0..31, [27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]);
array[0..31] of int: right_rotate_3 = array1d(0..31, [29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  _____                                                _      ____                         _                    _           _         
% |  ___|   ___    _ __  __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% | |_     / _ \  | '__| \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% |  _|   | (_) | | |     \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |_|      \___/  |_|      \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
       
                                                                                                                               
%k1 = 16
array[0..RD, 0..31] of var -1..1: xu0;
array[0..RD, 0..31] of var -1..1: xu1;
array[0..RD, 0..31] of var -1..1: xu2;
array[0..RD, 0..31] of var -1..1: xu3;
array[0..(RD - 1), 0..31] of var -1..1: yu0;
array[0..(RD - 1), 0..31] of var -1..1: yu1;
array[0..(RD - 1), 0..31] of var -1..1: yu2;
array[0..(RD - 1), 0..31] of var -1..1: yu3;
array[0..(RD - 1), 0..31] of var -1..1: zu1;
array[0..(RD - 1), 0..31] of var -1..1: zu2;
array[0..(RD - 1), 0..31] of var -1..1: wu1;
array[0..(RD - 1), 0..31] of var -1..1: wu2;
array[0..(RD - 1), 0..31] of var -1..1: c;
array[0..(RD - 1), 0..32] of var -1..1: c1;
array[0..(RD - 1), 0..31] of var -1..1: d;
array[0..(RD - 1), 0..32] of var -1..1: d1;
array[0..(RD - 1), 0..31] of var -1..1: f;
array[0..(RD - 1), 0..32] of var -1..1: f1;


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     yu0[round, i] = xu0[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     xu3[(round + 1), i] = xu0[round, i] 
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     yu1[round, i] = xu1[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     zu1[round, i] = xu1[round, i] 
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     yu2[round, i] = xu2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     zu2[round, i] = xu2[round, i] 
);



% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    c[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(yu0[round, i], yu1[round, i], c[round, i], wu1[round, i], c[round, i - 1], c1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(yu0[round, 0], yu1[round, 0], c[round, 0], wu1[round, 0], c1[round, 32], c1[round, 0])
);


% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    d[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(zu1[round, i], yu2[round, i], d[round, i], wu2[round, i], d[round, i - 1], d1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(zu1[round, 0], yu2[round, 0], d[round, 0], wu2[round, 0], d1[round, 32], d1[round, 0])
);


% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    f[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(xu3[round, i], zu2[round, i], f[round, i], yu3[round, i], f[round, i - 1], f1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(xu3[round, 0], zu2[round, 0], f[round, 0], yu3[round, 0], f1[round, 32], f1[round, 0])
);



% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    xu2[(round + 1), i] = yu3[round, right_rotate_3[i]]
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    xu1[(round + 1), i] = wu2[round, right_rotate_5[i]]
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    xu0[(round + 1), i] = wu1[round, left_rotate_9[i]]
);


constraint sum(i in 0..31) (xu0[0, i] + xu1[0, i] + xu2[0, i] + xu3[0, i]) != 0;
%constraint sum(i in 0..(k - 1)) (xul[3, i] + xur[3, i]) >= -60;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                   _                                    _      ____                         _                    _           _         
% | __ )    __ _    ___  | | __ __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% |  _ \   / _` |  / __| | |/ / \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% | |_) | | (_| | | (__  |   <   \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |____/   \__,_|  \___| |_|\_\   \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
                                                                                                                                             

array[0..RD, 0..31] of var -1..1: xd0;
array[0..RD, 0..31] of var -1..1: xd1;
array[0..RD, 0..31] of var -1..1: xd2;
array[0..RD, 0..31] of var -1..1: xd3;
array[0..(RD - 1), 0..31] of var -1..1: yd0;
array[0..(RD - 1), 0..31] of var -1..1: yd1;
array[0..(RD - 1), 0..31] of var -1..1: yd2;
array[0..(RD - 1), 0..31] of var -1..1: yd3;
array[0..(RD - 1), 0..31] of var -1..1: zd1;
array[0..(RD - 1), 0..31] of var -1..1: zd2;
array[0..(RD - 1), 0..31] of var -1..1: wd1;
array[0..(RD - 1), 0..31] of var -1..1: wd2;
array[0..(RD - 1), 0..31] of var -1..1: cl;
array[0..(RD - 1), 0..32] of var -1..1: cl1;
array[0..(RD - 1), 0..31] of var -1..1: dl;
array[0..(RD - 1), 0..32] of var -1..1: dl1;
array[0..(RD - 1), 0..31] of var -1..1: fl;
array[0..(RD - 1), 0..32] of var -1..1: fl1;


% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    yd0[round, i] = xd0[(round + 1), right_rotate_9[i]]
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    yd1[round, i] = xd1[(round + 1), left_rotate_5[i]]
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..31)
(
    wd2[round, i] = xd2[(round + 1), left_rotate_3[i]]
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     yd3[round, i] = xd3[(round + 1), i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     xd0[round, i] = xd3[(round + 1), i] 
);


% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    cl[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(yd0[round, i], yd3[round, i], cl[round, i], zd1[round, i], cl[round, i - 1], cl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(yd0[round, 0], yd3[round, 0], cl[round, 0], zd1[round, 0], cl1[round, 32], cl1[round, 0])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     yd2[round, i] = zd1[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     xd1[round, i] = zd1[round, i] 
);



% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    dl[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(yd1[round, i], yd2[round, i], dl[round, i], zd2[round, i], dl[round, i - 1], dl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(yd1[round, 0], yd2[round, 0], dl[round, 0], zd2[round, 0], dl1[round, 32], dl1[round, 0])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     wd1[round, i] = zd2[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..31)
(
     xd2[round, i] = zd2[round, i] 
);


% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    fl[round, 31] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..31)
(
   bit_addition(wd1[round, i], wd2[round, i], fl[round, i], xd3[round, i], fl[round, i - 1], fl1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(wd1[round, 0], wd2[round, 0], fl[round, 0], xd3[round, 0], fl1[round, 32], fl1[round, 0])
);



constraint sum(i in 0..31) (xd0[RD, i] + xd1[RD, i] + xd2[RD, i] + xd3[RD, i]) != 0;
%constraint sum(i in 0..(k - 1))(xdl[2, i] + xdr[2, i]) >= -62;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                         _                    _           _              __                     ____                   _                        _   _          _     _                 
%  / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___     / _|   ___    _ __     / ___|   ___    _ __   | |_   _ __    __ _    __| | (_)   ___  | |_  (_)   ___    _ __  
% | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|   | |_   / _ \  | '__|   | |      / _ \  | '_ \  | __| | '__|  / _` |  / _` | | |  / __| | __| | |  / _ \  | '_ \ 
% | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \   |  _| | (_) | | |      | |___  | (_) | | | | | | |_  | |    | (_| | | (_| | | | | (__  | |_  | | | (_) | | | | |
%  \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/   |_|    \___/  |_|       \____|  \___/  |_| |_|  \__| |_|     \__,_|  \__,_| |_|  \___|  \__| |_|  \___/  |_| |_|
                                                                                                                                                                                              
array[0..RD, 0..31] of var 0..1: contradict0;
constraint forall(round in 0..RD, i in 0..31)
(
    contradict0[round, i] = bool2int(xu0[round, i] + xd0[round, i] == 1)
);
array[0..RD, 0..31] of var 0..1: contradict1;
constraint forall(round in 0..RD, i in 0..31)
(
    contradict1[round, i] = bool2int(xu1[round, i] + xd1[round, i] == 1)
);

array[0..RD, 0..31] of var 0..1: contradict2;
constraint forall(round in 0..RD, i in 0..31)
(
    contradict2[round, i] = bool2int(xu2[round, i] + xd2[round, i] == 1)
);
array[0..RD, 0..31] of var 0..1: contradict3;
constraint forall(round in 0..RD, i in 0..31)
(
    contradict3[round, i] = bool2int(xu3[round, i] + xd3[round, i] == 1)
);

array[0..RD, 0..127] of var 0..1: contradict;
constraint forall(round in 0..RD, i in 0..31)
(
    contradict[round, i] = contradict0[round, i]
);
constraint forall(round in 0..RD, i in 32..63)
(
    contradict[round, i] = contradict1[round, i - 32]
);

constraint forall(round in 0..RD, i in 64..95)
(
    contradict[round, i] = contradict2[round, i - 64]
);

constraint forall(round in 0..RD, i in 96..127)
(
    contradict[round, i] = contradict3[round, i - 96]
);

constraint sum(round in 0..RD, i in 0..127)(contradict[round, i]) >= 1;

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

solve minimize sum(i in 0..31)(xu0[0, i] + xu1[0, i] + xu2[0, i] + xu3[0, i] + xd0[RD, i] + xd1[RD, i] + xd2[RD, i] + xd3[RD, i]);
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

 
 
 
 
 
 
 
 
 

 
 
 
 
 
 



