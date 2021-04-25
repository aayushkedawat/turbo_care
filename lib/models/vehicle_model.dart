class VehicleModel {
  String numberOfVehicle;
  String make;
  String model;
  String fuelType;
  String transmission;

  VehicleModel({
    this.fuelType,
    this.numberOfVehicle,
    this.make,
    this.model,
    this.transmission,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModel(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}

VehicleModel _$VehicleModel(Map<String, dynamic> json) {
  return VehicleModel(
      fuelType: json['fuelType'],
      make: json['make'],
      model: json['model'],
      numberOfVehicle: json['numberOfVehicle'],
      transmission: json['transmission']);
}

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'fuelType': instance.fuelType,
      'numberOfVehicle': instance.numberOfVehicle,
      'make': instance.make,
      'model': instance.model,
      'transmission': instance.transmission,
    };
