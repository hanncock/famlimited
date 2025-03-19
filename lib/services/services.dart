import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService{


  // saveMessotoDb(numberTo,messageId,message,status,status_code,cost)async{
  //
  //   var all = '$url/api/messages/save';
  //
  //   Map data = {
  //     "numberTo":numberTo,
  //     "companyId":companyIdtouse,
  //     "messageId":message,
  //     "message":messageId,
  //     "status":status,
  //     "status_code":status_code,
  //     "cost":cost,
  //     "user": currentUser
  //   };
  //
  //   var send = jsonEncode(data);
  //   print(send);
  //   var response = await http.post(Uri.parse(all), body: send, headers: headers);
  //   var responseData = jsonDecode(response.body);
  //   print(responseData);
  //   return responseData;
  // }


  // String url ="http://0.0.0.0:3000";
  // String vtour ="http://0.0.0.0:3000";
  // String imgurl ="http://0.0.0.0:3000/property/propImages";
  // String url ="https://3ee2-102-0-0-246.ngrok-free.app";

  String url ="https://famlimited.co.ke/svrfiles/index.php";
  String vtour = "https://famlimited.co.ke/";
  String imgurl ="https://famlimited.co.ke/svrfiles/property/propImages";

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };


 /* login(username,password)async{

    var all = '$url/api/settings/users/login';
    Map data = {

      "email": username,
      "pass": password
    };
    var send = jsonEncode(data);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    print('here is ${response.body} jj');
    var responseData = jsonDecode(response.body);
    if(responseData['success'] == true){

      var creds = [username,password];
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("Userdata", jsonEncode(responseData['data']));
      pref.setString("userCreds", jsonEncode(creds));
      return(User.fromJson(responseData['data']));
    }else {
      return responseData;
    }
  }*/

  getvalues(endpoint)async{
    var fetchedData = Uri.encodeFull("$url/api/$endpoint");
    print(fetchedData);
    try{
      var response =  await get(Uri.parse(fetchedData));
      var jsondata = jsonDecode(response.body);
      return jsondata['data'];
    }catch(e){
      return e.toString();
    }
  }



  saveMany(val,endpoint)async{
    var all = '${url}${endpoint}';
    var send = jsonEncode(val);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    print(response.body);
    var responseData = jsonDecode(response.body);
    print("here is the ${responseData}");
    return responseData;
  }


  delete(id,endpoinr,String? img)async{
    String res = "$url/api$endpoinr";
    // Map data = img == null ? {"id": id,} : {"id":id,"image":img};
    Map data =  {"id": id,};// : {"id":id,"image":img};
    print('deleting');
    // return data;
    var response = await http.post(Uri.parse(res), body: jsonEncode(data), headers: headers);
    var responseData = jsonDecode(response.body);
    return responseData;
  }


  deleteInv(id,endpoinr)async{
    print('deleting inv');
    String res = "$url/api$endpoinr";
    Map data = {"invNum": id,};
    var response = await http.post(Uri.parse(res), body: jsonEncode(data), headers: headers);
    var responseData = jsonDecode(response.body);
    print(responseData);
    return responseData;
  }





}