class GetTractorModel {
  String? message;
  Data? data;
  int? statusCode;

  GetTractorModel({this.message, this.data, this.statusCode});

  GetTractorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  List<Docstractor>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;

  Data(
      {this.docs,
      this.hasNextPage,
      this.hasPrevPage,
      this.limit,
      this.page,
      this.totalDocs,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docstractor>[];
      json['docs'].forEach((v) {
        docs!.add(new Docstractor.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Docstractor {
  Transmission? transmission;
  Hydraulics? hydraulics;
  FrontAxleAndSteering? frontAxleAndSteering;
  DimensionsAndWeight? dimensionsAndWeight;
  Tyres? tyres;
  Others? others;
  String? sId;
  String? modelName;
  String? brandName;
  String? description;
  String? features;
  String? engineMakeAndType;
  dynamic horsepower;
  String? engineCapacity;
  int? numberOfCylinders;
  String? coolingSystem;
  String? fuelType;
  int? fuelCapacity;
  int? length;
  int? width;
  int? height;
  int? wheelbase;
  dynamic maxSpeed;
  int? maximumLiftCapacity;
  String? frontTireSize;
  String? rearTireSize;
  String? hydraulicPumpType;
  dynamic hydraulicFlowRate;
  int? price;
  int? tax;
  int? discount;
  int? margin;
  List<Null>? images;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? quantity;

  Docstractor(
      {this.transmission,
      this.hydraulics,
      this.frontAxleAndSteering,
      this.dimensionsAndWeight,
      this.tyres,
      this.others,
      this.sId,
      this.modelName,
      this.brandName,
      this.description,
      this.features,
      this.engineMakeAndType,
      this.horsepower,
      this.engineCapacity,
      this.numberOfCylinders,
      this.coolingSystem,
      this.fuelType,
      this.fuelCapacity,
      this.length,
      this.width,
      this.height,
      this.wheelbase,
      this.maxSpeed,
      this.maximumLiftCapacity,
      this.frontTireSize,
      this.rearTireSize,
      this.hydraulicPumpType,
      this.hydraulicFlowRate,
      this.price,
      this.tax,
      this.discount,
      this.margin,
      this.images,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.quantity});

  Docstractor.fromJson(Map<String, dynamic> json) {
    transmission = json['transmission'] != null
        ? new Transmission.fromJson(json['transmission'])
        : null;
    hydraulics = json['hydraulics'] != null
        ? new Hydraulics.fromJson(json['hydraulics'])
        : null;
    frontAxleAndSteering = json['frontAxleAndSteering'] != null
        ? new FrontAxleAndSteering.fromJson(json['frontAxleAndSteering'])
        : null;
    dimensionsAndWeight = json['dimensionsAndWeight'] != null
        ? new DimensionsAndWeight.fromJson(json['dimensionsAndWeight'])
        : null;
    tyres = json['tyres'] != null ? new Tyres.fromJson(json['tyres']) : null;
    others =
        json['others'] != null ? new Others.fromJson(json['others']) : null;
    sId = json['_id'];
    modelName = json['modelName'];
    brandName = json['brandName'];
    description = json['description'];
    features = json['features'];
    engineMakeAndType = json['engineMakeAndType'];
    horsepower = json['horsepower'];
    engineCapacity = json['engineCapacity'];
    numberOfCylinders = json['numberOfCylinders'];
    coolingSystem = json['coolingSystem'];
    fuelType = json['fuelType'];
    fuelCapacity = json['fuelCapacity'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    wheelbase = json['wheelbase'];
    maxSpeed = json['maxSpeed'];
    maximumLiftCapacity = json['maximumLiftCapacity'];
    frontTireSize = json['frontTireSize'];
    rearTireSize = json['rearTireSize'];
    hydraulicPumpType = json['hydraulicPumpType'];
    hydraulicFlowRate = json['hydraulicFlowRate'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
    margin = json['margin'];
    if (json['images'] != null) {
      images = <Null>[];
      json['images'].forEach((v) {
        images!.add(null);
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transmission != null) {
      data['transmission'] = this.transmission!.toJson();
    }
    if (this.hydraulics != null) {
      data['hydraulics'] = this.hydraulics!.toJson();
    }
    if (this.frontAxleAndSteering != null) {
      data['frontAxleAndSteering'] = this.frontAxleAndSteering!.toJson();
    }
    if (this.dimensionsAndWeight != null) {
      data['dimensionsAndWeight'] = this.dimensionsAndWeight!.toJson();
    }
    if (this.tyres != null) {
      data['tyres'] = this.tyres!.toJson();
    }
    if (this.others != null) {
      data['others'] = this.others!.toJson();
    }
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    data['brandName'] = this.brandName;
    data['description'] = this.description;
    data['features'] = this.features;
    data['engineMakeAndType'] = this.engineMakeAndType;
    data['horsepower'] = this.horsepower;
    data['engineCapacity'] = this.engineCapacity;
    data['numberOfCylinders'] = this.numberOfCylinders;
    data['coolingSystem'] = this.coolingSystem;
    data['fuelType'] = this.fuelType;
    data['fuelCapacity'] = this.fuelCapacity;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['wheelbase'] = this.wheelbase;
    data['maxSpeed'] = this.maxSpeed;
    data['maximumLiftCapacity'] = this.maximumLiftCapacity;
    data['frontTireSize'] = this.frontTireSize;
    data['rearTireSize'] = this.rearTireSize;
    data['hydraulicPumpType'] = this.hydraulicPumpType;
    data['hydraulicFlowRate'] = this.hydraulicFlowRate;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['margin'] = this.margin;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => []);
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Transmission {
  Pto? pto;
  String? clutch;
  String? mainTransmission;
  String? noOfSpeeds;
  String? brakes;
  dynamic mechanicalDifferentialLock;

  Transmission(
      {this.pto,
      this.clutch,
      this.mainTransmission,
      this.noOfSpeeds,
      this.brakes,
      this.mechanicalDifferentialLock});

  Transmission.fromJson(Map<String, dynamic> json) {
    pto = json['pto'] != null ? new Pto.fromJson(json['pto']) : null;
    clutch = json['clutch'];
    mainTransmission = json['mainTransmission'];
    noOfSpeeds = json['noOfSpeeds'];
    brakes = json['brakes'];
    mechanicalDifferentialLock = json['mechanicalDifferentialLock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pto != null) {
      data['pto'] = this.pto!.toJson();
    }
    data['clutch'] = this.clutch;
    data['mainTransmission'] = this.mainTransmission;
    data['noOfSpeeds'] = this.noOfSpeeds;
    data['brakes'] = this.brakes;
    data['mechanicalDifferentialLock'] = this.mechanicalDifferentialLock;
    return data;
  }
}

class Pto {
  List<String>? speeds;
  String? onOffControl;

  Pto({this.speeds, this.onOffControl});

  Pto.fromJson(Map<String, dynamic> json) {
    speeds = json['speeds'].cast<String>();
    onOffControl = json['onOffControl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speeds'] = this.speeds;
    data['onOffControl'] = this.onOffControl;
    return data;
  }
}

class Hydraulics {
  String? controlSystem;
  String? threePointHitchCategory;
  int? maxLiftCapacity;
  dynamic transportLock;
  dynamic hitchPumpFlow;

  Hydraulics(
      {this.controlSystem,
      this.threePointHitchCategory,
      this.maxLiftCapacity,
      this.transportLock,
      this.hitchPumpFlow});

  Hydraulics.fromJson(Map<String, dynamic> json) {
    controlSystem = json['controlSystem'];
    threePointHitchCategory = json['threePointHitchCategory'];
    maxLiftCapacity = json['maxLiftCapacity'];
    transportLock = json['transportLock'];
    hitchPumpFlow = json['hitchPumpFlow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['controlSystem'] = this.controlSystem;
    data['threePointHitchCategory'] = this.threePointHitchCategory;
    data['maxLiftCapacity'] = this.maxLiftCapacity;
    data['transportLock'] = this.transportLock;
    data['hitchPumpFlow'] = this.hitchPumpFlow;
    return data;
  }
}

class FrontAxleAndSteering {
  String? frontAxleType;
  String? steeringType;
  String? fourWheelDriveEngagement;

  FrontAxleAndSteering(
      {this.frontAxleType, this.steeringType, this.fourWheelDriveEngagement});

  FrontAxleAndSteering.fromJson(Map<String, dynamic> json) {
    frontAxleType = json['frontAxleType'];
    steeringType = json['steeringType'];
    fourWheelDriveEngagement = json['fourWheelDriveEngagement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frontAxleType'] = this.frontAxleType;
    data['steeringType'] = this.steeringType;
    data['fourWheelDriveEngagement'] = this.fourWheelDriveEngagement;
    return data;
  }
}

class DimensionsAndWeight {
  FrontTrackWidth? frontTrackWidth;
  RearTrackWidth? rearTrackWidth;
  int? wheelbase;
  int? weight;
  int? overallHeightAtSteering;
  dynamic minTurningRadius;

  DimensionsAndWeight(
      {this.frontTrackWidth,
      this.rearTrackWidth,
      this.wheelbase,
      this.weight,
      this.overallHeightAtSteering,
      this.minTurningRadius});

  DimensionsAndWeight.fromJson(Map<String, dynamic> json) {
    frontTrackWidth = json['frontTrackWidth'] != null
        ? new FrontTrackWidth.fromJson(json['frontTrackWidth'])
        : null;
    rearTrackWidth = json['rearTrackWidth'] != null
        ? new RearTrackWidth.fromJson(json['rearTrackWidth'])
        : null;
    wheelbase = json['wheelbase'];
    weight = json['weight'];
    overallHeightAtSteering = json['overallHeightAtSteering'];
    minTurningRadius = json['minTurningRadius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.frontTrackWidth != null) {
      data['frontTrackWidth'] = this.frontTrackWidth!.toJson();
    }
    if (this.rearTrackWidth != null) {
      data['rearTrackWidth'] = this.rearTrackWidth!.toJson();
    }
    data['wheelbase'] = this.wheelbase;
    data['weight'] = this.weight;
    data['overallHeightAtSteering'] = this.overallHeightAtSteering;
    data['minTurningRadius'] = this.minTurningRadius;
    return data;
  }
}

class FrontTrackWidth {
  int? standard;
  int? optional;

  FrontTrackWidth({this.standard, this.optional});

  FrontTrackWidth.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    optional = json['optional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standard'] = this.standard;
    data['optional'] = this.optional;
    return data;
  }
}

class RearTrackWidth {
  int? standard;
  int? option1;
  dynamic option2;

  RearTrackWidth({this.standard, this.option1, this.option2});

  RearTrackWidth.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    option1 = json['option1'];
    option2 = json['option2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standard'] = this.standard;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    return data;
  }
}

class Tyres {
  FrontTire? frontTire;
  RearTire? rearTire;

  Tyres({this.frontTire, this.rearTire});

  Tyres.fromJson(Map<String, dynamic> json) {
    frontTire = json['frontTire'] != null
        ? new FrontTire.fromJson(json['frontTire'])
        : null;
    rearTire = json['rearTire'] != null
        ? new RearTire.fromJson(json['rearTire'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.frontTire != null) {
      data['frontTire'] = this.frontTire!.toJson();
    }
    if (this.rearTire != null) {
      data['rearTire'] = this.rearTire!.toJson();
    }
    return data;
  }
}

class FrontTire {
  String? standard;
  String? optional;

  FrontTire({this.standard, this.optional});

  FrontTire.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    optional = json['optional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standard'] = this.standard;
    data['optional'] = this.optional;
    return data;
  }
}

class RearTire {
  String? standard;
  String? option1;
  String? option2;

  RearTire({this.standard, this.option1, this.option2});

  RearTire.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    option1 = json['option1'];
    option2 = json['option2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standard'] = this.standard;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    return data;
  }
}

class Others {
  int? fuelTankCapacity;

  Others({this.fuelTankCapacity});

  Others.fromJson(Map<String, dynamic> json) {
    fuelTankCapacity = json['fuelTankCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuelTankCapacity'] = this.fuelTankCapacity;
    return data;
  }
}
