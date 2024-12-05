// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:helix_ai/views/shared_components/chat_text.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

import '../../../../data/controllers/provider_controllers/chat_provider.dart';
import '../../../../data/models/model/getCustomizedata.dart';
import '../../../../util/constants/constant.dart';
import '../../../../util/constants/images_path.dart';

class UserChatContainer extends StatelessWidget {
  final String question;
  final String? answer;
  final bool? isMeal;
  final MenuItem? menuItem;

  const UserChatContainer({
    super.key,
    required this.question,
    this.answer,
    this.menuItem,
    this.isMeal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // User's question bubble
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(51, 0, 7, 22),
            child: Container(
              padding: EdgeInsets.all(height * 0.015),
              decoration: BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(width * 0.030),
                  topLeft: Radius.circular(width * 0.030),
                  bottomLeft: Radius.circular(width * 0.030),
                  bottomRight: Radius.circular(width * 0.007),
                ),
              ),
              child: ChatText(
                text: question,
                textAlign: TextAlign.right,
                color: colorBlack,
              ),
            ),
          ),
        ),

        // Answer or Loading Indicator
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.01),
                height: width * 0.123,
                width: width * 0.123,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0x124a5568), blurRadius: 8, spreadRadius: 0)
                ], color: whiteColor, shape: BoxShape.circle),
                child: SvgPicture.asset(
                  appLogo,
                  fit: BoxFit.none,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: answer != null && answer!.isNotEmpty
                      ? ChatText(
                          text: answer!,
                          textAlign: TextAlign.left,
                        )
                      : SizedBox(
                          width: 30,
                          child: JumpingDots(
                            color: greenThemeColor,
                            radius: 10,
                            numberOfDots: 3,
                            innerPadding: 0,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        (isMeal != null && isMeal!)
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.25,
                          // width: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                spreadRadius: 3,
                                // How far the shadow spreads
                                blurRadius: 10,
                                // How blurry the shadow looks
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white),
                                  child: Image.network(
                                    menuItem!.image!,
                                    fit: BoxFit.contain,
                                  )),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    color: Colors.grey.shade300),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        menuItem!.name!,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.042),
                                      ),
                                      Text(
                                        "\$" + menuItem!.price!.toString(),
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.04),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Consumer<ChatProvider>(
                                builder: (_, chatProvider, __) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check,
                                          size: 18, color: gray1Color),
                                      GestureDetector(
                                        onTap: () async {
                                          chatProvider.getFinalQuote(
                                              'Confirm', context, menuItem!);
                                        },
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: gray1Color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.close,
                                            size: 18, color: gray1Color),
                                        Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: gray1Color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
