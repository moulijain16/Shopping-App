
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  void initialize({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) {
    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      onSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      onFailure,
    );
  }

  // void openCheckout({
  //   required String keyId,
  //   required int amountInPaise,
  //   required String name,
  //   required String description,
  // }) {
  //   var options = {
  //     'key': keyId,
  //     'amount': amountInPaise,
  //     'name': name,
  //     'description': description,
  //     'currency': 'INR',
  //   };

  //   _razorpay.open(options);
  // }
  void openCheckout({
  required String keyId,
  required int amountInPaise,
  required String name,
  required String description,
  required String orderId,
}) {
  var options = {
    'key': keyId,
    'amount': amountInPaise,
    'name': name,
    'description': description,
    'currency': 'INR',
    'order_id': orderId,
  };

  _razorpay.open(options);
}

  void dispose() {
    _razorpay.clear();
  }
}
