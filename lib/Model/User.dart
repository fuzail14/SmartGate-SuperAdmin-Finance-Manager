class User {
  User({
     this.success,
     this.data,
     this.bearer,
  });
   bool? success;
   Data? data;
   String? bearer;
  
  User.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
    bearer = json['Bearer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data!.toJson();
    _data['Bearer'] = bearer;
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.firstname,
     this.lastname,
     this.cnic,
     this.address,
     this.mobileno,
     this.roleid,
     this.rolename,
     this.image,
     this.fcmtoken,
     this.createdAt,
     this.updatedAt,
     this.financemanagerid,
     this.superadminid,
     this.status,
  });
   int? id;
   String? firstname;
   String? lastname;
   String? cnic;
   String? address;
   String? mobileno;
   int? roleid;
   String? rolename;
   String? image;
   Null? fcmtoken;
   String? createdAt;
   String? updatedAt;
   int? financemanagerid;
   int? superadminid;
   String? status;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    cnic = json['cnic'];
    address = json['address'];
    mobileno = json['mobileno'];
    roleid = json['roleid'];
    rolename = json['rolename'];
    image = json['image'];
    fcmtoken = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    financemanagerid = json['financemanagerid'];
    superadminid = json['superadminid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['cnic'] = cnic;
    _data['address'] = address;
    _data['mobileno'] = mobileno;
    _data['roleid'] = roleid;
    _data['rolename'] = rolename;
    _data['image'] = image;
    _data['fcmtoken'] = fcmtoken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['financemanagerid'] = financemanagerid;
    _data['superadminid'] = superadminid;
    _data['status'] = status;
    return _data;
  }
}