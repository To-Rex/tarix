import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../resource/app_colors.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  void _onItemTapped(int index) {
    _getController.changeIndex(index);
  }

  BottomNavigationBarItem _buildItem(int index, IconData icon, String label) { return BottomNavigationBarItem( icon: Column(children: [ _getController.index.value == index ? Container( margin: const EdgeInsets.only(bottom: 4), height: 2, width: 60, color: Colors.blue) : Container(), Icon(icon, color: _getController.index.value == index ? Colors.blue : Colors.grey) ]), label: label); }

  @override
  Widget build(BuildContext context) {
    _getController.changeWidgetOptions();
    return Scaffold(
      backgroundColor: AppColors.grey6,
        drawerEnableOpenDragGesture: false,
        body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if(_getController.index.value == 0) {
                exit(0);
              } else {
                _getController.changeIndex(0);
              }
            },
            child: Obx(() => IndexedStack(index: _getController.index.value, children: _getController.widgetOptions))
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          backgroundColor: AppColors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  _buildItem(0, _getController.index.value == 0 ? FluentIcons.home_24_filled : FluentIcons.home_24_regular, 'Fanlar'.tr),
                  _buildItem(1, _getController.index.value == 1 ? FluentIcons.settings_24_filled : FluentIcons.settings_24_regular, 'Sozlamalar'.tr),
                ],
                currentIndex: _getController.index.value,
                selectedItemColor: Colors.blue,
                onTap: _onItemTapped)
        )
    );
  }
}