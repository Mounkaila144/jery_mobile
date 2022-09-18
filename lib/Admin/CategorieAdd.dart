import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jery/Admin/AddOneCategories.dart';
import 'package:jery/Admin/ProductsAdd.dart';
import 'package:jery/Crud.dart';
import 'package:jery/ProductsList.dart';
import 'package:jery/service.dart';
import 'package:jery/theme.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../FadeAnimation.dart';
import '../Menu.dart';
import '../global.dart';
import '../view/widgets/Sidebar.dart';
class CategoriesAdd extends StatefulWidget {
  const CategoriesAdd({Key? key}) : super(key: key);

  @override
  State<CategoriesAdd> createState() => _CategoriesAddState();
}

class _CategoriesAddState extends State<CategoriesAdd> {
  Future <List<Categories>?>? categories;
  final link=url;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    categories =  Remote().getCategories(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listes des categories"),
        actions: [
          Card(
            color: Colors.blue.shade900,
            shape: const CircleBorder(),
            child: IconButton(
              icon: const Icon(
                Icons.add_circle,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddOneCategories() ));
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: const Sidebar(),

      body: FutureBuilder <List<Categories>?>(
          future: categories,
          builder: (context,snap){
            if(snap.hasData){
              List<Categories>? data=snap.data!;
              return
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueAccent.shade100,
                        Colors.white,
                      ],
                    ),
                  ),
                  child:  ResponsiveGridList(
                    horizontalGridMargin: 10,
                    verticalGridMargin: 10,
                    maxItemsPerRow: 3,
                    minItemWidth: 160,
                    shrinkWrap: true,
                    children: List.generate(
                      data.length==null?0:data.length,
                          (index) => InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>ProductsAdd(id: data[index].id)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.indigoAccent,
                                  Colors.orange.shade900,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    "http://${url}/${data[index].image}",
                                    // width: 120,height: 120,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  data[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                );
            }
            else if(snap.hasError){
              return
                themejolie(
                  donner: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        FadeAnimation(1, Text("Eureur   de chargement ", style: TextStyle(color: Colors.white, fontSize: 60),))
                        ,
                        SizedBox(
                          height: 70,
                        ),
                        FadeAnimation(
                          1.6,
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red[900]),
                            child: Center(
                              child:TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text("Retour", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
            return themejolie(donner: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  LoadingJumpingLine.circle(
                    borderColor: Colors.black,
                    borderSize: 3.0,
                    size: 200.0,
                    backgroundColor: Colors.white,
                    duration: Duration(milliseconds: 500),
                  ),
                ],
              ),
            ),);
          }

      ),
    );
  }
}
