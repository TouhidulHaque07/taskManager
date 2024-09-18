import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pracices13/Models/Product.dart';
import 'package:pracices13/screen/add_new_product_screen.dart';
import 'package:pracices13/weidgets/product_list.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  List<Product> ProductList=[];
  @override
  void initState() {
    // TODO: implement initState
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List:'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.separated(
            itemCount: ProductList.length,
            itemBuilder: (context, index) {
              return const productIem();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const addNewProductList();
          }),
          );
        },
        child: Icon(Icons.add),
      ),

    );

  }
  Future<void> getProductList() async{

    Uri uri=Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response= await get(uri);

    print(response.statusCode);
    print('OK');

    if(response.statusCode==200){
      Map<String, dynamic> jsonResponse=jsonDecode(response.body);
      print('OK-if');
      for(var item in jsonResponse['data']){
        Product product = Product(
            id: item['_id'],
            ProductName: item['ProductName'],
            ProductCode: item['ProductCode'],
            ProductImage: item['Img'],
            unitPrice: item['UnitPrice'],
            Quentity: item['Qty'],
            totalPrice: item['TotalPrice'],
            ceditedAt: item['CreatedDate']);

        ProductList.add(product);


      }
    }
   setState(() {

   });
  }
}
