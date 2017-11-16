# simbiology-to-json
Package for transformation of Matlab/Simbiology objects to regular structures accesible for serialization like JSON, YAML etc.

## Installation

1. Upload file SbioStruct.m or whole package from (https://github.com/insysbio/simbiology-to-json) and add the path to the package
```matlab
addpath('Y:\simbiology-to-json');
```

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

## Convert to pretty JSON using JSONLab

1. Download JSONlab package (https://github.com/fangq/jsonlab) and add the path to the package
```matlab
addpath('Y:\jsonlab');
```

2. Use savejson() to create json file
```matlab
json=savejson('', strc,'model-pretty.json');
```
```json
{
	"Annotation": {
	},
	"Events": {
	},
	"Name": "Antibacterial",
	"Notes": {
	},
	"Parameters": [
		[
			{
				"Annotation": {
				},
				"ConstantValue": 1,
				"Name": "KC50",
				"Notes": {
				},
				"Parent": "Antibacterial",
				"Tag": {
				},
				"Type": "parameter",
				"UserData": {
				},
				"Value": 1,
				"ValueUnits": "microgram\/milliliter"
			}
		],
		[
			{
				"Annotation": {
				},
				"ConstantValue": 1,
				"Name": "Kmax",
				"Notes": {
				},
				"Parent": "Antibacterial",
				"Tag": {
				},
				"Type": "parameter",
				"UserData": {
				},
				"Value": 3.5,
				"ValueUnits": "1\/hour"
			}
		],
...
```

## Convert to YAML using
1. Download Matlab YAML package (http://vision.is.tohoku.ac.jp/~kyamagu/software/yaml/) and add the path to the package
```matlab
addpath('Y:\yaml');
```

2. Use YAML.dump() to create YAML
```matlab
yaml = YAML.dump(strc);
YAML.write('model.yml', yaml);
```