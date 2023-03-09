function verbgen_assemble(samdirectory)
% usage: verbgen_assemble samdirectory
%

if nargin<1
    help verbgen1_compile
elseif ~exist(samdirectory,'dir')
    error('No such directory.')
end

cd(samdirectory)

cd SAMresponse
!mkdir temp
!mv *.svl temp
cd temp
%This line creates the s_beam file:
nut_svl2timef2('.',[],'verbgen1response');
%!mv temp/* .
%!rm -r temp/

%!rm -r ??,*to*ms*
%!rm ../../lang*.o*.1
cd ../../..
%verbgen2_assemble('SAM')
cd(samdirectory)

cd SAMstim
!mkdir temp
!mv *.svl temp
cd temp
nut_svl2timef2('.',[],'verbgen2stim');