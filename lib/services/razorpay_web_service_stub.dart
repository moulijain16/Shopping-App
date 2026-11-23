class RazorpayWebService {
  Future<void> openPayment({
    required String name,
    required String price,
    required Future<void> Function(
            String orderId, String paymentId, String signature)
        onSuccess,
    required void Function(String message) onFailure,
  }) async {
    throw UnsupportedError('Web payment is only available on web');
  }
}