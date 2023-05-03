function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivoting
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%   P = the permutation matrix

%clear, clc , close all

%% Start Algorithm
%For testing
%A = ones(5);

%Store original matrix for later comparison
Astore = A;

%Determine matrix dimensions:
Asize = size(A);

if Asize(1) ~= Asize(2)
    error("A must be a square matrix")
else
    %If square matrix, run function:

    %Define Pivot (Idenity matrix) and L matrix which will be filled in
    P = eye(Asize(1));
    L = eye(Asize(1));

    %FOR COLUMNS
    for i = 1:Asize(1)-1
        for j = i+1:Asize(1) %Increments n's starting position for each column moved over (diagonal)

            %Determine largest magnitude in column:
            ithCol = A(:,i);

            %Locates which row largest magnitude is
            [~,bigVal] = max(abs(ithCol));

            %This avoids the error where it might accedentally pivot
            %a zero into the first column when solving a later column.
            if bigVal >= i

                %Store both rows to avoid losing them by overwrite
                AstoredIthRow = A(i,:);
                AstoredBigRow = A(bigVal,:);

                %Modify P matrix too
                PstoredIthRow = P(i,:);
                PstoredBigRow = P(bigVal,:);

                %Overwrite both rows with the other row
                A(i,:) = AstoredBigRow;
                A(bigVal,:) = AstoredIthRow;

                %Overwrite P rows
                P(i,:) = PstoredBigRow;
                P(bigVal,:) = PstoredIthRow;

                %Overwrite L rows
                % L(i,:) = LstoredBigRow;
                % L(bigVal,:) = LstoredIthRow;
            end
        end

            %Compute the ratio
            ratio = A(j,i) / A(i,i);

            %Store the ratio in position in L matrix
            L(j,i) = ratio;

            %Apply row operations to eliminate the ith variable in row j
            A(j,:) = A(j,:) - ratio * A(i,:);

            %Modify L matrix too
            LstoredIthRow = L(i,:);
            LstoredBigRow = L(bigVal,:);

            %Overwrite L rows
            L(i,:) = LstoredBigRow;
            L(bigVal,:) = LstoredIthRow;
      end
  end

%Somehow overwrite the upper triangular matrix with an identity matrix.

for i = 1:Asize(1)
    for j = 1:Asize(1)

        if i == j
            L(i,j) = 1;
        end

        if i < j
            L(i,j) = 0;
        end
    end
end


%Output matrix variable chanege
U = A;

%Double check your answer. This ensures that it doesn't assume the
%factorization was correct when it was not.

PA = P*Astore;
LU = L*U;

if ~(isequal(LU,PA))
    error("That didn't work")
else
    disp("LU = PA, this is the correct solution.")
end

end