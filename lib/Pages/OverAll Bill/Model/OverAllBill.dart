class OverAllBill {
  OverAllBill({
    required this.success,
    required this.residentslist,
  });
  late final bool success;
  late final List<Residentslist> residentslist;
  
  OverAllBill.fromJson(Map<String, dynamic> json){
    success = json['success'];
    residentslist = List.from(json['residentslist']).map((e)=>Residentslist.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['residentslist'] = residentslist.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Residentslist {
  Residentslist({
    required this.id,
    required this.charges,
    required this.latecharges,
    required this.appcharges,
    required this.tax,
    required this.balance,
    required this.payableamount,
    required this.totalpaidamount,
    required this.subadminid,
    required this.financemanagerid,
    required this.residentid,
    required this.propertyid,
    required this.measurementid,
    required this.duedate,
    required this.billstartdate,
    required this.billenddate,
    required this.month,
    required this.billtype,
    required this.paymenttype,
    required this.status,
    required this.isbilllate,
    required this.noofappusers,
    required this.createdAt,
    required this.updatedAt,
    required this.firstname,
    required this.lastname,
    required this.cnic,
    required this.address,
    required this.mobileno,
    required this.password,
    required this.roleid,
    required this.rolename,
    required this.image,
    required this.fcmtoken,
    required this.vechileno,
    required this.residenttype,
    required this.propertytype,
    required this.committeemember,
  });
  late final int id;
  late final String charges;
  late final String latecharges;
  late final String appcharges;
  late final String tax;
  late final String balance;
  late final String payableamount;
  late final String totalpaidamount;
  late final int subadminid;
  late final int financemanagerid;
  late final int residentid;
  late final int propertyid;
  late final int measurementid;
  late final String duedate;
  late final String billstartdate;
  late final String billenddate;
  late final String month;
  late final String billtype;
  late final String paymenttype;
  late final String status;
  late final int isbilllate;
  late final int noofappusers;
  late final String createdAt;
  late final String updatedAt;
  late final String firstname;
  late final String lastname;
  late final String cnic;
  late final String address;
  late final String mobileno;
  late final String password;
  late final int roleid;
  late final String rolename;
  late final String image;
  late final String fcmtoken;
  late final String vechileno;
  late final String residenttype;
  late final String propertytype;
  late final int committeemember;
  
  Residentslist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    charges = json['charges'];
    latecharges = json['latecharges'];
    appcharges = json['appcharges'];
    tax = json['tax'];
    balance = json['balance'];
    payableamount = json['payableamount'];
    totalpaidamount = json['totalpaidamount'];
    subadminid = json['subadminid'];
    financemanagerid = json['financemanagerid'];
    residentid = json['residentid'];
    propertyid = json['propertyid'];
    measurementid = json['measurementid'];
    duedate = json['duedate'];
    billstartdate = json['billstartdate'];
    billenddate = json['billenddate'];
    month = json['month'];
    billtype = json['billtype'];
    paymenttype = json['paymenttype'];
    status = json['status'];
    isbilllate = json['isbilllate'];
    noofappusers = json['noofappusers'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cnic = json['cnic'];
    address = json['address'];
    mobileno = json['mobileno'];
    password = json['password'];
    roleid = json['roleid'];
    rolename = json['rolename'];
    image = json['image'];
    fcmtoken = json['fcmtoken'];
    vechileno = json['vechileno'];
    residenttype = json['residenttype'];
    propertytype = json['propertytype'];
    committeemember = json['committeemember'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['charges'] = charges;
    _data['latecharges'] = latecharges;
    _data['appcharges'] = appcharges;
    _data['tax'] = tax;
    _data['balance'] = balance;
    _data['payableamount'] = payableamount;
    _data['totalpaidamount'] = totalpaidamount;
    _data['subadminid'] = subadminid;
    _data['financemanagerid'] = financemanagerid;
    _data['residentid'] = residentid;
    _data['propertyid'] = propertyid;
    _data['measurementid'] = measurementid;
    _data['duedate'] = duedate;
    _data['billstartdate'] = billstartdate;
    _data['billenddate'] = billenddate;
    _data['month'] = month;
    _data['billtype'] = billtype;
    _data['paymenttype'] = paymenttype;
    _data['status'] = status;
    _data['isbilllate'] = isbilllate;
    _data['noofappusers'] = noofappusers;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['cnic'] = cnic;
    _data['address'] = address;
    _data['mobileno'] = mobileno;
    _data['password'] = password;
    _data['roleid'] = roleid;
    _data['rolename'] = rolename;
    _data['image'] = image;
    _data['fcmtoken'] = fcmtoken;
    _data['vechileno'] = vechileno;
    _data['residenttype'] = residenttype;
    _data['propertytype'] = propertytype;
    _data['committeemember'] = committeemember;
    return _data;
  }
}