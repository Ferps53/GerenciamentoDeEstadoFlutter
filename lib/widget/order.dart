import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _turnAnimation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc,
      ),
    );
    super.initState();
  }

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );
  Animation<double>? _turnAnimation;

  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.products.length * 25.0) + 15;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? itemsHeight + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "R\$${widget.order.total.toStringAsFixed(2)}",
              ),
              subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date),
              ),
              trailing: RotationTransition(
                turns: _turnAnimation!,
                child: IconButton(
                  icon: const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(
                      () {
                        _expanded = !_expanded;
                        if (_expanded) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _expanded ? itemsHeight : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product.quantity}X R\$ ${product.price}",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
