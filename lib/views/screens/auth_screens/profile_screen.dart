import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helix_ai/data/data_services/user_data_services.dart';
import 'package:helix_ai/models/billing_data_model.dart';
import 'package:helix_ai/util/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:helix_ai/views/screens/auth_screens/user_login.dart';
import 'package:helix_ai/views/shared_components/general_button.dart';
import 'package:provider/provider.dart';
import '../../../controllers/authentication_provider.dart';
import '../../../controllers/chat_provider.dart';
import '../../../data/shared_preferences/share_preferences_data.dart';
import '../../../util/constants/colors.dart';
import '../../shared_components/logout_alert_dialog.dart';
import '../../shared_components/want_text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isInitialized = false; // Flag to track initialization
  String addressBlock = "";
  Map<String, String> suggestion = {};

  // Declare variables outside the try block
  String street = '';
  String unit = '';
  String city = '';
  String state = '';
  String country = '';
  String zipcode = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

//MARK: - Code for Get Place Details
  String? _getAddressComponent(List components, String type) {
    try {
      return components.firstWhere(
          (component) => (component['types'] as List).contains(type),
          orElse: () => null)?['long_name'];
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, String>> _getPlaceDetails(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapsAPIkey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final addressComponents = data['result']['address_components'] as List;

        // Populate the variables with the corresponding address components
        street = _getAddressComponent(addressComponents, 'route') ?? '';
        unit = _getAddressComponent(addressComponents, 'subpremise') ?? '';
        city = _getAddressComponent(addressComponents, 'locality') ?? '';
        state = _getAddressComponent(
                addressComponents, 'administrative_area_level_1') ??
            '';
        country = _getAddressComponent(addressComponents, 'country') ?? '';
        zipcode = _getAddressComponent(addressComponents, 'postal_code') ?? '';
      } else {
        print('Error fetching place details: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }

    // Return the map of address details
    return {
      'street': street,
      'unit': unit,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
    };
  }

  void _onSuggestionSelected(Map<String, String> suggestion) async {
    final placeId = suggestion['place_id'];
    if (placeId != null) {
      final addressDetails = await _getPlaceDetails(placeId);
      addressBlock = jsonEncode(addressDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.061),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: size.width * 0.05,
                      ),
                      onTap: () {
                        Navigator.pop(context); // Back navigation
                      },
                    ),
                    WantText(
                        text: 'Profile',
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w500,
                        textColor: colorBlack.withOpacity(0.7),
                        usePoppins: false),
                    SizedBox()
                  ],
                ),
                Center(
                  child: WantText(
                      text: authProvider.userData != null
                          ? authProvider.userData?.name ?? ""
                          : '',
                      fontSize: size.width * 0.082,
                      fontWeight: FontWeight.bold,
                      textColor: textColor,
                      usePoppins: true),
                ),
                SizedBox(height: size.height * 0.035),
                buildEditableField(
                    "Full Name", authProvider.userData?.name ?? ""),
                buildEditableField(
                    "E-Mail", authProvider.userData?.email ?? ""),
                buildEditableField("Password", "********", isObscure: true),
                GestureDetector(
                  onTap: () {
                    showEditAddressBottomSheet(context);
                  },
                  child: Container(
                    color: Colors.white,
                    child: buildEditableField(
                      "Address",
                      authProvider.userData?.addressString ?? "",
                      isReadOnly: true,
                      onEditTap: () {
                        showEditAddressBottomSheet(context);
                      },
                    ),
                  ),
                ),
                buildEditableField(
                    "Phone Number", authProvider.userData?.phone ?? ""),
                GestureDetector(
                  onTap: () {
                    showEditBillingInfoBottomSheet(context);
                  },
                  child: Container(
                    color: Colors.white,
                    child: buildEditableField(
                      "Billing Information",
                      "**** **** **** ****",
                      isReadOnly: true,
                      onEditTap: () {
                        showEditBillingInfoBottomSheet(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                ListTile(
                  leading: Icon(Icons.description_outlined),
                  title: WantText(
                      text: 'Terms of Service',
                      fontSize: size.width * 0.0435,
                      fontWeight: FontWeight.w500,
                      textColor: textColor,
                      usePoppins: false),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to Terms of Service screen
                  },
                ),
                Container(
                  height: 1.5,
                  width: size.width,
                  color: colorGrey,
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: WantText(
                      text: 'Privacy Policy',
                      fontSize: size.width * 0.0435,
                      fontWeight: FontWeight.w500,
                      textColor: textColor,
                      usePoppins: false),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to Privacy Policy screen
                  },
                ),
                Container(
                  height: 1.5,
                  width: size.width,
                  color: colorGrey,
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: WantText(
                      text: 'Log out',
                      fontSize: size.width * 0.0435,
                      fontWeight: FontWeight.w500,
                      textColor: textColor,
                      usePoppins: false),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LogOutAlertDialog(
                            onLogout: () async {
                              debugPrint("logout clicked");
                              final service = FlutterBackgroundService();
                              var isRunning = await service.isRunning();
                              if (isRunning) {
                                service.invoke("stopService");
                              }
                              authProvider.signOut();
                              Provider.of<ChatProvider>(context, listen: false)
                                  .resetChat();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UserLogin()),
                                  (route) => false);
                            },
                          );
                        });
                  },
                ),
                Container(
                  height: 1.5,
                  width: size.width,
                  color: colorGrey,
                ),
                SizedBox(height: size.height * 0.035),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: size.height * 0.061,
                        child: Image.asset("assets/images/logo.png")),
                    SizedBox(width: size.width * 0.061),
                    WantText(
                        text: 'Healix AI\nV 1.0.0',
                        fontSize: size.width * 0.0435,
                        fontWeight: FontWeight.w500,
                        textColor: colorGreyText,
                        usePoppins: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(
    String label,
    String text, {
    bool isObscure = false,
    bool isReadOnly = false,
    VoidCallback? onEditTap,
    String? Function(String?)?
        validator, // Pass the onTap function as a parameter
  }) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.041),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WantText(
                  text: label,
                  fontSize: MediaQuery.of(context).size.height * 0.017,
                  fontWeight: FontWeight.w400,
                  textColor: colorBlack.withOpacity(0.7),
                  usePoppins: false,
                ),
                GestureDetector(
                  onTap: isReadOnly
                      ? onEditTap // Trigger editing functionality if readOnly
                      : null,
                  child: AbsorbPointer(
                    absorbing: isReadOnly,
                    // Prevents user interaction when readOnly
                    child: TextField(
                      readOnly: isReadOnly,
                      controller: TextEditingController(text: text),
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter $label",
                        isDense: true,
                      ),
                      style: GoogleFonts.roboto(
                        color: textColor,
                        fontSize: MediaQuery.of(context).size.width * 0.051,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Icon(Icons.edit, size: 20),
            onTap: onEditTap, // Pass the editing functionality
          ),
        ],
      ),
    );
  }

  void showEditAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        List<Map<String, String>> _placeSuggestions = [];
        final TextEditingController addressController = TextEditingController();

        bool _isLoading = false;

        Future<void> _getPlaceSuggestions(String input) async {
          if (input.isEmpty) return;

          final String url =
              'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleMapsAPIkey';

          try {
            final response = await http.get(Uri.parse(url));
            if (response.statusCode == 200) {
              final data = json.decode(response.body);
              final predictions = data['predictions'];

              setState(() {
                _placeSuggestions = predictions
                    .map<Map<String, String>>((p) => {
                          'description': p['description'] as String,
                          'place_id': p['place_id'] as String,
                        })
                    .toList();
              });
            } else {
              print('Error fetching suggestions: ${response.reasonPhrase}');
            }
          } catch (e) {
            print('Error fetching suggestions: $e');
          }
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.width * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          child: const Icon(Icons.close),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WantText(
                              text: "Change Address",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              textColor: textColor,
                              usePoppins: true),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.0615,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(
                                  color: colorBlack.withOpacity(0.15)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    MediaQuery.of(context).size.width * 0.03),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorBlack.withOpacity(0.15),
                                  blurRadius: 10,
                                  spreadRadius: 0.3,
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextField(
                              expands: true,
                              maxLines: null,
                              controller: addressController,
                              onChanged: (value) async {
                                setState(() => _isLoading = true);
                                await _getPlaceSuggestions(value);
                                setState(() => _isLoading = false);
                              },
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.roboto(
                                  color: colorGreyText,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.035,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Enter address',
                                suffixIcon: _isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  borderSide: BorderSide(color: colorGrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  borderSide: BorderSide(color: colorBlack),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.015,
                          ),
                          if (_placeSuggestions.isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _placeSuggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_placeSuggestions[index]
                                            ['description'] ??
                                        ''),
                                    onTap: () {
                                      suggestion = _placeSuggestions[index];
                                      setState(() {
                                        addressController.text =
                                            _placeSuggestions[index]
                                                    ['description'] ??
                                                '';
                                        _onSuggestionSelected(suggestion);
                                        print(suggestion);
                                        _placeSuggestions.clear();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.06,
                          ),
                          GeneralButton(
                            Width: MediaQuery.of(context).size.width,
                            onTap: () async {
                              // Get the new address from the controlle
                              String description =
                                  suggestion['description'] ?? '';

                              List<String> parts = description
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList();
                              print("Address description: $suggestion");

                              // Store in individual variables
                              String adstreet =
                                  parts.isNotEmpty ? parts[0] : '';

                              Map<String, dynamic> addressBlock = {
                                "city": city,
                                "country": country,
                                "state": state,
                                "street": adstreet,
                                "unit": unit,
                                "zipcode": zipcode
                              };
                              final authProvider =
                                  Provider.of<AuthenticationProvider>(context,
                                      listen: false);
                              authProvider.userData!.addressString =
                                  addressController.text;
                              authProvider.notifyListeners();
                              SharePreferenceData()
                                  .storeUserInfo(authProvider.userData!);

                              Navigator.pop(context);
                              bool success = await UserDataServices()
                                  .updateUserAddress(
                                      SharePreferenceData().uid, addressBlock);

                              if (!success) {
                                print(
                                    "error : Failed to update address. Please try again.");

                                Fluttertoast.showToast(
                                  msg:
                                      'Failed to update address. Please try again.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                                // Ensure that the context has a Scaffold and then show the SnackBar
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to update address. Please try again.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                });
                              }
                            },
                            label: "Save",
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showEditBillingInfoBottomSheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cardNoController = TextEditingController();
    final TextEditingController exDateController = TextEditingController();
    final TextEditingController cvcController = TextEditingController();
    String expiryMonth = '';
    String expiryYear = '';
    bool isSelected = false;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: size.width * 0.04,
                right: size.width * 0.04,
                top: size.width * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          child: const Icon(Icons.close),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WantText(
                              text: "Billing details",
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              textColor: textColor,
                              usePoppins: true),
                          SizedBox(
                            height: size.height * 0.029,
                          ),
                          _buildField(
                              label: "Name on the card",
                              hintText: 'John Doe',
                              controller: nameController),
                          SizedBox(
                            height: size.height * 0.017,
                          ),
                          _buildField(
                              label: 'Card Number',
                              hintText: '**** **** **** ****',
                              keyboardType: TextInputType.number,
                              controller: cardNoController),
                          SizedBox(
                            height: size.height * 0.017,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: _buildField(
                                label: 'Expiry Date',
                                hintText: 'MM / YY',
                                controller: exDateController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value.length == 2 &&
                                      !value.contains('/')) {
                                    exDateController.text = '$value/';
                                    exDateController.selection =
                                        TextSelection.fromPosition(
                                      TextPosition(
                                          offset: exDateController.text.length),
                                    );
                                  }
                                  if (value.length == 5) {
                                    setState(() {
                                      expiryMonth = value.substring(0, 2);
                                      expiryYear = value.substring(3, 5);
                                    });
                                  }
                                },
                              )),
                              SizedBox(width: size.width * 0.02),
                              Expanded(
                                  child: _buildField(
                                      label: 'CVV',
                                      hintText: '***',
                                      controller: cvcController)),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.017,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                side: BorderSide(color: colorGrey, width: 1.5),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: isSelected,
                                activeColor: greenThemeColor,
                                checkColor: whiteColor,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isSelected = value!;
                                  });
                                },
                              ),
                              WantText(
                                  text:
                                      'Remember my card details for future payments.',
                                  fontSize: size.width * 0.030,
                                  fontWeight: FontWeight.w400,
                                  textColor: colorBlack,
                                  usePoppins: false),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.029,
                          ),
                          GeneralButton(
                            Width: MediaQuery.of(context).size.width,
                            onTap: () async {
                              String? userUid = await SharePreferenceData()
                                  .retrieveUserInfo()
                                  .then((value) => value?.id);
                              String? userEmail = await SharePreferenceData()
                                  .retrieveUserInfo()
                                  .then((value) => value?.email);

                              BillingDataModel billingData = BillingDataModel(
                                  id: userUid!,
                                  userEmail: userEmail!,
                                  cardNumber: int.parse(
                                      cardNoController.text.toString()),
                                  expirationYear:
                                      int.parse(expiryYear.toString()),
                                  expirationMonth:
                                      int.parse(expiryMonth.toString()),
                                  cvc: cvcController.text);

                              final authProvider =
                                  Provider.of<AuthenticationProvider>(context,
                                      listen: false);

                              var response = await authProvider
                                  .setBillingDetails(billingData);
                              Navigator.pop(context);
                            },
                            label: "Save",
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildField(
      {required String label,
      required String hintText,
      TextInputType? keyboardType,
      required TextEditingController controller,
      void Function(String)? onChanged}) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WantText(
            text: label,
            fontSize: size.width * 0.030,
            fontWeight: FontWeight.w400,
            textColor: colorBlack,
            usePoppins: false),
        SizedBox(
          height: size.width * 0.004,
        ),
        Container(
          decoration: BoxDecoration(
            color: colorWhite,
            border: Border.all(color: colorBlack.withOpacity(0.15)),
            borderRadius: BorderRadius.all(
              Radius.circular(size.width * 0.03),
            ),
            boxShadow: [
              BoxShadow(
                color: colorBlack.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 0.3,
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextFormField(
            expands: true,
            maxLines: null,
            keyboardType:
                keyboardType != null ? keyboardType : TextInputType.text,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.roboto(
                color: colorGreyText,
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.w500,
              ),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.03),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.03),
                ),
                borderSide: BorderSide(color: colorGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.03),
                ),
                borderSide: BorderSide(color: colorBlack),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
