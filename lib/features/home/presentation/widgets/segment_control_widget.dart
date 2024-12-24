import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SegmentControlWidget extends StatefulWidget {
  const SegmentControlWidget({Key? key}) : super(key: key);

  @override
  _SegmentControlWidgetState createState() => _SegmentControlWidgetState();
}

class _SegmentControlWidgetState extends State<SegmentControlWidget> {
  int selectedSegment = 1; // Track selected segment index
  int selectedTab = 0; // Track selected tab for sub-segments

  // Dummy data for pie chart and tab content
  final chartData = {
    1: {
      0: [
        PieChartSectionData(
          value: 25,
          title: '25%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.receipt_long, Colors.green),
          badgePositionPercentageOffset: 1.2,
        ),
        PieChartSectionData(
          value: 25,
          title: '25%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.restaurant, Colors.orange),
          badgePositionPercentageOffset: 1.2,
        ),
        PieChartSectionData(
          value: 50,
          title: '50%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.cyan, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.receipt_long, Colors.green),
          badgePositionPercentageOffset: 1.2,
        ),
      ],
      1: [
        PieChartSectionData(
          value: 46,
          title: '46%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.shopping_cart, Colors.blue),
          badgePositionPercentageOffset: 1.2,
        ),
        PieChartSectionData(
          value: 54,
          title: '54%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.attach_money, Colors.green),
          badgePositionPercentageOffset: 1.2,
        ),
      ],
    },
    2: {
      0: [
        PieChartSectionData(
          value: 70,
          title: '70%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.home, Colors.blue),
          badgePositionPercentageOffset: 1.2,
        ),
        PieChartSectionData(
          value: 30,
          title: '30%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.yellow, Colors.amber],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.savings, Colors.yellow),
          badgePositionPercentageOffset: 1.2,
        ),
      ],
      1: [
        PieChartSectionData(
          value: 50,
          title: '50%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.auto_graph, Colors.red),
          badgePositionPercentageOffset: 1.2,
        ),
        PieChartSectionData(
          value: 50,
          title: '50%',
          radius: 80,
          titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          badgeWidget: _buildBadge(Icons.wallet, Colors.blue),
          badgePositionPercentageOffset: 1.2,
        ),
      ],
    },
  };
  final tabContentData = {
    1: {
      0: [
        {'icon': Icons.receipt_long, 'label': 'Hóa đơn', 'amount': '902.653đ'},
        {'icon': Icons.restaurant, 'label': 'Ăn uống', 'amount': '528.500đ'},
        {
          'icon': Icons.shopping_cart,
          'label': 'Chợ, siêu thị',
          'amount': '238.900đ'
        },
      ],
      1: [
        {'icon': Icons.home, 'label': 'Chi phí cố định', 'amount': '902.653đ'},
        {
          'icon': Icons.shopping_bag,
          'label': 'Chi tiêu - sinh hoạt',
          'amount': '767.400đ'
        },
      ],
    },
    2: {
      0: [
        {'icon': Icons.wallet, 'label': 'Thu nhập', 'amount': '1.200.000đ'},
        {'icon': Icons.attach_money, 'label': 'Lãi suất', 'amount': '300.000đ'},
      ],
      1: [
        {'icon': Icons.auto_graph, 'label': 'Đầu tư', 'amount': '500.000đ'},
        {'icon': Icons.savings, 'label': 'Tiết kiệm', 'amount': '800.000đ'},
      ],
    },
  };

  static Widget _buildBadge(IconData icon, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 16,
      ),
    );
  }

  Widget _buildPieChart() {
    final sections = chartData[selectedSegment]?[selectedTab] ?? [];
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    final items = tabContentData[selectedSegment]?[selectedTab] ?? [];

    return Column(
      children: items.map((item) {
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'] as IconData,
              color: Colors.orange,
            ),
          ),
          title: Text(item['label'] as String),
          trailing: Text(
            item['amount'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            print('Tapped on ${item['label']}');
          },
        );
      }).toList(),
    );
  }

  Widget _buildTabSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = 0;
            });
          },
          child: Column(
            children: [
              Text(
                'Danh mục con',
                style: TextStyle(
                  color: selectedTab == 0 ? Colors.pink : Colors.grey,
                  fontWeight:
                      selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (selectedTab == 0)
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.pink,
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = 1;
            });
          },
          child: Column(
            children: [
              Text(
                'Danh mục cha',
                style: TextStyle(
                  color: selectedTab == 1 ? Colors.pink : Colors.grey,
                  fontWeight:
                      selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (selectedTab == 1)
                Container(
                  height: 2,
                  width: 40,
                  color: Colors.pink,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSlidingSegmentedControl<int>(
          fromMax: true,
          innerPadding: const EdgeInsets.all(4),
          children: const {
            1: Text(
              'Income',
              textAlign: TextAlign.center,
            ),
            2: Text(
              'Expenses',
              textAlign: TextAlign.center,
            ),
          },
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          thumbDecoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          onValueChanged: (int value) {
            setState(() {
              selectedSegment = value;
              selectedTab = 0; // Reset to first tab
            });
          },
        ),
        const SizedBox(height: 60),
        _buildPieChart(),
        const SizedBox(height: 60),
        _buildTabSwitcher(),
        const SizedBox(height: 32),
        _buildTabContent(),
      ],
    );
  }
}
