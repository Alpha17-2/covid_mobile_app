import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_covid_app/models/covid_countries.dart';
import 'package:flutter_covid_app/widgets/app_header.dart';
import 'package:http/http.dart' as http;

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<Country> countryList = [];

  Future getCountries() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          countryList.add(Country.fromJson(i));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(image: 'assets/vector/doctor-team.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 1.1,
              child: ListView.builder(
                  itemCount: countryList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ]),
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: Text(countryList[index].country),
                        leading: SizedBox(
                          width: 120.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Hero(
                              tag: 'HeroCountryFlag',
                              child: Image.network(
                                countryList[index].countryInfo.flag,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0.0,
                                    backgroundColor: Colors.transparent,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1,
                                          padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 100,
                                            right: 20.0,
                                            bottom: 20.0,
                                          ),
                                          margin:
                                              const EdgeInsets.only(top: 50.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  offset: const Offset(0, 3),
                                                  blurRadius: 5.0,
                                                )
                                              ]),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: 'Country: ',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: countryList[index]
                                                            .country,
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: 'Total cases: ',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: countryList[index]
                                                            .cases
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: 'Total deaths: ',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: countryList[index]
                                                            .deaths
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: 'Today cases: ',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: countryList[index]
                                                            .todayCases
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                      const TextSpan(
                                                        text: 'Recovered: ',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: countryList[index]
                                                            .recovered
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ]),
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                          child: CircleAvatar(
                                            radius: 45,
                                            backgroundColor: Colors.transparent,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                child: Hero(
                                                  tag: 'HeroCountryFlag',
                                                  child: Image.network(
                                                    countryList[index]
                                                        .countryInfo
                                                        .flag,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
