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

%class()
%get() % get all properties
%isa(x, 'double')
