import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jery/global.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key, required this.screenSize, required this.image, required this.itemName,required this.price,required this.qty, this.del})
      : super(key: key);

  final Size screenSize;
  final String image, itemName,price;
  final int qty;
  final Function? del;

  @override
  Widget build(BuildContext context) {
    return
      Card(
        color: Colors.blue.shade200,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                height: screenSize.height * 0.13,
                width: screenSize.width * 0.3,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                 imageUrl: "http://$url/$image",
              ),
              SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16.0),
                          children: [
                            TextSpan(
                                text:
                                '${itemName}\n',
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                          text: 'Unit: ',
                          style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16.0),
                          children: [
                            TextSpan(
                                text:
                                '${1}\n',
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold)),
                          ]),
                    ),
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                          text: 'Price: ' r"$",
                          style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 16.0),
                          children: [
                            TextSpan(
                                text:
                                '${price}\n',
                                style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold)),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}