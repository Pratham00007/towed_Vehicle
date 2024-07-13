import 'dart:developer';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towedvechile/common_style/snackbar.dart';
import 'package:towedvechile/common_style/textinput.dart';
import 'package:towedvechile/settingpage.dart';

class Registervechile extends StatefulWidget {
  const Registervechile({super.key});

  @override
  State<Registervechile> createState() => _RegistervechileState();
}

class _RegistervechileState extends State<Registervechile> {
  TextEditingController vecnocontroller = TextEditingController();
  final TextEditingController takenfromcontroller = TextEditingController();
  final TextEditingController takentocontroller = TextEditingController();
  final TextEditingController tfaddress1controller = TextEditingController();
  final TextEditingController tfaddress2controller = TextEditingController();
  final TextEditingController tfStatecontroller = TextEditingController();
  final TextEditingController tfCitycontroller = TextEditingController();
  final TextEditingController tfLandmarkcontroller = TextEditingController();

  final TextEditingController ttaddress1controller = TextEditingController();
  final TextEditingController ttaddress2controller = TextEditingController();
  final TextEditingController ttStatecontroller = TextEditingController();
  final TextEditingController ttCitycontroller = TextEditingController();
  final TextEditingController ttLandmarkcontroller = TextEditingController();
  
  //os ke liye change karna xcode check googlr_ml_kit_text_recognition dev and mdify it
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool scannig = false;
  String mytext = '';
  File? pickedImage;
  bool isLoading = false;

  uploadData() async {
    setState(() {
      isLoading = true;
    });

    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Vechile Pic")
        .child(vecnocontroller.text.toString())
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    //save image url in database
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Vehicle")
        .doc(vecnocontroller.text.toString())
        .set({
      "Vehicle no": vecnocontroller.text.toString(),
      "Taken From": takenfromcontroller.text,
      "TakenTo": takentocontroller.text,
      "Image": url.toString(),
      "uploaded at": DateTime.now(),
    }).then((value) {
      log("Uploaded");
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Successfully Subitted"),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    });
  }

  showAlertDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pick Image From"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image),
                  title: const Text("Gallery"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Settingpage()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        title: const Text(
          "Where is my Vehicle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter All the Details",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[100],),
                    child: Column(children: [
                
                        
                
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                    onTap: () {
                      showAlertDialogBox();
                    },
                    child: Column(
                      children: [
                        pickedImage != null
                            ? CircleAvatar(
                                radius: 80,
                                foregroundImage: FileImage(pickedImage!),
                              )
                            : const CircleAvatar(
                                radius: 90,
                                child: Icon(
                                  Icons.car_repair,
                                  size: 70,
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        pickedImage != null
                            ? const Text(
                                "Change Vehicle Pic",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            : const Text(
                                "Upload Vehicle Pic",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              
                      ],
                    )
                    ),
                const SizedBox(
                  height: 20,
                ),
                Textinput(
                    textEditingController: vecnocontroller,
                    hintText: "Enter Vehicle no",
                    icon: Icons.no_crash_outlined),
                   mytext!=''
                   ?InkWell(
                    
                   onTap: () {
                    vecnocontroller.text = mytext;
                  },
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: const Color(0xFFedf0f8),
                          ),
                         child:  scannig
                                        ? const Padding(
                                            padding: EdgeInsets.only(top: 60),
                                            child: Center(
                        child: SpinKitThreeBounce(
                          color: Colors.black,
                          size: 20,
                        ),
                                            ),
                                          )
                                        : Center(
                                            child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TypewriterAnimatedText(mytext,
                              textAlign: TextAlign.center)
                        ],
                                            ),
                                          )
                                          
                        ),
                      ),
                    ],
                  ),
                  
                )
                : const InkWell(child: SizedBox(width: 2,),),

                const SizedBox(
                  height: 20,
                ),
                    
                    ],),
                
                ),
              ),          const SizedBox(width: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[100],),
                  child: Column(children: [
                  const SizedBox(height: 20,),
                      
                const Text("Enter The Place Vehicle Taken From :",style: TextStyle(fontSize: 20),),
                const SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(children: [
                    TextField(
                      controller: tfaddress1controller ,
                      decoration: InputDecoration(
                              hintText: "Address Line1",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: tfaddress2controller ,
                      decoration: InputDecoration(
                              hintText: "Address Line2",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                            ),
                            const SizedBox(height: 20,),

                            
          

                    
                    TextField(
                      controller: tfLandmarkcontroller ,
                      decoration: InputDecoration(
                              hintText: "Landmark",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                    ),
                              const SizedBox(height: 20,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller:tfStatecontroller ,
                            decoration: InputDecoration(
                                    hintText: "State",
                                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: const Color(0xFFedf0f8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(width: 2, color: Colors.blue)),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                  
                        
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: tfCitycontroller ,
                            decoration: InputDecoration(
                                    hintText: "City",
                                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 18,),
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: const Color(0xFFedf0f8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(width: 2, color: Colors.blue)),
                                  ),
                          ),
                        ),
                  
                  
                    ],),
                    const SizedBox(height: 20,),
                       
                  ],),
                )
                  ],),
                ),
              ),

              const SizedBox(width: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[100],),
                  child: Column(children: [
                  const SizedBox(height: 20,),
                      
                const Text("Enter The Place Vehicle Taken to :",style: TextStyle(fontSize: 20),),
                const SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Column(children: [
                    TextField(
                      controller: ttaddress1controller ,
                      decoration: InputDecoration(
                              hintText: "Address Line1",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: ttaddress2controller ,
                      decoration: InputDecoration(
                              hintText: "Address Line2",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                            ),
                            const SizedBox(height: 20,),

                            
          

                    
                    TextField(
                      controller: ttLandmarkcontroller ,
                      decoration: InputDecoration(
                              hintText: "Landmark",
                              hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                             
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xFFedf0f8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 2, color: Colors.blue)),
                            ),
                    ),
                              const SizedBox(height: 20,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: ttStatecontroller ,
                            decoration: InputDecoration(
                                    hintText: "State",
                                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: const Color(0xFFedf0f8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(width: 2, color: Colors.blue)),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                  
                        
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: ttCitycontroller ,
                            decoration: InputDecoration(
                                    hintText: "City",
                                    hintStyle: const TextStyle(color: Colors.black45, fontSize: 18,),
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: const Color(0xFFedf0f8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(width: 2, color: Colors.blue)),
                                  ),
                          ),
                        ),
                  
                  
                    ],),
                    const SizedBox(height: 20,),
                       
                  ],),
                )
                  ],),
                ),
              ),
              
              InkWell(
                onTap: () {
                  if (vecnocontroller.text.toString() != '' &&
                      takenfromcontroller.text != '' &&
                      takentocontroller.text != '' &&
                      pickedImage != null) {
                    setState(() {
                      isLoading = true;
                    });

                    uploadData();
                  } else {
                    showSnackBar(context, "Enter all the fields");
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    setState(() {
      scannig = true;
    });
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);

       final inputImage = InputImage.fromFilePath(photo.path);
    final textrecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText = await textrecognizer.processImage(inputImage);
    
      setState(() {
        pickedImage = tempImage;
         mytext = RecognizedText.text;
        scannig = false;
      });
        textrecognizer.close();
    } catch (ex) {
      log(ex.toString());
    }
  }

  performtextrecognitio() async {
    setState(() {
      scannig = true;
    });
    try{
    final inputImage = InputImage.fromFilePath(pickedImage!.path);
    final textrecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText = await textrecognizer.processImage(inputImage);
      setState(() {
        mytext = RecognizedText.text;
        scannig = false;
      });
      
      textrecognizer.close();
    } catch (e) {
      print("Error during rcognistion $e");
    }
  }
}
