import 'package:get/get.dart';
import 'package:lifeapp/core/network/Response.dart';
import 'package:lifeapp/pages/costs/tag/tag_cost_items/tag_cost_items_response.dart';
import 'package:lifeapp/pages/costs/tag/tag_service.dart';

import '../../category/time_picker.dart';

class TagCostItemsController extends GetxController {
  final TagService tagService = TagService();
  RxBool loading = false.obs;
  Rxn<TagCostItemsResponse> tagCostItemsResponse = Rxn();
  RxInt page = 0.obs;
  DatePickerController _datePickerController = Get.put(DatePickerController());

  void getTagCostItems(int tagId) async {
    if (page.value == 0) {
      loading.value = true;
    }
    CustomResponse customResponse = await tagService.getTagCostItems(
        tagId,
        tagCostItemsResponse.value == null
            ? null
            : tagCostItemsResponse.value!.nextPageUrl,
        _datePickerController.fromDate.value,
        _datePickerController.toDate.value);
    loading.value = false;

    if (customResponse.status == Status.COMPLETED) {
      if (page.value == 0) {
        tagCostItemsResponse.value = customResponse.data;
        tagCostItemsResponse.value!.items!.sort((a, b) {
          return b.itemSum!.compareTo(a.itemSum!);
        });
      } else {
        TagCostItemsResponse nextPageData = customResponse.data;
        tagCostItemsResponse.value!.items = [
          ...tagCostItemsResponse.value!.items!,
          ...nextPageData.items!
        ];
        tagCostItemsResponse.value!.nextPageUrl = nextPageData.nextPageUrl;
        tagCostItemsResponse.refresh();
      }
    }
  }
}
