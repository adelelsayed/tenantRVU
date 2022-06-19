import 'package:flutter/material.dart';
import 'package:tenant_review/models/review.dart';

class LogonCommnon extends StatelessWidget {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Text("pass");
  }
}

class StarButton extends StatefulWidget {
  ReviewItem itm = ReviewItem();

  StarButton(ReviewItem pItm) {
    itm = pItm;
  }
  @override
  _StarButton createState() => _StarButton(itm);
}

class _StarButton extends State<StarButton> {
  ReviewItem itm = ReviewItem();

  _StarButton(ReviewItem pItm) {
    itm = pItm;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> lista = [];
    for (int index = 0; index < itm.discreteDenominator.toInt(); index++) {
      lista.add(IconButton(
        color:
            index <= itm.itemDiscreteValue.toInt() - 1 ? Colors.yellow : null,
        icon: const Icon(
          Icons.star,
        ),
        onPressed: () {
          setState(() {
            itm.itemDiscreteValue = index + 1;
          });
        },
      ));
    }
    return Row(
      children: [...lista],
    );
  }
}
