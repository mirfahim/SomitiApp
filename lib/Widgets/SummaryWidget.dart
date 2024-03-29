import 'package:flutter/material.dart';

import 'package:somiti/Widgets/textStyle.dart';
import 'package:somiti/Widgets/uiHelper.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({this.income, this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Deposit', style: summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  Text(income.toString(), style: summaryNumberTextStyle)
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Expense',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(expense.toString(), style: summaryNumberTextStyle)
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Balance',

                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text((income - expense).toString(),
                      style: income > expense ?TextStyle( color: Colors.black, fontSize: 18, fontWeight:FontWeight.bold)
                          : TextStyle(color: Colors.red,fontSize: 18, fontWeight:FontWeight.bold))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
