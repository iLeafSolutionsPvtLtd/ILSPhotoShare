class User {
  int userID;
  int masterClientID;
  String email;
  String firstName;
  String lastName;
  int userTypeID;
  String company;
  String phone;
  String address1;
  String address2;
  String address3;
  String town;
  String country;
  String postCode;
  int crewDsp;

  User(
      {this.userID,
      this.masterClientID,
      this.email,
      this.firstName,
      this.lastName,
      this.userTypeID,
      this.company,
      this.phone,
      this.address1,
      this.address2,
      this.address3,
      this.town,
      this.country,
      this.postCode,
      this.crewDsp});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    masterClientID = json['masterClientID'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['LastName'];
    userTypeID = json['userTypeID'];
    company = json['company'];
    phone = json['phone'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    town = json['town'];
    country = json['country'];
    postCode = json['postCode'];
    crewDsp = json['crewDsp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['masterClientID'] = this.masterClientID;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['userTypeID'] = this.userTypeID;
    data['company'] = this.company;
    data['phone'] = this.phone;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['town'] = this.town;
    data['country'] = this.country;
    data['postCode'] = this.postCode;
    data['crewDsp'] = this.crewDsp;
    return data;
  }
}
