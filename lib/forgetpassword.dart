import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towedvechile/rtoemployeesignin.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            myDialogBox(context);
          },
          child: const Text(
            "Forget Password?",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Forget Your Password ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Your Registered Email",
                        hintText: "eg. abc@gmail.com"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await auth
                          .sendPasswordResetEmail(email: emailcontroller.text)
                          .then((value) {
                        //on success show this message
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                content:  Container(height: 250,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "We Have Send Password Reset Link on your Registerd Email Check Your Registered Email",
                                        ),
                                      )),
                                  
                                      const SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: (){ Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => const Rtoemployeesignin()));}, child: const Text("Ok"),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }).onError((error, stackTrace) {
                        //for unsuccessful
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                content:  Container(
                                  height: 250,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                     Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          error.toString(),
                                        ),
                                      )),
                                  
                                      const SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(onPressed: (){ Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => const Rtoemployeesignin()));}, child: const Text("Ok"),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text(error.toString())));
                      });
                      //Navigator.pop(context);
                      emailcontroller.clear();
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
