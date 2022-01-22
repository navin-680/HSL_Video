import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsl_videoplayer/controller/home_controller.dart';
import 'package:hsl_videoplayer/video_widget.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Obx(
              () => _homeController.jsonResult.isNotEmpty
              ? InViewNotifierList(
              scrollDirection: Axis.vertical,
              initialInViewIds: ['0', '59'],
              onListEndReached: () {
                Get.snackbar("Alert", "test");
              },
              isInViewPortCondition: (double deltaTop, double deltaBottom,
                  double viewPortDimension) {
                return deltaTop < (0.7 * viewPortDimension) &&
                    deltaBottom > (0.3 * viewPortDimension);
              },
              itemCount: _homeController.jsonResult.length,
              builder: (BuildContext context, int index) {
                return Column(children: [
                  Container(
                    width: double.infinity,
                    height: 300.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 14.0),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return InViewNotifierWidget(
                          id: '$index',
                          builder: (BuildContext context, bool isInView,
                              Widget? child) {
                            return VideoWidget(
                                play: isInView,
                                url: _homeController.jsonResult
                                    .elementAt(index)["videoUrl"]);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(_homeController
                              .jsonResult
                              .elementAt(index)["coverPicture"]),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "${_homeController.jsonResult.elementAt(index)["title"]}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ]);
              })
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      
      ],
    )
    );
  }
}
