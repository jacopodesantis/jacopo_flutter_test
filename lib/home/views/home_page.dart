import 'package:flutter/material.dart';
import 'package:jacopo_flutter_test/hive/widgets/hive_item.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width - 40,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(
                    viewportFraction: 1,
                    initialPage: 0,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const HiveItem();
                  },
                ),
              ),
              TabPageSelector(
                controller: TabController(
                  length: 5,
                  vsync: this,
                  initialIndex: 0,
                ),
                color: const Color.fromRGBO(123, 121, 134, 1),
                selectedColor: Colors.white,
                indicatorSize: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
