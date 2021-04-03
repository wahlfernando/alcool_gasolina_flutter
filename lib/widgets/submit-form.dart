import 'package:aog/widgets/input.widget.dart';
import 'package:aog/widgets/loading-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SubmitForm extends StatelessWidget {
  var gasCtrl = MoneyMaskedTextController();
  var alcCtrl = MoneyMaskedTextController();
  var busy = false;
  Function submitFunc;

  SubmitForm({
    @required this.gasCtrl,
    @required this.alcCtrl,
    @required this.busy,
    @required this.submitFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Input(
            label: 'Gasolina:',
            ctrl: gasCtrl,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Input(
            label: 'Álcool:',
            ctrl: alcCtrl,
          ),
        ),
        LoadingButton( 
              busy: busy, 
              invert: false, 
              func: submitFunc, 
              text: 'CALCULAR'),
      ],
    );
  }
}
