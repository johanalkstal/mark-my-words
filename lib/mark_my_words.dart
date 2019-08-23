import 'dart:io';
import 'src/asset.dart';
import 'src/log.dart';
import 'src/page.dart';
import 'src/post.dart';
import 'src/server.dart';

void build() {
  Log().info('Starting build.');
  buildAssets();
  buildPages();
  buildPosts();
}

void serve() {
  Log().info('Starting server.');
  startServer();
}

void watch() {
  Log().info('Watching files.');
  var directory = Directory('lib/src');
  directory.watch(recursive: true).listen((file) {
    Log().info('${file.path} changed');
    build();
  });
}
