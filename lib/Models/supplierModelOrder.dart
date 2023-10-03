import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class SupplierOrderModel extends StatelessWidget {
  final dynamic order;
  const SupplierOrderModel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.yellow.shade600, width: 2)),
        child: ExpansionTile(
          title: Container(
            constraints:
                const BoxConstraints(maxHeight: 80, maxWidth: double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        order['orderImage'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['orderName'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ('\$ ') + (order['orderprice']).toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(('X ') + (order['orderqty']).toString()),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('see more '), Text(order['deliveryStatus'])],
          ),
          children: [
            Container(
              width: double.infinity,
              //  height: 200,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ('Name: ') + (order['customer_name']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Phone No.: ') + (order['phone']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Email Address: ') + (order['email']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Address: ') + (order['address']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Payment status: ',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (order['paymentstatus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.purple),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Delivery status: '),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            (order['deliveryStatus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Order Date: '),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            (DateFormat('yyy-MM-dd')
                                .format(order['orderdate'].toDate())
                                .toString()),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      order['deliveryStatus'] == 'delivered'
                          ? const Text('This item has been already delivered')
                          : Row(
                              children: [
                                const Text(
                                  ('Change Delivery Status to: '),
                                  style: TextStyle(fontSize: 15),
                                ),
                                order['deliveryStatus'] == 'preparing'
                                    ? TextButton(
                                        onPressed: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime.now().add(
                                                  const Duration(days: 365)),
                                              onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) async {
                                            await FirebaseFirestore.instance
                                                .collection('orders')
                                                .doc(order['orderId'])
                                                .update({
                                              'deliveryStatus': 'shipping',
                                              'deliveryDate': date
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        child: const Text('shipping'))
                                    : TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('orders')
                                              .doc(order['orderId'])
                                              .update({
                                            'deliveryStatus': 'delivered',
                                            'deliveryDate': DateTime.now()
                                          });
                                        },
                                        child: const Text('Delivered '))
                              ],
                            ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
