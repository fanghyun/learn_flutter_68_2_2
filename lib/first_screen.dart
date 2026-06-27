import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

//Step3:  check Internet Connection
import 'package:connectivity_plus/connectivity_plus.dart';
//Step4: //Step4: Show toast message
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  //อะไรที่อยากจะให้ทำงานตอนเริ่มต้น ให้ใส่ในนี้
  void initState() {
    super.initState();
    // //เมื่อครบ3วิ ให้ไปหน้า SecondScreen
    // Timer(
    //   const Duration(seconds: 3),
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const SecondScreen()),
    //   ),
    // );

    //Step3:  check Internet Connection
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      _showToast(context, "Mobile network available.");
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
 _showToast(context, "Wi-fi is available.");
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
       _showToast(context, "Ethernet connection available.");
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
       _showToast(context, "Vpn connection active.");
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
       _showToast(context, "Bluetooth connection available.");
    } else if (connectivityResult.contains(ConnectivityResult.satellite)) {
      // Carrier-provided satellite network available
       _showToast(context, "satellite network available.");
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
       _showToast(context, "Ohther netword is available");
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network 
      setState(() {
        _showAlertDialog(context, 
        "No Tnternet", 
        "Please check your internet connection",
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.cyanAccent],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(0.5, 0.6),
          tileMode: TileMode.mirror,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: Image.asset("./android/assets/image/app_screen.png")),
          const SizedBox(height: 20),
          const SpinKitSpinningLines(
            color: Color.fromARGB(255, 251, 196, 196),
            size: 50.0,
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: const Center(
        child: Text(
          "This is the second screen",
          style: TextStyle(
            fontSize: 24,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w500,
            fontFamily: 'Alike',
          ),
        ),
      ),
    );
  }
}

//Step4: Show toast message
void _time(BuildContext context) {
  //เมื่อครบ3วิ ให้ไปหน้า SecondScreen
  Timer(
    const Duration(seconds: 3),
    () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    ),
  );
}

////Step4: Show toast message
void _showToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.amber,
    textColor: Colors.black,
    fontSize: 24,
  );
  _time(context);
}

void _showAlertDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Colors.deepOrange,
            fontWeight: FontWeight.w500,
            fontFamily: "Alike",
          ),
        ),
        content: Text(msg),
        actions: <Widget>[
          ElevatedButton(
            style:ButtonStyle( 
              backgroundColor: WidgetStatePropertyAll(Colors.deepPurple), 
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "OK",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontFamily: "Alike",       
              ),
            )
          ),
        ],
      );
    },
  );
}
