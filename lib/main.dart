import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

//run below command to get development build
//flutter build apk --release -t lib/main_development.dart --flavor development
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: App()));
}
