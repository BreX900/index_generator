# Index Generator
Automatically generate index / barrel files with all the exports needed for your library.

## Usage

1. Activate: `dart/flutter pub global activate index_generator`

2. Create `index_generator.yaml` file or add in your `pubspec.yaml` file:
```yaml
index_generator:
  filters:
    - black: .*.g.dart$
  # Define the paths of the folders in which to generate the index files
  indexes:
    - path: lib
```

3. You can generate index files with: `<dart|flutter> pub global run index_generator`

## Advance Usage

```yaml
index_generator:
  # You can define the default name of the index file
  default_name: barrel
  # You can define general filters for all indexes
  filters:
    - black: .*\.g$
  indexes:
    - path: lib
      # You can define specific filters for this index
      filters:
        - white: .*\include.g$
      # You can define specific export folders paths
      folders:
        - lib/src
      # You can define specific export dart packages in index file.
      exports:
        - package: args/args
          show:
            - ArgResults
          hide:
            - ArgParser
    - path: generator
      # You can define the name of the index file
      name: main
      # You can define the name of the library to use within the index
      library: index_generator
```

- **name**: Prioritize ownership in folders, otherwise it will use the one defined in the generator with `default_name` key.
  If it is missing, if the folder is `lib` it will use the package name otherwise the folder name
- **filters**: You can define `black` filters that remove files from the index but `white` filters will add them back
  You can use [RegExp] expressions
- **folders**: You can define specific export folders paths.
  The path of the folders is relative to the path of the index.
- **exports**: You can define specific export dart packages in index file. 
  You can use `package` to export a dart file package without dart extension.

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/BreX900/index_generator/issues).
