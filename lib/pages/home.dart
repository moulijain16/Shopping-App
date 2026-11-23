// import "package:cloud_firestore/cloud_firestore.dart";
// import "package:flutter/foundation.dart";
// import "package:flutter/material.dart";
// import "package:shoppingapp/pages/category_products.dart";
// import "package:shoppingapp/pages/product_detail.dart";
// import "package:shoppingapp/services/database.dart";
// import "package:shoppingapp/services/shared_pref.dart";
// import "package:shoppingapp/widget/support_widget.dart";
// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   bool  search=false;

//   List categories=[
//   "images/headphone_icon.png",
//   "images/laptop.png",
//   "images/watch.png",
//   "images/TV.png",
//   ];
//   List Categoryname=[
//     "Headphones",
//     "Laptop",
//     "Watch",
//     "TV",
//   ];

//   var queryResultSet=[];
//   var tempSearchStore=[];

//   initiateSearch(String value) {
//   if (value.isEmpty) {
//     setState(() {
//       queryResultSet = [];
//       tempSearchStore = [];
//       search = false;
//     });
//     return;
//   }

//   setState(() {
//     search = true;
//   });

//   final upper = value.toUpperCase();

//   if (queryResultSet.isEmpty) {
//     // load all products starting with the first letter, then filter
//     DatabaseMethods().search(upper.substring(0, 1)).then((QuerySnapshot docs) {
//       queryResultSet = docs.docs.map((d) => d.data()).toList();
//       setState(() {
//         tempSearchStore = queryResultSet.where((e) {
//           return (e['UpdatedName'] ?? "").toString().startsWith(upper);
//         }).toList();
//       });
//     });
//   } else {
//     setState(() {
//       tempSearchStore = queryResultSet.where((e) {
//         return (e['UpdatedName'] ?? "").toString().startsWith(upper);
//       }).toList();
//     });
//   }
// }
  
//   String? name,image;
//   getthesharedpref() async{
//     name=await SharedPreferenceHelper().getUserName();
//     image=await SharedPreferenceHelper().getUserImage();
//     setState(() {
      
//     });
//   }
//   ontheload()async{
//      await getthesharedpref();
//      setState(() {
       
//      });
//   }
//   @override
//   void initState(){
//     ontheload();
//     super.initState();
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Color(0xfff2f2f2),
//       body:
//       // name==null? Center(child: CircularProgressIndicator())
//       Container(
//           margin:EdgeInsets.only(top:50.0,left:20.0,right:20.0),
//           child:SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment:CrossAxisAlignment.start,
//               children:[
            
//                 Row(
//                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                     children:[
//                     Column(
//             crossAxisAlignment:CrossAxisAlignment.start,
//             children: [
//               Text(
//                 // "Hey, "+name!,
            
//                 "Hey, " + (name ?? "Guest"),
//                 style:AppWidget.boldTextFeildStyle(),
//               ),
//                Text("Good Morning",style:AppWidget.lightTextFeildStyle(),
//                     ),
//             ],
//                     ),
//                     ClipRRect(
//                     borderRadius:BorderRadius.circular(20),
//                     // child:Image.network(image!,height:70,width:70,fit:BoxFit.cover),
            
//                     child:(image != null && image!.isNotEmpty)
//                 ? Image.network(image!, height: 70, width: 70, fit: BoxFit.cover)
//                 : Icon(Icons.person, size: 60),
//                     )
               
                     
//               ],
//                 ),
//                 SizedBox(height:30.0),
//                     Container(
            
//             decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10)),
//             width:MediaQuery.of(context).size.width,
//             child: TextField(
//               onChanged: (value){
//                 initiateSearch(value.trim());
//               },
//               decoration:InputDecoration(border:InputBorder.none,hintText:"Search Products",hintStyle:AppWidget.lightTextFeildStyle(),prefixIcon:Icon(Icons.search,color:Colors.black,)),
//             )),
//             SizedBox(height:20.0),
//                      SizedBox(height: 20.0),
            
//             search
//                 ? ListView(
//                     padding: EdgeInsets.zero,
//                     primary: false,
//                     shrinkWrap: true,
//                     children: tempSearchStore.map<Widget>((element) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 10),
//               child: buildResultCard(element),
//             );
//                     }).toList(),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Categories", style: AppWidget.semiboldTextFeildStyle()),
//                 Text("see all",
//                     style: TextStyle(
//                         color: Color(0xFFfd6f3e),
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold)),
//               ],
//             ),
//             SizedBox(height: 20.0),
//             // your Row with the "All" box + categories ListView.builder (unchanged)
//             SizedBox(height: 20.0),
//             // your Row with "All Products" / "see all" (unchanged)
//             SizedBox(height: 20.0),
//             // your Container(height:240, child: ListView(...)) (unchanged)
//                     ],
//                   ),
//               Row(
//                 children: [
//                   Container(
//                      height:130,
//                     padding:EdgeInsets.all(20),
//                     margin:EdgeInsets.only(right:20.0),
//                     decoration:BoxDecoration(color:Color(0xFFFd6F3E),borderRadius:BorderRadius.circular(10)),
               
//                     child:Center(
//             child: Text("All",style:TextStyle(color:Colors.white,fontSize:20.0,fontWeight:FontWeight.bold)
                
//             ,),
//                     )
                    
//               ),
//                   Expanded(
//                     child: Container(
//                       margin:EdgeInsets.only(left:20.0),
//                       height:130,
//                       child:ListView.builder(
//                         padding:EdgeInsets.zero,
//                         itemCount:categories.length,
//                         shrinkWrap:true,
//                         scrollDirection:Axis.horizontal,
//                         itemBuilder:(context,index){
//                           return CategoryTile(image:categories[index],name:Categoryname[index]);
//                         })
//                     ),
//                   ),
//                 ],
//               ),
//                 SizedBox(height:20.0),
//               Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: [
//                 Text(
//                   "All Products",
//                   style:AppWidget.semiboldTextFeildStyle(),
//                 ),
//                 Text(
//                   "see all",
//                   style:TextStyle(color:Color(0xFFfd6f3e),fontSize:18.0,fontWeight:FontWeight.bold),
//                 ),
//               ]
//               ),
//               SizedBox(height:20.0),
//               Container(
              
//                 height:240,
//                 child: ListView(
//                   shrinkWrap:true,
//                   scrollDirection:Axis.horizontal,
//                   children: [
//                     Container(
//                       margin:EdgeInsets.only(right:20.0),
//                       padding:EdgeInsets.symmetric(horizontal:20.0),
//                       decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10)),
//                       child:Column(children:[
//                         Image.asset("images/headphone2.png",height:150,width:150,fit:BoxFit.cover),
//                         Text("HeadPhone",style:AppWidget.semiboldTextFeildStyle()),
//                         SizedBox(height:10.0),
//                         Row(
//                           children: [
//                           Text("\$100",style:TextStyle(color:Color(0xFFfd6f3e),fontSize:22.0,fontWeight:FontWeight.bold),),
//                           SizedBox(width:40.0),
//                           Container(
//                             padding:EdgeInsets.all(5),
//                             decoration:BoxDecoration(color:Color(0xFFfd6f3e),borderRadius:BorderRadius.circular(8)),
//                             child: Icon(Icons.add,color:Colors.white,))
//                         ],)
//                       ])
//                     ),
//                      Container(
//                       margin:EdgeInsets.only(right:20.0),
//                       padding:EdgeInsets.symmetric(horizontal:20.0),
//                       decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10)),
//                       child:Column(children:[
//                         Image.asset("images/Watch2.png",height:150,width:150,fit:BoxFit.cover),
//                         Text("Apple Watch",style:AppWidget.semiboldTextFeildStyle()),
//                         SizedBox(height:10.0),
//                         Row(
//                           children: [
//                           Text("\$300",style:TextStyle(color:Color(0xFFfd6f3e),fontSize:22.0,fontWeight:FontWeight.bold),),
//                           SizedBox(width:40.0),
//                           Container(
//                             padding:EdgeInsets.all(5),
//                             decoration:BoxDecoration(color:Color(0xFFfd6f3e),borderRadius:BorderRadius.circular(8)),
//                             child: Icon(Icons.add,color:Colors.white,))
//                         ],)
//                       ])
//                     ),
//                      Container(
//                       padding:EdgeInsets.symmetric(horizontal:20.0),
//                       decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10)),
//                       child:Column(children:[
//                         Image.asset("images/laptop2.png",height:150,width:150,fit:BoxFit.cover),
//                         Text("Laptop",style:AppWidget.semiboldTextFeildStyle()),
//                         SizedBox(height:10.0),
//                         Row(
//                           children: [
//                           Text("\$1000",style:TextStyle(color:Color(0xFFfd6f3e),fontSize:22.0,fontWeight:FontWeight.bold),),
//                           SizedBox(width:40.0),
//                           Container(
//                             padding:EdgeInsets.all(5),
//                             decoration:BoxDecoration(color:Color(0xFFfd6f3e),borderRadius:BorderRadius.circular(8)),
//                             child: Icon(Icons.add,color:Colors.white,))
//                         ],)
//                       ])
//                     )
//                   ],
//                 ),
//               )
//               ]
//               ),
//           )
//         ),
//       );
    
//   }
//    Widget buildResultCard(data){
//     return GestureDetector(
//       onTap:(){
//           Navigator.push(context,MaterialPageRoute(builder:(context)=>ProductDetail(detail: data['Detail'], price: data['Price'], name:data["Name"] , image: data['Image'])));
//       },
//       child: Container(
//         padding:EdgeInsets.only(left:20.0),
//         width:MediaQuery.of(context).size.width,
//         decoration:BoxDecoration(
//           borderRadius:BorderRadius.circular(10),
//           color:Colors.white
//         ),
//         height:100,
//         child:Row(children: [
//           ClipRRect(
//             borderRadius:BorderRadius.circular(10),
//             child: Image.network(data["Image"],height:50,width:50,fit:BoxFit.cover)),
//             SizedBox(height:20.0),
//           Text(data["Name"],style:AppWidget.semiboldTextFeildStyle()),
//         ],)
//       ),
//     );
//   }
// }
// class CategoryTile extends StatelessWidget {
//   String image,name;
//   CategoryTile({required this.image,required this.name});
  

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap:(){
//         Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(category: name)));
//       },
//       child: Container(
//         padding:EdgeInsets.all(20),
//         margin:EdgeInsets.only(right:20.0),
//         decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10)),
       
//         child:Column(
//           mainAxisAlignment:MainAxisAlignment.spaceBetween,
//           children: [
//           Image.asset(image,height:50,width:50,fit:BoxFit.cover,),
//           Icon(Icons.arrow_forward)
      
//         ],)
      
//       ),
//     );
//   }
 
// }



import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:shoppingapp/pages/category_products.dart";
import "package:shoppingapp/pages/product_detail.dart";
import "package:shoppingapp/services/database.dart";
import "package:shoppingapp/services/shared_pref.dart";
import "package:shoppingapp/widget/support_widget.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  final TextEditingController searchController = TextEditingController();

  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
  ];
  List Categoryname = [
    "Headphones",
    "Laptop",
    "Watch",
    "TV",
  ];

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    debugPrint("Searching: $value");

    if (value.isEmpty) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
        search = false;
      });
      return;
    }

    setState(() {
      search = true;
    });

    final upper = value.toUpperCase();

    if (queryResultSet.isEmpty) {
      DatabaseMethods().search(upper.substring(0, 1)).then((QuerySnapshot docs) {
        debugPrint("Search found: ${docs.docs.length}");
        queryResultSet = docs.docs.map((d) => d.data()).toList();
        if (!mounted) return;
        setState(() {
          tempSearchStore = queryResultSet.where((e) {
            return (e['UpdatedName'] ?? "").toString().startsWith(upper);
          }).toList();
        });
      });
    } else {
      setState(() {
        tempSearchStore = queryResultSet.where((e) {
          return (e['UpdatedName'] ?? "").toString().startsWith(upper);
        }).toList();
      });
    }
  }

  // Cross button: empty the box, empty both lists, back to the home page
  void clearSearch() {
    searchController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      search = false;
      queryResultSet = [];
      tempSearchStore = [];
    });
  }

  String? name, image;

  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    if (mounted) setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting + profile image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey, " + (name ?? "Guest"),
                        style: AppWidget.boldTextFeildStyle(),
                      ),
                      Text(
                        "Good Morning",
                        style: AppWidget.lightTextFeildStyle(),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: (image != null && image!.isNotEmpty)
                        ? Image.network(image!,
                            height: 70, width: 70, fit: BoxFit.cover)
                        : Icon(Icons.person, size: 60),
                  ),
                ],
              ),
              SizedBox(height: 30.0),

              // Search box (icon becomes a cross while searching)
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    initiateSearch(value.trim());
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: AppWidget.lightTextFeildStyle(),
                    prefixIcon: search
                        ? GestureDetector(
                            onTap: clearSearch,
                            child: Icon(Icons.close, color: Colors.black),
                          )
                        : Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Search results OR normal home content
              search
                  ? (tempSearchStore.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(child: Text("No products found")),
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          children: tempSearchStore.map<Widget>((element) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: buildResultCard(element),
                            );
                          }).toList(),
                        ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Categories",
                                style: AppWidget.semiboldTextFeildStyle()),
                            Text("see all",
                                style: TextStyle(
                                    color: Color(0xFFfd6f3e),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Container(
                              height: 130,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFd6F3E),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text("All",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: 130,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: categories.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return CategoryTile(
                                        image: categories[index],
                                        name: Categoryname[index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Products",
                                style: AppWidget.semiboldTextFeildStyle()),
                            Text("see all",
                                style: TextStyle(
                                    color: Color(0xFFfd6f3e),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20.0),

                        // All Products: live list from Firestore
                        SizedBox(
                          height: 240,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: DatabaseMethods().getAllProductsStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error: ${snapshot.error}"));
                              }
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              final docs = snapshot.data!.docs;

                              if (docs.isEmpty) {
                                return Center(child: Text("No products yet"));
                              }

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final p = docs[index].data()
                                      as Map<String, dynamic>;

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                            detail:
                                                (p["Detail"] ?? "").toString(),
                                            price:
                                                (p["Price"] ?? "").toString(),
                                            name: (p["Name"] ?? "").toString(),
                                            image:
                                                (p["Image"] ?? "").toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 190,
                                      margin: EdgeInsets.only(right: 20.0),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.network(
                                            (p["Image"] ?? "").toString(),
                                            height: 130,
                                            width: 130,
                                            fit: BoxFit.contain,
                                            errorBuilder: (c, e, s) => Icon(
                                                Icons.image_not_supported,
                                                size: 60),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            (p["Name"] ?? "").toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppWidget
                                                .semiboldTextFeildStyle(),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "\$" +
                                                (p["Price"] ?? "").toString(),
                                            style: TextStyle(
                                              color: Color(0xFFfd6f3e),
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              detail: (data['Detail'] ?? "").toString(),
              price: (data['Price'] ?? "").toString(),
              name: (data["Name"] ?? "").toString(),
              image: (data['Image'] ?? "").toString(),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network((data["Image"] ?? "").toString(),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Icon(Icons.image_not_supported)),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Text((data["Name"] ?? "").toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppWidget.semiboldTextFeildStyle()),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProduct(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}