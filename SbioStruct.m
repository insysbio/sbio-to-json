function out = SbioStruct(x)
    if ~isscalar(x) && contains(class(x),'SimBiology') % vector-like sbio classes
        out = arrayfun(@(x) SbioStruct(x), x, 'UniformOutput', true);
    elseif isscalar(x) && contains(class(x),'SimBiology') % structure-like fields
        fn = fieldnames(x);
        res = struct;
        for i = 1:length(fn)
            % 'Parent' case exception 
            if strcmp(fn{i}, 'Parent') && not(isempty(x.Parent))
                if isa(x.Parent, 'SimBiology.Root')
                    value = class(x.Parent);
                else
                    value = x.Parent.Name;
                end
            elseif strcmp(fn{i}, 'Species') && isa(x, 'SimBiology.Compartment')
                value = exceptionValues(x, fn{i});
            elseif strcmp(fn{i}, 'Products') && isa(x, 'SimBiology.Reaction')
                value = exceptionValues(x, fn{i});
            elseif strcmp(fn{i}, 'Reactants') && isa(x, 'SimBiology.Reaction')
                value = exceptionValues(x, fn{i});
            else
                value = get(x, fn{i});
            end

            if contains(class(value),'SimBiology')
                b = arrayfun(@(x) SbioStruct(x), value, 'UniformOutput',false);
            else
                b = SbioStruct(value);
            end
            
            res = setfield(res, fn{i}, b);
        end
        out = res;
    elseif isempty(x) && ~isa(x, 'char')% other empty objects like cells
        out = {};
    else % empty characters, matlab structures
        out = x;
    end
end

% working with exceptions
function value = exceptionValues(x, name_i)
   value = cell(1,length(get(x, name_i)));
   for j = 1:length(get(x, name_i))
       value{j} = get(getfield(x, name_i,{j}), 'Name');
   end
end