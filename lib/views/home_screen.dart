import 'package:demo_project/providers/states/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String homeScreen = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final PageController _pageController;
  late final TabController _bottomNavController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _bottomNavController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avokadio"),
      ),
      body: Consumer<HomeScreenState>(
        builder: (__, value, _) {
          return value.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.expand(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _bottomNavController.animateTo(index);

                      setState(() {});
                    },
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        color: Colors.blueGrey,
                        child: Text("Hi ${value.user!.name}, your up to date weight is ${value.user!.weight}"),
                      ),
                      Container(
                        color: Colors.red,
                      ),
                      Container(
                        color: Colors.green,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
        controller: _bottomNavController,
        onTap: (index) {
          setState(() {});
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
