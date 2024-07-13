import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:towedvechile/common_style/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;
  File? pickedimage;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  // onChangeFunction3(bool newValue3) {
  //   setState(() {
  //     valNotify3 = newValue3;
  //   });
  // }

  showaletdialogbox() {
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
        backgroundColor: Colors.blue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  showaletdialogbox();
                },
                child: pickedimage != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(pickedimage!),
                      )
                    : const CircleAvatar(
                        radius: 90,
                        child: Icon(
                          Icons.person_add_alt_1,
                          size: 70,
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.volume_up_outlined,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Notification",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: buildNotificationOption(
                        "", valNotify1, onChangeFunction1),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          sendmail();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact us",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          privacy();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Privacy And Security",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          advice();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Advice an Improvement",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          reportbug();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Report A Bug",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "App Version",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "1.0.0",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangedMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600]),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangedMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  pickImage(ImageSource imagesource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imagesource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedimage = tempImage;
      });
    } catch (ex) {
      showSnackBar(context, ex.toString());
    }
  }

  sendmail() async {
    const link =
        'mailto:pratham10600@gmail.com?subject=Contact regarding Where is my Vehicle';
    launchUrl(
      Uri.parse(link),
    );
  }

  privacy() async {
    const link =
        'https://i.pcmag.com/imagery/articles/05HBinOAf0RySw2Va94C8qK-2.fit_lim.size_1050x.png';
    launchUrl(
      Uri.parse(link),
    );
  }

  advice() async {
    const link =
        'mailto:pratham10600@gmail.com?subject=Advice regarding Where is my Vehicle';
    launchUrl(
      Uri.parse(link),
    );
  }

  reportbug() async {
    const link =
        'mailto:pratham10600@gmail.com?subject=Reporting Bug on Where is my Vehicle';
    launchUrl(
      Uri.parse(link),
    );
  }
}
