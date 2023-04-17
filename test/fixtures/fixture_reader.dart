import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

void testLoadEnv(String name) => dotenv.testLoad(
      fileInput: File(name).readAsStringSync(),
    );
