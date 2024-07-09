import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Gpt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue, // Adjust as needed
    backgroundColor: Color(0xFFECEFF1),
    errorColor: Colors.red, // Example of setting error color
    brightness: Brightness.light, // Adjust brightness
  ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Gpt'),
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
  String inputText= '';
  bool Vresponse=false;
  bool Vinput=false;


  //CALLING GPT FUNCTION
  //EXTRACTING TEXT FROM PDF METHOD
  Future<void> _callGPT(String question) async {
    try {
        //SENDING PDF'S TEXT TO GPT
        final GPTResponse1 = GPTResponse();
        final result = await GPTResponse1.askQuestion(question?? "");
        responseText = result['responseText'] ?? "";
        print('GPT Returned: $responseText');
        setState(() {
          Vresponse=true;
        });

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




  body: Container(

    child: Column(children: [



      //TEXT WIDGET TO DISPLAY USER INPUT
      if(Vinput)
      Align(
        alignment: Alignment.centerRight, // Aligns the message box to the left
        child: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Container(
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 65, 64, 64), // Background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            border: Border.all(
              color: Color.fromARGB(255, 65, 64, 64),
              width: 1, // Border width
            ),
          ),
            constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7, // Limits width to 70% of screen width
          ),
            padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
            children: [
              Text(
                'User:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8.0), // Space between title and message
              Text(
                inputText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),







//TEXT WIDGET TO DISPLAY GPT RESULT
if(Vresponse)
            Align(
      alignment: Alignment.centerLeft, // Aligns the message box to the left
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 65, 64, 64), // Background color
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            border: Border.all(
              color: Color.fromARGB(255, 65, 64, 64),
              width: 1, // Border width
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7, // Limits width to 70% of screen width
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
            children: [
              Text(
                'Chat gpt:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8.0), // Space between title and message
              Text(
                responseText,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),







       



          ],)),
    
    
    
    bottomNavigationBar: BottomAppBar(
      

      child:  Container(

        child: Container(
                //height: 400,
                margin: EdgeInsets.only(left: 20, right: 3),
              child: Row(children: [


                //TEXT FIELD
               Flexible(
                
                    child: TextField(

                      controller: questionctrl,
                      textAlign: TextAlign.start,
                      //autofocus: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),

                    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // Adjust color as needed
    ),

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
                              color: Colors.grey,
                            ),
                            onPressed: () {

                    setState(() {
                      Vresponse=false;
                      Vinput=false;
                    });
                    _callGPT(questionctrl.text);
                    setState(() {
                      inputText = questionctrl.text;
                      questionctrl.text='';
                      Vresponse= true;
                      Vinput=true;
                    });
                            },),

                


                            ],),),),
    
    
    
    
    
    ),);}}