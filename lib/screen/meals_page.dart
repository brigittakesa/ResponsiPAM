import 'package:flutter/material.dart';
import 'package:responsi_010/screen/detail_page.dart';
import 'package:responsi_010/services/api_data_source.dart';
import 'package:responsi_010/models/meals_model.dart';

class MealsPage extends StatefulWidget {
  final String Category;
  const MealsPage({super.key, required this.Category});

  @override
  State<MealsPage> createState() => _MealsPage();
}

class _MealsPage extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '${widget.Category.toUpperCase()} MEALS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 205, 68, 0),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.Category),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.hasData) {
            Meal meal = Meal.fromJson(snapshot.data!);
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 0.95),
                itemCount: meal.meals?.length,
                itemBuilder: (context, int index) {
                  final Meals? meals = meal.meals?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(idMeals: '${meals?.idMeal}')));
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 255, 217, 198),
                      child: SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.network(
                                '${meals?.strMealThumb}',
                                height: 120,
                                width: 120,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${meals?.strMeal}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          );
        },
      ),
    );
  }
}
