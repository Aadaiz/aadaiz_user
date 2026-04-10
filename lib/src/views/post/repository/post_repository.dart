import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/like_post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_chat_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_my_profile.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_other_profile.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_view_detail.dart';

class PostRepository {
  static final HttpHelper _http = HttpHelper();
  Future<PostListRes> getPostList(String token, int page) async {
    final res = await _http.get("${Api.postList}?token=$token&page=$page");
    return PostListRes.fromJson(res);
  }

  Future<LikePostRes> likePost(String token, dynamic id) async {
    final res = await _http.get("${Api.likePost}/$id?token=$token");
    return LikePostRes.fromJson(res);
  }

  Future<LikePostRes> savePost(String token, dynamic id) async {
    final res = await _http.get("${Api.savePost}/$id?token=$token");
    return LikePostRes.fromJson(res);
  }

  Future<dynamic> searchList(String token) async {
    final res = await _http.get("${Api.searchList}?token=$token");
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> addComment(dynamic id, dynamic data) async {
    final res = await _http.post("${Api.addComment}/$id", data);
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> addBio(dynamic data) async {
    final res = await _http.post(Api.addBio, data);
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> deletePost(dynamic id, String token) async {
    final res = await _http.post("${Api.deletePost}/$id?token=$token", null);
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> createConversation(
    String token,
    dynamic data,
  ) async {
    final res = await _http.post(
      "${Api.createConversation}?token=$token",
      data,
    );
    return jsonDecode(res);
  }

  Future<Map<String, dynamic>> sharePost(dynamic data, dynamic id) async {
    final res = await _http.post("${Api.sharePost}/$id", data);
    return jsonDecode(res);
  }

  Future<MyPostProfile> getMyProfile(String token) async {
    final res = await _http.get("${Api.myProfile}?token=$token");
    return MyPostProfile.fromJson(res);
  }

  Future<PostChatList> getChatList(String token) async {
    final res = await _http.get("${Api.postChatList}?token=$token");
    return PostChatList.fromJson(res);
  }

  Future<PostViewDetail> getPostViewDetails(String token, dynamic id) async {
    final res = await _http.get("${Api.viewDetail}/$id?token=$token");
    return PostViewDetail.fromJson(res);
  }

  Future<dynamic> followOthers(String token, dynamic id) async {
    final res = await _http.get("${Api.followOthers}/$id?token=$token");
    return jsonDecode(res);
  }

  Future<OtherProfileRes> getOtherProfile(dynamic id, String token) async {
    final res = await _http.get("${Api.otherProfile}/$id?token=$token");
    return OtherProfileRes.fromJson(res);
  }
}
