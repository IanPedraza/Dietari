import 'package:dietari/data/domain/Tip.dart';

abstract class TipsDataSource {
  Future<Tip?> getTip(tipId);
}
