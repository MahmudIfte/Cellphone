import 'package:cellphone/product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController productController = TextEditingController();
  TextEditingController pidController = TextEditingController();
  List<Product> products = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: productController,
              decoration: const InputDecoration(
                  hintText: 'Product Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pidController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration: const InputDecoration(
                  hintText: 'Product Id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = productController.text.trim();
                      String pid = pidController.text.trim();
                      if (name.isNotEmpty && pid.isNotEmpty) {
                        setState(() {
                          productController.text = '';
                          pidController.text = '';
                          products.add(Product(name: name, pid: pid));
                        });
                      }
                      //
                    },
                    child: const Text('Add')),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = productController.text.trim();
                      String pid = pidController.text.trim();
                      if (name.isNotEmpty && pid.isNotEmpty) {
                        setState(() {
                          productController.text = '';
                          pidController.text = '';
                          products[selectedIndex].name = name;
                          products[selectedIndex].pid = pid;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    child: const Text('Update')),
              ],
            ),
            const SizedBox(height: 10),
            products.isEmpty
                ? const Text(
              'No Product  yet..',
              style: TextStyle(fontSize: 22),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            products[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              products[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(products[index].pid),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    productController.text = products[index].name;
                    pidController.text = products[index].pid;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      products.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}