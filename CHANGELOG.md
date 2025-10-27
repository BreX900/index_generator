# CHANGELOG


## 4.1.2
- build: bumped `build` dependency to `^4.0.0`
- build: removed `mek_data_class` dependency

## 4.1.0
- feat: Enabled package-style imports by `use_package_support` key
- feat: Allows setting a custom directory for the generated index file by `output_path` key
- feat: Added support to `build_runner` package, but you must enable it. Required minimum `build` package to `^3.0.0`
- feat: Added option to remove library name by `include_library` key
- fix: sort export entries on `show` and `hide` keywords

## 4.0.1
- docs: updated documentation

## 4.0.0
- refactor!: In the `index_generator` field, `default_name` has been renamed to `default_file_name` and `indexes` to
  `libraries`
- refactor!: In the `indexes`/`libraries` field, `path` has been renamed to `directory_path`, `name` to `file_name` and
  `library` to `name`
- feat!: The default library name is now empty. You can enter the library name in the library generation settings using 
  the `name` field
- build: bumped `dart_style` dependency to `^3.0.0` 
- build: bumped dart sdk constraints to `^3.0.0`

## 3.4.1
- chore: update dart sdk constraints

## 3.4.0+1
- docs: add topics to pubspec.yaml

## 3.4.0
- chore: Update dependencies
- feat: export `index_generator` executable

## 3.3.3
- Revert wrong `defaultName` keyword to `default_name` in yaml file

## 3.3.2
- Fix the search for the yaml file within the project. Now correctly find the index_generator.yaml file

## 3.3.1
- fix export dart core libraries

## 3.3.0
- feat can disable printing generated code `disclaimer`
- feat added the `comments` field to the `indexes` to be able to add the comments or copyright to the library
- feat added the `docs` field to the `indexes` to be able to add the documentation to the library
- fix file library name when target a `lib` folder

## 3.2.0+1
- Now you can set the page size via `page_width`.
- Now the generated code is formatted.

## 3.1.0
- Added support for exporting dart core libraries
  - Please change from 'library/file' to 'package:library/file.dart'. (The old version remains supported)

## 3.0.0
### STABLE RELEASE
- Improve filters, now support a Glob expression
- Improve `exports` fields:
  - You can _show_ a specific class or methods.
  - You can _hide_ a specific class or methods.
#### BREAKING CHANGES
- The `exports` field now support a list of structure data with `package`, `show`m `hide` fields.
- Filters now support a Glob expression
- Filters now is separated in `include` and `exclude` fields
- The `folders` keyboard is removed in favour of `include` keyboard

## 2.1.0
- Improved handling of yaml file parsing errors using `json_serializable`
- Added the ability to export other libraries, see the field `exports`
- Fix #1 : Now LF is always used for the newline character. You can replace the newline character in the yaml using the `line_break` field
#### BREAKING CHANGES
- Now you have to start the index generator by writing only `index_generator` without`:main`
- Removed the ability to create an index file without the library name
- In the yaml file the `export` field has changed to `folders`

## 2.0.3
- Added an extra line at the end of the index file

## 2.0.2
- Fixed library name when it is missing in pubspec but index name is present

## 2.0.1
- Now the path of the export folders is relative to the path of the index

## 2.0.0
- Now you can define export folders (use `export` key)
### Breaking changes:
- Renamed `folders` key to `indexes` in yaml file
- Renamed `index_name` key to `default_name`  in yaml file
- Renamed `index_name` key in `indexes` to `name`  in yaml file

## 1.0.1
- Add warning line in index

## 1.0.0
- Add **Null Safety**

## 0.0.1
- Initial version
