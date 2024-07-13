import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:towedvechile/findvechile.dart';
import 'package:towedvechile/rtoemployeesignin.dart';
import 'package:towedvechile/showcase_widget.dart';
import 'package:video_player/video_player.dart';

class VechileHomePage extends StatefulWidget {
  const VechileHomePage({super.key});

  @override
  State<VechileHomePage> createState() => VechileHomePageState();
}

class VechileHomePageState extends State<VechileHomePage> {
  late VideoPlayerController _controller;
  final GlobalKey rtoempkey = GlobalKey();
  final GlobalKey vechilekey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('asset/video/car9emproved.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
        demo();
      });
  }

  demo() async {
//for tutorial
    var prefs = await SharedPreferences.getInstance();
    var getdemodetail = prefs.get(LoginWidget.Keyname);

    getdemodetail == null
        ? WidgetsBinding.instance.addPostFrameCallback((_) =>
            ShowCaseWidget.of(context).startShowCase([rtoempkey, vechilekey]))
        : WidgetsBinding.instance
            .addPostFrameCallback((_) => ShowCaseWidget.of(context).dismiss());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            LoginWidget(
              rtoempkey1: rtoempkey,
              vechilekey1: vechilekey,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key, required this.rtoempkey1, required this.vechilekey1});
  final GlobalKey rtoempkey1;
  final GlobalKey vechilekey1;
  static const String Keyname = "seendemo";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String isseendemo = "true";
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(Keyname, isseendemo);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Welcome....",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 45,
                      fontFamily: 'fontmain',
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShowCaseView(
                      title: 'Rto Employee',
                      description: "Register the Towed Vehicle",
                      globalKey: rtoempkey1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Rtoemployeesignin()));
                        },
                        child: const Text("RTO Employee"),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(300, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ShowCaseView(
                      globalKey: vechilekey1,
                      title: "Find Towed Vehicle Detail",
                      description: "Search for Towed Vehicle",
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Findvechile()));
                        },
                        child: const Text("Where is my Vehicle ?"),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(300, 50),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Icon(Icons.settings,color: Colors.white,),
                    //     TextButton(onPressed: (){

                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Settingpage()));

                    //     }, child: Text("Settings",style: TextStyle(color: Colors.white),)),
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
