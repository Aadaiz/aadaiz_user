import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/like_post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_my_profile.dart';

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

  Future<Map<String, dynamic>> addComment(dynamic id, dynamic data) async {
    final res = await _http.post("${Api.addComment}/$id", data);
    return jsonDecode(res);
  }
  Future<MyPostProfile> getMyProfile(String token) async {
    final res = await _http.get("${Api.myProfile}?token=$token");
    return MyPostProfile.fromJson(res);
  }
}
