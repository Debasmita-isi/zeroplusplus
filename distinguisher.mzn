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
                                                        

array[0..31] of int: left_rotate_16 = array1d(0..31, [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
array[0..31] of int: left_rotate_12 = array1d(0..31, [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
array[0..31] of int: left_rotate_8 = array1d(0..31, [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6, 7]);
array[0..31] of int: left_rotate_7 = array1d(0..31, [ 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1, 2, 3, 4, 5, 6]);


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
array[0..RD, 0..31] of var -1..1: xu4;
array[0..RD, 0..31] of var -1..1: xu5;
array[0..RD, 0..31] of var -1..1: xu6;
array[0..RD, 0..31] of var -1..1: xu7;
array[0..RD, 0..31] of var -1..1: xu8;
array[0..RD, 0..31] of var -1..1: xu9;
array[0..RD, 0..31] of var -1..1: xu10;
array[0..RD, 0..31] of var -1..1: xu11;
array[0..RD, 0..31] of var -1..1: xu12;
array[0..RD, 0..31] of var -1..1: xu13;
array[0..RD, 0..31] of var -1..1: xu14;
array[0..RD, 0..31] of var -1..1: xu15;


array[0..RD, 0..31] of var -1..1: yu0;
array[0..RD, 0..31] of var -1..1: yu1;
array[0..RD, 0..31] of var -1..1: yu2;
array[0..RD, 0..31] of var -1..1: yu3;
array[0..RD, 0..31] of var -1..1: yu4;
array[0..RD, 0..31] of var -1..1: yu5;
array[0..RD, 0..31] of var -1..1: yu6;
array[0..RD, 0..31] of var -1..1: yu7;
array[0..RD, 0..31] of var -1..1: yu8;
array[0..RD, 0..31] of var -1..1: yu9;
array[0..RD, 0..31] of var -1..1: yu10;
array[0..RD, 0..31] of var -1..1: yu11;
array[0..RD, 0..31] of var -1..1: yu12;
array[0..RD, 0..31] of var -1..1: yu13;
array[0..RD, 0..31] of var -1..1: yu14;
array[0..RD, 0..31] of var -1..1: yu15;


array[0..(RD - 1), 0..31] of var -1..1: wu0;
array[0..(RD - 1), 0..31] of var -1..1: wu1;
array[0..(RD - 1), 0..31] of var -1..1: wu2;
array[0..(RD - 1), 0..31] of var -1..1: wu3;
array[0..(RD - 1), 0..31] of var -1..1: wu4;
array[0..(RD - 1), 0..31] of var -1..1: wu5;
array[0..(RD - 1), 0..31] of var -1..1: wu6;
array[0..(RD - 1), 0..31] of var -1..1: wu7;
array[0..(RD - 1), 0..31] of var -1..1: wu8;
array[0..(RD - 1), 0..31] of var -1..1: wu9;
array[0..(RD - 1), 0..31] of var -1..1: wu10;
array[0..(RD - 1), 0..31] of var -1..1: wu11;
array[0..(RD - 1), 0..31] of var -1..1: wu12;
array[0..(RD - 1), 0..31] of var -1..1: wu13;
array[0..(RD - 1), 0..31] of var -1..1: wu14;
array[0..(RD - 1), 0..31] of var -1..1: wu15;


array[0..(RD - 1), 0..31] of var -1..1: zu0;
array[0..(RD - 1), 0..31] of var -1..1: zu1;
array[0..(RD - 1), 0..31] of var -1..1: zu2;
array[0..(RD - 1), 0..31] of var -1..1: zu3;
array[0..(RD - 1), 0..31] of var -1..1: zu4;
array[0..(RD - 1), 0..31] of var -1..1: zu5;
array[0..(RD - 1), 0..31] of var -1..1: zu6;
array[0..(RD - 1), 0..31] of var -1..1: zu7;
array[0..(RD - 1), 0..31] of var -1..1: zu8;
array[0..(RD - 1), 0..31] of var -1..1: zu9;
array[0..(RD - 1), 0..31] of var -1..1: zu10;
array[0..(RD - 1), 0..31] of var -1..1: zu11;
array[0..(RD - 1), 0..31] of var -1..1: zu12;
array[0..(RD - 1), 0..31] of var -1..1: zu13;
array[0..(RD - 1), 0..31] of var -1..1: zu14;
array[0..(RD - 1), 0..31] of var -1..1: zu15;


array[0..(RD - 1), 0..31] of var -1..1: w1u0;
array[0..(RD - 1), 0..31] of var -1..1: w1u1;
array[0..(RD - 1), 0..31] of var -1..1: w1u2;
array[0..(RD - 1), 0..31] of var -1..1: w1u3;
array[0..(RD - 1), 0..31] of var -1..1: w1u4;
array[0..(RD - 1), 0..31] of var -1..1: w1u5;
array[0..(RD - 1), 0..31] of var -1..1: w1u6;
array[0..(RD - 1), 0..31] of var -1..1: w1u7;
array[0..(RD - 1), 0..31] of var -1..1: w1u8;
array[0..(RD - 1), 0..31] of var -1..1: w1u9;
array[0..(RD - 1), 0..31] of var -1..1: w1u10;
array[0..(RD - 1), 0..31] of var -1..1: w1u11;
array[0..(RD - 1), 0..31] of var -1..1: w1u12;
array[0..(RD - 1), 0..31] of var -1..1: w1u13;
array[0..(RD - 1), 0..31] of var -1..1: w1u14;
array[0..(RD - 1), 0..31] of var -1..1: w1u15;


array[0..(RD - 1), 0..31] of var -1..1: z1u0;
array[0..(RD - 1), 0..31] of var -1..1: z1u1;
array[0..(RD - 1), 0..31] of var -1..1: z1u2;
array[0..(RD - 1), 0..31] of var -1..1: z1u3;
array[0..(RD - 1), 0..31] of var -1..1: z1u4;
array[0..(RD - 1), 0..31] of var -1..1: z1u5;
array[0..(RD - 1), 0..31] of var -1..1: z1u6;
array[0..(RD - 1), 0..31] of var -1..1: z1u7;
array[0..(RD - 1), 0..31] of var -1..1: z1u8;
array[0..(RD - 1), 0..31] of var -1..1: z1u9;
array[0..(RD - 1), 0..31] of var -1..1: z1u10;
array[0..(RD - 1), 0..31] of var -1..1: z1u11;
array[0..(RD - 1), 0..31] of var -1..1: z1u12;
array[0..(RD - 1), 0..31] of var -1..1: z1u13;
array[0..(RD - 1), 0..31] of var -1..1: z1u14;
array[0..(RD - 1), 0..31] of var -1..1: z1u15;

array[0..(RD - 1), 0..31] of var -1..1: y1u4;
array[0..(RD - 1), 0..31] of var -1..1: y1u5;
array[0..(RD - 1), 0..31] of var -1..1: y1u6;
array[0..(RD - 1), 0..31] of var -1..1: y1u7;
array[0..(RD - 1), 0..31] of var -1..1: y1u12;
array[0..(RD - 1), 0..31] of var -1..1: y1u13;
array[0..(RD - 1), 0..31] of var -1..1: y1u14;
array[0..(RD - 1), 0..31] of var -1..1: y1u15;

array[0..(RD - 1), 0..31] of var -1..1: v1u4;
array[0..(RD - 1), 0..31] of var -1..1: v1u5;
array[0..(RD - 1), 0..31] of var -1..1: v1u6;
array[0..(RD - 1), 0..31] of var -1..1: v1u7;
array[0..(RD - 1), 0..31] of var -1..1: v1u12;
array[0..(RD - 1), 0..31] of var -1..1: v1u13;
array[0..(RD - 1), 0..31] of var -1..1: v1u14;
array[0..(RD - 1), 0..31] of var -1..1: v1u15;


array[0..(RD - 1), 0..15, 0..31] of var -1..1: c;
array[0..(RD - 1), 0..15, 0..32] of var -1..1: c1;


% _   _           _    __      ___                           _                           ____                                _           _ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         / |
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | |
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |_|
                                                                                                                                           

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wu4[round, j] = xu4[round, j])
   else (wu5[round, j] = xu5[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u4[round, j] = xu4[round, j])
   else (w1u5[round, j] = xu5[round, j])
   endif
);

	
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 0, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu0[round, j], wu4[round, j], c[round, 0, j], wu0[round, j], c[round, 0, j - 1], c1[round, 0, j]))
    else (bit_addition(xu0[round, j], wu5[round, j], c[round, 0, j], wu0[round, j], c[round, 0, j - 1], c1[round, 0, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu0[round, 0], wu4[round, 0], c[round, 0, 0], wu0[round, 0], c1[round, 0, 32], c1[round, 0, 0]))
    else (bit_addition(xu0[round, 0], wu5[round, 0], c[round, 0, 0], wu0[round, 0], c1[round, 0, 32], c1[round, 0, 0]))
    endif
);

	
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u0[round, j] = wu0[round, j])
   else (w1u0[round, j] = wu0[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu0[round, j] = wu0[round, j])
   else (yu0[round, j] = wu0[round, j])
   endif
);


      
% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(xu12[round, j], w1u0[round, j], wu12[round, j]))
   else (exclusive_or(xu15[round, j], w1u0[round, j], wu15[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (w1u12[round, j] = wu12[round, left_rotate_16[j]])    
    else (w1u15[round, j] = wu15[round, left_rotate_16[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1u12[round, j] = w1u12[round, j])
   else (y1u15[round, j] = w1u15[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu12[round, j] = w1u12[round, j])
   else (yu15[round, j] = w1u15[round, j])
   endif
);   


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 1, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu8[round, j], y1u12[round, j], c[round, 1, j], wu8[round, j], c[round, 1, j - 1], c1[round, 1, j]))
    else (bit_addition(xu10[round, j], y1u15[round, j], c[round, 1, j], wu10[round, j], c[round, 1, j - 1], c1[round, 1, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu8[round, 0], y1u12[round, 0], c[round, 1, 0], wu8[round, 0], c1[round, 1, 32], c1[round, 1, 0]))
    else (bit_addition(xu10[round, 0], y1u15[round, 0], c[round, 1, 0], wu10[round, 0], c1[round, 1, 32], c1[round, 1, 0]))
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u8[round, j] = wu8[round, j])
   else (w1u10[round, j] = wu10[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu8[round, j] = wu8[round, j])
   else (yu10[round, j] = wu10[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(w1u8[round, j], w1u4[round, j], y1u4[round, j]))
   else (exclusive_or(w1u10[round, j], w1u5[round, j], y1u5[round, j]))
   endif
); 


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yu4[round, j] = y1u4[round, left_rotate_12[j]])    
    else (yu5[round, j] = y1u5[round, left_rotate_12[j]])
    endif
);


%  _   _           _    __      ___                           _                           ____                                _           ____  
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___ \ 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____    __) |
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  / __/ 
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |_____|
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zu4[round, j] = yu4[round, j])
   else (zu5[round, j] = yu5[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u4[round, j] = yu4[round, j])
   else (z1u5[round, j] = yu5[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 2, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu0[round, j], zu4[round, j], c[round, 2, j], zu0[round, j], c[round, 2, j - 1], c1[round, 2, j]))
    else (bit_addition(yu0[round, j], zu5[round, j], c[round, 2, j], zu0[round, j], c[round, 2, j - 1], c1[round, 2, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu0[round, 0], zu4[round, 0], c[round, 2, 0], zu0[round, 0], c1[round, 2, 32], c1[round, 2, 0]))
    else (bit_addition(yu0[round, 0], zu5[round, 0], c[round, 2, 0], zu0[round, 0], c1[round, 2, 32], c1[round, 2, 0]))
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u0[round, j] = zu0[round, j])
   else (z1u0[round, j] = zu0[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu0[round + 1, j] = zu0[round, j])
   else (xu0[round + 1, j] = zu0[round, j])
   endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(yu12[round, j], z1u0[round, j], zu12[round, j]))
   else (exclusive_or(yu15[round, j], z1u0[round, j], zu15[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (z1u12[round, j] = zu12[round, left_rotate_8[j]])    
    else (z1u15[round, j] = zu15[round, left_rotate_8[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1u12[round, j] = z1u12[round, j])
   else (v1u15[round, j] = z1u15[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu12[round + 1, j] = z1u12[round, j])
   else (xu15[round + 1, j] = z1u15[round, j])
   endif
);   

% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 3, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu8[round, j], v1u12[round, j], c[round, 3, j], zu8[round, j], c[round, 3, j - 1], c1[round, 3, j]))
    else (bit_addition(yu10[round, j], v1u15[round, j], c[round, 3, j], zu10[round, j], c[round, 3, j - 1], c1[round, 3, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu8[round, 0], v1u12[round, 0], c[round, 3, 0], zu8[round, 0], c1[round, 3, 32], c1[round, 3, 0]))
    else (bit_addition(yu10[round, 0], v1u15[round, 0], c[round, 3, 0], zu10[round, 0], c1[round, 3, 32], c1[round, 3, 0]))
    endif
);
%%%%%%%%%%

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u8[round, j] = zu8[round, j])
   else (z1u10[round, j] = zu10[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu8[round + 1, j] = zu8[round, j])
   else (xu10[round + 1, j] = zu10[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(z1u8[round, j], z1u4[round, j], v1u4[round, j]))
   else (exclusive_or(z1u10[round, j], z1u5[round, j], v1u5[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), i in 0..3, j in 0..31)
(
    if (round mod 2 == 0) then (xu4[round + 1, j] = v1u4[round, left_rotate_7[j]])    
    else (xu5[round + 1, j] = v1u5[round, left_rotate_7[j]])
    endif
);


%  _   _           _    __      ___                           _                           ____                                _           _____ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___ / 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____    |_ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  ___) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |____/ 
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wu5[round, j] = xu5[round, j])
   else (wu6[round, j] = xu6[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u5[round, j] = xu5[round, j])
   else (w1u6[round, j] = xu6[round, j])
   endif
);

	
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 4, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu1[round, j], wu5[round, j], c[round, 4, j], wu1[round, j], c[round, 4, j - 1], c1[round, 4, j]))
    else (bit_addition(xu1[round, j], wu6[round, j], c[round, 4, j], wu1[round, j], c[round, 4, j - 1], c1[round, 4, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu1[round, 0], wu5[round, 0], c[round, 4, 0], wu1[round, 0], c1[round, 4, 32], c1[round, 4, 0]))
    else (bit_addition(xu1[round, 0], wu6[round, 0], c[round, 4, 0], wu1[round, 0], c1[round, 4, 32], c1[round, 4, 0]))
    endif
);

	
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u1[round, j] = wu1[round, j])
   else (w1u1[round, j] = wu1[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu1[round, j] = wu1[round, j])
   else (yu1[round, j] = wu1[round, j])
   endif
);


      
% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(xu13[round, j], w1u1[round, j], wu13[round, j]))
   else (exclusive_or(xu12[round, j], w1u1[round, j], wu12[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (w1u13[round, j] = wu13[round, left_rotate_16[j]])    
    else (w1u12[round, j] = wu12[round, left_rotate_16[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1u13[round, j] = w1u13[round, j])
   else (y1u12[round, j] = w1u12[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu13[round, j] = w1u13[round, j])
   else (yu12[round, j] = w1u12[round, j])
   endif
);   


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 5, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu9[round, j], y1u13[round, j], c[round, 5, j], wu9[round, j], c[round, 5, j - 1], c1[round, 5, j]))
    else (bit_addition(xu11[round, j], y1u12[round, j], c[round, 5, j], wu11[round, j], c[round, 5, j - 1], c1[round, 5, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu9[round, 0], y1u13[round, 0], c[round, 5, 0], wu9[round, 0], c1[round, 5, 32], c1[round, 5, 0]))
    else (bit_addition(xu11[round, 0], y1u12[round, 0], c[round, 5, 0], wu11[round, 0], c1[round, 5, 32], c1[round, 5, 0]))
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u9[round, j] = wu9[round, j])
   else (w1u11[round, j] = wu11[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu9[round, j] = wu9[round, j])
   else (yu11[round, j] = wu11[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(w1u9[round, j], w1u5[round, j], y1u5[round, j]))
   else (exclusive_or(w1u11[round, j], w1u6[round, j], y1u6[round, j]))
   endif
); 


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yu5[round, j] = y1u5[round, left_rotate_12[j]])    
    else (yu6[round, j] = y1u6[round, left_rotate_12[j]])
    endif
);


%  _   _           _    __      ___                           _                           ____                                _           _  _   
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         | || |  
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | || |_ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| |__   _|
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|            |_|  
                                                                                                                                                

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zu5[round, j] = yu5[round, j])
   else (zu6[round, j] = yu6[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u5[round, j] = yu5[round, j])
   else (z1u6[round, j] = yu6[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 6, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu1[round, j], zu5[round, j], c[round, 6, j], zu1[round, j], c[round, 6, j - 1], c1[round, 6, j]))
    else (bit_addition(yu1[round, j], zu6[round, j], c[round, 6, j], zu1[round, j], c[round, 6, j - 1], c1[round, 6, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu1[round, 0], zu5[round, 0], c[round, 6, 0], zu1[round, 0], c1[round, 6, 32], c1[round, 6, 0]))
    else (bit_addition(yu1[round, 0], zu6[round, 0], c[round, 6, 0], zu1[round, 0], c1[round, 6, 32], c1[round, 6, 0]))
    endif
);



% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u1[round, j] = zu1[round, j])
   else (z1u1[round, j] = zu1[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu1[round + 1, j] = zu1[round, j])
   else (xu1[round + 1, j] = zu1[round, j])
   endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(yu13[round, j], z1u1[round, j], zu13[round, j]))
   else (exclusive_or(yu12[round, j], z1u1[round, j], zu12[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (z1u13[round, j] = zu13[round, left_rotate_8[j]])    
    else (z1u12[round, j] = zu12[round, left_rotate_8[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1u13[round, j] = z1u13[round, j])
   else (v1u12[round, j] = z1u12[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu13[round + 1, j] = z1u13[round, j])
   else (xu12[round + 1, j] = z1u12[round, j])
   endif
);   



% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 7, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu9[round, j], v1u13[round, j], c[round, 7, j], zu9[round, j], c[round, 7, j - 1], c1[round, 7, j]))
    else (bit_addition(yu11[round, j], v1u12[round, j], c[round, 7, j], zu11[round, j], c[round, 7, j - 1], c1[round, 7, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu9[round, 0], v1u13[round, 0], c[round, 7, 0], zu9[round, 0], c1[round, 7, 32], c1[round, 7, 0]))
    else (bit_addition(yu11[round, 0], v1u12[round, 0], c[round, 7, 0], zu11[round, 0], c1[round, 7, 32], c1[round, 7, 0]))
    endif
);




% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u9[round, j] = zu9[round, j])
   else (z1u11[round, j] = zu11[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu9[round + 1, j] = zu9[round, j])
   else (xu11[round + 1, j] = zu11[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(z1u9[round, j], z1u5[round, j], v1u5[round, j]))
   else (exclusive_or(z1u11[round, j], z1u6[round, j], v1u6[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xu5[round + 1, j] = v1u5[round, left_rotate_7[j]])    
    else (xu6[round + 1, j] = v1u6[round, left_rotate_7[j]])
    endif
);


%  _   _           _    __      ___                           _                           ____                                _           ____  
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         | ___| 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  |___ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  ___) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |____/ 
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wu6[round, j] = xu6[round, j])
   else (wu7[round, j] = xu7[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u6[round, j] = xu6[round, j])
   else (w1u7[round, j] = xu7[round, j])
   endif
);

	
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 8, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu2[round, j], wu6[round, j], c[round, 8, j], wu2[round, j], c[round, 8, j - 1], c1[round, 8, j]))
    else (bit_addition(xu2[round, j], wu7[round, j], c[round, 8, j], wu2[round, j], c[round, 8, j - 1], c1[round, 8, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu2[round, 0], wu6[round, 0], c[round, 8, 0], wu2[round, 0], c1[round, 8, 32], c1[round, 8, 0]))
    else (bit_addition(xu2[round, 0], wu7[round, 0], c[round, 8, 0], wu2[round, 0], c1[round, 8, 32], c1[round, 8, 0]))
    endif
);

	
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u2[round, j] = wu2[round, j])
   else (w1u2[round, j] = wu2[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu2[round, j] = wu2[round, j])
   else (yu2[round, j] = wu2[round, j])
   endif
);


      
% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(xu14[round, j], w1u2[round, j], wu14[round, j]))
   else (exclusive_or(xu13[round, j], w1u2[round, j], wu13[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (w1u14[round, j] = wu14[round, left_rotate_16[j]])    
    else (w1u13[round, j] = wu13[round, left_rotate_16[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1u14[round, j] = w1u14[round, j])
   else (y1u13[round, j] = w1u13[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu14[round, j] = w1u14[round, j])
   else (yu13[round, j] = w1u13[round, j])
   endif
);   


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 9, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu10[round, j], y1u14[round, j], c[round, 9, j], wu10[round, j], c[round, 9, j - 1], c1[round, 9, j]))
    else (bit_addition(xu8[round, j], y1u13[round, j], c[round, 9, j], wu8[round, j], c[round, 9, j - 1], c1[round, 9, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu10[round, 0], y1u14[round, 0], c[round, 9, 0], wu10[round, 0], c1[round, 9, 32], c1[round, 9, 0]))
    else (bit_addition(xu8[round, 0], y1u13[round, 0], c[round, 9, 0], wu8[round, 0], c1[round, 9, 32], c1[round, 9, 0]))
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u10[round, j] = wu10[round, j])
   else (w1u8[round, j] = wu8[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu10[round, j] = wu10[round, j])
   else (yu8[round, j] = wu8[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(w1u10[round, j], w1u6[round, j], y1u6[round, j]))
   else (exclusive_or(w1u8[round, j], w1u7[round, j], y1u7[round, j]))
   endif
); 


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yu6[round, j] = y1u6[round, left_rotate_12[j]])    
    else (yu7[round, j] = y1u7[round, left_rotate_12[j]])
    endif
);


%  _   _           _    __      ___                           _                           ____                                _            __   
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |          / /_  
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | '_ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | (_) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|          \___/ 
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zu6[round, j] = yu6[round, j])
   else (zu7[round, j] = yu7[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u6[round, j] = yu6[round, j])
   else (z1u7[round, j] = yu7[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 10, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu2[round, j], zu6[round, j], c[round, 10, j], zu2[round, j], c[round, 10, j - 1], c1[round, 10, j]))
    else (bit_addition(yu2[round, j], zu7[round, j], c[round, 10, j], zu2[round, j], c[round, 10, j - 1], c1[round, 10, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu2[round, 0], zu6[round, 0], c[round, 10, 0], zu2[round, 0], c1[round, 10, 32], c1[round, 10, 0]))
    else (bit_addition(yu2[round, 0], zu7[round, 0], c[round, 10, 0], zu2[round, 0], c1[round, 10, 32], c1[round, 10, 0]))
    endif
);



% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u2[round, j] = zu2[round, j])
   else (z1u2[round, j] = zu2[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu2[round + 1, j] = zu2[round, j])
   else (xu2[round + 1, j] = zu2[round, j])
   endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(yu14[round, j], z1u2[round, j], zu14[round, j]))
   else (exclusive_or(yu13[round, j], z1u2[round, j], zu13[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (z1u14[round, j] = zu14[round, left_rotate_8[j]])    
    else (z1u13[round, j] = zu13[round, left_rotate_8[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1u14[round, j] = z1u14[round, j])
   else (v1u13[round, j] = z1u13[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu14[round + 1, j] = z1u14[round, j])
   else (xu13[round + 1, j] = z1u13[round, j])
   endif
);   



% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 11, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu10[round, j], v1u14[round, j], c[round, 11, j], zu10[round, j], c[round, 11, j - 1], c1[round, 11, j]))
    else (bit_addition(yu8[round, j], v1u13[round, j], c[round, 11, j], zu8[round, j], c[round, 11, j - 1], c1[round, 11, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu10[round, 0], v1u14[round, 0], c[round, 11, 0], zu10[round, 0], c1[round, 11, 32], c1[round, 11, 0]))
    else (bit_addition(yu8[round, 0], v1u13[round, 0], c[round, 11, 0], zu8[round, 0], c1[round, 11, 32], c1[round, 11, 0]))
    endif
);




% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u10[round, j] = zu10[round, j])
   else (z1u8[round, j] = zu8[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu10[round + 1, j] = zu10[round, j])
   else (xu8[round + 1, j] = zu8[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(z1u10[round, j], z1u6[round, j], v1u6[round, j]))
   else (exclusive_or(z1u8[round, j], z1u7[round, j], v1u7[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xu6[round + 1, j] = v1u6[round, left_rotate_7[j]])    
    else (xu7[round + 1, j] = v1u7[round, left_rotate_7[j]])
    endif
);



% _   _           _    __      ___                           _                           ____                                _           _____ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___  |
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____     / / 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|   / /  
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|          /_/   
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wu7[round, j] = xu7[round, j])
   else (wu4[round, j] = xu4[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u7[round, j] = xu7[round, j])
   else (w1u4[round, j] = xu4[round, j])
   endif
);

	
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 12, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu3[round, j], wu7[round, j], c[round, 12, j], wu3[round, j], c[round, 12, j - 1], c1[round, 8, j]))
    else (bit_addition(xu3[round, j], wu4[round, j], c[round, 12, j], wu3[round, j], c[round, 12, j - 1], c1[round, 12, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu3[round, 0], wu7[round, 0], c[round, 12, 0], wu3[round, 0], c1[round, 12, 32], c1[round, 12, 0]))
    else (bit_addition(xu3[round, 0], wu4[round, 0], c[round, 12, 0], wu3[round, 0], c1[round, 12, 32], c1[round, 12, 0]))
    endif
);

	
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u3[round, j] = wu3[round, j])
   else (w1u3[round, j] = wu3[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu3[round, j] = wu3[round, j])
   else (yu3[round, j] = wu3[round, j])
   endif
);


      
% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(xu15[round, j], w1u3[round, j], wu15[round, j]))
   else (exclusive_or(xu14[round, j], w1u3[round, j], wu14[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (w1u15[round, j] = wu15[round, left_rotate_16[j]])    
    else (w1u14[round, j] = wu14[round, left_rotate_16[j]])
    endif
);



% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1u15[round, j] = w1u15[round, j])
   else (y1u14[round, j] = w1u14[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu15[round, j] = w1u15[round, j])
   else (yu14[round, j] = w1u14[round, j])
   endif
);   


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 13, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(xu11[round, j], y1u15[round, j], c[round, 13, j], wu11[round, j], c[round, 13, j - 1], c1[round, 13, j]))
    else (bit_addition(xu9[round, j], y1u14[round, j], c[round, 13, j], wu9[round, j], c[round, 13, j - 1], c1[round, 13, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(xu11[round, 0], y1u15[round, 0], c[round, 13, 0], wu11[round, 0], c1[round, 13, 32], c1[round, 13, 0]))
    else (bit_addition(xu9[round, 0], y1u14[round, 0], c[round, 13, 0], wu9[round, 0], c1[round, 13, 32], c1[round, 13, 0]))
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1u11[round, j] = wu11[round, j])
   else (w1u9[round, j] = wu9[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yu11[round, j] = wu11[round, j])
   else (yu9[round, j] = wu9[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(w1u11[round, j], w1u7[round, j], y1u7[round, j]))
   else (exclusive_or(w1u9[round, j], w1u4[round, j], y1u4[round, j]))
   endif
); 


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yu7[round, j] = y1u7[round, left_rotate_12[j]])    
    else (yu4[round, j] = y1u4[round, left_rotate_12[j]])
    endif
);



%  _   _           _    __            ___                           _                           ____                                _            ___  
% | | | |   __ _  | |  / _|          / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |          ( _ ) 
% | |_| |  / _` | | | | |_   _____  | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|         | |_) |  / _ \  | | | | | '_ \   / _` |  _____   / _ \ 
% |  _  | | (_| | | | |  _| |_____| | |_| | | |_| | | (_| | | |    | |_  |  __/ | |            |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | (_) |
% |_| |_|  \__,_| |_| |_|            \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|     _____  |_| \_\  \___/   \__,_| |_| |_|  \__,_|          \___/ 
%                                                                                      |_____|                                                        


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zu7[round, j] = yu7[round, j])
   else (zu4[round, j] = yu4[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u7[round, j] = yu7[round, j])
   else (z1u4[round, j] = yu4[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 14, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu3[round, j], zu7[round, j], c[round, 14, j], zu3[round, j], c[round, 14, j - 1], c1[round, 14, j]))
    else (bit_addition(yu3[round, j], zu4[round, j], c[round, 14, j], zu3[round, j], c[round, 14, j - 1], c1[round, 14, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu3[round, 0], zu7[round, 0], c[round, 14, 0], zu3[round, 0], c1[round, 14, 32], c1[round, 14, 0]))
    else (bit_addition(yu3[round, 0], zu4[round, 0], c[round, 14, 0], zu3[round, 0], c1[round, 14, 32], c1[round, 14, 0]))
    endif
);



% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u3[round, j] = zu3[round, j])
   else (z1u3[round, j] = zu3[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu3[round + 1, j] = zu3[round, j])
   else (xu3[round + 1, j] = zu3[round, j])
   endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(yu15[round, j], z1u3[round, j], zu15[round, j]))
   else (exclusive_or(yu14[round, j], z1u3[round, j], zu14[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (z1u15[round, j] = zu15[round, left_rotate_8[j]])    
    else (z1u14[round, j] = zu14[round, left_rotate_8[j]])
    endif
);


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1u15[round, j] = z1u15[round, j])
   else (v1u14[round, j] = z1u14[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu15[round + 1, j] = z1u15[round, j])
   else (xu14[round + 1, j] = z1u14[round, j])
   endif
);   



% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    c[round, 15, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(yu11[round, j], v1u15[round, j], c[round, 15, j], zu11[round, j], c[round, 15, j - 1], c1[round, 15, j]))
    else (bit_addition(yu9[round, j], v1u14[round, j], c[round, 15, j], zu9[round, j], c[round, 15, j - 1], c1[round, 15, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(yu11[round, 0], v1u15[round, 0], c[round, 15, 0], zu11[round, 0], c1[round, 15, 32], c1[round, 15, 0]))
    else (bit_addition(yu9[round, 0], v1u14[round, 0], c[round, 15, 0], zu9[round, 0], c1[round, 15, 32], c1[round, 15, 0]))
    endif
);




% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1u11[round, j] = zu11[round, j])
   else (z1u9[round, j] = zu9[round, j])
   endif
);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xu11[round + 1, j] = zu11[round, j])
   else (xu9[round + 1, j] = zu9[round, j])
   endif
);   


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(z1u11[round, j], z1u7[round, j], v1u7[round, j]))
   else (exclusive_or(z1u9[round, j], z1u4[round, j], v1u4[round, j]))
   endif
); 

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xu7[round + 1, j] = v1u7[round, left_rotate_7[j]])    
    else (xu4[round + 1, j] = v1u4[round, left_rotate_7[j]])
    endif
);



constraint sum(j in 0..31)(xu0[0, j] + xu1[0, j] + xu2[0, j] + xu3[0, j] + xu4[0, j] + xu5[0, j] + xu6[0, j] + xu7[0, j] + xu8[0, j] + xu9[0, j] + xu10[0, j] + xu11[0, j] + xu12[0, j] + xu13[0, j] + xu14[0, j] + xu15[0, j]) != 0;
%constraint forall(i in 0..11, j in 0..31)(xu[0, i, j] = 0);
constraint forall(i in 0..31) (xu0[0, i] = 0);
constraint forall(i in 0..31) (xu1[0, i] = 0);
constraint forall(i in 0..31) (xu2[0, i] = 0);
constraint forall(i in 0..31) (xu3[0, i] = 0);
constraint forall(i in 0..31) (xu4[0, i] = 0);
constraint forall(i in 0..31) (xu5[0, i] = 0);
constraint forall(i in 0..31) (xu6[0, i] = 0);
constraint forall(i in 0..31) (xu7[0, i] = 0);
constraint forall(i in 0..31) (xu8[0, i] = 0);
constraint forall(i in 0..31) (xu9[0, i] = 0);
constraint forall(i in 0..31) (xu10[0, i] = 0);
constraint forall(i in 0..31) (xu11[0, i] = 0);

%constraint sum(j in 0..31)(yu0[1, j] + yu1[1, j] + yu2[1, j] + yu3[1, j] + yu4[1, j] + yu5[1, j] + yu6[1, j] + yu7[1, j] + yu8[1, j] + yu9[1, j] + yu10[1, j] + yu11[1, j] + yu12[1, j] + yu13[1, j] + yu14[1, j] + yu15[1, j]) >= -510;

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
array[0..RD, 0..31] of var -1..1: xd4;
array[0..RD, 0..31] of var -1..1: xd5;
array[0..RD, 0..31] of var -1..1: xd6;
array[0..RD, 0..31] of var -1..1: xd7;
array[0..RD, 0..31] of var -1..1: xd8;
array[0..RD, 0..31] of var -1..1: xd9;
array[0..RD, 0..31] of var -1..1: xd10;
array[0..RD, 0..31] of var -1..1: xd11;
array[0..RD, 0..31] of var -1..1: xd12;
array[0..RD, 0..31] of var -1..1: xd13;
array[0..RD, 0..31] of var -1..1: xd14;
array[0..RD, 0..31] of var -1..1: xd15;


array[0..RD, 0..31] of var -1..1: yd0;
array[0..RD, 0..31] of var -1..1: yd1;
array[0..RD, 0..31] of var -1..1: yd2;
array[0..RD, 0..31] of var -1..1: yd3;
array[0..RD, 0..31] of var -1..1: yd4;
array[0..RD, 0..31] of var -1..1: yd5;
array[0..RD, 0..31] of var -1..1: yd6;
array[0..RD, 0..31] of var -1..1: yd7;
array[0..RD, 0..31] of var -1..1: yd8;
array[0..RD, 0..31] of var -1..1: yd9;
array[0..RD, 0..31] of var -1..1: yd10;
array[0..RD, 0..31] of var -1..1: yd11;
array[0..RD, 0..31] of var -1..1: yd12;
array[0..RD, 0..31] of var -1..1: yd13;
array[0..RD, 0..31] of var -1..1: yd14;
array[0..RD, 0..31] of var -1..1: yd15;


array[0..(RD - 1), 0..31] of var -1..1: wd0;
array[0..(RD - 1), 0..31] of var -1..1: wd1;
array[0..(RD - 1), 0..31] of var -1..1: wd2;
array[0..(RD - 1), 0..31] of var -1..1: wd3;
array[0..(RD - 1), 0..31] of var -1..1: wd4;
array[0..(RD - 1), 0..31] of var -1..1: wd5;
array[0..(RD - 1), 0..31] of var -1..1: wd6;
array[0..(RD - 1), 0..31] of var -1..1: wd7;
array[0..(RD - 1), 0..31] of var -1..1: wd8;
array[0..(RD - 1), 0..31] of var -1..1: wd9;
array[0..(RD - 1), 0..31] of var -1..1: wd10;
array[0..(RD - 1), 0..31] of var -1..1: wd11;
array[0..(RD - 1), 0..31] of var -1..1: wd12;
array[0..(RD - 1), 0..31] of var -1..1: wd13;
array[0..(RD - 1), 0..31] of var -1..1: wd14;
array[0..(RD - 1), 0..31] of var -1..1: wd15;


array[0..(RD - 1), 0..31] of var -1..1: zd0;
array[0..(RD - 1), 0..31] of var -1..1: zd1;
array[0..(RD - 1), 0..31] of var -1..1: zd2;
array[0..(RD - 1), 0..31] of var -1..1: zd3;
array[0..(RD - 1), 0..31] of var -1..1: zd4;
array[0..(RD - 1), 0..31] of var -1..1: zd5;
array[0..(RD - 1), 0..31] of var -1..1: zd6;
array[0..(RD - 1), 0..31] of var -1..1: zd7;
array[0..(RD - 1), 0..31] of var -1..1: zd8;
array[0..(RD - 1), 0..31] of var -1..1: zd9;
array[0..(RD - 1), 0..31] of var -1..1: zd10;
array[0..(RD - 1), 0..31] of var -1..1: zd11;
array[0..(RD - 1), 0..31] of var -1..1: zd12;
array[0..(RD - 1), 0..31] of var -1..1: zd13;
array[0..(RD - 1), 0..31] of var -1..1: zd14;
array[0..(RD - 1), 0..31] of var -1..1: zd15;


array[0..(RD - 1), 0..31] of var -1..1: w1d0;
array[0..(RD - 1), 0..31] of var -1..1: w1d1;
array[0..(RD - 1), 0..31] of var -1..1: w1d2;
array[0..(RD - 1), 0..31] of var -1..1: w1d3;
array[0..(RD - 1), 0..31] of var -1..1: w1d4;
array[0..(RD - 1), 0..31] of var -1..1: w1d5;
array[0..(RD - 1), 0..31] of var -1..1: w1d6;
array[0..(RD - 1), 0..31] of var -1..1: w1d7;
array[0..(RD - 1), 0..31] of var -1..1: w1d8;
array[0..(RD - 1), 0..31] of var -1..1: w1d9;
array[0..(RD - 1), 0..31] of var -1..1: w1d10;
array[0..(RD - 1), 0..31] of var -1..1: w1d11;
array[0..(RD - 1), 0..31] of var -1..1: w1d12;
array[0..(RD - 1), 0..31] of var -1..1: w1d13;
array[0..(RD - 1), 0..31] of var -1..1: w1d14;
array[0..(RD - 1), 0..31] of var -1..1: w1d15;


array[0..(RD - 1), 0..31] of var -1..1: z1d0;
array[0..(RD - 1), 0..31] of var -1..1: z1d1;
array[0..(RD - 1), 0..31] of var -1..1: z1d2;
array[0..(RD - 1), 0..31] of var -1..1: z1d3;
array[0..(RD - 1), 0..31] of var -1..1: z1d4;
array[0..(RD - 1), 0..31] of var -1..1: z1d5;
array[0..(RD - 1), 0..31] of var -1..1: z1d6;
array[0..(RD - 1), 0..31] of var -1..1: z1d7;
array[0..(RD - 1), 0..31] of var -1..1: z1d8;
array[0..(RD - 1), 0..31] of var -1..1: z1d9;
array[0..(RD - 1), 0..31] of var -1..1: z1d10;
array[0..(RD - 1), 0..31] of var -1..1: z1d11;
array[0..(RD - 1), 0..31] of var -1..1: z1d12;
array[0..(RD - 1), 0..31] of var -1..1: z1d13;
array[0..(RD - 1), 0..31] of var -1..1: z1d14;
array[0..(RD - 1), 0..31] of var -1..1: z1d15;

array[0..(RD - 1), 0..31] of var -1..1: y1d4;
array[0..(RD - 1), 0..31] of var -1..1: y1d5;
array[0..(RD - 1), 0..31] of var -1..1: y1d6;
array[0..(RD - 1), 0..31] of var -1..1: y1d7;
array[0..(RD - 1), 0..31] of var -1..1: y1d12;
array[0..(RD - 1), 0..31] of var -1..1: y1d13;
array[0..(RD - 1), 0..31] of var -1..1: y1d14;
array[0..(RD - 1), 0..31] of var -1..1: y1d15;

array[0..(RD - 1), 0..31] of var -1..1: v1d4;
array[0..(RD - 1), 0..31] of var -1..1: v1d5;
array[0..(RD - 1), 0..31] of var -1..1: v1d6;
array[0..(RD - 1), 0..31] of var -1..1: v1d7;
array[0..(RD - 1), 0..31] of var -1..1: v1d12;
array[0..(RD - 1), 0..31] of var -1..1: v1d13;
array[0..(RD - 1), 0..31] of var -1..1: v1d14;
array[0..(RD - 1), 0..31] of var -1..1: v1d15;


array[0..(RD - 1), 0..15, 0..31] of var -1..1: d;
array[0..(RD - 1), 0..15, 0..32] of var -1..1: d1;


% _   _           _    __      ___                           _                           ____                                _           _ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         / |
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | |
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |_|
                                                                                                                                           

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd0[round, j] = xd0[round + 1, j])
   else (wd0[round, j] = xd0[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d0[round, j] = xd0[round + 1, j])
   else (w1d0[round, j] = xd0[round + 1, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd8[round, j] = xd8[round + 1, j])
   else (wd10[round, j] = xd10[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d8[round, j] = xd8[round + 1, j])
   else (w1d10[round, j] = xd10[round + 1, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd12[round, j] = xd12[round + 1, j])
   else (wd15[round, j] = xd15[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d12[round, j] = xd12[round + 1, j])
   else (w1d15[round, j] = xd15[round + 1, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xd4[round + 1, j] = wd4[round, left_rotate_7[j]])    
    else (xd5[round + 1, j] = wd5[round, left_rotate_7[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd4[round, j], wd8[round, j], w1d4[round, j]))
   else (exclusive_or(wd5[round, j], wd10[round, j], w1d5[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 0, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d8[round, j], w1d12[round, j], d[round, 0, j], yd8[round, j], d[round, 0, j - 1], d1[round, 0, j]))
    else (bit_addition(w1d10[round, j], w1d15[round, j], d[round, 0, j], yd10[round, j], d[round, 0, j - 1], d1[round, 0, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d8[round, 0], w1d12[round, 0], d[round, 0, 0], yd8[round, 0], d1[round, 0, 32], d1[round, 0, 0]))
    else (bit_addition(w1d10[round, 0], w1d15[round, 0], d[round, 0, 0], yd10[round, 0], d1[round, 0, 32], d1[round, 0, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (wd12[round, j] = y1d12[round, left_rotate_8[j]])    
    else (wd15[round, j] = y1d15[round, left_rotate_8[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd0[round, j], y1d12[round, j], yd12[round, j]))
   else (exclusive_or(wd0[round, j], y1d15[round, j], yd15[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yd4[round, j] = w1d4[round, j])
   else (yd5[round, j] = w1d5[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1d4[round, j] = w1d4[round, j])
   else (y1d5[round, j] = w1d5[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 1, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d0[round, j], y1d4[round, j], d[round, 1, j], yd0[round, j], d[round, 1, j - 1], d1[round, 1, j]))
    else (bit_addition(w1d0[round, j], y1d5[round, j], d[round, 1, j], yd0[round, j], d[round, 1, j - 1], d1[round, 1, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d0[round, 0], y1d4[round, 0], d[round, 1, 0], yd0[round, 0], d1[round, 1, 32], d1[round, 1, 0]))
    else (bit_addition(w1d0[round, 0], y1d5[round, 0], d[round, 1, 0], yd0[round, 0], d1[round, 1, 32], d1[round, 1, 0]))
    endif
);

%  _   _           _    __      ___                           _                           ____                                _           ____  
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___ \ 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____    __) |
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  / __/ 
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |_____|
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd0[round, j] = yd0[round, j])
   else (zd0[round, j] = yd0[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d0[round, j] = yd0[round, j])
   else (z1d0[round, j] = yd0[round, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd8[round, j] = yd8[round, j])
   else (zd10[round, j] = yd10[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d8[round, j] = yd8[round, j])
   else (z1d10[round, j] = yd10[round, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd12[round, j] = yd12[round, j])
   else (zd15[round, j] = yd15[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d12[round, j] = yd12[round, j])
   else (z1d15[round, j] = yd15[round, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yd4[round, j] = zd4[round, left_rotate_12[j]])    
    else (yd5[round, j] = zd5[round, left_rotate_12[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd4[round, j], zd8[round, j], z1d4[round, j]))
   else (exclusive_or(zd5[round, j], zd10[round, j], z1d5[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 2, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d8[round, j], z1d12[round, j], d[round, 2, j], xd8[round, j], d[round, 2, j - 1], d1[round, 2, j]))
    else (bit_addition(z1d10[round, j], z1d15[round, j], d[round, 2, j], xd10[round, j], d[round, 2, j - 1], d1[round, 2, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d8[round, 0], z1d12[round, 0], d[round, 2, 0], xd8[round, 0], d1[round, 2, 32], d1[round, 2, 0]))
    else (bit_addition(z1d10[round, 0], z1d15[round, 0], d[round, 2, 0], xd10[round, 0], d1[round, 2, 32], d1[round, 2, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (zd12[round, j] = v1d12[round, left_rotate_16[j]])    
    else (zd15[round, j] = v1d15[round, left_rotate_16[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd0[round, j], v1d12[round, j], xd12[round, j]))
   else (exclusive_or(zd0[round, j], v1d15[round, j], xd15[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xd4[round, j] = z1d4[round, j])
   else (xd5[round, j] = z1d5[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1d4[round, j] = z1d4[round, j])
   else (v1d5[round, j] = z1d5[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 3, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d0[round, j], v1d4[round, j], d[round, 3, j], xd0[round, j], d[round, 3, j - 1], d1[round, 3, j]))
    else (bit_addition(z1d0[round, j], v1d5[round, j], d[round, 3, j], xd0[round, j], d[round, 3, j - 1], d1[round, 3, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d0[round, 0], v1d4[round, 0], d[round, 3, 0], xd0[round, 0], d1[round, 3, 32], d1[round, 3, 0]))
    else (bit_addition(z1d0[round, 0], v1d5[round, 0], d[round, 3, 0], xd0[round, 0], d1[round, 3, 32], d1[round, 3, 0]))
    endif
);

%  _   _           _    __      ___                           _                           ____                                _           _____ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___ / 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____    |_ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  ___) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |____/ 
                                                                                                                                               
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd1[round, j] = xd1[round + 1, j])
   else (wd1[round, j] = xd1[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d1[round, j] = xd1[round + 1, j])
   else (w1d1[round, j] = xd1[round + 1, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd9[round, j] = xd9[round + 1, j])
   else (wd11[round, j] = xd11[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d9[round, j] = xd9[round + 1, j])
   else (w1d11[round, j] = xd11[round + 1, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd13[round, j] = xd13[round + 1, j])
   else (wd12[round, j] = xd12[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d13[round, j] = xd13[round + 1, j])
   else (w1d12[round, j] = xd12[round + 1, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xd5[round + 1, j] = wd5[round, left_rotate_7[j]])    
    else (xd6[round + 1, j] = wd6[round, left_rotate_7[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd5[round, j], wd9[round, j], w1d5[round, j]))
   else (exclusive_or(wd6[round, j], wd11[round, j], w1d6[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 4, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d9[round, j], w1d13[round, j], d[round, 4, j], yd9[round, j], d[round, 4, j - 1], d1[round, 4, j]))
    else (bit_addition(w1d11[round, j], w1d12[round, j], d[round, 4, j], yd11[round, j], d[round, 4, j - 1], d1[round, 4, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d9[round, 0], w1d13[round, 0], d[round, 4, 0], yd9[round, 0], d1[round, 4, 32], d1[round, 4, 0]))
    else (bit_addition(w1d11[round, 0], w1d12[round, 0], d[round, 4, 0], yd11[round, 0], d1[round, 4, 32], d1[round, 4, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (wd13[round, j] = y1d13[round, left_rotate_8[j]])    
    else (wd12[round, j] = y1d12[round, left_rotate_8[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd1[round, j], y1d13[round, j], yd13[round, j]))
   else (exclusive_or(wd1[round, j], y1d12[round, j], yd12[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yd5[round, j] = w1d5[round, j])
   else (yd6[round, j] = w1d6[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1d5[round, j] = w1d5[round, j])
   else (y1d6[round, j] = w1d6[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 5, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d1[round, j], y1d5[round, j], d[round, 5, j], yd1[round, j], d[round, 5, j - 1], d1[round, 5, j]))
    else (bit_addition(w1d1[round, j], y1d6[round, j], d[round, 5, j], yd1[round, j], d[round, 5, j - 1], d1[round, 5, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d1[round, 0], y1d5[round, 0], d[round, 5, 0], yd1[round, 0], d1[round, 5, 32], d1[round, 5, 0]))
    else (bit_addition(w1d1[round, 0], y1d6[round, 0], d[round, 5, 0], yd1[round, 0], d1[round, 5, 32], d1[round, 5, 0]))
    endif
);

%  _   _           _    __      ___                           _                           ____                                _           _  _   
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         | || |  
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | || |_ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| |__   _|
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|            |_|  
                                                                                                                                                

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd1[round, j] = yd1[round, j])
   else (zd1[round, j] = yd1[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d1[round, j] = yd1[round, j])
   else (z1d1[round, j] = yd1[round, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd9[round, j] = yd9[round, j])
   else (zd11[round, j] = yd11[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d9[round, j] = yd9[round, j])
   else (z1d11[round, j] = yd11[round, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd13[round, j] = yd13[round, j])
   else (zd12[round, j] = yd12[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d13[round, j] = yd13[round, j])
   else (z1d12[round, j] = yd12[round, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yd5[round, j] = zd5[round, left_rotate_12[j]])    
    else (yd6[round, j] = zd6[round, left_rotate_12[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd5[round, j], zd9[round, j], z1d5[round, j]))
   else (exclusive_or(zd6[round, j], zd11[round, j], z1d6[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 6, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d9[round, j], z1d13[round, j], d[round, 6, j], xd9[round, j], d[round, 6, j - 1], d1[round, 6, j]))
    else (bit_addition(z1d11[round, j], z1d12[round, j], d[round, 6, j], xd11[round, j], d[round, 6, j - 1], d1[round, 6, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d9[round, 0], z1d13[round, 0], d[round, 6, 0], xd9[round, 0], d1[round, 6, 32], d1[round, 6, 0]))
    else (bit_addition(z1d11[round, 0], z1d12[round, 0], d[round, 6, 0], xd11[round, 0], d1[round, 6, 32], d1[round, 6, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (zd13[round, j] = v1d13[round, left_rotate_16[j]])    
    else (zd12[round, j] = v1d12[round, left_rotate_16[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd1[round, j], v1d13[round, j], xd13[round, j]))
   else (exclusive_or(zd1[round, j], v1d12[round, j], xd12[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xd5[round, j] = z1d5[round, j])
   else (xd6[round, j] = z1d6[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1d5[round, j] = z1d5[round, j])
   else (v1d6[round, j] = z1d6[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 7, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d1[round, j], v1d5[round, j], d[round, 7, j], xd1[round, j], d[round, 7, j - 1], d1[round, 7, j]))
    else (bit_addition(z1d1[round, j], v1d6[round, j], d[round, 7, j], xd1[round, j], d[round, 7, j - 1], d1[round, 7, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d1[round, 0], v1d5[round, 0], d[round, 7, 0], xd1[round, 0], d1[round, 7, 32], d1[round, 7, 0]))
    else (bit_addition(z1d1[round, 0], v1d6[round, 0], d[round, 7, 0], xd1[round, 0], d1[round, 7, 32], d1[round, 7, 0]))
    endif
);
                                                                                                                             

%  _   _           _    __      ___                           _                           ____                                _           ____  
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         | ___| 
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  |___ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|  ___) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|         |____/ 
                                                                                                                                               


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd2[round, j] = xd2[round + 1, j])
   else (wd2[round, j] = xd2[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d2[round, j] = xd2[round + 1, j])
   else (w1d2[round, j] = xd2[round + 1, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd10[round, j] = xd10[round + 1, j])
   else (wd8[round, j] = xd8[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d10[round, j] = xd10[round + 1, j])
   else (w1d8[round, j] = xd8[round + 1, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd14[round, j] = xd14[round + 1, j])
   else (wd13[round, j] = xd13[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d14[round, j] = xd14[round + 1, j])
   else (w1d13[round, j] = xd13[round + 1, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xd6[round + 1, j] = wd6[round, left_rotate_7[j]])    
    else (xd7[round + 1, j] = wd7[round, left_rotate_7[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd6[round, j], wd10[round, j], w1d6[round, j]))
   else (exclusive_or(wd7[round, j], wd8[round, j], w1d7[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 8, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d10[round, j], w1d14[round, j], d[round, 8, j], yd10[round, j], d[round, 8, j - 1], d1[round, 8, j]))
    else (bit_addition(w1d8[round, j], w1d13[round, j], d[round, 8, j], yd8[round, j], d[round, 8, j - 1], d1[round, 8, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d10[round, 0], w1d14[round, 0], d[round, 8, 0], yd10[round, 0], d1[round, 8, 32], d1[round, 8, 0]))
    else (bit_addition(w1d8[round, 0], w1d13[round, 0], d[round, 8, 0], yd8[round, 0], d1[round, 8, 32], d1[round, 8, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (wd14[round, j] = y1d14[round, left_rotate_8[j]])    
    else (wd13[round, j] = y1d13[round, left_rotate_8[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd2[round, j], y1d14[round, j], yd14[round, j]))
   else (exclusive_or(wd2[round, j], y1d13[round, j], yd13[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yd6[round, j] = w1d6[round, j])
   else (yd7[round, j] = w1d7[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1d6[round, j] = w1d6[round, j])
   else (y1d7[round, j] = w1d7[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 9, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d2[round, j], y1d6[round, j], d[round, 9, j], yd2[round, j], d[round, 9, j - 1], d1[round, 9, j]))
    else (bit_addition(w1d2[round, j], y1d7[round, j], d[round, 9, j], yd2[round, j], d[round, 9, j - 1], d1[round, 9, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d2[round, 0], y1d6[round, 0], d[round, 9, 0], yd2[round, 0], d1[round, 9, 32], d1[round, 9, 0]))
    else (bit_addition(w1d2[round, 0], y1d7[round, 0], d[round, 9, 0], yd2[round, 0], d1[round, 9, 32], d1[round, 9, 0]))
    endif
);


%  _   _           _    __      ___                           _                           ____                                _            __   
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |          / /_  
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____  | '_ \ 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | (_) |
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|          \___/ 
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd2[round, j] = yd2[round, j])
   else (zd2[round, j] = yd2[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d2[round, j] = yd2[round, j])
   else (z1d2[round, j] = yd2[round, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd10[round, j] = yd10[round, j])
   else (zd8[round, j] = yd8[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d10[round, j] = yd10[round, j])
   else (z1d8[round, j] = yd8[round, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd14[round, j] = yd14[round, j])
   else (zd13[round, j] = yd13[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d14[round, j] = yd14[round, j])
   else (z1d13[round, j] = yd13[round, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yd6[round, j] = zd6[round, left_rotate_12[j]])    
    else (yd7[round, j] = zd7[round, left_rotate_12[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd6[round, j], zd10[round, j], z1d6[round, j]))
   else (exclusive_or(zd7[round, j], zd8[round, j], z1d7[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 10, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d10[round, j], z1d14[round, j], d[round, 10, j], xd10[round, j], d[round, 10, j - 1], d1[round, 10, j]))
    else (bit_addition(z1d8[round, j], z1d13[round, j], d[round, 10, j], xd8[round, j], d[round, 10, j - 1], d1[round, 10, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d10[round, 0], z1d14[round, 0], d[round, 10, 0], xd10[round, 0], d1[round, 10, 32], d1[round, 10, 0]))
    else (bit_addition(z1d8[round, 0], z1d13[round, 0], d[round, 10, 0], xd8[round, 0], d1[round, 10, 32], d1[round, 10, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (zd14[round, j] = v1d14[round, left_rotate_16[j]])    
    else (zd13[round, j] = v1d13[round, left_rotate_16[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd2[round, j], v1d14[round, j], xd14[round, j]))
   else (exclusive_or(zd2[round, j], v1d13[round, j], xd13[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xd6[round, j] = z1d6[round, j])
   else (xd7[round, j] = z1d7[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1d6[round, j] = z1d6[round, j])
   else (v1d7[round, j] = z1d7[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 11, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d2[round, j], v1d6[round, j], d[round, 11, j], xd2[round, j], d[round, 11, j - 1], d1[round, 11, j]))
    else (bit_addition(z1d2[round, j], v1d7[round, j], d[round, 11, j], xd2[round, j], d[round, 11, j - 1], d1[round, 11, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d2[round, 0], v1d6[round, 0], d[round, 11, 0], xd2[round, 0], d1[round, 11, 32], d1[round, 11, 0]))
    else (bit_addition(z1d2[round, 0], v1d7[round, 0], d[round, 11, 0], xd2[round, 0], d1[round, 11, 32], d1[round, 11, 0]))
    endif
);
                                                                                                                             

% _   _           _    __      ___                           _                           ____                                _           _____ 
% | | | |   __ _  | |  / _|    / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |         |___  |
% | |_| |  / _` | | | | |_    | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|  _____  | |_) |  / _ \  | | | | | '_ \   / _` |  _____     / / 
% |  _  | | (_| | | | |  _|   | |_| | | |_| | | (_| | | |    | |_  |  __/ | |    |_____| |  _ <  | (_) | | |_| | | | | | | (_| | |_____|   / /  
% |_| |_|  \__,_| |_| |_|      \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|            |_| \_\  \___/   \__,_| |_| |_|  \__,_|          /_/   
                                                                                                                                               

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd3[round, j] = xd3[round + 1, j])
   else (wd3[round, j] = xd3[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d3[round, j] = xd3[round + 1, j])
   else (w1d3[round, j] = xd3[round + 1, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd11[round, j] = xd11[round + 1, j])
   else (wd9[round, j] = xd9[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d11[round, j] = xd11[round + 1, j])
   else (w1d9[round, j] = xd9[round + 1, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (wd15[round, j] = xd15[round + 1, j])
   else (wd14[round, j] = xd14[round + 1, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (w1d15[round, j] = xd15[round + 1, j])
   else (w1d14[round, j] = xd14[round + 1, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (xd7[round + 1, j] = wd7[round, left_rotate_7[j]])    
    else (xd4[round + 1, j] = wd4[round, left_rotate_7[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd7[round, j], wd11[round, j], w1d7[round, j]))
   else (exclusive_or(wd4[round, j], wd9[round, j], w1d4[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 12, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d11[round, j], w1d15[round, j], d[round, 12, j], yd11[round, j], d[round, 12, j - 1], d1[round, 12, j]))
    else (bit_addition(w1d9[round, j], w1d14[round, j], d[round, 12, j], yd9[round, j], d[round, 12, j - 1], d1[round, 12, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d11[round, 0], w1d15[round, 0], d[round, 12, 0], yd11[round, 0], d1[round, 12, 32], d1[round, 12, 0]))
    else (bit_addition(w1d9[round, 0], w1d14[round, 0], d[round, 12, 0], yd9[round, 0], d1[round, 12, 32], d1[round, 12, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (wd15[round, j] = y1d15[round, left_rotate_8[j]])    
    else (wd14[round, j] = y1d14[round, left_rotate_8[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(wd3[round, j], y1d15[round, j], yd15[round, j]))
   else (exclusive_or(wd3[round, j], y1d14[round, j], yd14[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (yd7[round, j] = w1d7[round, j])
   else (yd4[round, j] = w1d4[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (y1d7[round, j] = w1d7[round, j])
   else (y1d4[round, j] = w1d4[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 13, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(w1d3[round, j], y1d7[round, j], d[round, 13, j], yd3[round, j], d[round, 13, j - 1], d1[round, 13, j]))
    else (bit_addition(w1d3[round, j], y1d4[round, j], d[round, 13, j], yd3[round, j], d[round, 13, j - 1], d1[round, 13, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(w1d3[round, 0], y1d7[round, 0], d[round, 13, 0], yd3[round, 0], d1[round, 13, 32], d1[round, 13, 0]))
    else (bit_addition(w1d3[round, 0], y1d4[round, 0], d[round, 13, 0], yd3[round, 0], d1[round, 13, 32], d1[round, 13, 0]))
    endif
);


%  _   _           _    __            ___                           _                           ____                                _            ___  
% | | | |   __ _  | |  / _|          / _ \   _   _    __ _   _ __  | |_    ___   _ __          |  _ \    ___    _   _   _ __     __| |          ( _ ) 
% | |_| |  / _` | | | | |_   _____  | | | | | | | |  / _` | | '__| | __|  / _ \ | '__|         | |_) |  / _ \  | | | | | '_ \   / _` |  _____   / _ \ 
% |  _  | | (_| | | | |  _| |_____| | |_| | | |_| | | (_| | | |    | |_  |  __/ | |            |  _ <  | (_) | | |_| | | | | | | (_| | |_____| | (_) |
% |_| |_|  \__,_| |_| |_|            \__\_\  \__,_|  \__,_| |_|     \__|  \___| |_|     _____  |_| \_\  \___/   \__,_| |_| |_|  \__,_|          \___/ 
%                                                                                      |_____|                                                        


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd3[round, j] = yd3[round, j])
   else (zd3[round, j] = yd3[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d3[round, j] = yd3[round, j])
   else (z1d3[round, j] = yd3[round, j])
   endif
);

% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd11[round, j] = yd11[round, j])
   else (zd9[round, j] = yd9[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d11[round, j] = yd11[round, j])
   else (z1d9[round, j] = yd9[round, j])
   endif
);

  
% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (zd15[round, j] = yd15[round, j])
   else (zd14[round, j] = yd14[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (z1d15[round, j] = yd15[round, j])
   else (z1d14[round, j] = yd14[round, j])
   endif
);


% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (yd7[round, j] = zd7[round, left_rotate_12[j]])    
    else (yd4[round, j] = zd4[round, left_rotate_12[j]])
    endif
);

% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd7[round, j], zd11[round, j], z1d7[round, j]))
   else (exclusive_or(zd4[round, j], zd9[round, j], z1d4[round, j]))
   endif
); 
   
% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 14, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d11[round, j], z1d15[round, j], d[round, 14, j], xd11[round, j], d[round, 14, j - 1], d1[round, 14, j]))
    else (bit_addition(z1d9[round, j], z1d14[round, j], d[round, 14, j], xd9[round, j], d[round, 14, j - 1], d1[round, 14, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d11[round, 0], z1d15[round, 0], d[round, 14, 0], xd11[round, 0], d1[round, 14, 32], d1[round, 14, 0]))
    else (bit_addition(z1d9[round, 0], z1d14[round, 0], d[round, 14, 0], xd9[round, 0], d1[round, 14, 32], d1[round, 14, 0]))
    endif
);

% Rotation

constraint forall(round in 0..(RD - 1), j in 0..31)
(
    if (round mod 2 == 0) then (zd15[round, j] = v1d15[round, left_rotate_16[j]])    
    else (zd14[round, j] = v1d14[round, left_rotate_16[j]])
    endif
);


% exclusive or

constraint forall(round in 0..(RD - 1), j in 0..31)
(
   if (round mod 2 == 0) then (exclusive_or(zd3[round, j], v1d15[round, j], xd15[round, j]))
   else (exclusive_or(zd3[round, j], v1d14[round, j], xd14[round, j]))
   endif
);       


% Branching

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (xd7[round, j] = z1d7[round, j])
   else (xd4[round, j] = z1d4[round, j])
   endif

);

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
   if (round mod 2 == 0) then (v1d7[round, j] = z1d7[round, j])
   else (v1d4[round, j] = z1d4[round, j])
   endif
);


% Modulo Addition

constraint forall(round in 0..(RD - 1), j in 0..31)
( 
    d[round, 15, 31] = 0
);

constraint forall(round in 0..(RD - 1), j in 1..31)
( 
    if (round mod 2 == 0) then (bit_addition(z1d3[round, j], v1d7[round, j], d[round, 15, j], xd3[round, j], d[round, 15, j - 1], d1[round, 15, j]))
    else (bit_addition(z1d3[round, j], v1d4[round, j], d[round, 15, j], xd3[round, j], d[round, 15, j - 1], d1[round, 15, j]))
    endif
);

constraint forall(round in 0..(RD - 1))
( 
    if (round mod 2 == 0) then (bit_addition(z1d3[round, 0], v1d7[round, 0], d[round, 15, 0], xd3[round, 0], d1[round, 15, 32], d1[round, 15, 0]))
    else (bit_addition(z1d3[round, 0], v1d4[round, 0], d[round, 15, 0], xd3[round, 0], d1[round, 15, 32], d1[round, 15, 0]))
    endif
);
                                                                                                                             


constraint sum(j in 0..31)(xd0[RD, j] + xd1[RD, j] + xd2[RD, j] + xd3[RD, j] + xd4[RD, j] + xd5[RD, j] + xd6[RD, j] + xd7[RD, j] + xd8[RD, j] + xd9[RD, j] + xd10[RD, j] + xd11[RD, j] + xd12[RD, j] + xd13[RD, j] + xd14[RD, j] + xd15[RD, j]) != 0;

constraint forall(i in 0..31) (xd0[RD, i] = 0);
constraint forall(i in 0..31) (xd1[RD, i] = 0);
constraint forall(i in 0..31) (xd2[RD, i] = 0);
constraint forall(i in 0..31) (xd3[RD, i] = 0);
constraint forall(i in 0..31) (xd4[RD, i] = 0);
constraint forall(i in 0..31) (xd5[RD, i] = 0);
constraint forall(i in 0..31) (xd6[RD, i] = 0);
constraint forall(i in 0..31) (xd7[RD, i] = 0);
constraint forall(i in 0..31) (xd8[RD, i] = 0);
constraint forall(i in 0..31) (xd9[RD, i] = 0);
constraint forall(i in 0..31) (xd10[RD, i] = 0);
constraint forall(i in 0..31) (xd11[RD, i] = 0);


% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%  ____                         _                    _           _              __                     ____                   _                        _   _          _     _                 
%  / ___|   ___    _ __    ___  | |_   _ __    __ _  (_)  _ __   | |_   ___     / _|   ___    _ __     / ___|   ___    _ __   | |_   _ __    __ _    __| | (_)   ___  | |_  (_)   ___    _ __  
% | |      / _ \  | '_ \  / __| | __| | '__|  / _` | | | | '_ \  | __| / __|   | |_   / _ \  | '__|   | |      / _ \  | '_ \  | __| | '__|  / _` |  / _` | | |  / __| | __| | |  / _ \  | '_ \ 
% | |___  | (_) | | | | | \__ \ | |_  | |    | (_| | | | | | | | | |_  \__ \   |  _| | (_) | | |      | |___  | (_) | | | | | | |_  | |    | (_| | | (_| | | | | (__  | |_  | | | (_) | | | | |
%  \____|  \___/  |_| |_| |___/  \__| |_|     \__,_| |_| |_| |_|  \__| |___/   |_|    \___/  |_|       \____|  \___/  |_| |_|  \__| |_|     \__,_|  \__,_| |_|  \___|  \__| |_|  \___/  |_| |_|
                                                                                                                                                                                              

array[0..RD, 0..31] of var 0..1: contradict0;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict0[round, j] = bool2int(xu0[round, j] + xd0[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict1;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict1[round, j] = bool2int(xu1[round, j] + xd1[round, j] == 1)
);

array[0..RD, 0..31] of var 0..1: contradict2;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict2[round, j] = bool2int(xu2[round, j] + xd2[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict3;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict3[round, j] = bool2int(xu3[round, j] + xd3[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict4;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict4[round, j] = bool2int(xu4[round, j] + xd4[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict5;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict5[round, j] = bool2int(xu5[round, j] + xd5[round, j] == 1)
);

array[0..RD, 0..31] of var 0..1: contradict6;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict6[round, j] = bool2int(xu6[round, j] + xd6[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict7;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict7[round, j] = bool2int(xu7[round, j] + xd7[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict8;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict8[round, j] = bool2int(xu8[round, j] + xd8[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict9;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict9[round, j] = bool2int(xu9[round, j] + xd9[round, j] == 1)
);

array[0..RD, 0..31] of var 0..1: contradict10;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict10[round, j] = bool2int(xu10[round, j] + xd10[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict11;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict11[round, j] = bool2int(xu11[round, j] + xd11[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict12;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict12[round, j] = bool2int(xu12[round, j] + xd12[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict13;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict13[round, j] = bool2int(xu13[round, j] + xd13[round, j] == 1)
);

array[0..RD, 0..31] of var 0..1: contradict14;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict14[round, j] = bool2int(xu14[round, j] + xd14[round, j] == 1)
);


array[0..RD, 0..31] of var 0..1: contradict15;
constraint forall(round in 0..RD, j in 0..31)
(
    contradict15[round, j] = bool2int(xu15[round, j] + xd15[round, j] == 1)
);


%%%%


array[0..(RD - 1), 0..31] of var 0..1: contra0;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra0[round, j] = bool2int(yu0[round, j] + yd0[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra1;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra1[round, j] = bool2int(yu1[round, j] + yd1[round, j] == 1)
);

array[0..(RD - 1), 0..31] of var 0..1: contra2;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra2[round, j] = bool2int(yu2[round, j] + yd2[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra3;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra3[round, j] = bool2int(yu3[round, j] + yd3[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra4;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra4[round, j] = bool2int(yu4[round, j] + yd4[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra5;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra5[round, j] = bool2int(yu5[round, j] + yd5[round, j] == 1)
);

array[0..(RD - 1), 0..31] of var 0..1: contra6;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra6[round, j] = bool2int(yu6[round, j] + yd6[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra7;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra7[round, j] = bool2int(yu7[round, j] + yd7[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra8;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra8[round, j] = bool2int(yu8[round, j] + yd8[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra9;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra9[round, j] = bool2int(yu9[round, j] + yd9[round, j] == 1)
);

array[0..(RD - 1), 0..31] of var 0..1: contra10;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra10[round, j] = bool2int(yu10[round, j] + yd10[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra11;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra11[round, j] = bool2int(yu11[round, j] + yd11[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra12;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra12[round, j] = bool2int(yu12[round, j] + yd12[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra13;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra13[round, j] = bool2int(yu13[round, j] + yd13[round, j] == 1)
);

array[0..(RD - 1), 0..31] of var 0..1: contra14;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra14[round, j] = bool2int(yu14[round, j] + yd14[round, j] == 1)
);


array[0..(RD - 1), 0..31] of var 0..1: contra15;
constraint forall(round in 0..(RD - 1), j in 0..31)
(
    contra15[round, j] = bool2int(yu15[round, j] + yd15[round, j] == 1)
);



constraint sum(round in 0..(RD - 1), j in 0..31)(contra0[round, j] + contra1[round, j] + contra2[round, j] + contra3[round, j] + contra4[round, j] + contra5[round, j] + contra6[round, j] + contra7[round, j] + contra8[round, j] + contra9[round, j] + contra10[round, j] + contra11[round, j] + contra12[round, j] + contra13[round, j] + contra14[round, j] + contra15[round, j]) >= 1;


%constraint sum(round in 0..RD, j in 0..31)(contradict0[round, j] + contradict1[round, j] + contradict2[round, j] + contradict3[round, j] + contradict4[round, j] + contradict5[round, j] + contradict6[round, j] + contradict7[round, j] + contradict8[round, j] + contradict9[round, j] + contradict10[round, j] + contradict11[round, j] + contradict12[round, j] + contradict13[round, j] + contradict14[round, j] + contradict15[round, j]) >= 1;



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

solve minimize sum(j in 0..31)(xu0[0, j] + xu1[0, j] + xu2[0, j] + xu3[0, j] + xu4[0, j] + xu5[0, j] + xu6[0, j] + xu7[0, j] + xu8[0, j] + xu9[0, j] + xu10[0, j] + xu11[0, j] + xu12[0, j] + xu13[0, j] + xu14[0, j] + xu15[0, j] + xd0[RD, j] + xd1[RD, j] + xd2[RD, j] + xd3[RD, j] + xd4[RD, j] + xd5[RD, j] + xd6[RD, j] + xd7[RD, j] + xd8[RD, j] + xd9[RD, j] + xd10[RD, j] + xd11[RD, j] + xd12[RD, j] + xd13[RD, j] + xd14[RD, j] + xd15[RD, j]);
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

 
 
 
 
 
 
 
 
 

 
 
 
 
 
 



