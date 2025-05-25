import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/route.dart';
import '../model/customer_model.dart';

class CustomerItem extends StatelessWidget {
  CustomerModel customerData;
  CustomerItem({required this.customerData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 4,
          right: 4,
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  
                  await Get.toNamed(MyRoutes.customerDetails, arguments: {
                    "lname": customerData.lname,
                    "l_recno": customerData.l_recno
                  });
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Ledger No - ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: customerData.l_recno.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14))
                                  ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Customer - ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: customerData.lname.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14))
                                  ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Mobile No - ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: customerData.mobno.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14))
                                  ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Opening Balance - ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: customerData.lopbal
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14))
                                  ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
