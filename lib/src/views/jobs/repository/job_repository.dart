import 'dart:convert';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/services/http_services.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_filter_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_type_model.dart';

class JobRepository {
  static final HttpHelper _http = HttpHelper();
  Future<JobListRes> getJobList(String token) async {
    final res = await _http.get("${Api.jobList}?token=$token");
    return JobListRes.fromJson(res);
  }

  Future<JobFilterListRes> getJobFilter(String token) async {
    final res = await _http.get("${Api.jobFilterList}?token=$token");
    return JobFilterListRes.fromJson(res);
  }

  Future<Map<String, dynamic>> createJob(String token, dynamic data,bool? type,dynamic id) async {
    final res = await _http.post(type==false? Api.createJob:"${Api.updateJob}/$id", data);
    return jsonDecode(res);
  }
  Future<Map<String, dynamic>> deleteJob(String token,int id) async {
    final res = await _http.post("${Api.deleteJob}/$id?token=$token", null);
    return jsonDecode(res);
  }

  Future<JobListResponse> getJobListData(
    String token,
    int page, {
    String? jobType,
    String? jobCategory,
    String? salary,
    String? search,
  }) async {
    final Map<String, String> queryParams = {
      "token": token,
      "page": page.toString(),
    };

    if (jobType != null) {
      queryParams["job_type"] = jobType;
    }

    if (jobCategory != null) {
      queryParams["job_category"] = jobCategory;
    }

    if (salary != null) {
      queryParams["salary"] = salary;
    }

    if (search != null) {
      queryParams["search"] = search.toLowerCase();
    }

    final uri = Uri.parse(
      Api.jobListData,
    ).replace(queryParameters: queryParams);

    final res = await _http.get(uri.toString());

    return JobListResponse.fromJson(res);
  }
}
