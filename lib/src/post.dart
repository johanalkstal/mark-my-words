import 'dart:io' show File;
import 'package:markdown/markdown.dart';
import 'package:yaml/yaml.dart';
import 'config.dart';
import 'file.dart';

final String _postTemplateString =
    getFileContent(path: Config.postTemplatePath);

void buildPosts() {
  var posts =
      getFilesFromDirectory(dirPath: Config.postsSrcPath, fileExtension: '.md');

  posts.forEach(_buildPostFile);
}

void _buildPostFile(File file) {
  var content = getFileContent(file: file);
  if (!_hasYaml(content)) {
    throw FormatException('${file.path} is missing YAML data.');
  }
  var split = content.split(Config.yamlDelimiter);
  var yaml = loadYaml(split[1]);
  var html = markdownToHtml(split[2]);
  createHtmlFile(
      content: _postTemplateString,
      data: {"content": html},
      escapeHtml: true,
      name: yaml['name'],
      path: Config.postsOutputPath);
}

bool _hasYaml(String content) {
  return content.startsWith(Config.yamlDelimiter);
}
