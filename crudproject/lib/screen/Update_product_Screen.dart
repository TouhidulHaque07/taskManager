
import 'dart:convert';

import 'package:crudproject/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  final TextEditingController _ProductNameTEController=TextEditingController();
  final TextEditingController _UnitPriceTEController=TextEditingController();
  final TextEditingController _TotalPriceTEController=TextEditingController();
  final TextEditingController _ImageTEController=TextEditingController();
  final TextEditingController _ProductCodeTEController=TextEditingController();
  final TextEditingController _QueantityTEController=TextEditingController();

  final GlobalKey<FormState> _fromKey=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    fillTextFieldUpdate();
    super.initState();
  }

  void fillTextFieldUpdate(){
    _ProductNameTEController.text=widget.product.productName;
    _UnitPriceTEController.text=widget.product.unitPrice;
    _TotalPriceTEController.text=widget.product.totalPrice;
    _ImageTEController.text=widget.product.productImage;
    _ProductCodeTEController.text=widget.product.productCode;
    _QueantityTEController.text=widget.product.quentity;
    setState(() {
    });
  }
  bool _isProgress=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body:

      Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        _buildNewProductForm(),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          TextFormField(
            controller: _ProductNameTEController,
            decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Product Name'

            ),

          ),
          TextFormField(
            controller: _UnitPriceTEController,
            decoration: InputDecoration(
                hintText: 'Unit Price',
                labelText: 'Unit Price'
            ),
          ),
          TextFormField(
            controller: _TotalPriceTEController,
            decoration: InputDecoration(
                hintText: 'Total Price',
                labelText: 'Total Price'
            ),
          ),
          TextFormField(
            controller: _ImageTEController,
            decoration: InputDecoration(
                hintText: 'Image',
                labelText: 'Image'
            ),
          ),
          TextFormField(
            controller: _ProductCodeTEController,
            decoration: InputDecoration(
                hintText: 'Product Code',
                labelText: 'Product Code'
            ),
          ),
          TextFormField(
            controller: _QueantityTEController,
            decoration: InputDecoration(
                hintText: 'Quentity',
                labelText: 'Quentity'
            ),
          ),

          SizedBox(height: 20),
          _isProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(double.maxFinite),
                  ),
                  onPressed: _onTapUpdateProductButton,
                  child: Text('Update Product')),
        ],
      ),
    );
  }

  void _onTapUpdateProductButton(){

    if(_fromKey.currentState!.validate()){
      upDateProduct();
      setState(() {

      });
    }

  }

  Future<void> upDateProduct() async {
    _isProgress=true;
    setState(() {

    });

    Uri uri= Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> jsonBody={
      "Img":_ImageTEController.text,
      "ProductCode":_ProductCodeTEController.text,
      "ProductName":_ProductNameTEController.text,
      "Qty":_QueantityTEController.text,
      "TotalPrice":_TotalPriceTEController.text,
      "UnitPrice":_UnitPriceTEController.text,
    };

    Response response = await post(uri,
        headers:{
          "Content-Type":"application/json",
        },
        body:
        jsonEncode(jsonBody));
       // print(jsonBody);
      if(response.statusCode==200){
        _clearTextField();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Update Product')));
    }
      _isProgress=false;
      setState(() {
        
      });

  }

  void _clearTextField() {
    _ProductCodeTEController.clear();
    _UnitPriceTEController.clear();
    _TotalPriceTEController.clear();
    _ImageTEController.clear();
    _ProductNameTEController.clear();
    _QueantityTEController.clear();

  }


  @override
  void dispose() {
    _ProductCodeTEController.dispose();
    _UnitPriceTEController.dispose();
    _TotalPriceTEController.dispose();
    _ImageTEController.dispose();
    _ProductNameTEController.dispose();
    _QueantityTEController.dispose();
    super.dispose();

  }



}
