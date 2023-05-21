import 'package:freight/constant/bookingConstant.dart';

enum TypeOfCargo {
  package,
  solidBulk,
  hazardous,
}

enum TypeOfVehicle {
  tricycle,
  pickup,
  cargoVan,
  cargoTruck,
}

/*
  1. Get type of vehicle
      - to get the type of vehicle get weight and volume of the cargo
      - compute for the volume length x width x height
  2. Get vehicle cost
      - base price
      - adds per km
  3. Get booking fee
      - base on type of cargo and vehicle
  4. Get total booking Cost
*/

class Compute {
  TypeOfCargo? cargoType;
  TypeOfVehicle? vehicleType;
  double distance = 0;
  double weight = 0;
  double length = 0;
  double width = 0;
  double height = 0;
  double volume = 0;

  double basePrice = 0;
  double addsPerKm = 0;

  double bookingFee = 0;
  double totalBookingFee = 0;

  double totalBookingCost = 0;

  double driverShares = 0;

  getTypeOfVehicle() {
    volume = length * width * height;
    if (weight <= maxWeight['tricycle']! && volume <= maxVolume['tricycle']!) {
      vehicleType = TypeOfVehicle.tricycle;
    } else if (weight <= maxWeight['pickup']! &&
        volume <= maxVolume['pickup']!) {
      vehicleType = TypeOfVehicle.pickup;
    } else if (weight <= maxWeight['cargoVan']! &&
        volume <= maxVolume['cargoVan']!) {
      vehicleType = TypeOfVehicle.cargoVan;
    } else if (weight <= maxWeight['cargoTruck']! &&
        volume <= maxVolume['cargoTruck']!) {
      vehicleType = TypeOfVehicle.cargoTruck;
    }
  }

  getBasePrice() {
    if (vehicleType == TypeOfVehicle.tricycle) {
      basePrice = vehicleCost['tricycle']!['basePrice']!;
      addsPerKm = vehicleCost['tricycle']!['additionalCostPerKm']!;
    } else if (vehicleType == TypeOfVehicle.pickup) {
      basePrice = vehicleCost['pickup']!['basePrice']!;
      addsPerKm = vehicleCost['pickup']!['additionalCostPerKm']!;
    } else if (vehicleType == TypeOfVehicle.cargoVan) {
      basePrice = vehicleCost['cargoVan']!['basePrice']!;
      addsPerKm = vehicleCost['cargoVan']!['additionalCostPerKm']!;
    } else if (vehicleType == TypeOfVehicle.cargoTruck) {
      basePrice = vehicleCost['cargoTruck']!['basePrice']!;
      addsPerKm = vehicleCost['cargoTruck']!['additionalCostPerKm']!;
    }
  }

  getBookingFee() {
    bookingFee = fee[cargoType.toString().split('.')[1]]![
        vehicleType.toString().split('.')[1]]!;
  }

  getTotal() {
    // GET TOTAL COST W/O FEE
    totalBookingCost = basePrice + (distance * addsPerKm);
    // COMPUTE TOTAL FEE
    totalBookingFee = totalBookingCost * bookingFee;
    // ADD BOOKING FEE
    totalBookingCost = totalBookingCost + totalBookingFee;
    // GET DRIVERS SHARE
    driverShares = totalBookingCost * .7;
  }
}
