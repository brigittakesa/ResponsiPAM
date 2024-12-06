import 'package:flutter/material.dart';
import 'package:responsi_010/login.dart';
import 'package:responsi_010/models/categories_model.dart';
import 'package:responsi_010/screen/meals_page.dart';
import 'package:responsi_010/services/api_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPage();
}

class _CategoriesPage extends State<CategoriesPage> {
  late String username;
  late SharedPreferences loginData;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  void loadUsername() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username') ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MEAL CATEGORIES',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome, $username',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 205, 68, 0),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.hasData) {
            Category category = Category.fromJson(snapshot.data!);
            return ListView.builder(
                itemCount: category.categories?.length,
                itemBuilder: (BuildContext context, int index) {
                  var categories = category.categories?[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MealsPage(Category: '${categories?.strCategory}'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: const Color.fromARGB(255, 255, 217, 198),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              Image.network(
                                '${categories?.strCategoryThumb}',
                                height: 150,
                                width: 150,
                              ),
                              Text(
                                '${categories?.strCategory}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '${categories?.strCategoryDescription}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.deepOrange[900]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 205, 68, 0),
        onPressed: () {
          loginData.setBool("login", true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
