import 'package:flutter/material.dart';
import 'package:fluttergpt/GPTResponse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter gpt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter gpt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  TextEditingController questionctrl = new TextEditingController();
  String responseText= '';
  bool Vresponse=false;











  //CALLING GPT FUNCTION
  //EXTRACTING TEXT FROM PDF METHOD
  Future<void> _callGPT(String question) async {
    try {

                    //SENDING PDF'S TEXT TO GPT
                      final GPTResponse1 = GPTResponse();
                      final result = await GPTResponse1.askQuestion(question?? "");
                      responseText = result['responseText'] ?? "";
                      print('GPT Returned: $responseText');


                      // //CONVERTING ACTIVITIES INTO LIST
                      // final String activitiesString = result['ACTIVITIES'] ?? '';

                      // // Split activitiesString into a list of maps
                      // final List<Map<String, dynamic>> activities = activitiesString
                      //   .split(',')
                      //   .map((activity) => {'activity': activity.trim()})
                      //   .toList();


                      // NAVIGATING TO AiTour.dart
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AiTour(
                      //       DestPlace: result['DESTINATION PLACE'] ?? "",
                      //       DeptPlace: result['DEPARTURE PLACE'] ?? "",
                      //       DeptTime: result['DEPARTURE TIME'] ?? "",
                      //       ReturnTime: result['RETURN TIME'] ?? "",
                      //       Title: result['TITLE'] ?? "",
                      //       included: result['INCLUDED'] ?? "",
                      //       state: result['STATE'] ?? "",
                      //       seats: result['SEATS'] ?? "",
                      //       cost: result['COST'] ?? "",
                      //       //activities: activities,
                      //       activity: result['ACTIVITY'] ?? "",
                      //     ),
                      //   ),
                      // );
                      // }else{
                      //   //First choose a pdf file!
                      //   setState(() {
                      //     Vpdf=true;
                      //   });
                      // }

    } catch (e) {
      //Handle any exceptions
      print('Error extracting text: $e');
    }
  }














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [




//TEXT WIDGET TO DISPLAY GPT RESULT
if(Vresponse)
            Container(
              child: 
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(

                  decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2, // Adjust the width as needed
              ),
            ),
            
                  width: 300, //change as per your need
                  height: 300, //change as per your need
                  child: SingleChildScrollView(
                    child: Padding(
                padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      const Text('GPT Result: ',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(responseText),

                    ],)
                  ),)
                )
              ),),






              

                //TEXT FIELD
              Container(
                margin: const EdgeInsets.only(top: 5, right:20, left:20),
                alignment: Alignment.topLeft,
                    child: TextField(

                      controller: questionctrl,
                      textAlign: TextAlign.start,
                      //autofocus: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 107, 0, 1,), width: 2.0,),
                    ),
                    hintText: 'Enter prompt here...',
                    //hintStyle: GoogleFonts.merriweatherSans(fontSize: 10),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(5),
                    ),
                      ),  ),




                IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: () {
                    setState(() {
                      Vresponse=false;
                    });
                    _callGPT(questionctrl.text);
                    setState(() {
                      Vresponse= true;
                    });
                            },),
              





          ],))
    );}}