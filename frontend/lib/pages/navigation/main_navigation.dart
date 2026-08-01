import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/pages/root_pages/home_page.dart';
import 'package:frontend/pages/root_pages/profile_page.dart';
import 'package:frontend/pages/root_pages/watchlist_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/themes/colors.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  final int selectedIndex;
  const MainNavigation({super.key, this.selectedIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _selectedIndex;
  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(), // Home
    GlobalKey<NavigatorState>(), // Watchlist
    GlobalKey<NavigatorState>(), // Profile
  ];

  late final List<Widget> _pages;

  final ScrollController _homeController = ScrollController();
  final ScrollController _watchlistController = ScrollController();

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;

    _pages = <Widget>[
      HomePage(controller: _homeController),
      WatchlistPage(controller: _watchlistController),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      if (_navigatorKeys[index].currentState!.canPop()) {
        _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
      } else {
        _scrollToTop(index);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _scrollToTop(int index) {
    switch (index) {
      case 0:
        _homeController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        break;
      case 1:
        _watchlistController.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        break;
    }
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => _pages[index],
            settings: settings,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _homeController.dispose();
    _watchlistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (!authProvider.isLoggedIn) {
      return const LoginPage();
    }

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_selectedIndex]
            .currentState!
            .maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_selectedIndex != 0) {
            _onItemTapped(0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: Stack(
            children: _pages
                .asMap()
                .map((index, page) {
                  return MapEntry(index, _buildOffstageNavigator(index));
                })
                .values
                .toList(),
          ),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.primary.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: _selectedIndex == 0
                            ? AppColors.primary
                            : AppColors.textColor,
                      ),
                      label: 'Hem',
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.movie,
                        color: _selectedIndex == 1
                            ? AppColors.primary
                            : AppColors.textColor,
                      ),
                      label: 'Watchlist',
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: _selectedIndex == 2
                            ? AppColors.primary
                            : AppColors.textColor,
                      ),
                      label: 'Profil',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.textColor,
                  backgroundColor: AppColors.scaffoldBackgroundColor,
                  onTap: _onItemTapped,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
