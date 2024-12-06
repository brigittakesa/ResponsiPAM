import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsi_010/models/detail_meals.dart';
import 'package:responsi_010/services/api_data_source.dart';

class DetailPage extends StatefulWidget {
  final String idMeals;
  const DetailPage({super.key, required this.idMeals});

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'MEALS DETAIL',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 205, 68, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: ApiDataSource.instance.loadDetail(widget.idMeals),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR'),
              );
            }
            if (snapshot.hasData) {
              Detail detail = Detail.fromJson(snapshot.data!);
              return ListView.builder(
                itemCount: detail.meals?.length,
                itemBuilder: (BuildContext context, int index) {
                  var details = detail.meals?[index];
                  return Column(
                    children: [
                      Image.network(
                        '${details?.strMealThumb}',
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${details?.strMeal}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Category: ${details?.strCategory}',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            'Area: ${details?.strArea}',
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('${details?.strIngredient1}'),
                              Text('${details?.strIngredient2}'),
                              Text('${details?.strIngredient3}'),
                              Text('${details?.strIngredient4}'),
                              Text('${details?.strIngredient5}'),
                              Text('${details?.strIngredient6}'),
                              Text('${details?.strIngredient7}'),
                              Text('${details?.strIngredient8}'),
                              Text('${details?.strIngredient9}'),
                              Text('${details?.strIngredient10}'),
                              Text('${details?.strIngredient11}'),
                              Text('${details?.strIngredient12}'),
                              Text('${details?.strIngredient13}'),
                              Text('${details?.strIngredient14}'),
                              Text('${details?.strIngredient15}'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Measure',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('${details?.strMeasure1}'),
                              Text('${details?.strMeasure2}'),
                              Text('${details?.strMeasure3}'),
                              Text('${details?.strMeasure4}'),
                              Text('${details?.strMeasure5}'),
                              Text('${details?.strMeasure6}'),
                              Text('${details?.strMeasure7}'),
                              Text('${details?.strMeasure8}'),
                              Text('${details?.strMeasure9}'),
                              Text('${details?.strMeasure10}'),
                              Text('${details?.strMeasure11}'),
                              Text('${details?.strMeasure12}'),
                              Text('${details?.strMeasure13}'),
                              Text('${details?.strMeasure14}'),
                              Text('${details?.strMeasure15}'),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instructions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          Text('${details?.strInstructions}')
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.brown[900],
                        ),
                        onPressed: () {
                          _launchURL(details?.strYoutube ?? '');
                        },
                        child: Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(" Watch Tutorial",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.brown[900]),
            );
          },
        ),
      ),
    );
  }

  Future<void> launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {}
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
