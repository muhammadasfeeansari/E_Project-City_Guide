import 'package:e_project/themes/mythme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mytheme.creamcolor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: 'Select City'
            .text
            .color(mytheme.creamcolor)
            .fontFamily('cursive')
            .size(35)
            .bold
            .make(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_2_outlined,
                size: 35,
                color: Colors.white,
              ))
        ],
      ),
      body: const Center(child: Text("Welcome User")),
      drawer:const Drawer(),
    );
  }
}
