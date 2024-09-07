import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 final TextEditingController _textTECFirstNumber=TextEditingController();
 final TextEditingController _textTECSecondNumber=TextEditingController();
 final GlobalKey<FormState> _keyForm= GlobalKey<FormState>();

 double _result=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: Column(

            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _textTECFirstNumber,
                decoration: InputDecoration(
                  hintText: 'First Number',
                  label: Text('First Number'),
                ),
                validator: (String? value){
                  if(value==null||value.isEmpty){
                    return 'Enter a Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _textTECSecondNumber,
                decoration: InputDecoration(
                  hintText: 'Second Number',
                  label: Text('Seconnd Number'),
                ),
                validator: (String? value){
                  if(value==null||value.isEmpty){
                    return 'Enter a Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getButtonBilder(),
                ],
              ),
              Text('Result:${_result.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),


    );
  }

  Widget _getButtonBilder(){
    return Row(
      children: [
        IconButton(onPressed: _addOnTap, icon: Icon(Icons.add) ),
        IconButton(onPressed: _subtractOnTap, icon:Icon(Icons.remove)),
        IconButton(onPressed: _multiplicaionOnTap, icon:Text('*', style:TextStyle(
            fontSize: 24,color: Colors.black) )),
        IconButton(onPressed: _devisionOnTap, icon:Text('/', style:TextStyle(
            fontSize: 24,color: Colors.black) )),
      ],
    );

  }

  void _addOnTap(){

    if(_keyForm.currentState!.validate()){
      double firstNumber= double.tryParse(_textTECFirstNumber.text)??0;
      double secondNumber= double.tryParse(_textTECSecondNumber.text)??0;
      _result=firstNumber+secondNumber;
      setState(() {
      });
    }
    return;


  }
 void _subtractOnTap(){
   double firstNumber= double.tryParse(_textTECFirstNumber.text)??0;
   double secondNumber= double.tryParse(_textTECSecondNumber.text)??0;
   _result=firstNumber-secondNumber;
   setState(() {
   });
 }
 void _multiplicaionOnTap(){
   double firstNumber= double.tryParse(_textTECFirstNumber.text)??0;
   double secondNumber= double.tryParse(_textTECSecondNumber.text)??0;
   _result=firstNumber*secondNumber;
   setState(() {
   });
 }
 void _devisionOnTap(){
   double firstNumber= double.tryParse(_textTECFirstNumber.text)??0;
   double secondNumber= double.tryParse(_textTECSecondNumber.text)??0;
   _result=firstNumber/secondNumber;
   setState(() {
   });
 }




}
