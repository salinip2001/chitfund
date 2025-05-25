import 'dart:developer';

//import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sarkar_chit_fund/features/customer/controller/customer_controller.dart';
import 'package:sarkar_chit_fund/features/history/model/group_model.dart';

import '../../../utils/custom_snackbar.dart';
import '../../collection/controller/collection_controller.dart';
import '../../collection/model/collection_model.dart';
import '../../customer/ui/customer.dart';
import '../controller/customer_history_controller.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({Key? key}) : super(key: key);
  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final paymentController = TextEditingController();
  final collectionController = Get.put(CollectionController());
  final customerController = Get.put(CustomerController());
  final groupController = Get.put(CustomerHistoryController());
  TextEditingController receiptController = TextEditingController();

  List<CollectionModel> collectionData = [];
  List<GroupModel> groupData = [];
  List<GroupModel> groupAllData = [];
  List<GroupModel> selectGroupData = [];
  List availableBluetoothDevices = [];
  bool connected = false;

  // date format
  final now = DateTime.now();
  final formattor = DateFormat('dd-MM-yyyy');
  //time
  var time = DateFormat('hh:mm:ss').format(DateTime.now());

  int selected = -1;
  bool isexpanded = false;
  double collection = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      groupController.pIndex = -1;
    });
    Future.delayed(const Duration(milliseconds: 0), () async {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      print('arguments${arguments['lname']}');
      await collectionController
          .getCollectionData(arguments['l_recno'])
          .then((value) {
        collectionData = value;
      });
      log('collection${collectionData.toString()}');
      await groupController
          .getGroupData(collectionData.isNotEmpty
              ? collectionData.first.c_grouptype.toString()
              : groupController.groupData.toString())
          .then((value) {
        groupData = value;
      });

      await groupController.getGroupAllData().then((value) {
        groupAllData = value;
      });

      setState(() {
        collection = collectionData.fold(
            0,
            (previousValue, element) =>
                previousValue + double.parse(element.c_amount.toString()));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.print),
        onPressed: () async {
          await sarkarChitFund().then((value) => {});
        },
      ),
      appBar: AppBar(
        title: Text(arguments['lname'].toString().trim().toUpperCase()),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
               // await getBluetooth(context);
              },
              icon: const Icon(Icons.bluetooth))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Stack(children: [
                      collectionData.isNotEmpty && groupData.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total - ${int.parse(groupData[0].g_installment.toString()) * double.parse(collectionData[0].c_amount.toString())}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Installment - ${int.parse(groupData[0].g_installment.toString())}(in month)',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Remaining - ${(double.parse(collectionData.first.c_amount.toString()) * int.parse(groupData[0].g_installment.toString())) - collection}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 25,
                                // ),
                                const Text(
                                  'CHITS',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                SingleChildScrollView(
                                  child: Container(
                                    height: 70,
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        right: 15,
                                        bottom: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: groupData.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    onTap: () async {
                                                      // setState(() {
                                                      //   groupController.pIndex =
                                                      //       index;
                                                      // });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              bottom: 8.0),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6,
                                                              bottom: 6,
                                                              left: 15,
                                                              right: 15),
                                                      decoration: BoxDecoration(
                                                        boxShadow: groupController
                                                                    .pIndex ==
                                                                index
                                                            ? [
                                                                const BoxShadow(
                                                                  color: Colors
                                                                      .white,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                ),
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2),
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            1),
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        1)
                                                              ]
                                                            : null,
                                                        color: Colors
                                                            .green.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        groupData[index]
                                                            .g_name
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'ORDER HISTORY',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: collectionData.length > 5
                                        ? 5
                                        : collectionData.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        leading: Text(collectionData[index]
                                            .c_date
                                            .toString()
                                            .substring(0, 10)),
                                        title: Text(
                                          collectionData[index]
                                              .c_grouptype
                                              .toString(),
                                        ),
                                        trailing: Text(
                                          collectionData[index]
                                              .c_amount
                                              .toString(),
                                        ),
                                      );
                                    }),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Due Amount - ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                // const SizedBox(
                                //   height: 25,
                                // ),
                                const Text(
                                  'CHITS',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                SingleChildScrollView(
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        right: 15,
                                        bottom: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: groupAllData.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45),
                                                    onTap: () async {
                                                      selectGroupData.clear();
                                                      setState(() {
                                                        groupController.pIndex =
                                                            index;
                                                      });
                                                      selectGroupData.add(
                                                          groupAllData[index]);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              bottom: 8.0),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6,
                                                              bottom: 6,
                                                              left: 15,
                                                              right: 15),
                                                      decoration: BoxDecoration(
                                                        boxShadow: groupController
                                                                    .pIndex ==
                                                                index
                                                            ? [
                                                                const BoxShadow(
                                                                  color: Colors
                                                                      .white,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                ),
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2),
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            1),
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        1)
                                                              ]
                                                            : null,
                                                        color: groupController
                                                                    .pIndex ==
                                                                index
                                                            ? Colors
                                                                .green.shade400
                                                            : Colors
                                                                .red.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        groupAllData[index]
                                                            .g_name
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'ORDER HISTORY',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: Text(collectionData.isNotEmpty
                                      ? collectionData[0]
                                          .c_date
                                          .toString()
                                          .substring(0, 10)
                                      : ''),
                                  title: Text(
                                    collectionData.isNotEmpty
                                        ? collectionData[0]
                                            .c_grouptype
                                            .toString()
                                        : '',
                                  ),
                                  trailing: Text(
                                    collectionData.isNotEmpty
                                        ? collectionData[0].c_amount.toString()
                                        : '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                      Positioned(
                        bottom: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Center(
                              child: TextField(
                                controller: receiptController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    hintText: 'Amount',
                                    labelText: 'Payable Amount',
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    constraints: BoxConstraints(
                                        minWidth: mediaQuery.width * 0.40,
                                        maxWidth: mediaQuery.width * 0.45)),
                                onSubmitted: (value) {
                                  setState(() {
                                    receiptController.text = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Total -  ',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      receiptController.text,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 45,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (receiptController.text.isNotEmpty) {
                                      print(selectGroupData.length);
                                      if (collectionData.isEmpty
                                          ? selectGroupData.isNotEmpty
                                          : true) {
                                        if (collectionData.isNotEmpty
                                            ? ((double.parse(collectionData
                                                        .first.c_amount
                                                        .toString()) *
                                                    int.parse(groupData[0]
                                                        .g_installment
                                                        .toString())) >=
                                                (collection +
                                                    double.parse(
                                                        receiptController.text
                                                            .toString()
                                                            .trim())))
                                            : true) {
                                          log('message');
                                          await collectionController
                                              .insertCollection(CollectionModel(
                                                  c_recno: 0,
                                                  c_pfx: 'MCH2324',
                                                  c_no: 0,
                                                  c_date:
                                                      DateTime.now().toString(),
                                                  c_time: time.toString(),
                                                  c_amount: double.parse(
                                                      receiptController.text
                                                          .toString()),
                                                  c_type: 'CHIT',
                                                  adjamount: double.parse(
                                                      receiptController.text
                                                          .toString()),
                                                  c_relisedate: formattor
                                                      .format(DateTime.now()),
                                                  c_depositeddate: formattor
                                                      .format(DateTime.now()),
                                                  c_ledrecno:
                                                      arguments['l_recno'],
                                                  c_grouptype: collectionData.isNotEmpty
                                                      ? collectionData
                                                          .first.c_grouptype
                                                          .toString()
                                                      : selectGroupData.first.g_name
                                                          .toString()
                                                          .trim()))
                                              .then((value) {
                                            CustomSnackbar.showSnackbar(
                                                'Insert Successfully',
                                                Colors.green,
                                                Icons.verified);
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CustomerScreen()),
                                          );
                                        } else {
                                          CustomSnackbar.showSnackbar(
                                              'Remaing isnt higher than total amount',
                                              Colors.red,
                                              Icons.verified);
                                        }
                                      } else {
                                        CustomSnackbar.showSnackbar(
                                            'Please choose atleast one chit',
                                            Colors.red,
                                            Icons.verified);
                                      }
                                    } else {
                                      CustomSnackbar.showSnackbar(
                                          'Remaing isnt higher than total amount',
                                          Colors.red,
                                          Icons.verified);
                                    }
                                  },
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    minimumSize: const Size(100, 50),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
    );
  }

  // Future<void> getBluetooth(BuildContext context) async {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.bluetoothConnect.request();
  //     print(status);
  //   }
  //   final List? bluetooths =
  //       await BluetoothThermalPrinter.getBluetooths.catchError((onError) {
  //     print(onError);
  //   });
  //   print("Print $bluetooths");
  //   setState(() {
  //     availableBluetoothDevices = bluetooths!;
  //   });

  //   // ignore: use_build_context_synchronously
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Printers'),
  //           content: StatefulBuilder(
  //               builder: (BuildContext context, StateSetter setState) {
  //             return setupAlertDialoadContainer();
  //           }),
  //         );
  //       });
  // }

  Widget setupAlertDialoadContainer() {
    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        itemCount: availableBluetoothDevices.isNotEmpty
            ? availableBluetoothDevices.length
            : 0,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              String select = availableBluetoothDevices[index];
              List list = select.split("#");
              // String name = list[0];
              String mac = list[1];

              print(mac);
            //  setConnect(mac, availableBluetoothDevices[index]);
              // print("sabu");

              setState(() {});
              //  res == "true"?
              //    Fluttertoast.showToast(
              //             msg: "Successfully Connected to ${availableBluetoothDevices[index]}",
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.CENTER,
              //             timeInSecForIosWeb: 1,
              //             fontSize: 16.0)
              //             :
              //   Fluttertoast.showToast(
              //             msg: "Something went wrong",
              //             toastLength: Toast.LENGTH_SHORT,
              //             gravity: ToastGravity.CENTER,
              //             timeInSecForIosWeb: 1,
              //             fontSize: 16.0);

              Navigator.of(context).pop();
            },
            title: Text('${availableBluetoothDevices[index]}'),
            subtitle: connected == false
                ? const Text("Click to connect")
                : const Text("Connected"),
          );
        },
      ),
    );
  }

  // Future<void> setConnect(String mac, String device) async {
  //   print('object11');
  //   print(mac);
  //   //print( BluetoothThermalPrinter.connect(mac));
  //   try {
  //     var status = await Permission.storage.status;
  //     if (!status.isGranted) {
  //       await Permission.bluetoothScan.request();
  //       print(status);
  //     }
  //     final String? result = await BluetoothThermalPrinter.connect(mac);
  //     print("state conneected $result");
  //     // res=result!;
  //     if (result == "true") {
  //       setState(() {
  //         connected = true;
  //         // Fluttertoast.showToast(
  //         //     msg: "Successfully Connected to $device",
  //         //     toastLength: Toast.LENGTH_SHORT,
  //         //     gravity: ToastGravity.CENTER,
  //         //     timeInSecForIosWeb: 1,
  //         //     fontSize: 16.0);
  //       });
  //     } else {
  //       // Fluttertoast.showToast(
  //       //     msg: "Something went wrong",
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.CENTER,
  //       //     timeInSecForIosWeb: 1,
  //       //     fontSize: 16.0);
  //     }
  //   } catch (c) {
  //     print(c);
  //   }
  // }

  Future<void> sarkarChitFund() async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();
    final ByteData data = await rootBundle.load('assets/dataempty.png');
    // final Uint8List imgBytes = data.buffer.asUint8List();
    //final image = decodeImage(imgBytes)!;
    // bytes += generator.imageRaster(image);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    //  bytes += generator.imageRaster(image);
    bytes += generator.text('Welcomes You',
        styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2));

    bytes += generator.text('SARKAR SUPER MARKET',
        styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size1));

    bytes += generator.text('',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(
        'CUSTOMER NAME : ${arguments['lname'].toString().toUpperCase()}',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(
        'TOTAL : ${int.parse(groupData[0].g_installment.toString()) * double.parse(collectionData[0].c_amount.toString())}',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(
        'INSTALLMENT : ${int.parse(groupData[0].g_installment.toString())}(in month)',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(
        'REMAINING : ${(double.parse(collectionData.first.c_amount.toString()) * int.parse(groupData[0].g_installment.toString())) - collection}',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('CHITS : ${groupData[0].g_name.toString()}',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    bytes += generator.text('ORDER HISTORY',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text(
        'LAST DATE : ${collectionData[0].c_date.toString().substring(0, 10)}',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('LAST PAYMENT : ${collectionData[0].c_amount}',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    bytes += generator.text('',
        styles: const PosStyles(align: PosAlign.left, bold: true));
    bytes += generator.text('Thank You, Visit Again',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    bytes += generator.text('Powered by www.uthsoftware.com',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    bytes += generator.cut();
    //String? isConnected = await BluetoothThermalPrinter.connectionStatus;
   // if (isConnected == "true") {
    //  print('hihereeeee$bytes');
   //   final result = await BluetoothThermalPrinter.writeBytes(bytes);
     //Fluttertoast.showToast(msg: 'Billwise Print completed');
    //  print("Print $result");
  //  } else {
      ///Fluttertoast.showToast(msg: 'Failed printer not connected');
  //  }
  }
}
