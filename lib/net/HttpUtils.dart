import 'dart:io';
import 'dart:convert';
import 'package:flutter_sample/constants/Constants.dart';

class _HttpUtil {
  Future getRequest(String url) async {
    var responseBody;
    Uri uri = Uri.parse(url);
    HttpClient httpClient = HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      responseBody = await response.transform(utf8.decoder).join();
    }
    return responseBody;
  }

  postRequest() {
    //TODO 2019/1/10/21:31
  }
}

class ArticleNet {
  loadData(int page) {
    String url = UrlConstants.technologyArticle + "$page/json";
    _HttpUtil _httpUtil = _HttpUtil();
    return _httpUtil.getRequest(url);
  }
}
