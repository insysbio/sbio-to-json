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

function out = getGet(x)
    if length(x)>1 && not(strcmp(class(x),'char'))
        %disp(x.Type);
        out = arrayfun(@(x) getGet(x), x, 'UniformOutput',false);
    elseif length(x)==0
        out = "";
    elseif length(x)==1 && all(ishandle(x)) && not(x==0)
        %disp(x.Type);
        fn = fieldnames(x);
        res = struct;
        for i = 1:length(fn)
            if not(strcmp(fn{i}, 'Parent')) && 1
                value = get(x, fn{i});
                b = getGet(value);
                res = setfield(res, fn{i}, b);
            end
        end
        out = res;
    else
    	out = x;
    end
end
