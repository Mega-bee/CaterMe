part of flutter_pay;

class FlutterPay {
  final MethodChannel _channel = MethodChannel('flutter_pay');

  /// Switch Google Pay [environment]
  ///
  /// See [PaymentEnvironment]
  void setEnvironment(
      {PaymentEnvironment environment = PaymentEnvironment.Test}) {
    var params = <String, bool>{
      "isTestEnvironment": environment == PaymentEnvironment.Test,
    };
    _channel.invokeMethod('switchEnvironment', params);
  }

  /// Returns `true` if Apple/ Google Pay is available on device
  Future<bool> canMakePayments() async {
    final canMakePayments = await _channel.invokeMethod('canMakePayments');
    return canMakePayments;
  }

  /// Returns true if Apple/Google Pay is available on device and there is at least one activated card
  ///
  /// You can set allowed payment networks in [allowedPaymentNetworks] parameter.
  /// See [PaymentNetwork]
  Future<bool> canMakePaymentsWithActiveCard(
      { List<PaymentNetwork> allowedPaymentNetworks}) async {
    var paymentNetworks =
        allowedPaymentNetworks.map((network) => network.getName).toList();
    var params = <String, dynamic>{"paymentNetworks": paymentNetworks};

    final canMakePayments =
        await _channel.invokeMethod('canMakePaymentsWithActiveCard', params);
    return canMakePayments;
  }

  /// Process the payment and returns the token from Apple/Google pay
  ///
  /// Can throw [FlutterPayError]
  ///
  /// * [googleParameters] - options for Google Pay
  /// * [appleParameters] - options for Apple Pay
  /// * [allowedPaymentNetworks] - List of allowed payment networks.
  /// See [PaymentNetwork].
  /// * [allowedCardAuthMethods] - List of allowed authenticaion methods
  /// methods for Google Pay.
  /// * [paymentItems] - affects only Apple Pay. See [PaymentItem]
  /// * [merchantName] - affects only Google Pay.
  /// Mercant name which will be displayed to customer.
  Future<String> requestPayment({
    BuildContext context,
    GoogleParameters googleParameters,
    AppleParameters appleParameters,
    List<PaymentNetwork> allowedPaymentNetworks = const [],
     List<PaymentItem> paymentItems,
    bool emailRequired = false,
     String currencyCode,
   String countryCode,
  }) async {
    final _provid = Provider.of<OrderCaterProvider>(context, listen: false);
    String log="";
    var items = paymentItems.map((item) => item.toJson()).toList();
    var params = <String, dynamic>{
      "currencyCode": currencyCode,
      "countryCode": countryCode,
      "allowedPaymentNetworks":
          allowedPaymentNetworks.map((network) => network.getName).toList(),
      "items": items,
      "emailRequired": emailRequired,
    };

    if (Platform.isAndroid && googleParameters != null) {
      params.addAll(googleParameters.toMap());
    } else if (Platform.isIOS && appleParameters != null) {
      params.addAll(appleParameters.toMap());
    } else {
      throw FlutterPayError(description: "");
    }

    try {
      log="call with apple pau \n";
      var response = await _channel.invokeMethod('requestPayment', params);
     log=log+" done, get from map\n";
      var payResponse = Map<String, String>.from(response);
      log=log+" done, get from map\n";
      if (payResponse == null) {
        throw FlutterPayError(description: "Pay response cannot be parsed");
      }
      log=log+" $payResponse\n";
      var paymentToken = payResponse["token"];
      log=log+"token response: $payResponse\n";
      if (paymentToken != null) {
        print("Payment token: $paymentToken");
        log=log+"try  parse to map\n";
      Map<String,String> map=  json.decode(paymentToken);
        log=log+"done: $map\n";
        log=log+"token :${map["data"]}\n";
        _provid.log=log;
        return map["data"];
      } else {
        log=log+"token is null\n";
        print("Payment token: null");
        _provid.log=log;
        return "";
      }
    } on PlatformException catch (error) {
      if (error.code == "userCancelledError") {
        log=log+"user cancel\n";
        print(error.message);
        _provid.log=log;
        return "";
      }
      if (error.code == "paymentError") {
        log=log+"error catch : error.message\n";
        print(error.message);
        _provid.log=log;
        return "";
      }
      throw FlutterPayError(code: error.code, description: error.message);
    }
  }
}
