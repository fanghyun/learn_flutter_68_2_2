import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

//Step3:  check Internet Connection
import 'package:connectivity_plus/connectivity_plus.dart';
//Step4: //Step4: Show toast message
import 'package:fluttertoast/fluttertoast.dart';

//Step7: Firebase CRUD operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_flutter_68_2_2/services/firestore.dart';

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
        _showAlertDialog(
          context,
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

// class SecondScreen extends StatelessWidget {
//   const SecondScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Second Screen")),
//       body: const Center(
//         child: Text(
//           "This is the second screen",
//           style: TextStyle(
//             fontSize: 24,
//             color: Colors.deepPurple,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Alike',
//           ),
//         ),
//       ),
//     );
//   }
// }

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
            style: ButtonStyle(
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
            ),
          ),
        ],
      );
    },
  );
}

//Step7: Firebase CRUD operations
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  //make an instance of FirestoreService
  final FirestoreService firestoreService = FirestoreService();

  //text editing controllers for the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // Open a dialog to add a new person
  void openPersonBox(String? personID) async {
    if (personID != null) {
      //Update case
      final person = await firestoreService.getPersonById(personID);
      nameController.text = person?['personName'] ?? '';
      emailController.text = person?['personEmail'] ?? '';
      ageController.text = person?['personAge']?.toString() ?? '';
    } else {
      //Create case
      nameController.clear();
      emailController.clear();
      ageController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text;
              final email = emailController.text;
              final age = int.tryParse(ageController.text) ?? 0;

              if (personID != null) {
                //Update case
                await firestoreService.updatePerson(personID, name, email, age);
              } else {
                //Create case
                await firestoreService.addPerson(name, email, age);
              }

              nameController.clear();
              emailController.clear();
              ageController.clear();

              Navigator.of(context).pop();
            },
            child: Text(personID != null ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Persons List"),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            openPersonBox(null), // Open dialog for adding a new person
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPersons(),
        builder: (context, snapshot) {
          // if we data, get the list of persons
          if (snapshot.hasData) {
            final personsList = snapshot.data!.docs;

            //Display the list of persons
            return ListView.builder(
              itemCount: personsList.length,
              itemBuilder: (context, index) {
                // Get the person document
                DocumentSnapshot personDoc = personsList[index];
                String personID = personDoc.id;

                // Get  person from the document
                Map<String, dynamic> personData =
                    personDoc.data() as Map<String, dynamic>;

                String nameText = personData['personName'] ?? '';
                String emailText = personData['personEmail'] ?? '';
                int ageText = personData['personAge'] ?? 0;

                return ListTile(
                  title: Text(nameText),
                  subtitle: Text('Email: $emailText, Age: $ageText'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => openPersonBox(
                          personID,
                        ), // Open dialog for updating the person
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await firestoreService.deletePerson(personID);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          // if we don't have data, show a message
          return Center(
            child: Text("No persons found."),
          );
        },
      ),
    );
  }
}
