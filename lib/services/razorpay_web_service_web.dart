
// import 'dart:convert';
// import 'dart:js_interop';
// import 'package:http/http.dart' as http;

// @JS('openRazorpayCheckout')
// external void openRazorpayCheckout(JSString optionsJson);

// class RazorpayWebService {
//   static const String backendUrl = 'http://localhost:3000';

//   static const String keyId = 'rzp_test_TzK5qVHUAmmNM8';

//   Future<void> openPayment({
//     required String name,
//     required String price,
//   }) async {
//     try {
//       final parsedPrice = double.tryParse(
//         price.replaceAll(',', '').replaceAll('₹', '').replaceAll('\$', '').trim(),
//       );

//       if (parsedPrice == null || parsedPrice <= 0) {
//         throw Exception('Invalid product price');
//       }

//       final amountInPaise = (parsedPrice * 100).round();

//       // Create Razorpay order using local backend
//       final response = await http.post(
//         Uri.parse('$backendUrl/create-order'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'amount': amountInPaise}),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Unable to create Razorpay order');
//       }

//       final order = jsonDecode(response.body);

//       final options = {
//         'key': keyId,
//         'amount': order['amount'],
//         'currency': 'INR',
//         'order_id': order['id'],
//         'name': 'Shopping App',
//         'description': name,
//         'theme': {'color': '#fd6f3e'},
//       };

//       openRazorpayCheckout(jsonEncode(options).toJS);
//     } catch (error) {
//       print('Payment Error: $error');
//       rethrow;
//     }
//   }
// }



import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;

@JS('openRazorpayCheckout')
external void openRazorpayCheckout(
  JSString optionsJson,
  JSFunction onSuccess,
  JSFunction onFailure,
);

class RazorpayWebService {
  static const String backendUrl = 'http://localhost:3000';
  static const String keyId = 'rzp_test_TzK5qVHUAmmNM8';

  Future<void> openPayment({
    required String name,
    required String price,
    required Future<void> Function(
            String orderId, String paymentId, String signature)
        onSuccess,
    required void Function(String message) onFailure,
  }) async {
    final parsedPrice = double.tryParse(
      price.replaceAll(',', '').replaceAll('₹', '').replaceAll('\$', '').trim(),
    );

    if (parsedPrice == null || parsedPrice <= 0) {
      throw Exception('Invalid product price');
    }

    final amountInPaise = (parsedPrice * 100).round();

    final response = await http.post(
      Uri.parse('$backendUrl/create-order'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'amount': amountInPaise}),
    );

    if (response.statusCode != 200) {
      throw Exception('Unable to create Razorpay order');
    }

    final order = jsonDecode(response.body);

    final options = {
      'key': keyId,
      'amount': order['amount'],
      'currency': 'INR',
      'order_id': order['id'],
      'name': 'Shopping App',
      'description': name,
      'theme': {'color': '#fd6f3e'},
    };

    final successJs = ((JSString data) {
      final map = jsonDecode(data.toDart);
      onSuccess(
        map['razorpay_order_id'],
        map['razorpay_payment_id'],
        map['razorpay_signature'],
      );
    }).toJS;

    final failureJs = ((JSString data) {
      onFailure(data.toDart);
    }).toJS;

    openRazorpayCheckout(jsonEncode(options).toJS, successJs, failureJs);
  }
}