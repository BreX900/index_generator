# CHANGELOG

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
