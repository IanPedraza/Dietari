import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/repositories/TipsRepository.dart';

class GetTipsUseCase {
  TipsRepository tipsRepository;

  GetTipsUseCase({required this.tipsRepository});

  Future<Tip?> invoke(tipId) {
    return tipsRepository.getTip(tipId);
  }
}
