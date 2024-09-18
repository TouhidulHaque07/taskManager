import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addNewProductList extends StatefulWidget {
    const addNewProductList({super.key});

  @override
  State<addNewProductList> createState() => _addNewProductListState();
}

class _addNewProductListState extends State<addNewProductList> {
  final TextEditingController _ProductNameTEcontroler=TextEditingController();
  final TextEditingController _UnitPriceTEcontroler=TextEditingController();
  final TextEditingController _TotalPriceTEcontroler=TextEditingController();
  final TextEditingController _ProductImageTEcontroler=TextEditingController();
  final TextEditingController _ProductCodeTEcontroler=TextEditingController();
  final TextEditingController _ProductQuntityTEcontroler=TextEditingController();
  final GlobalKey<FormState> _fromKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        _buildNewProductFrom(),
      ),
    );
  }

 Widget _buildNewProductFrom() {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            TextFormField(
              controller: _ProductNameTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Name', labelText: 'Product Name'),
            ),
            TextFormField(
              controller: _UnitPriceTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Unit Price', labelText: 'Unit Price'),
            ),
            TextFormField(
              controller: _TotalPriceTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Total Price', labelText: 'Total Price'),
            ),
            TextFormField(
              controller: _ProductImageTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Image', labelText: 'Product Image'),
            ),
            TextFormField(
              controller: _ProductCodeTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Product Code', labelText: 'Product Code'),
            ),
            TextFormField(
              controller: _ProductQuntityTEcontroler,
              decoration: InputDecoration(
                  hintText: 'Product Quantity',
                  labelText: 'Product Quantity'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                ),
                onPressed: _onTapAddNewProductButton,
                child: Text('Add Product')),
          ],
        ),
      );
  }

  void _onTapAddNewProductButton(){

  }

  @override
  void dispose() {

    _ProductNameTEcontroler.dispose();
    _UnitPriceTEcontroler.dispose();
    _TotalPriceTEcontroler.dispose();
    _ProductImageTEcontroler.dispose();
    _ProductCodeTEcontroler.dispose();
    _ProductQuntityTEcontroler.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
