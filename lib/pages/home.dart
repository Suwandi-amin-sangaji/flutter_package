import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_faker/models/city.dart';
import 'package:http/http.dart' as http;
import '../models/province.dart';
import '../models/city.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String? idProvinsi;
  var faker = Faker.instance;
  var currentIndex = 0;
  final apiKey =
      "91735c0686aa85cfc7ec3d9a895e3070c8af64539f189ccdd165659fbd551e03";

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(),
          title: Text("${faker.name.fullName()}"),
          subtitle: Text("${faker.phoneNumber.phoneNumber()}"),
        ),
      ),
      Center(
        child: Text("Discovery"),
      ),
      ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            itemAsString: (Province item) => item.name,
            onChanged: (value) => idProvinsi = value?.id,
            asyncItems: (String? filter) async {
              print("Data Provinces");
              print(idProvinsi);
              var response = await http.get(
                Uri.parse(
                    'https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey'),
              );
              if (response.statusCode != 200) {
                return [];
              }
              List allProvinces =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];
              List<Province> allModelProvince = [];

              allProvinces.forEach((element) {
                allModelProvince
                    .add(Province(id: element['id'], name: element['name']));
              });
              return allModelProvince;
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<City>(
            itemAsString: (City item) => item.name,
            onChanged: (value) => print(value?.toJson()),
            asyncItems: (String? filter) async {
              var response = await http.get(
                Uri.parse(
                    'https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProvinsi'),
              );
              if (response.statusCode != 200) {
                return [];
              }
              List allCitys =
                  (json.decode(response.body) as Map<String, dynamic>)["value"];
              List<City> allModelCity = [];

              allCitys.forEach((element) {
                allModelCity.add(City(
                    id: element['id'],
                    idProvinsi: element['id_provinsi'],
                    name: element['name']));
              });
              return allModelCity;
            },
          )
        ],
      ),
      Center(
        child: Text("Message"),
      ),
      Center(
        child: Text("Profile"),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: list[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
