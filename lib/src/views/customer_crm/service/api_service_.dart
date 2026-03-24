import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiService{


    Future getAp({required String url,Map<String,dynamic>? params})async{

      try{
        final uri  = Uri.parse(url).replace(queryParameters: params);
        final response  = await http.get(uri,headers: {"Content-Type":"application/json"});

        if(response.statusCode == 200 || response.statusCode == 404){
            print("--------------------------------Success-------------------------------------");
            print("🚀 From Get API \n Status Code : ${response.statusCode} \n Body :  ${response.body} ");
            print("----------------------------------------------------------------------------");
            return json.decode(response.body);
        }else{
           print("-----------------------------------Error-Response---------------------------");
           print("❌ From Post Api${response.statusCode} \n ${response.body} ");
           print("----------------------------------------------------------------------------");
           return json.decode(response.body);
        }

      } on Exception catch (e) {
      print("------------------------------------Exception--------------------------------");
      print("❌ Exception Get API Call: $e");
      print("----------------------------------------------------------------------------");
      return null;
      }
    }

    Future postApi({required String url, required Map<String,dynamic> body})async{
      try{
        final uri = Uri.parse(url);
        final response =await http.post(uri,body: json.encode(body),headers: {"Content-Type":"application/json"});

        if(response.statusCode >=200 || response.statusCode<300){
            print("--------------------------------Success-------------------------------------");
            print("🚀 From Post API \n Status Code : ${response.statusCode} \n Body :  ${response.body} ");
            print("----------------------------------------------------------------------------");
          return json.decode(response.body);
        }else{
           print("-----------------------------------Error-Response---------------------------");
           print("❌ From Post Api${response.statusCode} \n ${response.body} ");
           print("----------------------------------------------------------------------------");
           return json.decode(response.body);
        }

      }
      on Exception catch(e){
           print("------------------------------------Exception--------------------------------");
           print("❌ Exception Post API Call: $e");
           print("----------------------------------------------------------------------------");
      return null;
      }
    }

}