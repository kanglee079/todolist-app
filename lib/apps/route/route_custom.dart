import 'package:get/get.dart';
import 'package:xikang_todolist/apps/route/route_name.dart';
import 'package:xikang_todolist/manage/bindings/donate_binding.dart';
import 'package:xikang_todolist/pages/donatePage/donate_page.dart';
import 'package:xikang_todolist/pages/favoritePage/favorite_page.dart';
import 'package:xikang_todolist/pages/homePage/addPage/add_page.dart';
import 'package:xikang_todolist/pages/homePage/editPage/edit_page.dart';
import 'package:xikang_todolist/pages/homePage/home_page.dart';
import 'package:xikang_todolist/pages/mainPage/main_page.dart';
import 'package:xikang_todolist/pages/todoDonePage/todo_done_page.dart';

class RouterCustom {
  static List<GetPage> getPage = [
    GetPage(
      name: RouterName.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouterName.todoDonePage,
      page: () => const TodoDonePage(),
    ),
    GetPage(
      name: RouterName.favoritePage,
      page: () => const FavoritePage(),
    ),
    GetPage(
      name: RouterName.donatePage,
      page: () => DonatePage(),
    ),
    GetPage(
      name: RouterName.mainPage,
      page: () => const MainPage(),
      binding: DonateBinding(),
    ),
    GetPage(
      name: RouterName.addTaskPage,
      page: () => const AddTaskPage(),
    ),
    GetPage(
      name: RouterName.editTaskPage,
      page: () => const EditTaskPage(),
    )
  ];
}
