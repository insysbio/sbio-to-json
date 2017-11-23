function out = SbioToStruct(x)
%{
   Copyright 2017 InSysBio, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
%}
    if ~isscalar(x) && contains(class(x),'SimBiology') % vector-like sbio classes
        out = arrayfun(@(x) SbioToStruct(x), x, 'UniformOutput', true);
    elseif isscalar(x) && contains(class(x),'SimBiology') % structure-like classes
        fn = fieldnames(x);
        if isa(x,'SimBiology.Model')
            fn{end+1} = 'Doses';
            fn{end+1} = 'Variants';
            fn{end+1} = 'Configset';
        end
        res = struct;
        for i = 1:length(fn)
            % 'Parent' case exception
            if strcmp(fn{i}, 'Parent') && ~isempty(x.Parent)
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
                b = arrayfun(@(x) SbioToStruct(x), value, 'UniformOutput',false);
            else
                b = SbioToStruct(value);
            end
            res.(fn{i}) = b;
        end
        out = res;
    elseif isempty(x) && ~isa(x, 'char')% other empty objects like cells
        out = {};
    else % empty characters, native matlab structures
        out = x;
    end
end %function

% working with exceptions
function value = exceptionValues(x, name_i)
   x_i = get(x, name_i);
   value = cell(1,length(x_i));
   for j = 1:length(x_i)
       value{j} = get(getfield(x, name_i,{j}), 'Name');
   end
end
