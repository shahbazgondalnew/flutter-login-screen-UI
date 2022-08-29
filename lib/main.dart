import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signUp.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD6hUZM0_JZXHY4kIn6dD8kX_OmOMyaD5w",
        appId: "1:533936968431:web:1ee7fa6d47894b9db5c11a",
        messagingSenderId: "533936968431",
        projectId: "flutter2022-17ba0"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '(' ')'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final showEmpty = SnackBar(content: Text('Imformation can not be empty'));
  final showLogin = SnackBar(content: Text('Login Suceed'));
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
          Widget>[
        TextField(
          controller: emailController,
          decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: const EdgeInsets.all(15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          onChanged: (value) {},
        ),
        TextField(
          obscureText: hide,
          controller: passController,
          decoration: InputDecoration(
              suffix: InkWell(
                onTap: showPassword,
                child: const Icon(Icons.visibility),
              ),
              hintText: 'Password',
              contentPadding: const EdgeInsets.all(15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          onChanged: (value) {},
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black)))),
                onPressed: () async {
                  String emailData = emailController.text;
                  if (emailController.text.isEmpty ||
                      passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Imformation Can not be empty")));
                  } else {
                    try {
                      // ignore: unused_local_variable

                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: emailData,
                              password: passController.text.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profilePage()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(showLogin);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                    Text('No user found for that email.')));
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Wrong password provided for that user.')));
                      }
                    }
                  }
                },
                child: Expanded(
                  child: const Text("Login"),
                ),
              ),
            ),
          ],
        ),
        Row(children: [
          Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.black)))),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAppSignUp()),
                    );
                  })),
        ])
      ]),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  showPassword() {
    setState(() {
      if (hide == true) {
        hide = false;
      } else {
        hide = true;
      }
    });
  }
}
