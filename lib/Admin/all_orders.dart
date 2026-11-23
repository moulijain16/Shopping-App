// import "package:flutter/material.dart";
// import "package:shoppingapp/widget/support_widget.dart";



// class AllOrders extends StatefulWidget {
//   const AllOrders({super.key});

//   @override
//   State<AllOrders> createState() =>  _AllOrdersState();
// }

// class  _AllOrdersState extends State <AllOrders> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title:Text("All Orders",style:AppWidget.boldTextFeildStyle(),)),
//       body:Container(
//         margin:EdgeInsets.only(left:20.0,right:20.0),
//         child:Column(
//           children: [
      
//           ],
//         )
//       )
//     );
//   }
// }



import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:shoppingapp/services/database.dart";
import "package:shoppingapp/widget/support_widget.dart";

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  Future<void> markDelivered(String docId) async {
    try {
      await DatabaseMethods().updateOrderStatus(docId, "Delivered");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order marked as Delivered")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update failed: $e")),
      );
    }
  }

  Widget userImage(String url) {
    final placeholder = Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, size: 40, color: Colors.white),
    );

    if (url.isEmpty) return placeholder;

    return ClipOval(
      child: Image.network(
        url,
        height: 70,
        width: 70,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => placeholder,
      ),
    );
  }

  Widget allOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseMethods().getAllOrders(),
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
          padding: EdgeInsets.only(top: 10, bottom: 20),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final ds = doc.data() as Map<String, dynamic>;
            final status = (ds["Status"] ?? "On the way").toString();
            final delivered = status == "Delivered";

            return Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userImage((ds["Image"] ?? "").toString()),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${ds["Name"] ?? ""}",
                              style: AppWidget.semiboldTextFeildStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Email : ${ds["Email"] ?? ""}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              ds["Product"] ?? "",
                              style: AppWidget.semiboldTextFeildStyle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "\$" + (ds["Price"] ?? "").toString(),
                              style: TextStyle(
                                color: Color(0xFFfd6f3e),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            delivered
                                ? Text(
                                    "Delivered",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => markDelivered(doc.id),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFfd6f3e),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Done",
                                          style: AppWidget
                                              .semiboldTextFeildStyle(),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        centerTitle: true,
        title: Text(
          "All Orders",
          style: AppWidget.boldTextFeildStyle(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: allOrders(),
      ),
    );
  }
}