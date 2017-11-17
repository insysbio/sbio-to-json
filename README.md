# sbio-to-json
Package for transformation of Matlab/Simbiology objects to regular structures accesible for serialization like JSON, YAML etc.

## Motivation
**SimBiology** is a popular tool for modeling in systems biology and systems pharmacology. It stores models in internal objects which can be created or modified by GUI or by Matlab scripting. Nevertheless in some cases you need representation of the model code in general-porpose way for additional analysis or exporting to another tools.

**JSON** (JavaScript Object Notation) is one of two most popular formats of searilization and it is supported by all programming languages. So it a good choice for model exporting.

Matlab provides function `jsonencode()` function but it cannot be used for `SimBiology.*` objects directly. `SbioToStruct()` function solves the problem.

## Installation

1. Upload file SbioToStruct.m or whole package from (https://github.com/insysbio/sbio-to-json) and add the path to the package.
```matlab
addpath('Y:\sbio-to-json');
```

## Quick demo

1. Load model from simbiodemos.
```matlab
out = sbioloadproject('C:\Program Files\MATLAB\R2017b\toolbox\simbio\simbiodemos\AntibacterialPKPD.sbproj');
model = out.m1;
```

2. Convert model object to Matlab structure
```matlab
strc = SbioToStruct(model);
```

3. Serialize to JSON and save to file.
```matlab
json = jsonencode(strc);

fileID = fopen('model.json','w');
fprintf(fileID, json);
fclose(fileID);
```

## Convert to pretty JSON
Steps 1 and 2 as above... but

3. Download JSONlab package (https://github.com/fangq/jsonlab) and add the path to the package
```matlab
addpath('Y:\jsonlab');
```

4. Use savejson() to create json file
```matlab
json=savejson('', strc,'model-pretty.json');
```
```json
{
  "Annotation": "",
  "Events": [],
  "Name": "Antibacterial",
  "Notes": "",
  "Parameters": [
    [
      {
        "Annotation": "",
        "ConstantValue": 1,
        "Name": "KC50",
        "Notes": "",
        "Parent": "Antibacterial",
        "Tag": "",
        "Type": "parameter",
        "UserData": [],
        "Value": 1,
        "ValueUnits": "microgram\/milliliter"
      }
    ],
    [
      {
        "Annotation": "",
        "ConstantValue": 1,
        "Name": "Kmax",
        "Notes": "",
        "Parent": "Antibacterial",
        "Tag": "",
        "Type": "parameter",
        "UserData": [],
        "Value": 3.5,
        "ValueUnits": "1\/hour"
      }
    ],
...
```
**Note!** JSONlab provides nice and flexible serialization but the structure of final JSON differ from `jsonencode()` function.

## Convert to YAML
Steps 1 and 2 as above... but

3. Download Matlab YAML package (https://github.com/hiroshiban/Mcalibrator2/tree/master/subfunctions/ifit-1.5/Objects/yaml) and add the path to the package
```matlab
addpath('Y:\yaml');
```

4. Use YAML.dump() to create YAML
```matlab
yaml = YAML.dump(strc);
YAML.write('model.yml', yaml);
```

## Another object to convert

The package can also be used for another object which includes `SimBiology.*` objects.
```matlab
root = sbioroot;
rootStruct = SbioToStruct(root);
```

```matlab
parameterStruct = SbioToStruct(model.parameter(1));
```

## Other

### Authors
- @metelkin
- @ivborissov

### License
Apache 2.0
