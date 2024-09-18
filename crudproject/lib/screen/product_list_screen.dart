import 'dart:convert';
import 'dart:developer';

import 'package:crudproject/models/product.dart';
import 'package:crudproject/screen/add_new_product_screen.dart';
import 'package:crudproject/widgets/product_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<Product> productList=[];
  bool _inProgress=true;

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              getProductList();
            }, icon: Icon(Icons.refresh)),
          ],
          title: Text('Product List'),

        ),
        body:
       _inProgress?const Center(
         child: CircularProgressIndicator(),
       ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return  productItem(
                product: productList[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return addNewProductScreen();
            }));
          },
          child: Icon(Icons.add),
          ),
    );
  }

  void getProductList() async {
    _inProgress=true;
    setState(() {

    });

      Uri uri =Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
      Response response= await get(uri);
      print(response);
      print(response.body);
      print(response.statusCode);

      if(response.statusCode==200){
        productList.clear();
        Map<String, dynamic> jsonResponse=jsonDecode(response.body);
        for(var item in jsonResponse['data']){
          Product product = Product(id: item['_id'] ?? '',
              productName: item['ProductName'] ?? '',
              productCode: item['ProductCode'] ?? '',
              productImage: item['Img'] ?? '',
              unitPrice: item['UnitPrice'] ?? '',
              quentity: item['Qty'] ?? '',
              totalPrice: item['TotalPrice'] ?? '',
              createAt: item['CreatedDate'] ?? '');
          productList.add(product);
        }
      }
    _inProgress=false;
  setState(() {

  });

  }

}


