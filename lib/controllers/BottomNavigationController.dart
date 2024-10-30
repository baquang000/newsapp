import 'package:get/get.dart';
import 'package:newsapp/views/Artical/artical_view.dart';
import 'package:newsapp/views/home/Home_View.dart';
import 'package:newsapp/views/profile/profile_view.dart';

class BottomNavController extends GetxController {
  RxInt index = 0.obs;

  var view = [ const HomeView(),  const ArticalView(),  const ProfileView()];
}
