// import "package:flutter/material.dart";
// import 'package:shoppingapp/services/shared_pref.dart';
// import "package:shoppingapp/widget/support_widget.dart";
// import 'package:shoppingapp/services/payment_service.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shoppingapp/services/database.dart';
// // import 'package:shoppingapp/services/razorpay_web_service.dart';
// class ProductDetail extends StatefulWidget {
//   String name,image,price,detail;
//   ProductDetail({
//   required this.detail,
//   required this.price,
//   required this.name,
//   required this.image,
// });

//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   String? name,mail,image;
//   getthesharedpref()async{
//     name=await SharedPreferenceHelper().getUserName();
//     mail=await SharedPreferenceHelper().getUserEmail();
//     image=await SharedPreferenceHelper().getUserImage();
//     setState(() {
      
//     });
//   }
//   ontheload()async{
//     await getthesharedpref();
//     setState(() {
      
//     });
//   }
//   late PaymentService paymentService;
//   @override
//   initState(){
//     super.initState();
//     ontheload();

// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor:Color(0xFFfef5f1),
// //       body: Container(
// //           padding:EdgeInsets.only(top:50.0,left:20.0),
// //           child:Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //           Stack(
// //             children: [GestureDetector(
// //               onTap: (){
// //                 Navigator.pop(context);
// //               },
// //               child: Container(
// //                 margin:EdgeInsets.only(left:40.0),
// //                 padding:EdgeInsets.all(10),
// //                 decoration:BoxDecoration(border:Border.all(),borderRadius:BorderRadius.circular(30)
// //                 ),
// //                 child: Icon(Icons.arrow_back_ios_new_outlined)),
// //                 ),
            
// //         Center(child:Image.network(
// //   widget.image,
// //   height: 300,
// //   width: double.infinity,
// //   fit: BoxFit.contain,
// // ))
// //         ]),
// //         Expanded(
// //           child: Container(
// //             padding:EdgeInsets.only(top:20.0,left:20.0,right:20.0),
// //             decoration:BoxDecoration(
// //               color:Colors.white,
// //               borderRadius:BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
// //             ),
// //             width:MediaQuery.of(context).size.width,child:Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(widget.name,style:AppWidget.boldTextFeildStyle()),
// //                      Text(
// //                     "\$"+widget.price,
// //                     style:TextStyle(color:Color(0xFFfd6f3e),fontSize:23.0,fontWeight:FontWeight.bold),
// //                   ),
// //                   ],
// //                 ),
// //                 SizedBox(height:20.0,),
// //                 Text("Details",style:AppWidget.semiboldTextFeildStyle(),),
// //                 SizedBox(height:10.0),
// //                 Text(widget.detail),
// //                  SizedBox(height:90.0,),
// //                 Container(
// //                   padding:EdgeInsets.symmetric(vertical: 10.0),
// //                   decoration:BoxDecoration(color:Color(0xFFfd6f3e),borderRadius:BorderRadius.circular(10)),
// //                   width:MediaQuery.of(context).size.width,
// //                   child:Center(child: Text("Buy Now",style:TextStyle(color:Colors.white,fontSize:20.0,fontWeight:FontWeight.bold))),
// //                 )
// //               ],
// //             ),),
// //         )
// //         ],
// //             ),
// //             ),
// //       );
   
// //   }
// // }



//   paymentService = PaymentService();

//   paymentService.initialize(
//     onSuccess: (PaymentSuccessResponse response) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment Successful!')),
//       );
//     },
//     onFailure: (PaymentFailureResponse response) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment Failed!')),
//       );
//     },
//   );
//   }
//  Future<void> saveOrderDetails() async {
//   Map<String, dynamic> orderInfoMap = {
//     "Product": widget.name,
//     "Price": widget.price,
//     "Name": name,
//     "Email": mail,
//     "Image": image,
//     "ProductImage": widget.image,
//   };

//   await DatabaseMethods().orderDetails(orderInfoMap);
// }

// @override
// void dispose() {
//   paymentService.dispose();
//   super.dispose();
// }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Color(0xFFF7F3F0),
//     body: SafeArea(
//       child: Column(
//         children: [
//           // Product image and back button
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.38,
//             width: double.infinity,
//             child: Stack(
//               children: [
//                 Center(
//                   child: Image.network(
//                     widget.image,
//                     height: 280,
//                     width: double.infinity,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 20,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Icon(Icons.arrow_back_ios_new_outlined),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Product information section
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.name,
//                         style: AppWidget.boldTextFeildStyle(),
//                       ),
//                       Text(
//                         "\$" + widget.price,
//                         style: TextStyle(
//                           color: Color(0xFFfd6f3e),
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 20),

//                   Text(
//                     "Details",
//                     style: AppWidget.semiboldTextFeildStyle(),
//                   ),

//                   SizedBox(height: 10),

//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(widget.detail),
//                     ),
//                   ),

//                   SizedBox(height: 15),

//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//             onPressed: () {
//   try {
//     final parsedPrice = double.tryParse(
//       widget.price
//           .replaceAll(',', '')
//           .replaceAll('₹', '')
//           .replaceAll('\$', '')
//           .trim(),
//     );

//     if (parsedPrice == null || parsedPrice <= 0) {
//       throw Exception('Invalid product price');
//     }

//     paymentService.openCheckout(
//       keyId: 'rzp_test_TzK5qVHUAmmNM8',
//       amountInPaise: (parsedPrice * 100).round(),
//       name: 'Shopping App',
//       description: widget.name,
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Unable to start payment: $e')),
//     );
//   }
// },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFFfd6f3e),
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         "Buy Now",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shoppingapp/services/shared_pref.dart';
import 'package:shoppingapp/widget/support_widget.dart';
import 'package:shoppingapp/services/payment_service.dart';
// import 'package:shoppingapp/services/razorpay_web_service_web.dart';
import 'package:shoppingapp/services/razorpay_web_service.dart';
import 'package:shoppingapp/services/database.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductDetail extends StatefulWidget {
  String name, image, price, detail;

  ProductDetail({
    required this.detail,
    required this.price,
    required this.name,
    required this.image,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String? name, mail, image, userId;

  PaymentService? paymentService;

  // Android emulator backend address
  // static const String backendUrl = 'http://10.0.2.2:3000';
  String get backendUrl =>
    kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';

  // Load customer details
  Future<void> getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    mail = await SharedPreferenceHelper().getUserEmail();
    image = await SharedPreferenceHelper().getUserImage();
    userId = await SharedPreferenceHelper().getUserId();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getthesharedpref();
  }

  // Initialize native Razorpay only on Android/iOS
  @override
  void initState() {
    super.initState();

    ontheload();

    if (!kIsWeb) {
      paymentService = PaymentService();

      paymentService!.initialize(
        onSuccess: (PaymentSuccessResponse response) {
  if (response.orderId == null ||
      response.paymentId == null ||
      response.signature == null) return;
  verifyAndSaveOrder(
    orderId: response.orderId!,
    paymentId: response.paymentId!,
    signature: response.signature!,
  );
},
        onFailure: (PaymentFailureResponse response) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment Failed!')),
          );
        },
      );
    }
  }

  // Save order in Firebase after payment verification
  Future<void> saveOrderDetails({
    required String orderId,
    required String paymentId,
  }) async {

    Map<String, dynamic> orderInfoMap = {
      "Product": widget.name,
      "Price": widget.price,
      "Name": name,
      "Email": mail,
      "Image": image,
      "ProductImage": widget.image,
      "UserId": userId,
      "PaymentStatus": "Paid",
      "RazorpayOrderId": orderId,
      "RazorpayPaymentId": paymentId,
      "OrderDate": FieldValue.serverTimestamp(),
      "Status":"On the way"
    };

    await DatabaseMethods().orderDetails(orderInfoMap);
  }

  // Verify Android payment through Node.js backend
  Future<void> verifyAndSaveOrder({
  required String orderId,
  required String paymentId,
  required String signature,
}) async {
  try {
    final result = await http.post(
      Uri.parse('$backendUrl/verify-payment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'razorpay_order_id': orderId,
        'razorpay_payment_id': paymentId,
        'razorpay_signature': signature,
      }),
    );

    debugPrint('verify-payment: ${result.statusCode} ${result.body}');
    final data = jsonDecode(result.body);

    if (result.statusCode != 200 || data['success'] != true) {
      throw Exception('Payment verification failed');
    }

    try {
      await saveOrderDetails(orderId: orderId, paymentId: paymentId);
      debugPrint('Order saved to Firestore');
    } catch (e) {
      debugPrint('Firestore save error: $e');
      throw Exception('Firestore save failed: $e');
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment verified! Order saved successfully.')),
    );
  } catch (e) {
    debugPrint('Order error: $e');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order error: $e')),
    );
  }
}
  // Start payment
  Future<void> startPayment() async {
    try {
      final parsedPrice = double.tryParse(
        widget.price
            .replaceAll(',', '')
            .replaceAll('₹', '')
            .replaceAll('\$', '')
            .trim(),
      );

      if (parsedPrice == null || parsedPrice <= 0) {
        throw Exception('Invalid product price');
      }

      final amountInPaise = (parsedPrice * 100).round();

      // Chrome payment
      if (kIsWeb) {
  await RazorpayWebService().openPayment(
    name: widget.name,
    price: widget.price,
    onSuccess: (orderId, paymentId, signature) => verifyAndSaveOrder(
      orderId: orderId,
      paymentId: paymentId,
      signature: signature,
    ),
    onFailure: (msg) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Failed!')),
      );
    },
  );
  return;
}

      // Android: create order through backend
      final result = await http.post(
        Uri.parse('$backendUrl/create-order'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amountInPaise,
        }),
      );

      if (result.statusCode != 200) {
        throw Exception('Unable to create Razorpay order');
      }

      final order = jsonDecode(result.body);

      // Open native Razorpay checkout
      paymentService!.openCheckout(
        keyId: 'rzp_test_TzK5qVHUAmmNM8',
        amountInPaise: amountInPaise,
        name: 'Shopping App',
        description: widget.name,
        orderId: order['id'],
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to start payment: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    paymentService?.dispose();
    super.dispose();
  }

  // Product detail UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F3F0),
      body: SafeArea(
        child: Column(
          children: [

            // Product image and back button
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
              width: double.infinity,
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      widget.image,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product information
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppWidget.boldTextFeildStyle(),
                        ),

                        Text(
                          "\$" + widget.price,
                          style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Details",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),

                    SizedBox(height: 10),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(widget.detail),
                      ),
                    ),

                    SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: startPayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFfd6f3e),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
