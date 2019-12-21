
class Records {

  int _id;
  String identifier;
  String issued;
  String authorityName;
  int authoritytIdentifier;
  String distributorName;
  String distributorIdentifier;
  String status;
  String validFrom;
  String validThrough;
  String contractNumber;
  String contractDateSigned;
  String type;
  String planesValue;
  String horizontalSizeValue;
  String verticalSizeValue;
  String squareValue;
  int addressPostCode;
  String addressAdminUnitL1;
  String addressAdminUnitL2;
  String addressAdminUnitL3;
  String addressPostName;
  String addressThoroughfare;
  String addressLocatorDesignator;
  String addressLocatorBuilding;
  String addressDescription;
  String geoCoordinatesLatitude;
  String geoCoordinatesLongitude;
  String imageURL;

	Records.fromJsonMap(Map<String, dynamic> map): 
		_id = map["_id"],
		identifier = map["identifier"],
		issued = map["issued"],
		authorityName = map["authorityName"],
		authoritytIdentifier = map["authoritytIdentifier"],
		distributorName = map["distributorName"],
		distributorIdentifier = map["distributorIdentifier"],
		status = map["status"],
		validFrom = map["validFrom"],
		validThrough = map["validThrough"],
		contractNumber = map["contractNumber"],
		contractDateSigned = map["contractDateSigned"],
		type = map["type"],
		planesValue = map["planesValue"],
		horizontalSizeValue = map["horizontalSizeValue"],
		verticalSizeValue = map["verticalSizeValue"],
		squareValue = map["squareValue"],
		addressPostCode = map["addressPostCode"],
		addressAdminUnitL1 = map["addressAdminUnitL1"],
		addressAdminUnitL2 = map["addressAdminUnitL2"],
		addressAdminUnitL3 = map["addressAdminUnitL3"],
		addressPostName = map["addressPostName"],
		addressThoroughfare = map["addressThoroughfare"],
		addressLocatorDesignator = map["addressLocatorDesignator"],
		addressLocatorBuilding = map["addressLocatorBuilding"],
		addressDescription = map["addressDescription"],
		geoCoordinatesLatitude = map["geoCoordinatesLatitude"],
		geoCoordinatesLongitude = map["geoCoordinatesLongitude"],
		imageURL = map["imageURL"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = _id;
		data['identifier'] = identifier;
		data['issued'] = issued;
		data['authorityName'] = authorityName;
		data['authoritytIdentifier'] = authoritytIdentifier;
		data['distributorName'] = distributorName;
		data['distributorIdentifier'] = distributorIdentifier;
		data['status'] = status;
		data['validFrom'] = validFrom;
		data['validThrough'] = validThrough;
		data['contractNumber'] = contractNumber;
		data['contractDateSigned'] = contractDateSigned;
		data['type'] = type;
		data['planesValue'] = planesValue;
		data['horizontalSizeValue'] = horizontalSizeValue;
		data['verticalSizeValue'] = verticalSizeValue;
		data['squareValue'] = squareValue;
		data['addressPostCode'] = addressPostCode;
		data['addressAdminUnitL1'] = addressAdminUnitL1;
		data['addressAdminUnitL2'] = addressAdminUnitL2;
		data['addressAdminUnitL3'] = addressAdminUnitL3;
		data['addressPostName'] = addressPostName;
		data['addressThoroughfare'] = addressThoroughfare;
		data['addressLocatorDesignator'] = addressLocatorDesignator;
		data['addressLocatorBuilding'] = addressLocatorBuilding;
		data['addressDescription'] = addressDescription;
		data['geoCoordinatesLatitude'] = geoCoordinatesLatitude;
		data['geoCoordinatesLongitude'] = geoCoordinatesLongitude;
		data['imageURL'] = imageURL;
		return data;
	}
}
