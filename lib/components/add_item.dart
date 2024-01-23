import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fridge/database/models/fridge.dart';
import 'package:fridge/styling/styles.dart';
import 'package:realm/realm.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class WoltSheet {
  static final WoltSheet _instance = WoltSheet._internal();
  factory WoltSheet() => _instance;

  WoltSheet._internal();

  /// Benötigt für den Wolt-Sheet, um die Seiten zu wechseln
  final pageIndexNotifier = ValueNotifier(0);
  final double _padding = 10;

  /// Simulieren eines Barcode-Scans
  SliverWoltModalSheetPage scanBarcode(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage(
      enableDrag: true,
      hasSabGradient: false,
      topBarTitle: Text('Barcode scannen', style: Styles.semiBold(40)),
      isTopBarLayerAlwaysVisible: true,
      trailingNavBarWidget: IconButton(
        padding: EdgeInsets.all(_padding),
        icon: const Icon(FeatherIcons.x),
        onPressed: Navigator.of(modalSheetContext).pop,
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            70.w,
            50.h,
            70.w,
            20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Scanne den Barcode",
                style: Styles.semiBold(40),
              )),
              SizedBox(
                height: 20.h,
              ),
              const Center(
                child: Icon(
                  CupertinoIcons.barcode,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () =>
                    pageIndexNotifier.value = pageIndexNotifier.value + 1,
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      "Scannen",
                      style: Styles.semiBold(35, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  /// Konfigurieren eines neuen Produkts
  SliverWoltModalSheetPage addItemPage(
      BuildContext modalSheetContext, TextTheme textTheme) {
    TextEditingController productNameTextController = TextEditingController();

    /// Initial Datetime
    DateTime expireDate = DateTime.now().add(const Duration(days: 7));

    return WoltModalSheetPage(
      enableDrag: true,
      hasSabGradient: false,
      topBarTitle: Text('Produkt hinzufügen', style: Styles.semiBold(40)),
      isTopBarLayerAlwaysVisible: true,
      trailingNavBarWidget: IconButton(
        padding: EdgeInsets.all(_padding),
        icon: const Icon(FeatherIcons.x),
        onPressed: Navigator.of(modalSheetContext).pop,
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            70.w,
            50.h,
            70.w,
            20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Produktname",
                style: Styles.semiBold(40),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2)),
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: TextField(
                  controller: productNameTextController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: Styles.medium(35),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Ablaufdatum",
                style: Styles.semiBold(40),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 400.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  minimumYear: DateTime.now().year,
                  onDateTimeChanged: (date) {
                    expireDate = date;
                  },
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.of(modalSheetContext).pop(Product(
                    ObjectId(),
                    productNameTextController.text,
                    "1234",
                    expireDate)),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      "Hinzufügen",
                      style: Styles.semiBold(35, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
