import 'package:chat_messenger_app/controllers/data_retrieve.dart';
import 'package:chat_messenger_app/view_pages/chat_view_page.dart';
import 'package:chat_messenger_app/view_pages/notifications_view_page.dart';
import 'package:chat_messenger_app/view_pages/profile_view_page.dart';
import 'package:chat_messenger_app/view_pages/shop_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  String pageAppBarTitle = 'Chat';
  DataRetrieve dataRetrieve = DataRetrieve();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageAppBarTitle = _pageTitles[_selectedIndex];
    });
  }

  late final List<Widget> _viewsPages;

  @override
  void initState() {
    super.initState();

    _viewsPages = <Widget>[
      ShopViewPage(loadData: dataRetrieve.shopDataRetrieve()),
      ChatViewPage(loadData: dataRetrieve.follwersDataRetrieve()),
      NotificatonsViewPage(loadData: dataRetrieve.follwersDataRetrieve()),
      ProfileViewPage(loadData: dataRetrieve.profileDataRetrieve()),
    ];
  }

  static const List<String> _pageTitles = [
    'Shop',
    'Chat',
    'Notifications',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 3
          ? buildAppBar(pageAppBarTitle, false)
          : buildAppBar(pageAppBarTitle, true),
      body: _viewsPages[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: '',
        ),
      ],
    );
  }

  PreferredSizeWidget buildAppBar(String pageAppBarTitle, bool visibleAppBar) {
    return visibleAppBar
        ? AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            elevation: 0,
            title: Text(
              pageAppBarTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            actions: const [
              Icon(
                Icons.search_outlined,
                color: Colors.black87,
                size: 30,
              )
            ],
          )
        : PreferredSize(
            preferredSize: const Size.fromHeight(15),
            child: SafeArea(
              child: Container(),
            ),
          );
  }
}
