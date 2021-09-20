import 'package:dietari/data/datasources/TipsDataSource.dart';
import 'package:dietari/data/domain/Tip.dart';

class TipsRepository {
  TipsDataSource tipsDataSource;

  TipsRepository({required this.tipsDataSource});

  Future<Tip?> getTip(tipId) {
    return tipsDataSource.getTip(tipId);
  }
}
