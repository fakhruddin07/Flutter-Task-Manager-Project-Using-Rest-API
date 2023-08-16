import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/summery_count_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SummaryCountController extends GetxController {
  bool _getCountSummaryInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  String message = "";

  bool get getCountSummaryInProgress => _getCountSummaryInProgress;
  SummaryCountModel get summaryCountModel => _summaryCountModel;

  Future<bool> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);

    _getCountSummaryInProgress = false;
    update();

    if (response.statusCode == 200) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      return true;
    } else {
      return false;
    }
  }
}
