import 'package:shared_preferences/shared_preferences.dart';

int calculatewater(
  int weight,
  int age,
) {
  if (age <= 30) {
    return (weight * (40) * 1.044).toInt();
  }
  if (age > 30 && age <= 50) {
    return (weight * (35) * 1.044).toInt();
  }
  if (age > 50) {
    return (weight * (30) * 1.044).toInt();
  }
  return 31; // Add your function code here!
}

void saveWaterToDrink(int water) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('watertodrink', water);
}

int waterleft(
  int cup,
  int water,
  double drinktype,
) {
  if ((water - (cup * drinktype)) < 0) {
    return 0;
  } else {
    return (water - (cup * drinktype)).round();
  }
  // Add your function code here!
}

int waterundo(
  int water,
  int cup,
  int initial,
  double drinktype,
) {
  if ((water + cup * drinktype) > initial) {
    return (initial);
  } else {
    return (water + cup * drinktype).round();
  }
  // Add your function code here!
}

int try1(
  int totalml,
  int cup,
) {
  double a = totalml / cup;
  double b = 600 / a;
  if (a == 0) {
    return 0;
  }else{
  return (b).toInt();
  }

  // Add your function code here!
}

double progressbar1(
  int watercap,
  int cup,
) {
  double y = cup / watercap;

  return y;
  // Add your function code here!
}

double progressinc(
  double amount,
  double current,
) {
  if ((current + amount) <= 1) {
    return amount;
  } else {
    return (1 - current);
  }

  // Add your function code here!
}

double? progressdec(
  double amount,
  double current,
) {
  if ((current - amount) >= 0) {
    return -amount;
  } else {
    return -current;
  }

  // Add your function code here!
}

int doubletoint(double doublee) {
  return doublee.round();

  // Add your function code here!
}

int everydayreset(DateTime? finishtime) {
  DateTime dt2 = DateTime.now();

  if (finishtime != null) {
    finishtime = finishtime.add(Duration(days: 1));
    if (finishtime.compareTo(dt2) < 0) {
      return 1;
    } else {
      return 0;
    }
  } else {
    return 1;
  }

  // Add your function code here!
}

int dranksofarundo(
  int cup,
  int dranksofar,
  double drinktype,
) {
  if ((dranksofar - cup * drinktype) < 0) {
    return (0);
  } else {
    return (dranksofar - cup * drinktype).round();
  }
  // Add your function code here!
}

int? timereset() {
  return null;

  // Add your function code here!
}

int drinktypecupsize(
  int cupsize,
  double drinktype,
) {
  return (cupsize * drinktype).round();
  // Add your function code here!
}
