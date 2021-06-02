class DemoModel {
  String logo;
  String title;
  String companyName;
  String divider;
  String heading;
  String subheading1;
  String subheading2;
  String buttonText;
  String subtitle;
  List<Plans> plans;

  DemoModel(
      {this.logo,
        this.title,
        this.companyName,
        this.divider,
        this.heading,
        this.subheading1,
        this.subheading2,
        this.buttonText,
        this.subtitle,
        this.plans});

  DemoModel.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    title = json['title'];
    companyName = json['companyName'];
    divider = json['divider'];
    heading = json['heading'];
    subheading1 = json['subheading1'];
    subheading2 = json['subheading2'];
    buttonText = json['buttonText'];
    subtitle = json['subtitle'];
    if (json['plans'] != null) {
      plans = new List<Plans>();
      json['plans'].forEach((v) {
        plans.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['title'] = this.title;
    data['companyName'] = this.companyName;
    data['divider'] = this.divider;
    data['heading'] = this.heading;
    data['subheading1'] = this.subheading1;
    data['subheading2'] = this.subheading2;
    data['buttonText'] = this.buttonText;
    data['subtitle'] = this.subtitle;
    if (this.plans != null) {
      data['plans'] = this.plans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String name;
  String tagLine;
  String image;

  Plans({this.name, this.tagLine, this.image});

  Plans.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tagLine = json['tagLine'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tagLine'] = this.tagLine;
    data['image'] = this.image;
    return data;
  }
}
