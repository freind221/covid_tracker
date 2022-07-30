import 'package:covid_tracker_app/services/utitiles/widgets.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String image;
  final int totalCase,
      totalRecovered,
      totalDeath,
      active,
      test,
      criticle,
      todayRecovered;
  const DetailPage(
      {Key? key,
      required this.name,
      required this.image,
      required this.active,
      required this.criticle,
      required this.test,
      required this.todayRecovered,
      required this.totalCase,
      required this.totalDeath,
      required this.totalRecovered})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.067),
                child: Card(
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.067,
                    ),
                    ReuseableRow(
                        title: 'Total cases',
                        data: widget.totalCase.toString()),
                    ReuseableRow(
                        title: 'Active cases', data: widget.active.toString()),
                    ReuseableRow(
                        title: 'Criticle ', data: widget.criticle.toString()),
                    ReuseableRow(
                        title: 'Today Recovered',
                        data: widget.todayRecovered.toString()),
                    ReuseableRow(
                        title: 'Total Recovered',
                        data: widget.totalRecovered.toString()),
                    ReuseableRow(
                        title: 'Total Deaths',
                        data: widget.totalDeath.toString()),
                    ReuseableRow(
                        title: 'Total Tests', data: widget.test.toString()),
                  ]),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
