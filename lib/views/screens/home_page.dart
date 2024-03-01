import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_cart/controller/controller.dart';
import 'package:provider/provider.dart';
import '../../helpers/auth_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Homepage'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('search_page');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(),
            GestureDetector(
              onTap: () {
                AuthHelper.authHelper.signOut().then(
                      (value) =>
                          Navigator.of(context).pushReplacementNamed('/'),
                    );
              },
              child: const SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: List.generate(
                5,
                (index) => AnimatedContainer(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        Provider.of<ProductController>(context)
                            .allProduct[index]
                            .thumbnail,
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 300,
                  duration: const Duration(milliseconds: 600),
                ),
              ),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 300,
                ),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.bounceInOut,
                enlargeCenterPage: true,
              ),
            ),
            const Gap(20),
            const Text(
              'All Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Consumer<ProductController>(
                builder: (context, pro, _) => GridView.builder(
                  itemCount: pro.allProduct.length,
                  itemBuilder: (context, index) => Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % 18],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          pro.allProduct[index].thumbnail,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
