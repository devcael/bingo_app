import 'package:bingo_app/views/components/navbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: Row(
          children: [
            const NavBar(),
            Expanded(
              child: PageView(
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: size.height,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
