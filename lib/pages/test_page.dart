import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/TestItemCard.dart';
import 'package:dietari/utils/colors.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        onPressed: () {},
        textAppBar: test_list,
      ),
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 15, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 15, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 30, right: 20),
            child: TestItemCard(
              onPressed: () {},
              textTestItem: button_item_test,
              check: true,
            ),
          ),
        ],
      ),
    );
  }
}
