import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'config.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  bool loading = true;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(Config.graphData));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          loading = false;
        });
      } else {
        showError('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error: $e');
    }
  }

  void showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: Color(0xFFC5EDFE),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (data == null || data!['videoScores'] == null) {
      return Scaffold(
        backgroundColor: Color(0xFFC5EDFE),
        body: Center(child: Text('No data available')),
      );
    }

    final videoScores = data!['videoScores'] as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Color(0xFFC5EDFE),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80), // Space below the back button
                _buildTitle(),
                SizedBox(height: 20),
                _buildChart(videoScores),
                if (data!['bestVideoTitles'] != null && data!['bestVideoTitles'].isNotEmpty)
                  _buildBestVideos(data!['bestVideoTitles']),
              ],
            ),
          ),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, {double iconSize = 14.0}) {
    return Positioned(
      top: 45,
      left: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: IconButton(
          icon: Image.asset('assets/backarrow.png'),
          iconSize: iconSize,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: _boxDecoration(),
      child: Text(
        'Best Video Performance',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChart(Map<String, dynamic> videoScores) {
    final chartData = videoScores.values.map((e) {
      final value = double.tryParse(e.toString());
      return value != null && value.isFinite ? value : 0.0;
    }).toList();

    final labels = videoScores.keys.toList();

    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  final label = labels[value.toInt()];
                  return Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: chartData
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.orange,
              barWidth: 4,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestVideos(List<dynamic> bestVideoTitles) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: _boxDecoration(color: Color(0xFFE0F7FA)),
      child: Text(
        'Best Performing Video(s): ${bestVideoTitles.join(', ')}',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration _boxDecoration({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
