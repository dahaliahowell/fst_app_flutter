import 'package:flutter/material.dart';
import 'package:fst_app_flutter/routing/routes.dart';
import 'package:fst_app_flutter/widgets/card_container/card_container_mobile.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';
import 'package:fst_app_flutter/widgets/navigation_card.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({Key key}) : super(key: key);

  static Map<String, List<NavigationCard>> getContainerContents(
      BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return {
      "mobile_portrait": [
        NavigationCard(
          height: queryData.size.longestSide * 0.20,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.directions_bus,
          title: "Bus\nRoutes",
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.16,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.location_on,
          title: "Map",
          route: mapRoute,
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.16,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.school,
          title: "Scholarships",
          route: scholarshipRoute,
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.184,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.photo_album,
          title: "Gallery",
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.35,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.star,
          title: "Events",
          route: eventsRoute,
        ),
      ],
      "mobile_landscape": [
        NavigationCard(
          height: queryData.size.longestSide * 0.20,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.directions_bus,
          title: "Bus\nRoutes",
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.20,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.location_on,
          title: "Map",
          route: mapRoute,
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.20,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.school,
          title: "Scholarships",
          route: scholarshipRoute,
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.20,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.photo_album,
          title: "Gallery",
        ),
        NavigationCard(
          height: queryData.size.longestSide * 0.41,
          width: queryData.size.shortestSide * 0.40,
          icon: Icons.star,
          title: "Events",
          route: eventsRoute,
        ),
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => CardContainerMobilePortrait(
          columns: 2,
          cards: getContainerContents(context)["mobile_portrait"],
          itemPerColumn: 3,
        ),
        landscape: (context) => CardContainerMobilePortrait(
          columns: 3,
          cards: getContainerContents(context)["mobile_landscape"],
          itemPerColumn: 2,
        ),
      ),
      tablet: OrientationLayout(
        portrait: (context) => Container(),
        landscape: (context) => Container(),
      ),
    );
  }
}
