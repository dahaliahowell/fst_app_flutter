import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/events_screen/events_mobile_view.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class EventsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: EventsMobileView(),
      //tablet: ScholarshipTabletView(),
    );
  }
}
