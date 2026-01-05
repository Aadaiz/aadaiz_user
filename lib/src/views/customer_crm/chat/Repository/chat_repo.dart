

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/model/chatList_model.dart';



class ChatRepository{
  static final HttpHelper _http = HttpHelper();

  callOthers(dynamic request)async{
    final res = await _http.post(Api.callOthers,request);
    return res;

  } getChatList(dynamic request)async{
    final res = await _http.get(Api.chatList,);
    return ChatList.fromMap(res);

  }
}