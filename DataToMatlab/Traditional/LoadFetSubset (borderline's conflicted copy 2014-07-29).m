function [Fet, nFeatures] = LoadFetSubset(FileName,Subset)
% [Fet, nFeatures] = LoadFetSubset(FileName,Subset)
%
% A simple matlab function to load a .fet file

if ~exist('Subset','var');
    Subset = Inf;
end

% if ~strcmpi(FileName(end-3:end),'.fet');
%     FileName = [FileName,'.fet'];
% end
Fp = fopen(FileName, 'r');

if Fp==-1
    error(['Could not open file ' FileName]);
end

nFeatures = fscanf(Fp, '%d', 1);

if isinf(Subset)
    Fet = fscanf(Fp, '%f', [nFeatures, inf])';
else
    Fet = [];
    counter = 0;
    while ~feof(Fp)
        counter = counter+1;
        FetBuf = fscanf(Fp, '%f', [nFeatures, 1])';
        if ismember(counter,Subset);
            Fet = [Fet; FetBuf];
        end
    end
end

fclose(Fp);

