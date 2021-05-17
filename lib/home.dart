import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  bool imago = true;
  File _image;
  List _output;
  String outputans;
  dynamic _pickImageError;

  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    catdog();
    setState(() {
      _output = output;
      outputans = '${_output[0]['label']}';
      _loading = false;
    });
  }

  void catdog() {
    if (outputans == "Cat") {
      imago = true;
      print("cat");
    } else if (outputans == "Dog") {
      imago = false;
    }

    // return imago;
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  pickImage() async {
    try {
      var image = await picker.getImage(source: ImageSource.camera);
      if (image == null) return null;
      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }

    detectImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  Widget build(BuildContext context) {
    print(outputans);
    catdog();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60),
                Text("A Simple App ",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          //    fontFamily: ,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    )),
                SizedBox(
                  height: 1,
                ),
                Text("CATDOG ",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Color(0xFFFF9900),
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30),
                Center(
                    child: _loading
                        ? Container(
                            child: Column(
                            children: <Widget>[
                              Image.asset('assets/images/catdog.png'),
                              SizedBox(
                                height: 35,
                              )
                            ],
                          ))
                        : Container(
                            //here we will show selected photos and analyzed data
                            child: Column(children: <Widget>[
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_image))),
                              //child: ClipOval(child: Image.file(_image))
                            ),
                            SizedBox(height: 20),
                            _output != null
                                ? Row(
                                    children: <Widget>[
                                      Text("its a " + outputans,
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Color(0xFFFF9900),
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(),
                                        child: imago
                                            ? Image(
                                                image: AssetImage(
                                                    'assets/images/itsacat.png'))
                                            : Image(
                                                image: AssetImage(
                                                    'assets/images/itsadog.png')),
                                      ),
                                      // AssetImage('assets/images/itsacat.png')
                                    ],
                                  )
                                : Container(),
                          ]))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              pickGalleryImage();
                              Vibration.vibrate(duration: 50);
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 18),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF9900),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Select  Photo',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              pickImage();
                              Vibration.vibrate(duration: 50);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 18),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF9900),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('Take a Photo',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
