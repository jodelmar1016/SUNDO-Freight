class Compute {
  double distance = 10; // TEMPORARY
  double weight = 0;
  double length = 0;
  double width = 0;
  double height = 0;

  double bookingFee = 0;
  double totalBookingFee = 0;
  double base = 0;
  double addsPerKm = 0;

  double total = 0;

  void onWeightChanged(val) {
    weight = val;
    if (val <= 20) {
      base = 49;
      if (distance <= 5) {
        addsPerKm = 6;
      } else {
        addsPerKm = 5;
      }
    } else if (val <= 50) {
      base = 69;
      if (distance <= 5) {
        addsPerKm = 8;
      } else {
        addsPerKm = 7;
      }
    } else if (val <= 300) {
      base = 115;
      addsPerKm = 20;
    } else if (val <= 600) {
      base = 220;
      addsPerKm = 25;
    } else if (val <= 2000) {
      base = 1650;
      addsPerKm = 45;
    }
  }

  void getTotal() {
    if (distance != 0 && weight != 0 && bookingFee != 0)
      total = distance * addsPerKm + base;
    totalBookingFee = bookingFee * total;
    total = total + totalBookingFee;
  }
}
