final Map<String, Map<String, double>> vehicleCost = {
  'tricycle': {
    'basePrice': 69.0,
    'additionalCostPerKm': 7.0,
  },
  'pickup': {
    'basePrice': 115.0,
    'additionalCostPerKm': 20.0,
  },
  'cargoVan': {
    'basePrice': 220.0,
    'additionalCostPerKm': 25.0,
  },
  'cargoTruck': {
    'basePrice': 1650.0,
    'additionalCostPerKm': 45.0,
  },
};

final Map<String, Map<String, double>> fee = {
  'package': {
    'tricycle': 0.05,
    'pickup': 0.07,
    'cargoVan': 0.08,
    'cargoTruck': 0.10,
  },
  'solidBulk': {
    'tricycle': 0.08,
    'pickup': 0.10,
    'cargoVan': 0.12,
    'cargoTruck': 0.15,
  },
  'hazardous': {
    'tricycle': 0.10,
    'pickup': 0.12,
    'cargoVan': 0.15,
    'cargoTruck': 0.18,
  },
};

final Map<String, int> maxWeight = {
  'tricycle': 50,
  'pickup': 300,
  'cargoVan': 600,
  'cargoTruck': 1200,
};

final Map<String, int> maxVolume = {
  'tricycle': 15,
  'pickup': 66,
  'cargoVan': 400,
  'cargoTruck': 2000,
};
