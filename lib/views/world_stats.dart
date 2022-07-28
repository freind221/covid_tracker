import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          PieChart(
            dataMap: const {'Totals': 30, 'Recovered': 15, 'Death': 5},
            animationDuration: const Duration(seconds: 3),
            chartType: ChartType.ring,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: const [Colors.blue, Colors.green, Colors.red],
            legendOptions:
                const LegendOptions(legendPosition: LegendPosition.left),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * .019),
            child: Card(
              child: Column(
                children: const [
                  ReuseableRow(
                    title: 'Total',
                    data: '2000',
                  ),
                  ReuseableRow(
                    title: 'Total',
                    data: '2000',
                  ),
                  ReuseableRow(
                    title: 'Total',
                    data: '2000',
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * .024),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
            child: const Center(
              child: Text(
                'Track Country',
                textScaleFactor: 1.18,
              ),
            ),
          )
        ],
      )),
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
