import 'package:calculator/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

//main function
void main() {
  runApp(MaterialApp(
    title: 'Debug Banner',
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

//created a class name calculator app which is extended with statefulwidget
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override

  State<CalculatorApp> createState() => _CalculatorAppState();
}

//body of the app
class _CalculatorAppState extends State<CalculatorApp> {

  //creating variables to perform operation
  double firstno=0.0;
  double secondno=0.0;
  var input ="";
  var output ="";
  var operation ="";
  var hideinput=false;
  var outputsize=34.0;

  onButtonClick(value){

    //if clicking on all clear
    if(value=="AC"){
      input="";
      output="";
    }
    //if clicking on C then the it remove the last digit we enter in the input
    else if(value=="C"){
      if(input.isNotEmpty){
        //cheacking if it is empty or not
        input=input.substring(0,input.length-1);
      }
    }
    else if(value=="=") {
      //cheacking if input is empty
      if (input.isNotEmpty) {
        //creating variable user input to store the input coming form user
        var userinput = input;
        //replacing x with * as we using maths library to perform the maths calculations
        userinput = input.replaceAll(("x"), "*");
        //importing parser which do the mathematical calculation
        Parser p = Parser();
        //expression variable created to passing the input variable
        Expression expression = p.parse(userinput);
        //creating context model which can access the expression getting from the parent
        ContextModel cm = ContextModel();
        //storing the final value in variable
        var finalvalue = expression.evaluate((EvaluationType.REAL), cm);
        //geting final value in output variable
        output = finalvalue.toString();

        //creating a condition of it ends with .o then remove it from the ans
        if(output.endsWith(".0")){
          output=output.substring((0),output.length-2);
        }

        //for geting the ans in big big terms thats why we put it in input to show the output and take the output to do further calculationns
        input=output;

        //hiding the input to show the final output in bold when user click the = sign
        hideinput =true;
        //changing the size of output
        outputsize=52;
      }
    }
    //we creating a input where the button we press it come as input and add up as a combined input given buy the user
    else{
      input=input+value;
      //hiding the input to show the final output in bold when user click the = sign
      hideinput =false;
      //changing the size of output
      outputsize=34;
    }
    //for refreshing screen
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //giving the background color
      backgroundColor: Colors.black,

      //defining the main body
      body: Column(

        //children created to store all the rows of buttons and output in it in it
        children: [

          //input output area
          Expanded(
              child: Container(

                padding: const EdgeInsets.all(12),
                width: double.infinity,

                //place to display the text and the output we getting
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [

                    //input
                    Text(
                      hideinput ? "": input,
                      style:TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),

                    //creating space btwn i/p o/p
                    SizedBox(
                      height: 20,
                    ),

                    //output
                    Text(
                      output,
                      style:TextStyle(
                        fontSize: outputsize,
                        color: Colors.white70,
                      ),
                    ),

                    //creating space btwn o/p and buttons
                    SizedBox(
                      height: 40,
                    ),

                  ],

                ),

              )

          ),

          //buttons area(using in a row)

          //ac,C,%,/
          Row(
            //creating a children container which store the buttons in 1 row
            children: [
              button(text: "AC",buttonbgcolor: operatorColor, tcolor: orangecolor),
              button(text: "C",buttonbgcolor: operatorColor, tcolor: orangecolor),
              button(text: "!%",buttonbgcolor: operatorColor),
              button(text: "/",buttonbgcolor: operatorColor)
            ],
          ),

          //7,8,9,x
          Row(
            //creating a children container which store the buttons in 1 row
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x",buttonbgcolor: operatorColor)
            ],
          ),

          //4,5,6,-
          Row(
            //creating a children container which store the buttons in 1 row
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-",buttonbgcolor: operatorColor)
            ],
          ),

          //1,2,3,+
          Row(
            //creating a children container which store the buttons in 1 row
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+",buttonbgcolor: operatorColor)
            ],
          ),

          //
          Row(
            //creating a children container which store the buttons in 1 row
            children: [
              button(text: "%",buttonbgcolor: operatorColor),
              button(text: "0"),
              button(text: ".",buttonbgcolor: operatorColor),
              button(text: "=",buttonbgcolor: orangecolor)
            ],
          ),

        ] //Children
      ),
    );

  }

  //creating a function for the buttons as we have to use it again and again so code redudancy will be increased
  Widget button({text,tcolor = Colors.white,buttonbgcolor=buttonColor}){
    return Expanded(
          child: Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: buttonbgcolor,
                    padding: const EdgeInsets.all(22),
                  ),
                  onPressed: () =>onButtonClick(text),
                  child: Text(
                      text,
                      style:TextStyle(
                        fontSize: 18,
                        color: tcolor,
                        fontWeight: FontWeight.bold,
                      )
                  )
              )
          )
      );
  }
}


