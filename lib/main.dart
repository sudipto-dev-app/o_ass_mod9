import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class Product {
  String image;
  String name;
  int Price;
  String color;
  String size;
  int quantity;

  Product(this.image, this.name, this.Price, this.color, this.size,
      this.quantity);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [
    Product('img.png', 'Pullover', 51, 'Black', 'L', 1),
    Product('img_1.png', 'T-Shirt', 30, 'Gray', 'L', 1),
    Product('img_2.png', 'Sport Dress', 43, 'Black', 'M', 1),
  ];

  void increaseItemCount(int index) {
    setState(() {
      products[index].quantity++;
    });
  }

  void decreaseItemCount(int index) {
    if (products[index].quantity > 0) {
      setState(() {
        products[index].quantity--;
      });
    }
  }

  int calculateTotalAmount() {
    int total = 0;
    for (var product in products) {
      total += product.quantity * product.Price;
    }
    return total;
  }

  MySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.search), onPressed: () {  },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "My Bag",
              style: TextStyle(
                fontSize: 34,fontWeight: FontWeight.w500
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(products[index].image),
                        Expanded(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(products[index].name),
                                const Icon(Icons.more_vert),
                              ],
                            ),
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Color: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: products[index].color,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '  Size: ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        TextSpan(
                                          text: products[index].size,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF979797),
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.white,
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            onTap: () =>
                                                decreaseItemCount(index),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          products[index].quantity.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,),
                                        ),
                                      ),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF979797),
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.white,
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            onTap: () =>
                                                increaseItemCount(index),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${products[index].Price * products[index].quantity}\$',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 105,
        elevation: 0,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${calculateTotalAmount().toStringAsFixed(0)}\$',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                MySnackBar(
                    "Congratulations",
                    context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 48),
                backgroundColor: const Color(0xffdb3022),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                "CHECK OUT",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}