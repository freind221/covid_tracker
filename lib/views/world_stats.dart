import 'package:covid_tracker_app/models/world_states.dart';
import 'package:covid_tracker_app/services/remote_services.dart';
import 'package:covid_tracker_app/views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3));

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RemoteService remoteService = RemoteService();
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: remoteService.fetchWorldStats(),
              builder: (context, AsyncSnapshot<WorldStates> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: animationController,
                      ));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        PieChart(
                          dataMap: {
                            'Totals':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Death':
                                double.parse(snapshot.data!.deaths!.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          animationDuration: const Duration(seconds: 3),
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: const [
                            Colors.blue,
                            Colors.green,
                            Colors.red
                          ],
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * .019),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                  title: 'Total',
                                  data: snapshot.data!.cases.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Total Recovered',
                                  data: snapshot.data!.recovered.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Total Deaths',
                                  data: snapshot.data!.deaths.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Active Cases',
                                  data: snapshot.data!.active.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Criticle',
                                  data: snapshot.data!.critical.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today Recovered',
                                  data:
                                      snapshot.data!.todayRecovered.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today Deaths',
                                  data: snapshot.data!.todayDeaths.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.height * .024),
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green),
                            child: const Center(
                              child: Text(
                                'Track Country',
                                textScaleFactor: 1.18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, data;
  const ReuseableRow({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(data)],
          )
        ],
      ),
    );
  }
}
