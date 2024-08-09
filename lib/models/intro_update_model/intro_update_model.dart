class IntroUpdateModel {
  int? status;
  String? id;
  dynamic cNICNumber;
  String? mRNo;
  dynamic identityType;
  String? name;
  dynamic identityTypeName;
  String? patientTypeName;
  String? patientTypeId;
  dynamic personTitleId;
  dynamic title;
  String? prefix;
  String? firstName;
  dynamic middleName;
  dynamic lastName;
  String? gender;
  String? genderId;
  dynamic relationshipTypeId;
  dynamic relationshipTypeName;
  dynamic guardianName;
  dynamic maritalStatusId;
  dynamic maritalStatus;
  String? dateOfBirth;
  String? referenceId;
  dynamic picturePath;
  String? country;
  String? countryId;
  String? stateOrProvince;
  String? stateOrProvinceId;
  String? city;
  String? cityId;
  String? address;
  String? cellNumber;
  dynamic telephoneNumber;
  String? email;
  dynamic occupationId;
  dynamic occupation;
  dynamic nOKFirstName;
  dynamic nOKLastName;
  dynamic nOKRelation;
  dynamic nOKRelationId;
  dynamic nOKCNICNumber;
  dynamic nOKCellNumber;
  dynamic bloodGroup;
  dynamic bloodGroupId;
  String? age;
  dynamic latitude;
  dynamic longitude;
  String? errorMessage;
  double? height;
  double? weight;
  String? heightMeasurementCategoryId;
  String? heightMeasurementCategoryName;
  String? weightMeasurementCategoryId;
  String? weightMeasurementCategoryName;
  String? physicalActivityLevelId;
  String? physicalActivityLevelName;
  String? physicalActivitiesListName;
  String? physicalActivitiesListIds;
  String? diseasesListName;
  String? diseasesListIds;

  IntroUpdateModel(
      {this.status,
      this.id,
      this.cNICNumber,
      this.mRNo,
      this.identityType,
      this.name,
      this.identityTypeName,
      this.patientTypeName,
      this.patientTypeId,
      this.personTitleId,
      this.title,
      this.prefix,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.genderId,
      this.relationshipTypeId,
      this.relationshipTypeName,
      this.guardianName,
      this.maritalStatusId,
      this.maritalStatus,
      this.dateOfBirth,
      this.referenceId,
      this.picturePath,
      this.country,
      this.countryId,
      this.stateOrProvince,
      this.stateOrProvinceId,
      this.city,
      this.cityId,
      this.address,
      this.cellNumber,
      this.telephoneNumber,
      this.email,
      this.occupationId,
      this.occupation,
      this.nOKFirstName,
      this.nOKLastName,
      this.nOKRelation,
      this.nOKRelationId,
      this.nOKCNICNumber,
      this.nOKCellNumber,
      this.bloodGroup,
      this.bloodGroupId,
      this.age,
      this.latitude,
      this.longitude,
      this.errorMessage,
      this.height,
      this.weight,
      this.heightMeasurementCategoryId,
      this.heightMeasurementCategoryName,
      this.weightMeasurementCategoryId,
      this.weightMeasurementCategoryName,
      this.physicalActivityLevelId,
      this.physicalActivityLevelName,
      this.physicalActivitiesListName,
      this.physicalActivitiesListIds,
      this.diseasesListName,
      this.diseasesListIds});

  IntroUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    id = json['Id'];
    cNICNumber = json['CNICNumber'];
    mRNo = json['MRNo'];
    identityType = json['IdentityType'];
    name = json['Name'];
    identityTypeName = json['IdentityTypeName'];
    patientTypeName = json['PatientTypeName'];
    patientTypeId = json['PatientTypeId'];
    personTitleId = json['PersonTitleId'];
    title = json['Title'];
    prefix = json['Prefix'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    gender = json['Gender'];
    genderId = json['GenderId'];
    relationshipTypeId = json['RelationshipTypeId'];
    relationshipTypeName = json['RelationshipTypeName'];
    guardianName = json['GuardianName'];
    maritalStatusId = json['MaritalStatusId'];
    maritalStatus = json['MaritalStatus'];
    dateOfBirth = json['DateOfBirth'];
    referenceId = json['ReferenceId'];
    picturePath = json['PicturePath'];
    country = json['Country'];
    countryId = json['CountryId'];
    stateOrProvince = json['StateOrProvince'];
    stateOrProvinceId = json['StateOrProvinceId'];
    city = json['City'];
    cityId = json['CityId'];
    address = json['Address'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    email = json['Email'];
    occupationId = json['OccupationId'];
    occupation = json['Occupation'];
    nOKFirstName = json['NOKFirstName'];
    nOKLastName = json['NOKLastName'];
    nOKRelation = json['NOKRelation'];
    nOKRelationId = json['NOKRelationId'];
    nOKCNICNumber = json['NOKCNICNumber'];
    nOKCellNumber = json['NOKCellNumber'];
    bloodGroup = json['BloodGroup'];
    bloodGroupId = json['BloodGroupId'];
    age = json['Age'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    errorMessage = json['ErrorMessage'];
    height = json['Height'];
    weight = json['Weight'];
    heightMeasurementCategoryId = json['HeightMeasurementCategoryId'];
    heightMeasurementCategoryName = json['HeightMeasurementCategoryName'];
    weightMeasurementCategoryId = json['WeightMeasurementCategoryId'];
    weightMeasurementCategoryName = json['WeightMeasurementCategoryName'];
    physicalActivityLevelId = json['PhysicalActivityLevelId'];
    physicalActivityLevelName = json['PhysicalActivityLevelName'];
    physicalActivitiesListName = json['PhysicalActivitiesListName'];
    physicalActivitiesListIds = json['PhysicalActivitiesListIds'];
    diseasesListName = json['DiseasesListName'];
    diseasesListIds = json['DiseasesListIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Id'] = id;
    data['CNICNumber'] = cNICNumber;
    data['MRNo'] = mRNo;
    data['IdentityType'] = identityType;
    data['Name'] = name;
    data['IdentityTypeName'] = identityTypeName;
    data['PatientTypeName'] = patientTypeName;
    data['PatientTypeId'] = patientTypeId;
    data['PersonTitleId'] = personTitleId;
    data['Title'] = title;
    data['Prefix'] = prefix;
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['Gender'] = gender;
    data['GenderId'] = genderId;
    data['RelationshipTypeId'] = relationshipTypeId;
    data['RelationshipTypeName'] = relationshipTypeName;
    data['GuardianName'] = guardianName;
    data['MaritalStatusId'] = maritalStatusId;
    data['MaritalStatus'] = maritalStatus;
    data['DateOfBirth'] = dateOfBirth;
    data['ReferenceId'] = referenceId;
    data['PicturePath'] = picturePath;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['StateOrProvince'] = stateOrProvince;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['City'] = city;
    data['CityId'] = cityId;
    data['Address'] = address;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['Email'] = email;
    data['OccupationId'] = occupationId;
    data['Occupation'] = occupation;
    data['NOKFirstName'] = nOKFirstName;
    data['NOKLastName'] = nOKLastName;
    data['NOKRelation'] = nOKRelation;
    data['NOKRelationId'] = nOKRelationId;
    data['NOKCNICNumber'] = nOKCNICNumber;
    data['NOKCellNumber'] = nOKCellNumber;
    data['BloodGroup'] = bloodGroup;
    data['BloodGroupId'] = bloodGroupId;
    data['Age'] = age;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['ErrorMessage'] = errorMessage;
    data['Height'] = height;
    data['Weight'] = weight;
    data['HeightMeasurementCategoryId'] = heightMeasurementCategoryId;
    data['HeightMeasurementCategoryName'] = heightMeasurementCategoryName;
    data['WeightMeasurementCategoryId'] = weightMeasurementCategoryId;
    data['WeightMeasurementCategoryName'] = weightMeasurementCategoryName;
    data['PhysicalActivityLevelId'] = physicalActivityLevelId;
    data['PhysicalActivityLevelName'] = physicalActivityLevelName;
    data['PhysicalActivitiesListName'] = physicalActivitiesListName;
    data['PhysicalActivitiesListIds'] = physicalActivitiesListIds;
    data['DiseasesListName'] = diseasesListName;
    data['DiseasesListIds'] = diseasesListIds;
    return data;
  }
}
