%% New Optimization problem
function [clusters,objective_value,X] = new_ilp(dist,del,scaling)



%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program new_ilp.m is part of the MATLAB Speaker Diarization Toolkit 
% <https://github.com/parthe/Speaker-Diarization-toolkit-MATLAB>
% Copyright (C) 2015 Parthe Pandit
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or 
% any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
 

    N = size(dist,1);

%     A1 = eye(N^2);
    A1 = speye(N^2);
    for k = 1:N

        A1((k-1)*N+1:k*N,(k-1)*N+1 + k-1) =  A1((k-1)*N+1:k*N,(k-1)*N+1 + k-1) - ones(N,1);

    end

    A2 = zeros(N^2,1);
    for i = 1:N
        for j = 1:N
           A2((i-1)*N+j) = dist(i,j); 
        end
    end
%     A2 = diag(A2);
    A2 = sparse(1:N^2,1:N^2,A2,N^2,N^2);
    
    A = [A1;...
         A2];
    
    if (nargin < 2)
        del = 180;
    end
%     b = [zeros(N^2,1);del*ones(N^2,1)];
    b = sparse([zeros(N^2,1);del*ones(N^2,1)]);


    Aeq = [];
    for i = 1:N
%         Aeq = [Aeq eye(N)];
          Aeq = [Aeq speye(N)];
    end
    beq = sparse(ones(N,1));
    
    if (nargin < 3)
        scaling = max(max(A2));
    end
    f = diag(A2)/scaling;  f(f==0) = 1;
    intcon = (1:length(f))';

    lb = zeros(length(f),1);
    ub = ones(length(f),1);
    v = version;
    if (str2double(v(end-2)) >= 4)
        options = optimoptions('intlinprog','Display','off');
        x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,options);
    else
        x = bintprog(f,A,b,Aeq,beq);
    end
%     I = find(x(1:N)==1);
    X = round((reshape(x,N,N)'));
    
%     [I,J] = find(X == 1); 
    count = 1;
    clusters = cell(length(find(diag(X)==1)),1);
    for j = 1:length(X)
        if (X(j,:) == zeros(1,length(X)))

            continue
        end

        clusters{count} = find(X(j,:) == 1);
        %         disp(sort(clusters{count}))
        count = count + 1;
    end
%     disp(clusters)
    if (nargout >= 2)
        objective_value = f'*x;
    end
%     disp(X)
end
%% Global optimization problem solving using intlinprog (ILP) -- Erroneous

% % N = size(segment_IVs,2);
% N= 3;
% % A = zeros(N^2*N^2,N^2+N);
% 
% A1 = zeros(N^2,N);
% for i = 1:N
%     A1(N*(i-1)+1:N*i,i) = -ones(N,1);
% end
% A2 = eye(N^2);
% A3 = zeros(N^2,N);
% 
% A4 = zeros(N^2,1);
% for i = 1:N
%     for j = 1:N
%        A4((i-1)*N+j) = dist(i,j); 
%     end
% %     r = 1 + floor(i/N);
% %     c = 1 + rem(i,N);
% %     A4(i) = dist(r,c);
% end
% A4 = diag(A4);
% 
% A = [A1 A2;...
%      A3 A4];
% 
% del = 180;
% b = [zeros(N^2,1);del*ones(N^2,1)];
% 
% % Aeq = zeros(N,N^2+N);
% 
% Aeq1 = zeros(N,N);
% Aeq2 = -A1';
% 
% Aeq = [Aeq1 Aeq2];
% beq = ones(N,1);
% 
% scaling = max(max(A4));
% f = [ones(N,1);scaling*diag(A4)];
% intcon = (1:length(f))';
% 
% lb = zeros(length(f),1);
% ub = ones(length(f),1);
% v = version;
% if (str2double(v(end-2)) >= 4)
%     x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);
% else
%     x = bintprog(f,A,b,Aeq,beq);
% end
% I = find(x(1:N)==1);
% [x(1:N) reshape(x(N+1:N+N^2),N,N)']
% objective_value = f'*x