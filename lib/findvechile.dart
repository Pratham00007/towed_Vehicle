import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towedvechile/common_style/snackbar.dart';
import 'package:towedvechile/common_style/textinput.dart';
import 'package:towedvechile/homepage.dart';
import 'package:towedvechile/splash/searchsplash.dart';


class Findvechile extends StatefulWidget {
  const Findvechile({super.key});

  @override
  State<Findvechile> createState() => _FindvechileState();
}

class _FindvechileState extends State<Findvechile> {
  bool isLoading = false;
  final TextEditingController vecnocontroller = TextEditingController();
  final TextEditingController searchcontroller = TextEditingController();
  final CollectionReference myItems =
      FirebaseFirestore.instance.collection("Vehicle");
  String searchtext = "";
  void onSearchChange(String value) {
    setState(() {
      searchtext = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: const AlignmentDirectional(-1, -1),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VechileHomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.asset('asset/images/form fill.jpg'),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Vehicle Details",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Textinput(
                textEditingController: vecnocontroller,
                hintText: "Enter Vehicle no",
                icon: Icons.car_repair,
              ),
              InkWell(
                onTap: () {
                  if (vecnocontroller.text.toString() == '') {
                    showSnackBar(context, "Enter the Vehicle Number !");
                  } else if (vecnocontroller.text.length < 8) {
                    showSnackBar(context, "Enter correct details !");
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Searchsplash(
                                lastpagesearch:
                                    vecnocontroller.text.toString())));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.blue,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
