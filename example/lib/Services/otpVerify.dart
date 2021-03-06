
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_us_model.dart';

class OtpVerify {
  static Future<int> Otpverify(String id,String session)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('POST',Uri.parse(ApiLink.GetOrderStatus+"/$id"));
      request.headers.addAll(headers);
      request.bodyFields={
        "url":session
      };
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        int responseData = int.parse(response.body);
        // ContactUsModel posts = ContactUsModel.fromJson(responseData);

        return responseData;
      } else {
        print(response.reasonPhrase);
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

}




