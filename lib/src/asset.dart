import 'config.dart';
import 'file.dart';
import 'log.dart';

void buildAssets() {
  var assets = getFilesFromDirectory(dirPath: Config.assetsSrcPath);
  assets.forEach((file) {
    var name = getFileName(file, includeExtension: true);
    file.copy('${Config.assetsOutputPath}/$name');
  });
}
