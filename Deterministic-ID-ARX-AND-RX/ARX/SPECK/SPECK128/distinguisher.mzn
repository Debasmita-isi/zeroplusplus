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
                                                        

array[0..63] of int: right_rotate_8 = array1d(0..63, [56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55]);
array[0..63] of int: left_rotate_8 = array1d(0..63, [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7]);
array[0..63] of int: right_rotate_3 = array1d(0..63, [61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60]);
array[0..63] of int: left_rotate_3 = array1d(0..63, [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  _____                                                _      ____                         _                    _           _         
% |  ___|   ___    _ __  __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% | |_     / _ \  | '__| \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% |  _|   | (_) | | |     \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |_|      \___/  |_|      \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
       
                                                                                                                               
int: k = 64;
%k1 = 16
array[0..RD, 0..(k - 1)] of var -1..1: xul;
array[0..RD, 0..(k - 1)] of var -1..1: xur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: yul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: yur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: c;
array[0..(RD - 1), 0..k] of var -1..1: c1;

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    yul[round, i] = xul[round, right_rotate_8[i]]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     yur[round, i] = xur[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zur[round, i] = xur[round, i] 
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    c[round, k-1] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(yul[round, i], yur[round, i], c[round, i], zul[round, i], c[round, i - 1], c1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(yul[round, 0], yur[round, 0], c[round, 0], zul[round, 0], c1[round, k], c1[round, 0])
);


% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wul[round, i] = zul[round, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xul[round + 1, i] = zul[round, i] 
);

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wur[round, i] = zur[round, left_rotate_3[i]]
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(wur[round, i], wul[round, i], xur[round + 1, i])
);


constraint sum(i in 0..(k - 1)) (xul[0, i] + xur[0, i]) != 0;
%constraint sum(i in 0..(k - 1)) (xul[3, i] + xur[3, i]) >= -60;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                   _                                    _      ____                         _                    _           _         
% | __ )    __ _    ___  | | __ __      __   __ _   _ __    __| |    / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___ 
% |  _ \   / _` |  / __| | |/ / \ \ /\ / /  / _` | | '__|  / _` |   | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|
% | |_) | | (_| | | (__  |   <   \ V  V /  | (_| | | |    | (_| |   | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \
% |____/   \__,_|  \___| |_|\_\   \_/\_/    \__,_| |_|     \__,_|    \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/
                                                                                                                                             

array[0..RD, 0..(k - 1)] of var -1..1: xdl;
array[0..RD, 0..(k - 1)] of var -1..1: xdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: ydl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: ydr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zdl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wdl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: cd;
array[0..(RD - 1), 0..k] of var -1..1: cd1;

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     zdl[round, i] = xdl[round + 1, i] 
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     wdl[round, i] = xdl[round + 1, i] 
);

% exclusive or

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     exclusive_or(xdr[round + 1, i], wdl[round, i], wdr[round, i])
);


% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wdr[round, right_rotate_3[i]] = zdr[round, i]
);

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     ydr[round, i] = zdr[round, i]
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xdr[round, i] = zdr[round, i]
);

% Modulo Addition

constraint forall(round in 0..(RD - 1))
(
    cd[round, k-1] = 0
);

constraint forall(round in 0..(RD - 1), i in 1..(k - 1))
(
   bit_addition(zdl[round, i], ydr[round, i], cd[round, i], ydl[round, i], cd[round, i - 1], cd1[round, i])
);

constraint forall(round in 0..(RD - 1))
(
   bit_addition(zdl[round, 0], ydr[round, 0], cd[round, 0], ydl[round, 0], cd1[round, k], cd1[round, 0])
);


% Rotation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    ydl[round, left_rotate_8[i]] = xdl[round, i]
);


constraint sum(i in 0..(k - 1)) (xdl[RD, i] + xdr[RD, i]) != 0;
%constraint sum(i in 0..(k - 1))(xdl[2, i] + xdr[2, i]) >= -62;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                         _                    _           _              __                     ____                   _                        _   _          _     _                 
%  / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___     / _|   ___    _ __     / ___|   ___    _ __   | |_   _ __    __ _    __| | (_)   ___  | |_  (_)   ___    _ __  
% | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|   | |_   / _ \  | '__|   | |      / _ \  | '_ \  | __| | '__|  / _` |  / _` | | |  / __| | __| | |  / _ \  | '_ \ 
% | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \   |  _| | (_) | | |      | |___  | (_) | | | | | | |_  | |    | (_| | | (_| | | | | (__  | |_  | | | (_) | | | | |
%  \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/   |_|    \___/  |_|       \____|  \___/  |_| |_|  \__| |_|     \__,_|  \__,_| |_|  \___|  \__| |_|  \___/  |_| |_|
                                                                                                                                                                                              
array[0..RD, 0..(k - 1)] of var 0..1: contradictl;
constraint forall(round in 0..RD, i in 0..(k - 1))
(
    contradictl[round, i] = bool2int(xul[round, i] + xdl[round, i] == 1)
);
array[0..RD, 0..(k - 1)] of var 0..1: contradictr;
constraint forall(round in 0..RD, i in 0..(k - 1))
(
    contradictr[round, i] = bool2int(xur[round, i] + xdr[round, i] == 1)
);

array[0..RD, 0..((2 * k) - 1)] of var 0..1: contradict;
constraint forall(round in 0..RD, i in 0..(k - 1))
(
    contradict[round, i] = contradictl[round, i]
);
constraint forall(round in 0..RD, i in k..((2 * k) - 1))
(
    contradict[round, i] = contradictr[round, i - k]
);

constraint sum(round in 0..RD, i in 0..((2 * k) - 1))(contradict[round, i]) >= 1;

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

solve minimize sum(i in 0..(k - 1))(xul[0, i] + xur[0, i] + xdl[RD, i] + xdr[RD, i]);
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

 
 
 
 
 
 
 
 
 

 
 
 
 
 
 



