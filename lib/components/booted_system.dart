import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../api/weather_repository.dart';
import '../database/models/fridge.dart';
import '../database/mongo_data_repository.dart';
import '../database/mongo_database.dart';
import '../helper/helper.dart';
import '../helper/timeago_message.dart';
import '../styling/styles.dart';
import 'add_item.dart';

class BootedSystem extends StatefulWidget {
  const BootedSystem({super.key});

  @override
  State<BootedSystem> createState() => _BootedSystemState();
}

class _BootedSystemState extends State<BootedSystem> {
  void openModal() async {
    Product? product = await WoltModalSheet.show<Product?>(
      showDragHandle: true,
      enableDrag: true,
      pageIndexNotifier: WoltSheet().pageIndexNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          WoltSheet().scanBarcode(modalSheetContext, textTheme),
          WoltSheet().addItemPage(modalSheetContext, textTheme),
        ];
      },
      modalTypeBuilder: (context) {
        return WoltModalType.bottomSheet;
      },
      minPageHeight: 0.0,
      maxPageHeight: 1,
    );
    if (product != null) {
      try {
        MongoDatabase().saveProductToDatabase(product!);
      } catch (e) {
        print("Error: $e");
      }
    }
    WoltSheet().pageIndexNotifier.value = 0;
    setState(() {});
  }

  @override
  void initState() {
    timeago.setLocaleMessages('customDE', MyCustomDEMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData = FeatherIcons.sun;
    switch (WeatherRepository.weatherData!.weatherStatus) {
      case WeatherStatus.Normal:
        iconData = FeatherIcons.cloud;
        break;
      case WeatherStatus.Snowfall:
        iconData = FeatherIcons.cloudSnow;
        break;
      case WeatherStatus.Rain:
        iconData = FeatherIcons.cloudRain;
        break;
      case WeatherStatus.Showers:
        iconData = FeatherIcons.cloudDrizzle;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("HH:mm").format(DateTime.now()),
                    style:
                        Styles.medium(50, color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    DateFormat("EEEE, DD MMMM", "de_DE").format(DateTime.now()),
                    style:
                        Styles.medium(23, color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${WeatherRepository.weatherData!.temperatur}°",
                  style:
                      Styles.medium(40, color: Colors.white.withOpacity(0.8)),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Icon(
                  iconData,
                  color: Colors.white.withOpacity(0.8),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50.h,
        ),
        SizedBox(
          height: 150.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: Icon(
                              FeatherIcons.box,
                              size: 8,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Produkte",
                            style: Styles.semiBold(22,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${MongoDataRepository().allProducts.length}",
                            style: Styles.medium(45,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: Icon(
                              FeatherIcons.clock,
                              size: 8,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Abgelaufen",
                            style: Styles.semiBold(22,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${MongoDataRepository().expiredProducts.length}",
                            style: Styles.medium(45,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Text(
          "Produktliste",
          style: Styles.bold(25, color: Colors.white.withOpacity(0.8)),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  MongoDataRepository().allSortedProducts().length,
                  (index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            MongoDataRepository()
                                .allSortedProducts()[index]
                                .productName,
                            style: Styles.semiBold(22,
                                color: getExpireColor(MongoDataRepository()
                                    .allSortedProducts()[index]
                                    .expiresIn)),
                          ),
                          Text(
                            timeago.format(
                                MongoDataRepository()
                                    .allSortedProducts()[index]
                                    .expiresIn,
                                locale: "customDE",
                                allowFromNow: true),
                            style: Styles.semiBold(22,
                                color: getExpireColor(MongoDataRepository()
                                    .allSortedProducts()[index]
                                    .expiresIn)),
                          ),
                        ],
                      )),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await MongoDatabase().deleteExpiredProducts();
                  setState(() {});
                },
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Icon(
                      FeatherIcons.minus,
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => openModal(),
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Icon(
                      FeatherIcons.plusCircle,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
