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
include "table.mzn";
int: m;
int: block_size;
int: RD;
int: RB; % length of the prepended rounds in key-recovery
int: RF; % length of the appended rounds in key-recovery
% total number of rounds
%int: RT = RB + RD + RF;

constraint assert(RD >= 0, "Invalid value for RD: " ++
         "RD must be greater than or equal to 0");

constraint assert(RB >= 1, "Invalid value for RB: " ++
                  "RB must be greater than or equal to 1");

constraint assert(RF >= 1, "Invalid value for RF: " ++
                 "RF must be greater than or equal to 1");
% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____          __  _                _                   _                    _____       _      _            
% |  _ \   ___  / _|(_) _ __    ___  | |     ___    ___  | | __ _   _  _ __   |_   _|__ _ | |__  | |  ___  ___ 
% | | | | / _ \| |_ | || '_ \  / _ \ | |    / _ \  / _ \ | |/ /| | | || '_ \    | | / _` || '_ \ | | / _ \/ __|
% | |_| ||  __/|  _|| || | | ||  __/ | |___| (_) || (_) ||   < | |_| || |_) |   | || (_| || |_) || ||  __/\__ \
% |____/  \___||_|  |_||_| |_| \___| |_____|\___/  \___/ |_|\_\ \__,_|| .__/    |_| \__,_||_.__/ |_| \___||___/
%                                                                     |_|                                      
% define lookup tables

array[0..63] of int: left_rotate_8 = array1d(0..63, [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1, 2, 3, 4, 5, 6, 7]);
array[0..63] of int: left_rotate_1 = array1d(0..63, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0]);
array[0..63] of int: left_rotate_2 = array1d(0..63, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 0, 1]);


% define the ceil(log2(x) - 0.53) function
array[1..256, 1..2] of int: log2_minus_053_table = array2d(1..256, 1..2, [1, 0, 2, 1, 3, 2, 4, 2, 5, 2, 6, 3, 7, 3, 8, 3, 9, 3, 10, 3, 11, 3, 12, 4, 13, 4, 14, 4, 15, 4, 16, 4, 17, 4, 18, 4, 19, 4, 20, 4, 21, 4, 22, 4, 23, 4, 24, 5, 25, 5, 26, 5, 27, 5, 28, 5, 29, 5, 30, 5, 31, 5, 32, 5, 33, 5, 34, 5, 35, 5, 36, 5, 37, 5, 38, 5, 39, 5, 40, 5, 41, 5, 42, 5, 43, 5, 44, 5, 45, 5, 46, 5, 47, 6, 48, 6, 49, 6, 50, 6, 51, 6, 52, 6, 53, 6, 54, 6, 55, 6, 56, 6, 57, 6, 58, 6, 59, 6, 60, 6, 61, 6, 62, 6, 63, 6, 64, 6, 65, 6, 66, 6, 67, 6, 68, 6, 69, 6, 70, 6, 71, 6, 72, 6, 73, 6, 74, 6, 75, 6, 76, 6, 77, 6, 78, 6, 79, 6, 80, 6, 81, 6, 82, 6, 83, 6, 84, 6, 85, 6, 86, 6, 87, 6, 88, 6, 89, 6, 90, 6, 91, 6, 92, 6, 93, 7, 94, 7, 95, 7, 96, 7, 97, 7, 98, 7, 99, 7, 100, 7, 101, 7, 102, 7, 103, 7, 104, 7, 105, 7, 106, 7, 107, 7, 108, 7, 109, 7, 110, 7, 111, 7, 112, 7, 113, 7, 114, 7, 115, 7, 116, 7, 117, 7, 118, 7, 119, 7, 120, 7, 121, 7, 122, 7, 123, 7, 124, 7, 125, 7, 126, 7, 127, 7, 128, 7, 129, 7, 130, 7, 131, 7, 132, 7, 133, 7, 134, 7, 135, 7, 136, 7, 137, 7, 138, 7, 139, 7, 140, 7, 141, 7, 142, 7, 143, 7, 144, 7, 145, 7, 146, 7, 147, 7, 148, 7, 149, 7, 150, 7, 151, 7, 152, 7, 153, 7, 154, 7, 155, 7, 156, 7, 157, 7, 158, 7, 159, 7, 160, 7, 161, 7, 162, 7, 163, 7, 164, 7, 165, 7, 166, 7, 167, 7, 168, 7, 169, 7, 170, 7, 171, 7, 172, 7, 173, 7, 174, 7, 175, 7, 176, 7, 177, 7, 178, 7, 179, 7, 180, 7, 181, 7, 182, 7, 183, 7, 184, 7, 185, 8, 186, 8, 187, 8, 188, 8, 189, 8, 190, 8, 191, 8, 192, 8, 193, 8, 194, 8, 195, 8, 196, 8, 197, 8, 198, 8, 199, 8, 200, 8, 201, 8, 202, 8, 203, 8, 204, 8, 205, 8, 206, 8, 207, 8, 208, 8, 209, 8, 210, 8, 211, 8, 212, 8, 213, 8, 214, 8, 215, 8, 216, 8, 217, 8, 218, 8, 219, 8, 220, 8, 221, 8, 222, 8, 223, 8, 224, 8, 225, 8, 226, 8, 227, 8, 228, 8, 229, 8, 230, 8, 231, 8, 232, 8, 233, 8, 234, 8, 235, 8, 236, 8, 237, 8, 238, 8, 239, 8, 240, 8, 241, 8, 242, 8, 243, 8, 244, 8, 245, 8, 246, 8, 247, 8, 248, 8, 249, 8, 250, 8, 251, 8, 252, 8, 253, 8, 254, 8, 255, 8, 256, 8]);
% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _   _ 
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| | | |
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | | | |
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |_| |
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____| \___/ 
% constraints for EU
int: k = 64;
%k1 = 16
array[0..RD, 0..(k - 1)] of var -1..1: xul;
array[0..RD, 0..(k - 1)] of var -1..1: xur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: yul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: pul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: qul;

% Diffusion layer

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    yul[round, i] = xul[round, left_rotate_8[i]]
);


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zul[round, i] = xul[round, left_rotate_1[i]]
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wul[round, i] = xul[round, left_rotate_2[i]]
);

% and operation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(

    and(yul[round, i], zul[round, i], pul[round, i])

);

% xor operation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(

    exclusiveor(pul[round, i], wul[round, i], qul[round, i])

);


% S-box layer
constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    sbox(yul[round, i], zul[round, i], wul[round, i], xur[round, i], xul[round + 1, i])
);

% Equality condition

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xul[round, i] = xur[round + 1, i]
);



constraint sum(i in 0..(k - 1)) (xul[0, i] + xur[0, i]) != 0;


% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _     
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| |    
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | |    
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |___ 
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____||_____|
% constraints for EL

array[0..RD, 0..(k - 1)] of var -1..1: xdl;
array[0..RD, 0..(k - 1)] of var -1..1: xdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: ydr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: pdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: qdr;

% Diffusion layer

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    ydr[round, i] = xdr[round + 1, left_rotate_8[i]]
);


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zdr[round, i] = xdr[round + 1, left_rotate_1[i]]
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wdr[round, i] = xdr[round + 1, left_rotate_2[i]]
);

% and operation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(

    and(ydr[round, i], zdr[round, i], pdr[round, i])

);

% xor operation

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(

    exclusiveor(pdr[round, i], wdr[round, i], qdr[round, i])

);


% S-box layer

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    sbox(ydr[round, i], zdr[round, i], wdr[round, i], xdl[round + 1, i], xdr[round, i])
);

% Equality condition

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
     xdr[round + 1, i] = xdl[round, i]
);


constraint sum(i in 0..(k - 1)) (xdl[RD, i] + xdr[RD, i]) != 0;
% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                                   _                _    _              ____               _                    _  _        _    _               
%  / ___| _   _   __ _  _ __  __ _  _ __  | |_  ___   ___  | |_ | |__    ___   / ___| ___   _ __  | |_  _ __  __ _   __| |(_)  ___ | |_ (_)  ___   _ __  
% | |  _ | | | | / _` || '__|/ _` || '_ \ | __|/ _ \ / _ \ | __|| '_ \  / _ \ | |    / _ \ | '_ \ | __|| '__|/ _` | / _` || | / __|| __|| | / _ \ | '_ \ 
% | |_| || |_| || (_| || |  | (_| || | | || |_|  __/|  __/ | |_ | | | ||  __/ | |___| (_) || | | || |_ | |  | (_| || (_| || || (__ | |_ | || (_) || | | |
%  \____| \__,_| \__,_||_|   \__,_||_| |_| \__|\___| \___|  \__||_| |_| \___|  \____|\___/ |_| |_| \__||_|   \__,_| \__,_||_| \___| \__||_| \___/ |_| |_|
%                                                                                                                                        |___/                              
% constraints for the meeting point
array[0..RD, 0..(k - 1)] of var 0..1: contradictl;
constraint forall(round in 0..RD, i in 0..(k - 1))
(
    contradictl[round, i] = bool2int(xul[round, i] + xdl[round, i] == 1)
);
array[0..RD, 0..(k - 1)] of var 0..1: contradictr;
constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
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

constraint sum(round in 1..(RD - 1), i in 0..31)(contradict[round, i]) >= 1;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  ____  
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| __ ) 
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  |  _ \ 
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |_) |
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____||____/ 
% constraints for EB

% variables corresponding to truncated difference propagation:
array[0..RB, 0..(k - 1)] of var -1..1: dxbl;
array[0..RB, 0..(k - 1)] of var -1..1: dxbr;
array[0..(RB - 1), 0..(k - 1)] of var -1..1: dybr;
array[0..(RB - 1), 0..(k - 1)] of var -1..1: dzbr;
array[0..(RB - 1), 0..(k - 1)] of var -1..1: dwbr;
array[0..(RB - 1), 0..(k - 1)] of var -1..1: dpbr;
array[0..(RB - 1), 0..(k - 1)] of var -1..1: dqbr;

% variables corresponding to filter propagation:
array[0..(RB - 1), 0..(k - 1)] of var 0..1: fin1;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: fin2; 

% variables corresponding to KDX propagation:
array[0..RB, 0..(k - 1)] of var 0..1: kdxbl;
array[0..RB, 0..(k - 1)] of var 0..1: kdxbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdybr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdzbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdwbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdpbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdqbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdybr1;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdzbr1;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kdwbr1;


% variables corresponding to KX propagation:

array[0..RB, 0..(k - 1)] of var 0..1: kxbl;
array[0..RB, 0..(k - 1)] of var 0..1: kxbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kybr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kzbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kwbr;

array[0..(RB - 1), 0..(k - 1)] of var 0..1: kybr1;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kzbr1;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kwbr1;

array[0..(RB - 1), 0..(k - 1)] of var 0..1: kpbr;
array[0..(RB - 1), 0..(k - 1)] of var 0..1: kqbr;


array[1..(RB - 1), 0..(k - 1)] of var 0..1: NGK0;


% #############################################################################################################################################
%%% Difference propagation in backward direction.

% Link in the boundary

constraint forall(i in 0..(k - 1))
(
     dxbl[RB, i] = xul[0, i]
);

constraint forall(i in 0..(k - 1))
(
     dxbr[RB, i] = xur[0, i]
);

% Equality Condition

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      dxbl[round, i] = dxbr[round + 1, i]

);


% Diffusion layer

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    dybr[round, i] = dxbr[round + 1, left_rotate_8[i]]
);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    dzbr[round, i] = dxbr[round + 1, left_rotate_1[i]]
);

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    dwbr[round, i] = dxbr[round + 1, left_rotate_2[i]]
);


% Non-linear Operation

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    and(dybr[round, i], dzbr[round, i], dpbr[round, i])
);


% xor operation

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
 
    exclusiveor(dpbr[round, i], dwbr[round, i], dqbr[round, i])

);

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
 
    exclusiveor(dqbr[round, i], dxbl[round + 1, i], dxbr[round, i])

);

% #############################################################################################################################################
%%%% Filter detection at each round


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

    filter(dpbr[round, i], dwbr[round, i], dqbr[round, i], fin1[round, i]) 

);

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

    filter(dqbr[round, i], dxbr[round, i], dxbl[round + 1, i], fin2[round, i]) 

);

% #############################################################################################################################################
%%%% KDX Propagation at each round

% Boundary Condition

constraint forall(i in 0..(k - 1))
(

      link(dxbl[RB, i], kdxbl[RB, i])

);

constraint forall(i in 0..(k - 1))
(

      link(dxbr[RB, i], kdxbr[RB, i])

);



% Xor operation


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      Xor_1(dxbr[round, i], dqbr[round, i], kdxbl[round + 1, i], fin2[round, i], kdxbr[round, i], kdqbr[round, i])

);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      Xor_1(dpbr[round, i], dwbr[round, i], kdqbr[round, i], fin1[round, i], kdpbr[round, i], kdwbr[round, i])

);


% AND operation

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      and_1(dybr[round, i], dzbr[round, i], kdpbr[round, i], kdybr[round, i], kdzbr[round, i])

);


% Diffusion layer

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kdybr1[round, left_rotate_8[i]] = kdybr[round, i]
);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kdzbr1[round, left_rotate_1[i]] = kdzbr[round, i]
);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kdwbr1[round, left_rotate_2[i]] = kdwbr[round, i]
);


% Merging

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

    merge(kdybr1[round, i], kdzbr1[round, i], kdwbr1[round, i], kdxbr[round + 1, i], kdxbl[round, i])

);



% #############################################################################################################################################
%%%% KX Propagation at each round

% Boundary Condition

constraint forall(i in 0..(k - 1))
(

       kxbl[RB, i] = 0    

);


constraint forall(i in 0..(k - 1))
(

       kxbr[RB, i] = 0    

);


% Xor operation


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      Xor_2(kxbl[round + 1, i], kxbr[round, i], kqbr[round, i])

);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      Xor_2(kqbr[round, i], kpbr[round, i], kwbr[round, i])

);

% AND operation

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      and_2(kdpbr[round, i], kpbr[round, i], dybr[round, i], dzbr[round, i], kybr[round, i], kzbr[round, i])

);

% Diffusion layer

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kybr1[round, left_rotate_8[i]] = kybr[round, i]
);


constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kzbr1[round, left_rotate_1[i]] = kzbr[round, i]
);

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(
    kwbr1[round, left_rotate_2[i]] = kwbr[round, i]
);

% Merging

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

    merge(kybr1[round, i], kzbr1[round, i], kwbr1[round, i], kxbr[round + 1, i], kxbl[round, i])

);

% optional

constraint forall(round in 1..(RB - 1), i in 0..(k - 1))
(

    merge2(kybr1[round, i], kzbr1[round, i], NGK0[round, i])

);


% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _____ 
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____||  ___|
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | |_   
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ |  _|  
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____||_|    
% constraints for EF

% variables corresponding to truncated difference propagation:
array[0..RF, 0..(k - 1)] of var -1..1: dxfl;
array[0..RF, 0..(k - 1)] of var -1..1: dxfr;
array[0..(RF - 1), 0..(k - 1)] of var -1..1: dyfl;
array[0..(RF - 1), 0..(k - 1)] of var -1..1: dzfl;
array[0..(RF - 1), 0..(k - 1)] of var -1..1: dwfl;
array[0..(RF - 1), 0..(k - 1)] of var -1..1: dpfl;
array[0..(RF - 1), 0..(k - 1)] of var -1..1: dqfl;

% variables corresponding to filter propagation:
array[0..(RF - 1), 0..(k - 1)] of var 0..1: fout1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: fout2; 

% variables corresponding to KDX propagation:
array[0..RF, 0..(k - 1)] of var 0..1: kdxfl;
array[0..RF, 0..(k - 1)] of var 0..1: kdxfr;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdyfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdzfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdwfl;

array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdyfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdzfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdwfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdpfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kdqfl;


% variables corresponding to KX propagation:
array[0..RF, 0..(k - 1)] of var 0..1: kxfl;
array[0..RF, 0..(k - 1)] of var 0..1: kxfr;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kyfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kzfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kwfl;

array[0..(RF - 1), 0..(k - 1)] of var 0..1: kyfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kzfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kwfl1;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kpfl;
array[0..(RF - 1), 0..(k - 1)] of var 0..1: kqfl;

array[1..(RF - 1), 0..(k - 1)] of var 0..1: NGK1;
array[2..(RF - 1), 0..(k - 1)] of var 0..2: IKyfl;
array[2..(RF - 1), 0..(k - 1)] of var 0..2: IKzfl;
array[2..(RF - 1), 0..(k - 1)] of var 0..2: IKyfl1;
array[2..(RF - 1), 0..(k - 1)] of var 0..2: IKzfl1;
array[2..(RF - 1), 0..(k - 1)] of var 0..2: K;
array[2..(RF - 1), 0..(k - 1)] of var 0..1: pyfl;
array[2..(RF - 1), 0..(k - 1)] of var 0..1: pzfl;
array[2..(RF - 1), 0..(k - 1)] of var 0..1: pyfl1;
array[2..(RF - 1), 0..(k - 1)] of var 0..1: pzfl1;
array[2..(RF - 1), 0..(k - 1)] of var 0..1: K1;


% #############################################################################################################################################
%%% Difference propagation in forward direction.

% Link in the boundary

constraint forall(i in 0..(k - 1))
(
     dxfl[0, i] = xdl[RD, i]
);

constraint forall(i in 0..(k - 1))
(
     dxfr[0, i] = xdr[RD, i]
);

% Equality Condition

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      dxfr[round + 1, i] = dxfl[round, i]

);

% Diffusion layer

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    dyfl[round, i] = dxfl[round, left_rotate_8[i]]
);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    dzfl[round, i] = dxfl[round, left_rotate_1[i]]
);

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    dwfl[round, i] = dxfl[round, left_rotate_2[i]]
);

% Non-linear Operation

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    and(dyfl[round, i], dzfl[round, i], dpfl[round, i])
);


% xor operation

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
 
    exclusiveor(dpfl[round, i], dwfl[round, i], dqfl[round, i])

);

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
 
    exclusiveor(dqfl[round, i], dxfr[round, i], dxfl[round + 1, i])

);



% #############################################################################################################################################
%%%% Filter detection at each round


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

    filter(dpfl[round, i], dwfl[round, i], dqfl[round, i], fout1[round, i]) 

);

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

    filter(dqfl[round, i], dxfl[round + 1, i], dxfr[round, i], fout2[round, i]) 

);

% #############################################################################################################################################
%%% KDX propagation in forward direction.


% Boundary Condition

constraint forall(i in 0..(k - 1))
(

      link(dxfl[0, i], kdxfl[0, i])

);

constraint forall(i in 0..(k - 1))
(

      link(dxfr[0, i], kdxfr[0, i])

);



% Xor operation


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      Xor_1(dxfl[round + 1, i], dqfl[round, i], kdxfr[round, i], fout2[round, i], kdxfl[round + 1, i], kdqfl[round, i])

);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      Xor_1(dpfl[round, i], dwfl[round, i], kdqfl[round, i], fout1[round, i], kdpfl[round, i], kdwfl[round, i])

);


% AND operation

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      and_1(dyfl[round, i], dzfl[round, i], kdpfl[round, i], kdyfl[round, i], kdzfl[round, i])

);



% Diffusion layer

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kdyfl1[round, left_rotate_8[i]] = kdyfl[round, i]
);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kdzfl1[round, left_rotate_1[i]] = kdzfl[round, i]
);

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kdwfl1[round, left_rotate_2[i]] = kdwfl[round, i]
);

% Merging

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

    merge(kdyfl1[round, i], kdzfl1[round, i], kdwfl1[round, i], kdxfl[round, i], kdxfr[round + 1, i])

);

% #############################################################################################################################################
%%% KX propagation in forward direction.

% Boundary Condition

constraint forall(i in 0..(k - 1))
(

       kxfl[0, i] = 0    

);


constraint forall(i in 0..(k - 1))
(

       kxfr[0, i] = 0    

);

% Xor operation


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      Xor_2(kxfr[round, i], kxfl[round + 1, i], kqfl[round, i])

);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      Xor_2(kqfl[round, i], kpfl[round, i], kwfl[round, i])

);


% AND operation

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      and_2(kdpfl[round, i], kpfl[round, i], dyfl[round, i], dzfl[round, i], kyfl[round, i], kzfl[round, i])

);

% Diffusion layer

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kyfl1[round, left_rotate_8[i]] = kyfl[round, i]
);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kzfl1[round, left_rotate_1[i]] = kzfl[round, i]
);

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(
    kwfl1[round, left_rotate_2[i]] = kwfl[round, i]
);

% Merging

constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

    merge(kyfl1[round, i], kzfl1[round, i], kwfl1[round, i], kxfl[round, i], kxfr[round + 1, i])

);

% post-processing



constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(

    op(dyfl[(round - 1), i], dzfl[(round - 1), i], kyfl[(round - 1), i], kzfl[(round - 1), i], IKyfl[round, i], IKzfl[round, i])

);


% Diffusion layer

constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(
    IKyfl1[round, left_rotate_8[i]] = IKyfl[round, i]
);


constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(
    IKzfl1[round, left_rotate_1[i]] = IKzfl[round, i]
);


constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(

    merge3(IKyfl1[(round), i], IKzfl1[(round), i], K[round, i])

);

 %final

constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(

    final(IKyfl[round, i], IKzfl[round, i], IKzfl1[round, (i + 8) mod k], IKyfl1[round, (i + 1) mod k], pyfl[round, i], pzfl[round, i])

);

% Diffusion layer

constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(
    pyfl1[round, left_rotate_8[i]] = pyfl[round, i]
);


constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(
    pzfl1[round, left_rotate_1[i]] = pzfl[round, i]
);


constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(

    merge2(pyfl1[(round), i], pzfl1[(round), i], K1[round, i])

);

% Last Step

constraint forall(round in 2..(RF - 1), i in 0..(k - 1))
(

    NGK1[round, i] = K1[round, i]

);


constraint forall(i in 0..(k - 1))
(

    merge2(kyfl1[0, i], kzfl1[0, i], NGK1[1, i])

);



% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  _  __                    ____         _      _         _               
% | |/ / ___  _   _        | __ )  _ __ (_)  __| |  __ _ (_) _ __    __ _ 
% | ' / / _ \| | | | _____ |  _ \ | '__|| | / _` | / _` || || '_ \  / _` |
% | . \|  __/| |_| ||_____|| |_) || |   | || (_| || (_| || || | | || (_| |
% |_|\_\\___| \__, |       |____/ |_|   |_| \__,_| \__, ||_||_| |_| \__, |
%             |___/                                |___/            |___/ 
% constraints for key-bridging


array[0..(RB + RD + RF - 1), 0..(k - 1)] of var 0..1: IK;
array[0..(RB + RD + RF - 1), 0..(k - 1)] of var 0..1: IK1;
%array[0..(RB + RD + RF - m - 1), 0..(k - 1)] of var 0..1: CK;

constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
(

      IK1[round, i] = kxbl[round + 1, i]

);


constraint forall(round in 0..(RF - 1), i in 0..(k - 1))
(

      IK1[(RB + RD + round), i] = kxfr[round, i]

);


%constraint forall(round in 0..(RB - 1), i in 0..(k - 1))
%(

%     key_bridge(IK[round, i], IK[round + 1, i], IK[round + 1, (k + i - 1) mod k], IK[round + 3, (k + i - 3) mod k], IK[round + 3, (k + i - 4) mod k], IK[round + 4, i], CK[round, i]) 


%);

%constraint forall(round in RB..(RB + RD - m - 1), i in 0..(k - 1))
%(

%     key_bridge(IK[round, i], IK[round + 1, i], IK[round + 1, (k + i - 1) mod k], IK[round + 3, (k + i - 3) mod k], IK[round + 3, (k + i - 4) mod k], IK[round + 4, i], CK[round, i]) 


%);


%constraint forall(round in (RB + RD - m)..(RB + RD + RF - m - 1), i in 0..(k - 1))
%(

%     key_bridge(IK[round, i], IK[round + 1, i], IK[round + 1, (k + i - 1) mod k], IK[round + 3, (k + i - 3) mod k], IK[round + 3, (k + i - 4) mod k], IK[round + 4, i], CK[round, i]) 


%);


var 0..((RB + RD + RF) * k): FIK;
var 0..((RB + RD + RF) * k): FIK1;
var 0..((RB + RD + RF) * k): KB;
var 0..((RB + RD + RF) * k): KF;

constraint KB =  sum(round in 1..(RB - 1), i in 0..(k - 1))(NGK0[round, i]);
constraint KF =  sum(round in 1..(RF - 1), i in 0..(k - 1))(NGK1[round, i]);
constraint FIK = sum(round in 1..(RB - 1), i in 0..(k - 1))(NGK0[round, i]) + sum(round in 1..(RF - 1), i in 0..(k - 1))(NGK1[round, i]);


constraint forall(round in 0..(RB - 2), i in 0..(k - 1))
(

      IK[round, i] = NGK0[round + 1, i]

);


constraint forall(round in 0..(RF - 2), i in 0..(k - 1))
(

      IK[(RB + RD + round + 1), i] = NGK1[round + 1, i]

);

constraint FIK1 = sum(round in 0..(RB - 1), i in 0..(k - 1))(IK1[round, i]) + sum(round in RB + RD..(RB + RD + RF - 1), i in 0..(k - 1))(IK1[round, i]);

%constraint FIK = sum(round in 0..(RB - 1), i in 0..(k - 1))(IK[round, i]) + sum(round in RB + RD..(RB + RD + RF - 1), i in 0..(k - 1))(IK[round, i]) - sum(round in (RB + RD - m)..(RB + RD + RF - m - 1), i in 0..(k - 1))(CK[round, i]) - sum(round in 0..(RB - 1), i in 0..(k - 1))(CK[round, i]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                          _              _  _               _                   _              _      
%  / ___| ___   _ __ ___   _ __  | |  ___ __  __(_)| |_  _   _     / \    _ __    __ _ | | _   _  ___ (_) ___ 
% | |    / _ \ | '_ ` _ \ | '_ \ | | / _ \\ \/ /| || __|| | | |   / _ \  | '_ \  / _` || || | | |/ __|| |/ __|
% | |___| (_) || | | | | || |_) || ||  __/ >  < | || |_ | |_| |  / ___ \ | | | || (_| || || |_| |\__ \| |\__ \
%  \____|\___/ |_| |_| |_|| .__/ |_| \___|/_/\_\|_| \__| \__, | /_/   \_\|_| |_| \__,_||_| \__, ||___/|_||___/
%                         |_|                            |___/                             |___/              
% constraints for complexity analysis

var 0..(2 * k): DB;
var 0..(2 * k): DF;
var 0..(2 * k): CB;
var 0..(2 * k): CF;


constraint DB = sum(i in 0..(k - 1))(bool2int(dxbl[0, i] == -1)) + sum(i in 0..(k - 1))(bool2int(dxbr[0, i] == -1));
constraint DF = sum(i in 0..(k - 1))(bool2int(dxfl[RF, i] == -1)) + sum(i in 0..(k - 1))(bool2int(dxfr[RF, i] == -1));

constraint CB = sum(round in 0..(RB - 1), i in 0..(k - 1))(fin1[round, i]) + sum(round in 0..(RB - 1), i in 0..(k - 1))(fin2[round, i]) - sum(i in 0..(k - 1))(bool2int(xul[0, i] == -1)) - sum(i in 0..(k - 1))(bool2int(xur[0, i] == -1));
constraint CF = sum(round in 0..(RF - 1), i in 0..(k - 1))(fout1[round, i]) + sum(round in 0..(RF - 1), i in 0..(k - 1))(fout2[round, i]) - sum(i in 0..(k - 1))(bool2int(xdl[RD, i] == -1)) - sum(i in 0..(k - 1))(bool2int(xdr[RD, i] == -1));
%constraint CB = sum(round in 0..(RB - 1), i in 0..(k - 1))(fin1[round, i]) + sum(round in 0..(RB - 1), i in 0..(k - 1))(fin2[round, i]);
%constraint CF = sum(round in 0..(RF - 1), i in 0..(k - 1))(fout1[round, i]) + sum(round in 0..(RF - 1), i in 0..(k - 1))(fout2[round, i]);


% #############################################################################################################################################
% #############################################################################################################################################
%  ___         _                           
% |_ _| _ __  | |_  ___   __ _   ___  _ __ 
%  | | | '_ \ | __|/ _ \ / _` | / _ \| '__|
%  | | | | | || |_|  __/| (_| ||  __/| |   
% |___||_| |_| \__|\___| \__, | \___||_|   
%                        |___/    

var 0..9: log_2_minus_053_of_g;
var 1..256: g;
constraint table([g, log_2_minus_053_of_g], log2_minus_053_table);

array[0..3] of var 0..256: data_complexity;
var 0..256: memory_complexity;
constraint data_complexity[0] = ((CB + CF + block_size + 1 - DF) div 2) + (log_2_minus_053_of_g div 2);
constraint data_complexity[1] = ((CB + CF + block_size + 1 - DB) div 2) + (log_2_minus_053_of_g div 2);
constraint data_complexity[2] = min(data_complexity[0], data_complexity[1]);
constraint data_complexity[3] = CB + CF + block_size + 1 - DB - DF + log_2_minus_053_of_g;
array[0..3] of var 0..256: t_complexity;
constraint t_complexity[0] = max(data_complexity[2], data_complexity[3]);
constraint t_complexity[1] = CB + CF + log_2_minus_053_of_g;
constraint t_complexity[2] = FIK + log_2_minus_053_of_g;
constraint t_complexity[3] = 256 - g;
constraint memory_complexity = min(FIK, t_complexity[1]);

 %constrain g
constraint g > 1;
constraint g <= FIK;

var 0..256: max_term;
constraint max_term = max(i in 0..3)(t_complexity[i]);

constraint t_complexity[0] < block_size; % data complexity
constraint memory_complexity < 256; % memory complexity
constraint max_term < 256; % time complexity

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____          _             
% / ___|   ___  | |__   __ ___ 
% \___ \  / _ \ | |\ \ / // _ \
%  ___) || (_) || | \ V /|  __/
% |____/  \___/ |_|  \_/  \___|

% some artificial constraints to control the input and output masks
solve minimize max_term;
%solve minimize FIK;
%solve minimize sum(i in 0..(k - 1))(xul[0, i] + xur[0, i] + xdl[RD, i] + xdr[RD, i]);
% solve :: restart_constant(10000)
%       :: search_ann minimize sum(i in 0..63)(xu[0, i]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%     _                 _  _  _                       _____                     _    _                    
%    / \   _   _ __  __(_)| |(_)  __ _  _ __  _   _  |  ___|_   _  _ __    ___ | |_ (_)  ___   _ __   ___ 
%   / _ \ | | | |\ \/ /| || || | / _` || '__|| | | | | |_  | | | || '_ \  / __|| __|| | / _ \ | '_ \ / __|
%  / ___ \| |_| | >  < | || || || (_| || |   | |_| | |  _| | |_| || | | || (__ | |_ | || (_) || | | |\__ \
% /_/   \_\\__,_|/_/\_\|_||_||_| \__,_||_|    \__, | |_|    \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/
%                                             |___/       
% auxiliary functions


predicate sbox(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: x3, var -1..1: y0) = 

    if (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == 0)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 0)
    else (y0 = -1)
    endif
;
 
 
predicate and(var -1..1: x0, var -1..1: x1, var -1..1: y0) = 

    if (x0 == 0 /\ x1 == 0) then (y0 == 0)
    else (y0 = -1)
    endif
; 
 

predicate exclusiveor(var -1..1: x0, var -1..1: x1, var -1..1: y0) = 

    if (x0 == 0 /\ x1 == 0) then (y0 == 0)
    elseif (x0 == 0 /\ x1 == 1) then (y0 == 1)
    elseif (x0 == 1 /\ x1 == 0) then (y0 == 1)
    elseif (x0 == 1 /\ x1 == 1) then (y0 == 0)
    else (y0 == -1)
    endif
;  
 
 
 
predicate filter(var -1..1: x0, var -1..1: x1, var -1..1: x2, var 0..1: y0) = 

    if ((x2 >= 0) /\ (x0 == -1 \/ x1 == -1)) then (y0 == 1)
    else (y0 == 0)
    endif
;  
  
 
predicate link(var -1..1: x0, var 0..1: y0) = 

    if ((x0 >= 0)) then (y0 == 0)
    else true
    endif
;  
 

predicate Xor_1(var -1..1: x0, var -1..1: x1, var 0..1: x2, var 0..1: x3, var 0..1: y0, var 0..1: y1) = 

    if (x2 == 0 /\ x3 == 0) then (y0 == 0 /\ y1 == 0)
    elseif (x0 == -1 /\ x1 >= 0 /\ (x2 + x3) >= 1) then (y0 == 1 /\ y1 == 0)
    elseif (x0 >= 0 /\ x1 == -1 /\ (x2 + x3) >= 1) then (y0 == 0 /\ y1 == 1)
    elseif (x0 == -1 /\ x1 == -1 /\ (x2 + x3) >= 1) then (y0 == 1 /\ y1 == 1)
    elseif (x0 >= 0 /\ x1 >= 0 /\ (x2 + x3) >= 1) then (y0 == 0 /\ y1 == 0)
    else true
    endif
;  
   
predicate and_1(var -1..1: x0, var -1..1: x1, var 0..1: x2, var 0..1: y0, var 0..1: y1) = 


     if (x2 == 0) then (y0 == 0 /\ y1 == 0)
     elseif (x0 == -1 /\ x1 >= 0 /\ x2 == 1) then (y0 == 1 /\ y1 == 0)
     elseif (x0 >= 0 /\ x1 == -1 /\ x2 == 1) then (y0 == 0 /\ y1 == 1)
     elseif (x0 == -1 /\ x1 == -1 /\ x2 == 1) then (y0 == 1 /\ y1 == 1)
     elseif (x0 >= 0 /\ x1 >= 0 /\ x2 == 1) then (y0 == 0 /\ y1 == 0)
     else true
     endif
;

predicate Xor_2(var 0..1: x0, var 0..1: y0, var 0..1: y1) = 


      if (x0 == 0) then (y0 == 0 /\ y1 == 0)
      else (y0 == 1 /\ y1 == 1)
      endif
;

predicate and_2(var 0..1: x0, var 0..1: x1, var -1..1: x2, var -1..1: x3, var 0..1: y0, var 0..1: y1) = 


       if (x0 == 0 /\ x1 == 0) then (y0 == 0 /\ y1 == 0)
       elseif (x0 == 1 /\ x1 == 0 /\ x2 == 0 /\ (x3 == 1 \/ x3 == -1)) then (y0 == 1 /\ y1 == 0)
       elseif (x0 == 1 /\ x1 == 0 /\ (x2 == 1 \/ x2 == -1) /\ x3 == 0) then (y0 == 0 /\ y1 == 1)
       else (y0 == 1 /\ y1 == 1)
       endif
;


predicate merge(var 0..1: x0, var 0..1: x1, var 0..1: x2, var 0..1: x3, var 0..1: y0) =


       if (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == 0)
       else (y0 == 1)
       endif
; 


predicate key_bridge(var 0..1: x0, var 0..1: x1, var 0..1: x2, var 0..1: x3, var 0..1: x4, var 0..1: x5, var 0..1: y0) =



	if (x0 == 1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1 /\ x5 == 1) then (y0 == 1)
        else (y0 == 0)
        endif
;


predicate merge2(var 0..1: x0, var 0..1: x1, var 0..1: y0) = 


	if (x0 == 0 /\ x1 == 0) then (y0 == 0)
        else (y0 == 1)
        endif

;


predicate merge3(var 0..2: x0, var 0..2: x1, var 0..2: y0) = 


	if (x0 == 0 /\ x1 == 0) then (y0 == 0)
	elseif (x0 == 0 /\ x1 == 2) then (y0 == 2)
	elseif (x0 == 2 /\ x1 == 0) then (y0 == 2)
	elseif (x0 == 2 /\ x1 == 2) then (y0 == 2)
        else (y0 == 1)
        endif

;


predicate op(var -1..1: x0, var -1..1: x1, var 0..1: x2, var 0..1: x3, var 0..2: y0, var 0..2: y1) =



	if (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 1) then (y0 == 2 /\ y1 == 2)
        else (y0 == x2 /\ y1 == x3)
        endif
;



predicate final(var 0..2: x0, var 0..2: x1, var 0..2: x2, var 0..2: x3, var 0..1: y0, var 0..1: y1) =



	if (x0 == 2 /\ x1 == 2 /\ x2 == 0 /\ x3 == 0) then (y0 == 1 /\ y1 == 0)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 0 /\ x3 == 1) then (y0 == 0 /\ y1 == 1)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 1 /\ x3 == 0) then (y0 == 1 /\ y1 == 0)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 1 /\ x3 == 1) then (y0 == 1 /\ y1 == 1)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 0 /\ x3 == 2) then (y0 == 0 /\ y1 == 1)

	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 2 /\ x3 == 0) then (y0 == 1 /\ y1 == 0)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 2 /\ x3 == 2) then (y0 == 1 /\ y1 == 0)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 2 /\ x3 == 1) then (y0 == 0 /\ y1 == 1)
	elseif (x0 == 2 /\ x1 == 2 /\ x2 == 1 /\ x3 == 2) then (y0 == 1 /\ y1 == 0)
        else   (y0 == x0 /\ y1 == x1) 
        endif
;











