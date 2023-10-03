import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, required this.order});

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
                      Text(
                        ('Estimated Delivery Time: ') +
                            (DateFormat('yyyy-MM-dd')
                                .format(order['deliveryDate'].toDate())),
                        style: const TextStyle(fontSize: 15),
                      ),
                      order['deliveryStatus'] == 'shipping'
                          ? Text(
                              ('Estimated Delivery Date: ') +
                                  (order['deliveryDate']),
                              style: const TextStyle(fontSize: 15),
                            )
                          : const Text(''),
                      order['deliveryStatus'] == 'delivered' &&
                              order['orderreview'] == false
                          ? TextButton(
                              onPressed: () {},
                              child: const Text('Write a Review'))
                          : const Text(''),
                      order['deliveryStatus'] == 'delivered' &&
                              order['orderreview'] == true
                          ? const Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Review Added',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            )
                          : const Text('')
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
