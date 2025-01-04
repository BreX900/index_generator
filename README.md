# Index Generator
Automatically generate index / barrel files with all the exports needed for your library.

### Stable release
There will be no more breaking changes

## Usage

1. Activate: `dart/flutter pub global activate index_generator`

2. Create `index_generator.yaml` file or add in your `pubspec.yaml` file:
```yaml
index_generator:
  exclude:
    - '**.g.dart'
  # Define the paths of the folders in which to generate the index files
  libraries:
    - directory_path: lib
```

3. You can generate index files with: `<dart|flutter> pub global run index_generator`

## Advance Usage

[See more examples](https://github.com/BreX900/index_generator/tree/master/example)

```yaml
index_generator:
  # You can define the default name of the index file
  default_file_name: barrel
  # You can define general filters for all indexes
  exclude:
    - '**.g.dart'
    - '{_,**/_}*.dart'
  libraries:
    - directory_path: lib
      # You can define specific filters for this index
      include:
        # You can define specific export folders paths
        - 'src/**'
      # You can define specific export dart packages in index file.
      exports:
        - package: package:args/args.dart
          show:
            - ArgResults
          hide:
            - ArgParser
    - directory_path: generator
      # You can define the name of the index file
      file_name: main
      # Disable/Enable the generated code disclaimer
      disclaimer: false
      # Comments added on the generated file, like copyright
      comments: |
        Copyright (c) 2020 BreX900
      # Documentation added on the generated file above the library name
      docs: | 
        Automatically generate index / barrel / library files
        with all the export needed for your library.
      # You can define the name of the library to use within the index
      name: index_generator
```

- **directory_path**: Path in which to create the index file. All filters will get the relative path from this directory
- **file_name**: Prioritize ownership in folders, otherwise it will use the one defined in the generator with `default_file_name` key.
  If it is missing, if the folder is `lib` it will use the package name otherwise the folder name
- **name**: The name of the library used in the index dart file by the `library` keyword
- **include** | **exclude**: You can define filters that exclude or include files to be included in the index. The filters are passed paths relative to the 
  index file. You can use [Glob](https://pub.dev/packages/glob) expressions.
- **exports**: You can define specific export dart packages in index file. 
  You can use `package` to export a dart file package or dart core library.

## Command
`--help` command output:
```
-s, --settings=<Define a yaml file path.>    If not present use the "index_generator.yaml" file if it exists otherwise use the "pubspec.yaml" file.
-v, --[no-]verbose                           Print verbose logs
-h, --help 
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/BreX900/index_generator/issues).

# Extra

- [mek_assets](https://pub.dev/packages/mek_assets): Automatically generate dart classes / flutter pubspec entries for your assets files.
- [mek_data_class](https://pub.dev/packages/mek_data_class): Generate `hashCode`, `==`, `toString`, `copyWith` and `change` methods with low code.
