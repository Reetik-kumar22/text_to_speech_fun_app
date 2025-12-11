import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(speechApp());
}
class speechApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: "Text To Speech",
     theme: ThemeData(
       primarySwatch: Colors.grey,
     ),
     home: texttospeech(),
   );
  }
}
class texttospeech extends StatefulWidget{
  @override
  State<texttospeech> createState() => _texttospeechState();
}

class _texttospeechState extends State<texttospeech> {

  TextEditingController textcontroller = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  double volume = 0.8;
  double rate = 0.5;
  double pitch = 1.0;

  String selectedlanguage="en-US";

  Future<void> speakText() async {
    await flutterTts.setLanguage(selectedlanguage);
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.speak(textcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Text to speech",style: TextStyle(fontWeight: FontWeight.bold),),
       backgroundColor: Colors.orange,
     ),
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Center(child: Image.network("https://media.istockphoto.com/id/1313123682/vector/mans-speech-on-white-background-vector-of-male-head-with-sound-vibration-boy-speaking-man.jpg?s=612x612&w=0&k=20&c=4pIkRuQK-p6AESFgbjSjepBqs9JwN7EYtuDcHW_MyIg=",height: 280,)),
       Center(
         child: Container(
           height: 90,
           width: 400,
           decoration: BoxDecoration(
             color: Colors.orange,
             borderRadius: BorderRadius.circular(15),
           ),
           child: Center(
             child: TextField(
               controller: textcontroller,
               decoration: InputDecoration(
                 border: InputBorder.none,
                 hint: Text("Enter the text",style: TextStyle(fontSize: 25),),
                 contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
               ),
             ),
           ),
         ),
       ),

         SizedBox(height: 30,),

         Slider(
             value: volume,
             min: 0.0,
             max: 1.0,
             onChanged: (val){
               setState(() {
                 volume = val;
               });
             }
         ),

         SizedBox(height: 10,),

         Slider(
             value: rate,
             min: 0.0,
             max: 1.0,
             onChanged: (val){
               setState(() {
                 rate = val;
               });
             }
         ),

         SizedBox(height: 10,),

         Slider(
             value: pitch,
             min: 0.0,
             max: 2.0,
             onChanged: (val){
               setState(() {
                 pitch  = val;
               });
             }
         ),

         Center(
           child: Container(
             height: 60,
             width: 380,
             decoration: BoxDecoration(
               color: Colors.cyanAccent,
               borderRadius: BorderRadius.circular(22),
             ),
             child:
               Center(
                 child: DropdownButton<String>(
                   value: selectedlanguage,
                   items: [
                     DropdownMenuItem(
                       child: Text("English"),
                       value: "en-US",
                     ),
                     DropdownMenuItem(
                       child: Text("Hindi"),
                       value: "hi-IN",
                     ),
                     DropdownMenuItem(
                       child: Text("Punjabi"),
                       value: "pa-IN",
                     )
                   ],
                   onChanged: (value){
                     setState(() {
                       selectedlanguage = value!;
                     });
                   }
                 ),
               ),
           ),
         ),

         SizedBox(height: 30,),

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             GestureDetector(
               onTap: speakText,
               child: Container(
                 height: 70,
                 width: 150,
                 decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(22),
                 ),
                 child: Center(child: Text("▶️  Play",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
               ),
             ),

             GestureDetector(
               onTap:(){
                flutterTts.stop();
              },
               child: Container(
                 height: 70,
                 width: 150,
                 decoration: BoxDecoration(
                   color: Colors.red,
                   borderRadius: BorderRadius.circular(22),
                 ),
                 child: Center(child: Text("⏹️  Stop",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
               ),
             ),
           ],
         ),
       ],
     ),
   );
  }
}