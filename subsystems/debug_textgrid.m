debug_filename = [filepath filename];

T = cell(length(original)+1,1);
for k = 1:length(labels)
    for t = 1:length(labels{k})
        T{labels{k}(t)} = ['s' num2str(k)];
    end
end

Y = [0 ; J_start(:) ; J_stop(:) ; length(MFCC{1})]/100;
X = sort([Y; original(:)/100],'ascend');
Xmin = X(1:end-1);  Xmax = X(2:end);    Text = cell(length(Xmin),1);
for i = 1:length(Xmin)
    
    for j = 1:length(J_start)
        if(ismember(Xmin(i),J_start/100)...
                ||ismember(Xmax(i),J_stop/100))
            Text{i} = 'NS';
            break
        end
    end
    if (isempty(Text{i}))
        ind = find(original/100 >= Xmax(i),1);
        if(isempty(ind))
            Text{i} = T{end};
        else
            Text{i} = T{ind};
        end
    end

end
% ind = find(Xmax-Xmin < 0.01);
% Xmin([ind(:)]) = []; Xmax([ind(:)]) = []; Text([ind(:)]) = [];
if ((Xmax >= Xmin) & length(Xmax)== length(Text) & issorted(Xmax) & issorted(Xmin))
    array2textgrid(debug_filename,Xmin,Xmax,Text)
else
    disp('Unknwon Error.. Either: Lengths mismatching, unsorted arrays or XMAX(i) < XMIN(i)')
    disp('File Not created')
end