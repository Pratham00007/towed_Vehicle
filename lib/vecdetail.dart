import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:towedvechile/findvechile.dart';
import 'package:towedvechile/settingpage.dart';

class Vecdetail extends StatefulWidget {
  var searchedvech;
  Vecdetail({super.key, required this.searchedvech});

  @override
  State<Vecdetail> createState() => VecdetailState(this.searchedvech);
}

class VecdetailState extends State<Vecdetail> {
  final TextEditingController searchcontroller = TextEditingController();
  final CollectionReference myItems =
      FirebaseFirestore.instance.collection("Vehicle");
  String searchedvech;
  VecdetailState(this.searchedvech);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Settingpage()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Towed Vehicle Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Findvechile(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: StreamBuilder(
          stream: myItems.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                  .where((doc) => doc['Vehicle no']
                      .toLowerCase()
                      .contains(searchedvech.toLowerCase()))
                  .toList();
              if (items.length < 1) {
                return Scaffold(
                  body: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        color: Colors.blue[100],
                      ),
                      width: 350,
                      height: 300,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "🥺",
                            style: TextStyle(fontSize: 130),
                          ),
                          Text(
                            "Oops No Data Found !",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     children: [
                    //       IconButton(onPressed: (){
                    //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  VechileHomePage()));
                    //       }, icon: Icon(
                    //             Icons.home,
                    //             size: 30,
                    //             color: Colors.amber,
                    //           )),
                    //       SizedBox(
                    //         width: 10,
                    //       ),

                    //       Text("|"),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       IconButton(
                    //           onPressed: () {
                    //             const link = 'https://maps.google.com/';
                    //             launchUrl(
                    //               Uri.parse(link),
                    //               mode: LaunchMode.inAppWebView
                    //             );
                    //           },
                    //           icon: Icon(
                    //             Icons.location_on,
                    //             size: 30,
                    //             color: Colors.amber,
                    //           )),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.9),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                items[index];
                            String time = DateFormat('h:mma MMM d,y').format(
                                documentSnapshot['uploaded at'].toDate());

                            return GestureDetector(
                              onTap: () {},
                              child: Material(
                                elevation: 3,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          " Vehicle Information",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              child: CircleAvatar(
                                              radius: 80,
                                              backgroundImage: NetworkImage(
                                                documentSnapshot['Image'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          color: Colors.blue[100],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                " ${documentSnapshot['Vehicle no']}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Table(
                                          border: TableBorder.all(),
                                          children: [
                                            TableRow(children: [
                                              const Text(
                                                "Taken From: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 15,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                  "${documentSnapshot['Taken From']}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center),
                                            ]),
                                            TableRow(children: [
                                              const Text("Taken to: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center),
                                              Text(
                                                  "${documentSnapshot['TakenTo']}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center),
                                            ]),
                                            TableRow(children: [
                                              const Text("Taken Time: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center),
                                              Text("$time",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.center),
                                            ])
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.black,
                      indent: 50.0,
                      endIndent: 50.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      children: [
                        const Text(
                          "Documents You Need There:",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 27),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: const Column(
                            children: [
                              Text(
                                "1. Registraton Certificate (RC)",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "2. Driving Licence",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "3. Vehicle Insurance",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "4. Chassis Number ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "5. All Document Shows Your Ownership",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
