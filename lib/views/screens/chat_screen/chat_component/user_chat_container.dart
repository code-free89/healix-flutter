// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helix_ai/util/constants/colors.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';

import '../../../../data/controllers/provider_controllers/chat_provider.dart';
import '../../../../data/models/model/getCustomizedata.dart';

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
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: greenThemeColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(3),
                ),
              ),
              child: Text(
                question,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // Answer or Loading Indicator
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 55, 22),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: gray5Color,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(12),
                ),
              ),
              // Show loading indicator or answer text
              child: answer != null && answer!.isNotEmpty
                  ? Text(
                      answer!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Urbanist',
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
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
