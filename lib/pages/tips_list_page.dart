import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/TipComponent.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class TipsListPage extends StatefulWidget {
  TipsListPage({Key? key}) : super(key: key);

  @override
  _TipsListPageState createState() => _TipsListPageState();
}

class _TipsListPageState extends State<TipsListPage> {
  final _getUserTipsUseCase = Injector.appInstance.get<GetUserTipsUseCase>();
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();

  List<Tip> _tips = [];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _fetchTips();
    });

    super.initState();
  }

  Future<void> _fetchTips() async {
    setState(() {
      _tips = [];
    });

    final userId = _getUserIdUseCase.invoke();

    List<Tip> tips =
        userId != null ? await _getUserTipsUseCase.invoke(userId) : [];

    setState(() {
      _tips = tips;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
        textAppBar: tips_list,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: RefreshIndicator(
        onRefresh: _fetchTips,
        child: ListView.builder(
          itemCount: _tips.length,
          itemBuilder: (contex, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: TipComponent(
                tip: _tips[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
