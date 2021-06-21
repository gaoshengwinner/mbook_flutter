class AdditionalInfo{
  bool canBeUse = false;
  int no = 0;
  String value = "";
  String title = "";

  AdditionalInfo({this.no, this.canBeUse, this.value, this.title});
}

class AdditionalMana{
  List<AdditionalInfo> simpleTexts = [];
  List<AdditionalInfo> htmlTexts = [];
  List<AdditionalInfo> pictures = [];
  List<AdditionalInfo> videos = [];
  List<AdditionalInfo> webViews = [];
}
