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
int: MD;
constraint assert(RD >= 0, "Invalid value for RD: " ++
         "RD must be greater than or equal to 0");

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

array[0..31] of int: left_rotate_1 = array1d(0..31, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _   _ 
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| | | |
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | | | |
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |_| |
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____| \___/ 
% constraints for EU
int: k = 32;
%k1 = 16
array[0..RD, 0..(k - 1)] of var -1..1: xul;
array[0..RD, 0..(k - 1)] of var -1..1: xur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: yul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zul1;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: p;

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
  
   branching(xul[round, i], zul1[round, i], yul[round, i])

);


% Diffusion layer


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zul[round, i] = zul1[round, left_rotate_1[i]]
);


% Xor

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    xur[round, i] = zul[round, i]
   
);

% S-box layer
constraint forall(round in 0..(RD - 1), i in 0..4)
(
    sbox(yul[round, i], yul[round, 5 + i], yul[round, 10 + i], xur[round, i], xur[round, 5 + i],
         p[round, i], xur[round + 1, 5 + i], p[round, 10 + i], wul[round, i], wul[round, 5 + i])
);

constraint forall(round in 0..(RD - 1), i in 0..4)
(
    sbox(p[round, 10 + i], yul[round, 15 + i], yul[round, 20 + i], xur[round, 10 + i], xur[round, 15 + i],
         xur[round + 1, 10 + i], xur[round + 1, 15 + i], p[round, 20 + i], wul[round, 10 + i], wul[round, 15 + i])
);

constraint forall(round in 0..(RD - 1), i in 0..1)
(
    sbox(p[round, 20 + i], yul[round, 25 + i], yul[round, 30 + i], xur[round, 20 + i], xur[round, 25 + i],
         xur[round + 1, 20 + i], xur[round + 1, 25 + i], p[round, 30 + i], wul[round, 20 + i], wul[round, 25 + i])
);


constraint forall(round in 0..(RD - 1), i in 0..2)
(
    sbox(p[round, 22 + i], yul[round, 27 + i], p[round, i], xur[round, 22 + i], xur[round, 27 + i],
         xur[round + 1, 22 + i], xur[round + 1, 27 + i], xur[round + 1, i], wul[round, 22 + i], wul[round, 27 + i])
);



constraint forall(round in 0..(RD - 1), i in 0..1)
(
    sbox1(p[round, 30 + i], p[round, 3 + i], xur[round, 30 + i], xur[round + 1, 30 + i], xur[round + 1, 3 + i], wul[round, 30 + i])
);


% Xor

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    zul[round, i] = wul[round, i]
   
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    xul[round + 1, i] = wul[round, i]
   
);

constraint sum(i in 0..(k - 1)) (xul[0, i] + xur[0, i]) != 0;

constraint forall(i in 0..(k - 1))(xur[0, i] = 0);
constraint forall(i in 1..(k - 1))(xul[0, i] = 0);
constraint (xul[0, 0] = 1);

% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _     
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| |    
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | |    
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |___ 
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____||_____|
% constraints for EL


array[0..RD, 0..(k - 1)] of var -1..1: xdl;
array[0..RD, 0..(k - 1)] of var -1..1: xdr;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: ydl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zdl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wdl;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zdl1;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: pd;

% Branching

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
  
   branching(xdr[round + 1, i], zdl1[round, i], ydl[round, i])

);


% Diffusion layer


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zdl[round, i] = zdl1[round, left_rotate_1[i]]
);


% Xor

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    xdl[round + 1, i] = zdl[round, i]
   
);

% S-box layer
constraint forall(round in 0..(RD - 1), i in 0..4)
(
    sbox(ydl[round, i], ydl[round, 5 + i], ydl[round, 10 + i], xdl[round + 1, i], xdl[round + 1, 5 + i],
         pd[round, i], xdl[round, 5 + i], pd[round, 10 + i], wdl[round, i], wdl[round, 5 + i])
);

constraint forall(round in 0..(RD - 1), i in 0..4)
(
    sbox(pd[round, 10 + i], ydl[round, 15 + i], ydl[round, 20 + i], xdl[round + 1, 10 + i], xdl[round + 1, 15 + i],
         xdl[round, 10 + i], xdl[round, 15 + i], pd[round, 20 + i], wdl[round, 10 + i], wdl[round, 15 + i])
);

constraint forall(round in 0..(RD - 1), i in 0..1)
(
    sbox(pd[round, 20 + i], ydl[round, 25 + i], ydl[round, 30 + i], xdl[round + 1, 20 + i], xdl[round + 1, 25 + i],
         xdl[round, 20 + i], xdl[round, 25 + i], pd[round, 30 + i], wdl[round, 20 + i], wdl[round, 25 + i])
);


constraint forall(round in 0..(RD - 1), i in 0..2)
(
    sbox(pd[round, 22 + i], ydl[round, 27 + i], pd[round, i], xdl[round + 1, 22 + i], xdl[round + 1, 27 + i],
         xdl[round, 22 + i], xdl[round, 27 + i], xdl[round, i], wdl[round, 22 + i], wdl[round, 27 + i])
);



constraint forall(round in 0..(RD - 1), i in 0..1)
(
    sbox1(pd[round, 30 + i], pd[round, 3 + i], xdl[round + 1, 30 + i], xdl[round, 30 + i], xdl[round, 3 + i], wdl[round, 30 + i])
);

% Xor

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    zdl[round, i] = wdl[round, i]
   
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    
    xdr[round, i] = wdl[round, i]
   
);

constraint sum(i in 0..(k - 1)) (xdl[RD, i] + xdr[RD, i]) != 0;

constraint forall(i in 0..(k - 1))(xdl[RD, i] = 0);
constraint forall(i in 4..(k - 1))(xdr[RD, i] = 0);
constraint forall(i in 0..2)(xdr[RD, i] = 0);
constraint (xdr[RD, 3] = 1);



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

%constraint sum(round in 1..(RD - 1), i in 0..((2 * k) - 1))(contradict[round, i]) >= 1;

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################

%  __  __                         _                      ____                       _   _   _     _                 
% |  \/  |   ___   _ __    __ _  (_)  _ __     __ _     / ___|   ___    _ __     __| | (_) | |_  (_)   ___    _ __  
% | |\/| |  / _ \ | '__|  / _` | | | | '_ \   / _` |   | |      / _ \  | '_ \   / _` | | | | __| | |  / _ \  | '_ \ 
% | |  | | |  __/ | |    | (_| | | | | | | | | (_| |   | |___  | (_) | | | | | | (_| | | | | |_  | | | (_) | | | | |
% |_|  |_|  \___| |_|     \__, | |_| |_| |_|  \__, |    \____|  \___/  |_| |_|  \__,_| |_|  \__| |_|  \___/  |_| |_|
%                         |___/               |___/                                                                 


array[0..RD, 0..(k - 1)] of var -1..1: mxl;
array[0..RD, 0..(k - 1)] of var -1..1: mxr;
array[0..RD, 0..(k - 1)] of var -1..1: mxl1;
array[0..RD, 0..(k - 1)] of var -1..1: mxr1;
array[0..RD, 0..(k - 1)] of var 0..1: mcontradictl;
array[0..RD, 0..(k - 1)] of var 0..1: mcontradictr;


constraint forall(i in 0..(k - 1))
(

    merge(xul[MD, i], xdl[MD, i], mxl[MD, i], mcontradictl[MD, i])

);

constraint forall(i in 0..(k - 1))
(

    merge(xur[MD, i], xdr[MD, i], mxr[MD, i], mcontradictr[MD, i])

);

constraint forall(i in 0..(k - 1))
(

   mxl[MD, i] = mxl1[MD, i] 

);

constraint forall(i in 0..(k - 1))
(

   mxr[MD, i] = mxr1[MD, i] 

);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################

%  _____                                                _        _       __   _                     __  __                         _                 
% |  ___|   ___    _ __  __      __   __ _   _ __    __| |      / \     / _| | |_    ___   _ __    |  \/  |   ___   _ __    __ _  (_)  _ __     __ _ 
% | |_     / _ \  | '__| \ \ /\ / /  / _` | | '__|  / _` |     / _ \   | |_  | __|  / _ \ | '__|   | |\/| |  / _ \ | '__|  / _` | | | | '_ \   / _` |
% |  _|   | (_) | | |     \ V  V /  | (_| | | |    | (_| |    / ___ \  |  _| | |_  |  __/ | |      | |  | | |  __/ | |    | (_| | | | | | | | | (_| |
% |_|      \___/  |_|      \_/\_/    \__,_| |_|     \__,_|   /_/   \_\ |_|    \__|  \___| |_|      |_|  |_|  \___| |_|     \__, | |_| |_| |_|  \__, |
%                                                                                                                          |___/               |___/ 

array[MD..(RD - 1), 0..(k - 1)] of var -1..1: myul;
array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mzul;
array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mwul;
array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mzul1;
array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mp;

% Branching

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
  
   branching(mxl[round, i], mzul1[round, i], myul[round, i])

);


% Diffusion layer


constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    mzul[round, i] = mzul1[round, left_rotate_1[i]]
);


% Xor

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    
    mxr[round, i] = mzul[round, i]
   
);

% S-box layer
constraint forall(round in MD..(RD - 1), i in 0..4)
(
    sbox(myul[round, i], myul[round, 5 + i], myul[round, 10 + i], mxr[round, i], mxr[round, 5 + i],
         mp[round, i], mxr1[round + 1, 5 + i], mp[round, 10 + i], mwul[round, i], mwul[round, 5 + i])
);

constraint forall(round in MD..(RD - 1), i in 0..4)
(
    sbox(mp[round, 10 + i], myul[round, 15 + i], myul[round, 20 + i], mxr[round, 10 + i], mxr[round, 15 + i],
         mxr1[round + 1, 10 + i], mxr1[round + 1, 15 + i], mp[round, 20 + i], mwul[round, 10 + i], mwul[round, 15 + i])
);

constraint forall(round in MD..(RD - 1), i in 0..1)
(
    sbox(mp[round, 20 + i], myul[round, 25 + i], myul[round, 30 + i], mxr[round, 20 + i], mxr[round, 25 + i],
         mxr1[round + 1, 20 + i], mxr1[round + 1, 25 + i], mp[round, 30 + i], mwul[round, 20 + i], mwul[round, 25 + i])
);


constraint forall(round in MD..(RD - 1), i in 0..2)
(
    sbox(mp[round, 22 + i], myul[round, 27 + i], mp[round, i], mxr[round, 22 + i], mxr[round, 27 + i],
         mxr1[round + 1, 22 + i], mxr1[round + 1, 27 + i], mxr1[round + 1, i], mwul[round, 22 + i], mwul[round, 27 + i])
);



constraint forall(round in MD..(RD - 1), i in 0..1)
(
    sbox1(mp[round, 30 + i], mp[round, 3 + i], mxr[round, 30 + i], mxr1[round + 1, 30 + i], mxr1[round + 1, 3 + i], mwul[round, 30 + i])
);


% Xor

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    
    mzul[round, i] = mwul[round, i]
   
);

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    
    mxl1[round + 1, i] = mwul[round, i]
   
);

% merge

constraint forall(round in (MD + 1)..(RD - 1), i in 0..(k - 1))
(

    merge(xdl[round, i], mxl1[round, i], mxl[round, i], mcontradictl[round, i]) 

);

constraint forall(round in (MD + 1)..(RD - 1), i in 0..(k - 1))
(

    merge(xdr[round, i], mxr1[round, i], mxr[round, i], mcontradictr[round, i]) 

);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################

%  ____                   _                                    _        _       __   _                     __  __                         _                 
% | __ )    __ _    ___  | | __ __      __   __ _   _ __    __| |      / \     / _| | |_    ___   _ __    |  \/  |   ___   _ __    __ _  (_)  _ __     __ _ 
% |  _ \   / _` |  / __| | |/ / \ \ /\ / /  / _` | | '__|  / _` |     / _ \   | |_  | __|  / _ \ | '__|   | |\/| |  / _ \ | '__|  / _` | | | | '_ \   / _` |
% | |_) | | (_| | | (__  |   <   \ V  V /  | (_| | | |    | (_| |    / ___ \  |  _| | |_  |  __/ | |      | |  | | |  __/ | |    | (_| | | | | | | | | (_| |
% |____/   \__,_|  \___| |_|\_\   \_/\_/    \__,_| |_|     \__,_|   /_/   \_\ |_|    \__|  \___| |_|      |_|  |_|  \___| |_|     \__, | |_| |_| |_|  \__, |
%                                                                                                                                 |___/               |___/ 


array[0..(MD - 1), 0..(k - 1)] of var -1..1: mydl;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mzdl;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mwdl;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mzdl1;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mpd;

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
  
   branching(mxr[round + 1, i], mzdl1[round, i], mydl[round, i])

);


% Diffusion layer


constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    mzdl[round, i] = mzdl1[round, left_rotate_1[i]]
);


% Xor

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    
    mxl[round + 1, i] = mzdl[round, i]
   
);

% S-box layer
constraint forall(round in 0..(MD - 1), i in 0..4)
(
    sbox(mydl[round, i], mydl[round, 5 + i], mydl[round, 10 + i], mxl[round + 1, i], mxl[round + 1, 5 + i],
         mpd[round, i], mxl1[round, 5 + i], mpd[round, 10 + i], mwdl[round, i], mwdl[round, 5 + i])
);

constraint forall(round in 0..(MD - 1), i in 0..4)
(
    sbox(mpd[round, 10 + i], mydl[round, 15 + i], mydl[round, 20 + i], mxl[round + 1, 10 + i], mxl[round + 1, 15 + i],
         mxl1[round, 10 + i], mxl1[round, 15 + i], mpd[round, 20 + i], mwdl[round, 10 + i], mwdl[round, 15 + i])
);

constraint forall(round in 0..(MD - 1), i in 0..1)
(
    sbox(mpd[round, 20 + i], mydl[round, 25 + i], mydl[round, 30 + i], mxl[round + 1, 20 + i], mxl[round + 1, 25 + i],
         mxl1[round, 20 + i], mxl1[round, 25 + i], mpd[round, 30 + i], mwdl[round, 20 + i], mwdl[round, 25 + i])
);


constraint forall(round in 0..(MD - 1), i in 0..2)
(
    sbox(mpd[round, 22 + i], mydl[round, 27 + i], mpd[round, i], mxl[round + 1, 22 + i], mxl[round + 1, 27 + i],
         mxl1[round, 22 + i], mxl1[round, 27 + i], mxl1[round, i], mwdl[round, 22 + i], mwdl[round, 27 + i])
);



constraint forall(round in 0..(MD - 1), i in 0..1)
(
    sbox1(mpd[round, 30 + i], mpd[round, 3 + i], mxl[round + 1, 30 + i], mxl1[round, 30 + i], mxl1[round, 3 + i], mwdl[round, 30 + i])
);

% Xor

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    
    mzdl[round, i] = mwdl[round, i]
   
);

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    
    mxr1[round, i] = mwdl[round, i]
   
);

% merge

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(

    merge(xul[round, i], mxl1[round, i], mxl[round, i], mcontradictl[round, i]) 

);

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(

    merge(xur[round, i], mxr1[round, i], mxr[round, i], mcontradictr[round, i]) 

);
% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################

% ___               _   _                        _        ____                   _                        _   _          _     _                 
% |_ _|  _ __     __| | (_)  _ __    ___    ___  | |_     / ___|   ___    _ __   | |_   _ __    __ _    __| | (_)   ___  | |_  (_)   ___    _ __  
%  | |  | '_ \   / _` | | | | '__|  / _ \  / __| | __|   | |      / _ \  | '_ \  | __| | '__|  / _` |  / _` | | |  / __| | __| | |  / _ \  | '_ \ 
%  | |  | | | | | (_| | | | | |    |  __/ | (__  | |_    | |___  | (_) | | | | | | |_  | |    | (_| | | (_| | | | | (__  | |_  | | | (_) | | | | |
% |___| |_| |_|  \__,_| |_| |_|     \___|  \___|  \__|    \____|  \___/  |_| |_|  \__| |_|     \__,_|  \__,_| |_|  \___|  \__| |_|  \___/  |_| |_|
                                                                                                                                                 

array[0..RD, 0..((2 * k) - 1)] of var 0..1: mcontradict;
constraint forall(round in 0..RD, i in 0..(k - 1))
(
    mcontradict[round, i] = mcontradictl[round, i]
);
constraint forall(round in 0..RD, i in k..((2 * k) - 1))
(
    mcontradict[round, i] = mcontradictr[round, i - k]
);

constraint sum(round in 1..(RD - 1), i in 0..((2 * k) - 1))(mcontradict[round, i] + contradict[round, i]) >= 1;


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
%  ____          _             
% / ___|   ___  | |__   __ ___ 
% \___ \  / _ \ | |\ \ / // _ \
%  ___) || (_) || | \ V /|  __/
% |____/  \___/ |_|  \_/  \___|

% some artificial constraints to control the input and output masks

solve minimize sum(i in 0..(k - 1))(xul[0, i] + xur[0, i] + xdl[RD, i] + xdr[RD, i]);
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


predicate branching(var -1..1: a, var -1..1: b, var -1..1: c) = 
 
 
    if (a == -1 \/ b == -1) then (c == -1)
    else (c = (a + b) mod 2)
    endif
;
 
 

predicate sbox(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: x3, var -1..1: x4, var -1..1: y0, var -1..1: y1, var -1..1: y2, var -1..1: y3, var -1..1: y4) = 


	if (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 0 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 0 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == 1 /\ x4 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == 1 /\ y4 == -1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == -1 /\ x3 == -1 /\ x4 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == 1)
	else (y0 == -1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1 /\ y4 == -1)
        endif
;


predicate sbox1(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: y0, var -1..1: y1, var -1..1: y2) = 

	if (x0 == 0 /\ x1== 0 /\ x2 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 0)
	elseif (x0 == 0 /\ x1== 0 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == 0)
	elseif (x0 == 0 /\ x1== 1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 0)
	elseif (x0 == 0 /\ x1== -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == 0)
	elseif (x0 == 1 /\ x1== 0 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == 0)
	elseif (x0 == 1 /\ x1== 1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 0)
	elseif (x0 == 1 /\ x1== -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == 0)
	elseif (x0 == -1 /\ x1== 0 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == 0)
	elseif (x0 == -1 /\ x1== 1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0)
	elseif (x0 == -1 /\ x1== -1 /\ x2 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1)
	else (y0 == -1 /\ y1 == -1 /\ y2 == -1)
        endif
;

 
predicate merge(var -1..1: a, var -1..1: b, var -1..1: c, var 0..1: d) =  
 
    if (a == -1) then ((c == b) /\ (d == 0))
    elseif (b == -1) then ((c == a) /\ (d == 0))
    elseif (a == b) then ((c == a) /\ (d == 0))
    else (d == 1)
    endif
;
 
 

 



