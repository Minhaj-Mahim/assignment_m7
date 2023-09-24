import 'package:flutter/material.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyProductCounterApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 20),
    Product(name: "Product 3", price: 30),
    Product(name: "Product 4", price: 40),
    Product(name: "Product 5", price: 50),
    Product(name: "Product 6", price: 60),
    Product(name: "Product 7", price: 70),
    Product(name: "Product 8", price: 80),
    Product(name: "Product 9", price: 90),
    Product(name: "Product 10", price: 100),
    Product(name: "Product 11", price: 100),
    Product(name: "Product 12", price: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 20,
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
            builder: (context) => CartPage(products: products)
            )
          );
        },
      ),


      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
            onBuyPressed: () {
              setState(() {
                products[index].incrementCounter();
                if (products[index].counter == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Congratulations!"),
                        content: Text(
                          'You\'ve bought 5 ${products[index].name}!',
                          style: TextStyle(
                            fontSize: 13,
                        ),
                        ),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter = 0;

  Product({required this.name, required this.price});

  void incrementCounter() {
    counter++;
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onBuyPressed;

  ProductItem({required this.product, required this.onBuyPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: ${product.counter}'),
          Expanded(
            child: ElevatedButton(
              onPressed: onBuyPressed,
              child: Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}


class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalItems = products.fold(0, (sum, product) => sum + product.counter);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Total Products: $totalItems"),
      ),
    );
  }
}
