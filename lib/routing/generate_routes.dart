import 'package:flutter/material.dart';
import 'package:fst_app_flutter/routing/slide_up_route.dart';
import 'package:fst_app_flutter/screens/app_preferences_screen/app_preferences_view.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view.dart';
import 'package:fst_app_flutter/screens/home_screen/home_view.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/scholarship_view.dart';
import 'package:fst_app_flutter/screens/events_screen/events_view.dart';
import 'routes.dart';

/// Handles routing in the app
class Router {
  /// Controls how each [Route] is generated
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case contactRoute:
        return MaterialPageRoute(builder: (context) => ContactView());
      case contactDetailRoute:
        return SlideUpPageRoute(page: ContactDetailPage(settings.arguments));
      case scholarshipRoute:
        return MaterialPageRoute(builder: (context) => ScholarshipView());
      case appPreferencesRoute:
        return MaterialPageRoute(builder: (context) => AppPreferencesView());
      case mapRoute:
        return MaterialPageRoute(builder: (context) => CampusMapView());
      case eventsRoute:
        return MaterialPageRoute(builder: (context) => EventsView());
      default:
        return MaterialPageRoute(builder: (context) => HomeView());
    }
  }
}
