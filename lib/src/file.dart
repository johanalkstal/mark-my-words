import 'dart:io';
import 'package:mustache/mustache.dart';
import 'partial.dart';

void createHtmlFile(
    {String content,
    Map<String, dynamic> data,
    bool escapeHtml = false,
    String name,
    String path}) {
  data = data != null ? data : {};
  var templateString = Template(content,
          name: name, htmlEscapeValues: escapeHtml, partialResolver: getPartial)
      .renderString(data);
  _createFile(name: '${path}/${name}.html', content: templateString);
}

String getFileContent({File file, String path}) {
  if (file != null) {
    return file.readAsStringSync();
  }

  if (path != null) {
    return File(path).readAsStringSync();
  }

  throw ArgumentError('Neither a file or path was provided.');
}

String getFileName(File file, { bool includeExtension = false}) {
  var path = file.path.split('\\');
  var nameAndExtension = path[path.length - 1];
  return includeExtension? nameAndExtension : _removeFileExtension(nameAndExtension);
}

List<File> getFilesFromDirectory({String dirPath, String fileExtension = ''}) {
  var dir = Directory(dirPath);
  return dir
      .listSync()
      .where((entity) => entity is File && entity.path.endsWith(fileExtension))
      .map((entity) => entity as File)
      .toList();
}

void _createFile({String name, String content}) {
  File(name).writeAsStringSync(content);
}

String _removeFileExtension(String fileName) {
  return fileName.split('.')[0];
}
