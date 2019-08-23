import 'package:mustache/mustache.dart';
import 'config.dart';
import 'file.dart';

Map<String, Template> _partials = {};

Template getPartial(String name) {
  if (_partials.isEmpty) {
    _createPartials();
  }

  return _partials[name];
}

void _createPartials() {
  var partials = getFilesFromDirectory(
      dirPath: Config.partialsPath, fileExtension: '.mustache');
  partials.forEach((file) {
    var name = getFileName(file);
    var content = getFileContent(file: file);
    _partials[name] = Template(content, name: '$name partial');
  });
}
