import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModel/productsVm.dart';
import '../widgets/cartCounter.dart';
import 'cart.dart';


Widget iconcart(context) {
    return
      InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CartScreen()));
      },
      child: Padding(
        padding:
        const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Icon(Icons.shopping_cart_rounded,
                    color: Colors.blue, size: 25)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Consumer<ProductsVM>(
                builder: (context, value, child) => CartCounter(
                  count: value.lst.length.toString(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

