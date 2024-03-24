import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:toastification/toastification.dart';
import 'package:xikang_todolist/pages/donatePage/donate_page.dart';
import 'package:xikang_todolist/pages/favoritePage/favorite_page.dart';
import 'package:xikang_todolist/pages/homePage/home_page.dart';
import 'package:xikang_todolist/pages/todoDonePage/todo_done_page.dart';

import '../../apps/config/const.dart';
import '../../manage/controller/task_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TaskController taskController = Get.put(TaskController());

  void showToastificationError(String message) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      title: const Text('Deleted'),
      description: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      // Các cài đặt khác của toastification
    );
  }

  Widget _getCurrentPage() {
    switch (_controller.selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const TodoDonePage();
      case 2:
        return const FavoritePage();
      case 3:
        return DonatePage();
      default:
        return const HomePage();
    }
  }

  Widget _getCurrentPageAppBar() {
    switch (_controller.selectedIndex) {
      case 0:
        return Row(
          children: [
            const Expanded(
              child: Text(
                "Home Page",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () => taskController.transToAddPage(),
              child: Container(
                width: 110,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 3),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 3),
                  ],
                ),
              ),
            ),
          ],
        );
      case 1:
        return Row(
          children: [
            const Expanded(
              child: Text(
                "Task Done",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                taskController.deleteAllDoneTasks();
                showToastificationError("Deleted All !");
              },
              child: Container(
                width: 110,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 3),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "Delete All",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 3),
                  ],
                ),
              ),
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            const Expanded(
              child: Text(
                "Favorite Task",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                taskController.deleteAllFavoriteTasks();
                showToastificationError("Deleted All !");
              },
              child: Container(
                width: 110,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 3),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "Delete All",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(width: 3),
                  ],
                ),
              ),
            ),
          ],
        );
      case 3:
        return const Text(
          "Donate Page",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        );
      default:
        return const Text("Page");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle:
              TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 24),
          selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 26),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
        footerDivider: divider,
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              _scaffoldKey.currentState?.closeDrawer();
            },
          ),
          SidebarXItem(
            icon: Icons.done,
            label: 'Done',
            onTap: () {
              _scaffoldKey.currentState?.closeDrawer();
            },
          ),
          SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorites',
            onTap: () {
              _scaffoldKey.currentState?.closeDrawer();
            },
          ),
          SidebarXItem(
            icon: Icons.coffee,
            label: 'Donate us',
            onTap: () {
              _scaffoldKey.currentState?.closeDrawer();
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => _getCurrentPageAppBar(),
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => _getCurrentPage(),
      ),
    );
  }
}
