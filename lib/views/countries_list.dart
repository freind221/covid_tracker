// import 'package:covid_tracker_app/services/remote_services.dart';
// import 'package:covid_tracker_app/views/details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class CountriesList extends StatefulWidget {
//   const CountriesList({Key? key}) : super(key: key);

//   @override
//   State<CountriesList> createState() => _CountriesListState();
// }

// class _CountriesListState extends State<CountriesList> {
//   TextEditingController textEditingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     RemoteService remoteService = RemoteService();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               onChanged: (value) {
//                 setState(() {});
//               },
//               controller: textEditingController,
//               decoration: InputDecoration(
//                   hintText: 'Search City',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10))),
//             ),
//           ),
//           FutureBuilder(
//               future: remoteService.fetchCountryStats(),
//               builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Expanded(
//                       flex: 1,
//                       child: SpinKitFadingCircle(
//                         color: Colors.white,
//                       ));
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: ((context, index) {
//                           String name = snapshot.data![index]['country'];
//                           if (textEditingController.text.isEmpty) {
//                             return Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => DetailPage(
//                                                 name: snapshot.data![index]
//                                                     ['country'],
//                                                 image: snapshot.data![index]
//                                                     ['countryInfo']['flag'],
//                                                 active: snapshot.data![index]
//                                                     ['active'],
//                                                 criticle: snapshot.data![index]
//                                                     ['critical'],
//                                                 test: snapshot.data![index]
//                                                     ['tests'],
//                                                 todayRecovered: snapshot.data![index]
//                                                     ['todayRecovered'],
//                                                 totalCase: snapshot.data![index]
//                                                     ['cases'],
//                                                 totalDeath: snapshot.data![index]
//                                                     ['deaths'],
//                                                 totalRecovered: snapshot.data![index]
//                                                     ['recovered'])));
//                                   },
//                                   child: ListTile(
//                                     leading: Image(
//                                       height: 50,
//                                       width: 50,
//                                       image: NetworkImage(snapshot.data![index]
//                                           ['countryInfo']['flag']),
//                                     ),
//                                     title:
//                                         Text(snapshot.data![index]['country']),
//                                     subtitle: Text(snapshot.data![index]
//                                             ['cases']
//                                         .toString()),
//                                   ),
//                                 )
//                               ],
//                             );
//                           } else if (name.toLowerCase().contains(
//                               textEditingController.text.toLowerCase())) {
//                             return Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => DetailPage(
//                                                 name: snapshot.data![index]
//                                                     ['country'],
//                                                 image: snapshot.data![index]
//                                                     ['countryInfo']['flag'],
//                                                 active: snapshot.data![index]
//                                                     ['active'],
//                                                 criticle: snapshot.data![index]
//                                                     ['critical'],
//                                                 test: snapshot.data![index]
//                                                     ['tests'],
//                                                 todayRecovered: snapshot.data![index]
//                                                     ['todayRecovered'],
//                                                 totalCase: snapshot.data![index]
//                                                     ['cases'],
//                                                 totalDeath: snapshot.data![index]
//                                                     ['deaths'],
//                                                 totalRecovered: snapshot.data![index]
//                                                     ['recovered'])));
//                                   },
//                                   child: ListTile(
//                                     leading: Image(
//                                       height: 50,
//                                       width: 50,
//                                       image: NetworkImage(snapshot.data![index]
//                                           ['countryInfo']['flag']),
//                                     ),
//                                     title:
//                                         Text(snapshot.data![index]['country']),
//                                     subtitle: Text(snapshot.data![index]
//                                             ['cases']
//                                         .toString()),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } else {
//                             return Container();
//                           }
//                         })),
//                   );
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }

import 'package:covid_tracker_app/services/remote_services.dart';
import 'package:covid_tracker_app/views/details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  _CountriesListScreenState createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RemoteService newsListViewModel = RemoteService();
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
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            searchController.text = "";
                            setState(() {});
                          },
                          child: const Icon(Icons.clear)),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: newsListViewModel.fetchCountryStats(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCase: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeath: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    criticle:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                  )));
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
                                      subtitle: Text(
                                          "Effected: ${snapshot.data![index]['cases']}"),
                                    ),
                                  ),
                                  const Divider()
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
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
                                    subtitle: Text(
                                        "Effected: ${snapshot.data![index]['cases']}"),
                                  ),
                                  const Divider()
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
