import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sarkar_chit_fund/constant/route.dart';
import 'package:sarkar_chit_fund/features/collection/controller/collection_controller.dart';
import 'package:sarkar_chit_fund/features/customer/controller/customer_controller.dart';

import '../../../utils/custom_snackbar.dart';
import '../../../widgets/custom_drawer.dart';
import '../model/customer_model.dart';
import 'customer_item.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController mobnoController = TextEditingController();
  final customerController = Get.put(CustomerController());
  final collectionController = Get.put(CollectionController());
  List<CustomerModel> customerData = [];
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      customerData = customerController.customerData;
    });

    mobnoController.addListener(_performSearch);
  }

  @override
  void dispose() {
    mobnoController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    setState(() {
      customerController.getSearchData(mobnoController.text.toString());
    });
    setState(() {
      customerData = customerController.customerData
          .where((element) => element.mobno
              .toLowerCase()
              .contains(mobnoController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Customer Entry',
          onPressed: () {
            alertDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: mobnoController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _performSearch();
            },
          ),
        ),
        body: ListView.builder(
            itemCount: customerData.length,
            itemBuilder: ((context, index) {
              return CustomerItem(customerData: customerData[index]);
            })));
  }

  void alertDialog(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Customer Entry')),
            content: SingleChildScrollView(
              child: SizedBox(
                height: mediaQuery.height * 0.6,
                child: Column(children: [
                  TextField(
                      readOnly: false,
                      focusNode: customerController.customerNameFocusNode,
                      controller: customerController.customerNameController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          hintText: 'Customer Name',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).requestFocus(
                              customerController.address1FocusNode);
                        } else {
                          FocusScope.of(context).requestFocus(
                              customerController.customerNameFocusNode);
                        }
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                      readOnly: false,
                      focusNode: customerController.address1FocusNode,
                      controller: customerController.address1Controller,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          hintText: 'Address1',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).requestFocus(
                              customerController.address2FocusNode);
                        } else {
                          FocusScope.of(context).requestFocus(
                              customerController.address1FocusNode);
                        }
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                      readOnly: false,
                      focusNode: customerController.address2FocusNode,
                      controller: customerController.address2Controller,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          hintText: 'Address2',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context).requestFocus(
                              customerController.address3FocusNode);
                        } else {
                          FocusScope.of(context).requestFocus(
                              customerController.address2FocusNode);
                        }
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                      readOnly: false,
                      focusNode: customerController.address3FocusNode,
                      controller: customerController.address3Controller,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          hintText: 'Address3',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context)
                              .requestFocus(customerController.areaFocusNode);
                        } else {
                          FocusScope.of(context).requestFocus(
                              customerController.address3FocusNode);
                        }
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                      readOnly: false,
                      focusNode: customerController.areaFocusNode,
                      controller: customerController.areaController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                          hintText: 'Area',
                          hintStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          FocusScope.of(context)
                              .requestFocus(customerController.mobNoFocusNode);
                        } else {
                          FocusScope.of(context)
                              .requestFocus(customerController.areaFocusNode);
                        }
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    readOnly: false,
                    focusNode: customerController.mobNoFocusNode,
                    controller: customerController.mobnoController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    decoration: const InputDecoration(
                        hintText: 'Mobno',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        enabled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ))),
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                            customerController.customerNameController.clear();
                            customerController.address1Controller.clear();
                            customerController.address2Controller.clear();
                            customerController.address3Controller.clear();
                            customerController.areaController.clear();
                            customerController.mobnoController.clear();
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await customerController
                                  .insertNewCustomer()
                                  .then((value) {
                                if (value == 'Insert Successfully') {
                                  customerController.customerNameController
                                      .clear();
                                  customerController.address1Controller.clear();
                                  customerController.address2Controller.clear();
                                  customerController.address3Controller.clear();
                                  customerController.areaController.clear();
                                  customerController.mobnoController.clear();
                                  CustomSnackbar.showSnackbar(
                                      'Insert Successfully',
                                      Colors.green,
                                      Icons.verified);
                                  Navigator.of(context).pop();
                                  Get.toNamed(MyRoutes.login);
                                } else {
                                  Navigator.of(context).pop();
                                  CustomSnackbar.showSnackbar(
                                      'In this Customer Already Exists',
                                      Colors.red,
                                      Icons.verified);
                                  customerController.customerNameController
                                      .clear();
                                  customerController.address1Controller.clear();
                                  customerController.address2Controller.clear();
                                  customerController.address3Controller.clear();
                                  customerController.areaController.clear();
                                  customerController.mobnoController.clear();
                                }
                              });
                            },
                            child: const Text('Ok'))
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
