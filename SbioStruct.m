function out = SbioStruct(x)
    if length(x)>1 && contains(class(x),'SimBiology')
        %disp(x.Type);
        out = arrayfun(@(x) SbioStruct(x), x, 'UniformOutput',false);
    elseif isempty(x)
        out = "";
    elseif length(x)==1 && contains(class(x),'SimBiology')
        %disp(x);
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
              %  value = {};
              %  for j = 1:length(x.Species)
               %     value{j} = x.Species(j).Name;
              %  end
                
            elseif strcmp(fn{i}, 'Products') && isa(x, 'SimBiology.Reaction')
                value = exceptionValues(x, fn{i});
               % value = {};
               % for j = 1:length(x.Products)
                %    value{j} = x.Products(j).Name;
                %end
            elseif strcmp(fn{i}, 'Reactants') && isa(x, 'SimBiology.Reaction')
                value = exceptionValues(x, fn{i});
               % value = {};
                %for j = 1:length(x.Reactants)
                %    value{j} = x.Reactants(j).Name;
               % end 
                
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
    else
        out = x;
    end
end

function value = exceptionValues(x, name_i)
   
   value = cell(1,length(get(x, name_i)));
   for j = 1:length(get(x, name_i))
       value{j} = get(getfield(x, name_i,{j}), 'Name');
   end
end