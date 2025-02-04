class ApiUrl {
  // static const String _base = 'https://portal.getepay.in:8443/getepayPortal';
  static bool kTest = false;
  static String base = kTest
      ? 'https://pay1.getepay.in:8443/getepayPortal'
      : 'https://portal.getepay.in:8443/getepayPortal';

  // static const String _base = 'https://portal.getepay.in:8443'; // send box - production

  static String getLink = "$base/pg/generateInvoice";
  static String getInvoiceStatus = "$base/pg/invoiceStatus";
  static String ru = '$base/pg/pgPaymentResponse';
}
