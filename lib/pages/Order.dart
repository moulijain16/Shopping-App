// import "package:flutter/material.dart";
// import "package:shoppingapp/widget/support_widget.dart";

// class Order extends StatefulWidget {
//   const Order({super.key});

//   @override
//   State<Order> createState() => _OrderState();
// }

// class _OrderState extends State<Order> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//            backgroundColor:Color(0xfff2f2f2),
//       appBar: AppBar(
//           backgroundColor:Color(0xfff2f2f2),
//           title:Text("Current Orders",style:AppWidget.boldTextFeildStyle(),
//       ),
//       ),
//       body:Container(child:Column(children: [

//       ],),),
//     );
//   }
// }




import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:shoppingapp/services/database.dart";
import "package:shoppingapp/services/shared_pref.dart";
import "package:shoppingapp/widget/support_widget.dart";

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;
  Stream<QuerySnapshot>? orderStream;

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Future<void> getontheload() async {
    email = await SharedPreferenceHelper().getUserEmail();
    if (email != null) {
      orderStream = await DatabaseMethods().getOrders(email!);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget allOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: orderStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return Center(child: Text("No orders yet"));
        }

        return ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final ds = docs[index];

            return Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ds["ProductImage"],
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        height: 90,
                        width: 90,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ds["Product"],
                          style: AppWidget.semiboldTextFeildStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "\$" + ds["Price"].toString(),
                          style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                      
                          ),
                        ),
                        Text(
                          "Status:" + ds["Status"].toString(),
                          style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                      
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        title: Text(
          "Current Orders",
          style: AppWidget.boldTextFeildStyle(),
        ),
      ),
      body: orderStream == null
          ? Center(child: CircularProgressIndicator())
          : allOrders(),
    );
  }
}