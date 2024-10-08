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


array[0..23] of int: left_rotate_5 = array1d(0..23, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 0, 1, 2, 3, 4]);
array[0..23] of int: left_rotate_1 = array1d(0..23, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 0]);
array[0..23] of int: left_rotate_2 = array1d(0..23, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 0, 1]);

% #############################################################################################################################################
% #############################################################################################################################################
% #############################################################################################################################################
%   ____                    _                _         _           __                _____  _   _ 
%  / ___| ___   _ __   ___ | |_  _ __  __ _ (_) _ __  | |_  ___   / _|  ___   _ __  | ____|| | | |
% | |    / _ \ | '_ \ / __|| __|| '__|/ _` || || '_ \ | __|/ __| | |_  / _ \ | '__| |  _|  | | | |
% | |___| (_) || | | |\__ \| |_ | |  | (_| || || | | || |_ \__ \ |  _|| (_) || |    | |___ | |_| |
%  \____|\___/ |_| |_||___/ \__||_|   \__,_||_||_| |_| \__||___/ |_|   \___/ |_|    |_____| \___/ 
% constraints for EU
int: k = 24;
%k1 = 16
array[0..RD, 0..(k - 1)] of var -1..1: xul;
array[0..RD, 0..(k - 1)] of var -1..1: xur;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: yul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: zul;
array[0..(RD - 1), 0..(k - 1)] of var -1..1: wul;
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: pl;
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: ql;
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: sl;

% Diffusion layer

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    yul[round, i] = xul[round, i]
);


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zul[round, i] = xul[round, left_rotate_5[i]]
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wul[round, i] = xul[round, left_rotate_1[i]]
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

%constraint sum(i in 0..(k - 1)) (xul[MD, i] + xur[MD, i]) >= -47;
%constraint forall(i in 0..(k - 1))(xul[0, i] = 0);
%constraint forall(i in 1..(k - 1))(xur[0, i] = 0);
%constraint (xur[0, 0] = 1);

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
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: pd;
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: qd;
%array[0..(RD - 1), 0..(k - 1)] of var -1..1: sd;


% Diffusion layer

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    ydr[round, i] = xdr[round + 1, i]
);


constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    zdr[round, i] = xdr[round + 1, left_rotate_5[i]]
);

constraint forall(round in 0..(RD - 1), i in 0..(k - 1))
(
    wdr[round, i] = xdr[round + 1, left_rotate_1[i]]
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

%constraint sum(i in 0..(k - 1)) (xdl[MD, i] + xdr[MD, i]) >= -47;

%constraint forall(i in 0..(k - 1))(xdr[RD, i] = 0);
%constraint forall(i in 6..(k - 1))(xdl[RD, i] = 0);
%constraint forall(i in 0..4)(xdl[RD, i] = 0);
%constraint (xdl[RD, 5] = 1);


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
%constraint sum(i in 0..(k - 1)) (ml[MD, i] + mr[MD, i]) != -48;

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
%array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mpl;
%array[MD..(RD - 1), 0..(k - 1)] of var -1..1: mql;
%array[MD..(RD - 1), 0..(k - 1)] of var -1..1: msl;


%Diffusion layer

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    myul[round, i] = mxl[round, i]
);


constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    mzul[round, i] = mxl[round, left_rotate_5[i]]
);

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    mwul[round, i] = mxl[round, left_rotate_1[i]]
);


% S-box layer
constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
    sbox(myul[round, i], mzul[round, i], mwul[round, i], mxr[round, i], mxl1[round + 1, i])
);

% Equality condition

constraint forall(round in MD..(RD - 1), i in 0..(k - 1))
(
     mxl[round, i] = mxr1[round + 1, i]
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


array[0..(MD - 1), 0..(k - 1)] of var -1..1: mydr;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mzdr;
array[0..(MD - 1), 0..(k - 1)] of var -1..1: mwdr;
%array[0..(MD - 1), 0..(k - 1)] of var -1..1: mpd;
%array[0..(MD - 1), 0..(k - 1)] of var -1..1: mqd;
%array[0..(MD - 1), 0..(k - 1)] of var -1..1: msd;


% Diffusion layer

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    mydr[round, i] = mxr[round + 1, i]
);


constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    mzdr[round, i] = mxr[round + 1, left_rotate_5[i]]
);

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    mwdr[round, i] = mxr[round + 1, left_rotate_1[i]]
);

% S-box layer

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
    sbox(mydr[round, i], mzdr[round, i], mwdr[round, i], mxl[round + 1, i], mxr1[round, i])
);

% Equality condition

constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
(
     mxr[round + 1, i] = mxl1[round, i]
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
                                                                                                                                                 

%array[0..(MD - 1), 0..(k - 1)] of var 0..1: mucontradictl;
%constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
%(
%    mucontradictl[round, i] = bool2int(xul[round, i] + ml[round, i] == 1)
%);

%array[0..(MD - 1), 0..(k - 1)] of var 0..1: mucontradictr;
%constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
%(
%    mucontradictr[round, i] = bool2int(xur[round, i] + mr[round, i] == 1)
%);

%array[(MD + 1)..RD, 0..(k - 1)] of var 0..1: mdcontradictl;
%constraint forall(round in (MD + 1)..RD, i in 0..(k - 1))
%(
%    mdcontradictl[round, i] = bool2int(xdl[round, i] + ml[round, i] == 1)
%);

%array[(MD + 1)..RD, 0..(k - 1)] of var 0..1: mdcontradictr;
%constraint forall(round in (MD + 1)..RD, i in 0..(k - 1))
%(
%    mdcontradictr[round, i] = bool2int(xdr[round, i] + mr[round, i] == 1)
%);


%constraint forall(round in 0..(MD - 1), i in 0..(k - 1))
%(
%    contradict[round, i] = mucontradictl[round, i]
%);

%constraint forall(round in 0..(MD - 1), i in k..((2 * k) - 1))
%(
%    contradict[round, i] = mucontradictr[round, i - k]
%);


%constraint forall(i in 0..((2 * k) - 1))
%(
%    contradict[MD, i] = 0
%);
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

predicate sbox1(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: x3, var -1..1: y0, var -1..1: y1, var -1..1: y2, var -1..1: y3) = 
    if (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 0 /\ y3 == 0)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 0 /\ y1 == 0 /\ y2 == 0 /\ y3 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == -1) then (y0 == 0 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 1 /\ y3 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == 1 /\ y3 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 1) then (y0 == 0 /\ y1 == 0 /\ y2 == 1 /\ y3 == 0)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == -1) then (y0 == 0 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == -1 /\ x3 == 0) then (y0 == 0 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == -1 /\ x3 == 1) then (y0 == 0 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == -1 /\ x3 == -1) then (y0 == 0 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 0 /\ x3 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 0 /\ x3 == 1) then (y0 == 0 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 0 /\ x3 == -1) then (y0 == 0 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 1 /\ x3 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 1 /\ x3 == 1) then (y0 == 0 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == 1 /\ x3 == -1) then (y0 == 0 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == -1 /\ x3 == 0) then (y0 == 0 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == -1 /\ x3 == 1) then (y0 == 0 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == 1 /\ x2 == -1 /\ x3 == -1) then (y0 == 0 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 0 /\ x3 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 0 /\ x3 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 0 /\ x3 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 1 /\ x3 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 1 /\ x3 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == 1 /\ x3 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == -1 /\ x3 == 0) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == -1 /\ x3 == 1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 0 /\ x1 == -1 /\ x2 == -1 /\ x3 == -1) then (y0 == 0 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 0 /\ x3 == -1) then (y0 == 1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 1 /\ x3 == 1) then (y0 == 1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == 1 /\ x3 == -1) then (y0 == 1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == -1 /\ x3 == 0) then (y0 == 1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == -1 /\ x3 == 1) then (y0 == 1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 0 /\ x2 == -1 /\ x3 == -1) then (y0 == 1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 0 /\ x3 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 0 /\ x3 == 1) then (y0 == 1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 0 /\ x3 == -1) then (y0 == 1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 1) then (y0 == 1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == 1 /\ x3 == -1) then (y0 == 1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == -1 /\ x3 == 0) then (y0 == 1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == -1 /\ x3 == 1) then (y0 == 1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == 1 /\ x2 == -1 /\ x3 == -1) then (y0 == 1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 0 /\ x3 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 0 /\ x3 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 0 /\ x3 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 1 /\ x3 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 1 /\ x3 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == 1 /\ x3 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == -1 /\ x3 == 0) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == -1 /\ x3 == 1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == 1 /\ x1 == -1 /\ x2 == -1 /\ x3 == -1) then (y0 == 1 /\ y1 == -1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == -1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 0 /\ x3 == -1) then (y0 == -1 /\ y1 == 0 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 1 /\ x3 == 1) then (y0 == -1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == 1 /\ x3 == -1) then (y0 == -1 /\ y1 == 0 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == -1 /\ x3 == 0) then (y0 == -1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == -1 /\ x3 == 1) then (y0 == -1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 0 /\ x2 == -1 /\ x3 == -1) then (y0 == -1 /\ y1 == 0 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 0 /\ x3 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 0 /\ x3 == 1) then (y0 == -1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 0 /\ x3 == -1) then (y0 == -1 /\ y1 == 1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 1) then (y0 == -1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 1 /\ x3 == 1) then (y0 == -1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == 1 /\ x3 == -1) then (y0 == -1 /\ y1 == 1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == -1 /\ x3 == 0) then (y0 == -1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == -1 /\ x3 == 1) then (y0 == -1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == 1 /\ x2 == -1 /\ x3 == -1) then (y0 == -1 /\ y1 == 1 /\ y2 == -1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 0 /\ x3 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 0 /\ x3 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 0 /\ x3 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == 0 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 1 /\ x3 == 0) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 1 /\ x3 == 1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    elseif (x0 == -1 /\ x1 == -1 /\ x2 == 1 /\ x3 == -1) then (y0 == -1 /\ y1 == -1 /\ y2 == 1 /\ y3 == -1)
    else (y0 = -1 /\ y1 = -1 /\ y2 = -1 /\ y3 = -1)
    endif
;


predicate merge(var -1..1: a, var -1..1: b, var -1..1: c, var 0..1: d) =  
 
    if (a == -1) then ((c == b) /\ (d == 0))
    elseif (b == -1) then ((c == a) /\ (d == 0))
    elseif (a == b) then ((c == a) /\ (d == 0))
    else (d == 1)
    endif
;
    

predicate sbox(var -1..1: x0, var -1..1: x1, var -1..1: x2, var -1..1: x3, var -1..1: y0) = 

    if (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 0) then (y0 == 0)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 1 /\ x3 == 0) then (y0 == 1)
    elseif (x0 == 0 /\ x1 == 0 /\ x2 == 0 /\ x3 == 1) then (y0 == 0)
    else (y0 = -1)
    endif
;
 
 
 
 
 
 

 
 
 
 
 
 



