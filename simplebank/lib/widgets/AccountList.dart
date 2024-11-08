import 'package:flutter/material.dart';

class Accountlist extends StatelessWidget {
  const Accountlist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Account Name'),
      subtitle: Column(

        children: [
          Text('Account Name:'),
          Text('Account No:'),
          Text('Account Type:'),
          Text('Balance:'),
          Divider(),
          ButtonBar(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Deposite')),
              ElevatedButton(onPressed: () {}, child: Text('Withdraw')),
            ],
          )
        ],
      ),
    );
  }
}
