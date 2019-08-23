import 'dart:io' show File;
import 'config.dart';
import 'file.dart';
import 'log.dart';

void buildPages() {
  var pages = getFilesFromDirectory(
      dirPath: Config.pagesSrcPath, fileExtension: '.mustache');
  pages.forEach(_buildPageFile);
}

void _buildPageFile(File file) {
  var page = getFileContent(file: file);
  var name = getFileName(file);
  createHtmlFile(path: Config.pagesOutputPath, name: name, content: page);
}
