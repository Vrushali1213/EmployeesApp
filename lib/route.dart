import 'package:employeeinformation/splplashscreen/splashscreen.dart';
import 'package:employeeinformation/view/employeelist.dart';

class Routes {
  static generateRoute() {
    return {
      '/SplashScreen': (context) => const SplashScreen(),
      '/EmployeeList': (context) => const EmployeeList(),
    };
  }
}
