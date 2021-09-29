import 'package:dietari/components/AppBarComponent.dart';
import 'package:dietari/components/TipComponent.dart';
import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/framework/firebase/FirebaseAuthDataSource.dart';
import 'package:dietari/data/framework/firebase/FirebaseUserDataSouce.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';
import 'package:dietari/data/repositories/UserRepository.dart';
import 'package:dietari/data/usecases/GetUserIdUseCase.dart';
import 'package:dietari/data/usecases/GetUserTipsUseCase.dart';
import 'package:dietari/utils/strings.dart';
import 'package:flutter/material.dart';

class TipsListPage extends StatefulWidget {
  TipsListPage({Key? key}) : super(key: key);

  @override
  _TipsListPageState createState() => _TipsListPageState();
}

class _TipsListPageState extends State<TipsListPage> {
  late AuthDataSource _authDataSource;
  late AuthRepository _authRepository;
  late GetUserIdUseCase _getUserIdUseCase;

  late UserRepository _userRepository;
  late GetUserTipsUseCase _getUserTipsUseCase;
  late UserDataSource _userDataSource;

  List<Tip> _tips = [];

  @override
  void initState() {
    _authDataSource = FirebaseAuthDataSource();
    _authRepository = AuthRepository(authDataSource: _authDataSource);
    _getUserIdUseCase = GetUserIdUseCase(authRepository: _authRepository);

    _userDataSource = FirebaseUserDataSouce();
    _userRepository = UserRepository(userDataSource: _userDataSource);
    _getUserTipsUseCase = GetUserTipsUseCase(userRepository: _userRepository);

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
