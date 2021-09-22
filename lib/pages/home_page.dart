import 'dart:convert';

import 'package:e_commerce/models/cart.dart';
import 'package:e_commerce/models/catalog.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:e_commerce/widgets/home_widget/catalog-list.dart';
import 'package:e_commerce/widgets/home_widget/catalog_header.dart';
import 'package:flutter/cupertino.dart';

import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";
  
  final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {

    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");
    // Map<String, dynamic> jsonData = jsonDecode(catalogJson);

    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromJson(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
          mutations: {AddMutation,RemoveMutation,}, builder: (BuildContext context, store, VxStatus? status,) =>FloatingActionButton(onPressed: ()=>  Navigator.pushNamed(context, MyRoutes.cartRoute,),
          backgroundColor: context.theme.buttonColor,
          child: Icon(CupertinoIcons.cart,color: Colors.white,),
          
        ).badge(
              color: Vx.gray200,
              size: 22,
              count: _cart.items.length,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
      ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatalogModel.items != null &&
                    CatalogModel.items!.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}
