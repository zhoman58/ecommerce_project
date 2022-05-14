import 'package:ecommerce_p/screens/all_category.dart';
import 'package:ecommerce_p/services/apiService.dart';
import 'package:ecommerce_p/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllCategory()));
              },
              icon: Icon(Icons.view_list))
        ],
      ),
      body: FutureBuilder(
          future: ApiService().getAllPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['title']),
                        leading: Image.network(
                          snapshot.data[index]['image'],
                          height: 50,
                          width: 30,
                        ),
                        subtitle:
                            Text(snapshot.data[index]['price'].toString()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                      snapshot.data[index]['id'])));
                        },
                      );
                    }),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
