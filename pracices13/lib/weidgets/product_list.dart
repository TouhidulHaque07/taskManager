
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pracices13/Models/Product.dart';
import 'package:pracices13/screen/Update_product_screen.dart';

class productIem extends StatefulWidget { const productIem({ super.key });
  @override
  State<productIem> createState() => _productIemState();
}
late final  Product product;

class _productIemState extends State<productIem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: Colors.white,
          title: Text('product Name: ${product.ProductName}'),
          subtitle:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Product Code: ${product.ProductCode}'),
            Text('Price: ${product.unitPrice}'),
            Text('Quantity: ${product.Quentity}'),
            Text('Total Price: ${product.totalPrice}'),

            Divider(),
            ButtonBar(
              children: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const UpdateProductScreen();
                      }),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit')),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outlined),
                    label: Text('Delete', style: TextStyle(
                        color: Colors.red
                    ),)),
              ],
            )
          ]),
        )
      ],
    );
  }


}