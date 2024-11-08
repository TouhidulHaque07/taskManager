import 'package:flutter/material.dart';
import 'package:simplebank/Models/accountModels.dart';
import 'package:simplebank/widgets/AccountList.dart';

class Simplebankscreen extends StatefulWidget {
  const Simplebankscreen({super.key});

  @override
  State<Simplebankscreen> createState() => _SimplebankscreenState();

}

acountModel CoustomerAccount = acountModel(
    accountID: '001',
    accountName: 'Md.Touhidul Haque',
    accountType: 'Saving',
    accountNumber: 'SB-00001',
    balance: 500);

class _SimplebankscreenState extends State<Simplebankscreen> {
  TextEditingController _inputTEcontroller=TextEditingController();
  @override
  void initState() {
    getCoustomerData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Bank Mangement'),
      ),
      body:
     ListView.separated(

       itemCount: 1,
       itemBuilder: (context,index){

         return ListTile(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

           title: Text('Account Holder: ${CoustomerAccount.accountName}'),
           subtitle: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text('Account Type: ${CoustomerAccount.accountType}'),
               Text('Account Number: ${CoustomerAccount.accountNumber}'),
               Text('Balance: ${CoustomerAccount.balance}'),
              Center(
                child: SizedBox(

                  width: 100,
                  child: TextField(
                    controller: _inputTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      labelText: 'Enter Amount',
                    ),

                    keyboardType: TextInputType.number,
                  ),

                ),
              ),

               Divider(),
               ButtonBar(
                 children: [

                   ElevatedButton(onPressed: (){
                     onTapdeposite();
                   }, child: Text('Diposite')),
                   ElevatedButton(onPressed: (){
                     onTapWithdraw();
                   }, child: Text('Withdraw'))
                 ],
               ),



             ],

           ),
         );
       },separatorBuilder: (context, index){
         return SizedBox(height: 20,);
     },
     ),


    );
  }

  void onTapdeposite() {
      double inputBalance=0;
    if(_inputTEcontroller.text.isEmpty||int.parse(_inputTEcontroller.text)<0){
            return ;
    }
    else{
        inputBalance= double.parse(_inputTEcontroller.text);
        CoustomerAccount.balance+=inputBalance;
        setState(() {

        });
    }

  }

  void onTapWithdraw() {
    double inputBalance=0;
    if(_inputTEcontroller.text.isEmpty||int.parse(_inputTEcontroller.text)<0){
      return ;
    }
    else{
      inputBalance= double.parse(_inputTEcontroller.text);
      if(CoustomerAccount.balance<=500){
        return;
      }else if(CoustomerAccount.balance-inputBalance<500){
        return;
      }else{
        CoustomerAccount.balance-=inputBalance;
        setState(() {

        });
      }

    }

  }
}

void getCoustomerData() {

}


