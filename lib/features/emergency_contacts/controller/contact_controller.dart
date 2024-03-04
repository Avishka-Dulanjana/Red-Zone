import 'package:get/get.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';
import 'package:red_zone/utils/constants/loaders.dart';

import '../../../data/repositories/contact/contact_repository.dart';

class ContactController extends GetxController {
  static ContactController get instance => Get.find();

  final isLoading = false.obs;
  final contactRepository = Get.put(ContactRepository());

  RxList<ContactModel> contactList = <ContactModel>[].obs;

  @override
  void onInit() {
    fetchContactList();
    super.onInit();
  }

  void fetchContactList() async {
    try {
      // Start Loading
      isLoading.value = true;

      final contacts = await contactRepository.getContactDetails();

      contactList.assignAll(contacts);

      print('Contact List:$contacts');

      // Show success message
      TLoaders.successSnackBar(title: 'Success', message: 'Contact data fetched successfully');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong! Please try again!(controller)');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ContactModel>> getContactDetails(String emergencyServiceCategory) async {
    try {
      final contacts = await contactRepository.getContactsForCategory(emergencyServiceCategory);
      return contacts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong! Please try again!(controller)');
      return [];
    }
  }
}
