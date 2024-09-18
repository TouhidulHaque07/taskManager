import 'dart:convert';

import 'package:crudproject/models/product.dart';
import 'package:crudproject/screen/Update_product_Screen.dart';
import 'package:crudproject/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class productItem extends StatelessWidget {
  productItem({
    super.key, required this.product,
  });
final Product product;
bool _isProgress=false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.white,
        title: Text('Product Name: ${product.productName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Code: ${product.productCode}'),
            Text('Price: ${product.unitPrice}'),
            Text('Quentity: ${product.quentity}'),
            Text('Total Price: ${product.totalPrice}'),
            Text('Create Date: ${product.createAt}'),
            Divider(),
            ButtonBar(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return UpdateProductScreen(
                            product: Product(
                                id: product.id,
                                productName: product.productName,
                                productCode: product.productCode,
                                productImage: product.productImage,
                                unitPrice: product.unitPrice,
                                quentity: product.quentity,
                                totalPrice: product.totalPrice,
                                createAt: product.createAt));
                      }),);

                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
                TextButton.icon(
                  onPressed: () {
                    onTapDeleteProduct(product.id);
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ProductListScreen();
                    }));

                    },
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  ),
                  label: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ));

  }

 Future<void> onTapDeleteProduct( String Product_ID) async {
    Uri uri=Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/${Product_ID}');
    Response response= await get(uri,
        headers: {
          "Content-Type":"application/json",
        }
    );
    if(response.statusCode==200){
      print('Delete Product');

    }
  }
}

