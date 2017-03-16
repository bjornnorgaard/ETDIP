%Run-length encoding and decoding
%HKa Feb. 2015

%Cut and pasted from "MATLAB array manipulation tips and tricks", Peter J. Acklam,
%Statistics Division, Department of Mathematics, University of Oslo,Norway
%WWW URL: http://www.math.uio.no/~jacklam/

%Assuming x is a vector
x = [ 4 4 5 5 5 6 7 7 8 8 8 8 ]

%and one wants to obtain the two vectors
l = [ 2 3 1 2 4 ]; % run lengths
v = [ 4 5 6 7 8 ]; % values

%one can get the run length vector l by using
l = diff([ 0 find(x(1:end-1) ~= x(2:end)) length(x) ])

%and the value vector v by using one of
v = x([ find(x(1:end-1) ~= x(2:end)) length(x) ])
v = x(logical([ x(1:end-1) ~= x(2:end) 1 ]))

%These two steps can be combined into
i = [ find(x(1:end-1) ~= x(2:end)) length(x) ];
l = diff([ 0 i ]);
v = x(i);

%Run-length decoding
%Given the run-length vector l and the value vector v, one may create the full vector x by using
i = cumsum([ 1 l ])
j = zeros(1, i(end)-1)
j(i(1:end-1)) = 1
x = v(cumsum(j))