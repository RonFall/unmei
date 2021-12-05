import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final List<ChartData> chartData = [
    ChartData(value: 0, sectorValue: 1, color: Color(0xFF399999)),
    ChartData(value: 0, sectorValue: 2, color: Color(0xFF339933)),
    ChartData(value: 0, sectorValue: 3, color: Color(0xFF993399)),
    ChartData(value: 0, sectorValue: 4, color: Color(0xFF51d4ff)),
    ChartData(value: 0, sectorValue: 5, color: Color(0xFF993333)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: 18, color: Colors.black),
                    SizedBox(width: 4),
                    Text("Назад", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("Профиль", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SvgPicture.asset("assets/icons/user.svg"),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "RonFall",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          "Android dev.",
                          style: TextStyle(fontSize: 18, color: Color(0xFF0073FF)),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("Новеллы", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SfCircularChart(series: <CircularSeries>[
                            // Render pie chart
                            DoughnutSeries<ChartData, double>(
                              dataSource: chartData,
                              pointColorMapper: (ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.value,
                              yValueMapper: (ChartData data, _) => data.sectorValue,
                            )
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              flagIcon("Запланировано: 1", Icons.assistant_photo, 0xFF399999),
                              flagIcon("Пройдено: 2", Icons.check, 0xFF339933),
                              flagIcon("Прохожу: 3", Icons.av_timer, 0xFF993399),
                              flagIcon("Отложено: 4", Icons.ac_unit, 0xFF51d4ff),
                              flagIcon("Брошено: 5", Icons.not_interested, 0xFF993333),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Весь список", style: TextStyle(fontSize: 18, color: Colors.black)),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget flagIcon(String n, IconData icon, int color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Color(color)),
        SizedBox(width: 4),
        Text(n, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }
}

class ChartData {
  final double value;
  final double sectorValue;
  final Color color;

  ChartData({required this.value, required this.sectorValue, required this.color});
}
