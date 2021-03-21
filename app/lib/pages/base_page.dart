import 'package:app/pages/no_internet_connection_page.dart';
import 'package:app/providers/internet_provider.dart';
import 'package:app/providers/voice_provider.dart';
import 'package:app/routes/destination.dart';
import 'package:app/routes/destinations.dart';
import 'package:app/routes/navigation_provider.dart';
import 'package:app/widgets/cutsom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select<NavigationProvider, int>(
        (provider) => provider.currentTabIndex);
    final hasInternet = context
        .select<InternetProvider, bool>((provider) => provider.hasInternet);

    return !hasInternet
        ? NoInternetConnectionPage()
        : WillPopScope(
            onWillPop: () {
              final provider = context.read<NavigationProvider>();
              provider.pop();
              return Future.value(false);
            },
            child: Scaffold(
              body: SafeArea(
                top: false,
                child: IndexedStack(
                  index: currentIndex,
                  children: Destinations.allDestinations
                      .map<Widget>(
                        (Destination destination) =>
                            Destinations.buildDestinationView(destination),
                      )
                      .toList(),
                ),
              ),
              floatingActionButton: CustomFloatingButtons(),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Color(0xfff2f0f2),
                fixedColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (int index) {
                  context.read<NavigationProvider>().pushName(tab: index);
                },
                items:
                    Destinations.allDestinations.map((Destination destination) {
                  return BottomNavigationBarItem(
                    icon: Icon(
                      destination.icon,
                      color: destination.color,
                      semanticLabel: destination.title,
                    ),
                    activeIcon: Icon(
                      destination.icon,
                      semanticLabel: destination.title,
                      color: destination.color,
                    ),
                    title: Text(
                      destination.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
