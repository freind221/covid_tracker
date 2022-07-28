import 'package:covid_tracker_app/services/remote_services.dart';
import 'package:covid_tracker_app/views/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RemoteService remoteService = RemoteService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: 'Search City',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            FutureBuilder(
                future: remoteService.fetchCountryStats(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        
                      ));;
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            String name = snapshot.data![index]['country'];
                            if (textEditingController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  name: snapshot.data![index]
                                                      ['country'],
                                                  image: snapshot.data![index]
                                                      ['countryInfo']['flag'],
                                                  active: snapshot.data![index]
                                                      ['active'],
                                                  criticle: snapshot.data![index]
                                                      ['critical'],
                                                  test: snapshot.data![index]
                                                      ['tests'],
                                                  todayRecovered:
                                                      snapshot.data![index]
                                                          ['todayRecovered'],
                                                  totalCase: snapshot.data![index]
                                                      ['cases'],
                                                  totalDeath: snapshot.data![index]
                                                      ['deaths'],
                                                  totalRecovered: snapshot.data![index]['recovered'])));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                textEditingController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          })),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
