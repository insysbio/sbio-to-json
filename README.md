# simbiology-to-json
Package for transformation of Matlab/Simbiology objects to regular structures accesible for serialization like JSON, YAML etc.

## Quick demo

1. Load model from sbio demos.
```matlab
out = sbioloadproject('C:\Program Files\MATLAB\R2017b\toolbox\simbio\simbiodemos\AntibacterialPKPD.sbproj');
model = out.m1;
```

2. Convert model object to Matlab structure
```matlab
strc = SbioStruct(model);
```

3. Serialize to JSON and save to file.
```matlab
json = jsonencode(strc);

fileID = fopen('model.json','w');
fprintf(fileID, json);
fclose(fileID);
```

## Convert to pretty JSON using jsonlab

1. Download JSONlab package (https://github.com/fangq/jsonlab) and add the path
```matlab
addpath('Y:\jsonlab');
```

2. Use savejson() to create json file
```matlab
json=savejson('', strc,'model-pretty.json');
```

## Installation

1. Upload file SbioStruct.m or whole package from (https://github.com/insysbio/simbiology-to-json) and add the path
addpath('Y:\simbiology-to-json');

