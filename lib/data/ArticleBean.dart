class ArticleBean {
  int errorCode;
  String errorMsg;
  ContentBody contentBody;

  ArticleBean({this.errorCode, this.errorMsg, this.contentBody});

  factory ArticleBean.parseJson(Map<String, dynamic> parseJson) {
    return ArticleBean(
        errorCode: parseJson['errorCode'],
        errorMsg: parseJson['errorMsg'],
        contentBody: ContentBody.parseJson(parseJson['data']));
  }

  @override
  String toString() {
    return 'ArticleBean{errorCode: $errorCode, errorMsg: $errorMsg, contentBody: $contentBody}';
  }


}

class ContentBody {
  int curPage;
  List<Content> dataList = List();

  ContentBody({this.curPage, this.dataList});

  factory ContentBody.parseJson(Map<String, dynamic> parseJson) {
    var data = parseJson['datas'] as List;
    return ContentBody(
        curPage: parseJson['curPage'],
        dataList: data.map((i) => Content.parseJson(i)).toList());
  }

  @override
  String toString() {
    return 'ContentBody{curPage: $curPage, dataList: $dataList}';
  }

}

class Content {
  String chapterName;
  String desc;
  String envelopePic;

  Content({this.chapterName, this.desc, this.envelopePic});

  factory Content.parseJson(Map<String, dynamic> parseJson) {
    return Content(
        chapterName: parseJson['chapterName'],
        desc: parseJson['desc'],
        envelopePic: parseJson['envelopePic']);
  }

  @override
  String toString() {
    return 'Content{chapterName: $chapterName, desc: $desc, envelopePic: $envelopePic}';
  }

}
