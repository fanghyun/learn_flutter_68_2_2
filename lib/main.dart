import 'package:flutter/material.dart';

import 'package:learn_flutter_68_2_2/first_screen.dart';

//step 5 : Connect to Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: FirstScreen()));
}
