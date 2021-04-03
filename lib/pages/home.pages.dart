import 'package:aog/widgets/logo.widget.dart';
import 'package:aog/widgets/submit-form.dart';
import 'package:aog/widgets/success.widget.dart';
import 'package:aog/pages/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.lightBlue;
  var _gasCtrl = MoneyMaskedTextController();
  var _alcCtrl = MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = 'Compensa usar Álcool';
  BannerAd _banner;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: Ads.appId);
    _banner = BannerAd(
      adUnitId: Ads.banner, 
      size: AdSize.banner
    );
    _loadBanner();
  }

  @override
  void dispose() {
    super.dispose();
    _banner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 1200),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _completed
                  ? Sucesso(
                      result: _resultText,
                      reset: reset,
                    )
                  : SubmitForm(
                      gasCtrl: _gasCtrl,
                      alcCtrl: _alcCtrl,
                      busy: _busy,
                      submitFunc: calcula),
            ],
          ),
        ),
      );
  }

  Future calcula() {
    double alc = double.parse(_alcCtrl.text.replaceAll(RegExp(r'[,.]'), '')) / 100;
    double gas = double.parse(_gasCtrl.text.replaceAll(RegExp(r'[,.]'), '')) / 100;
    double res = alc / gas;

    setState(() {
      _completed = false;
      _busy = true;
    });

    //aqui tem um tempo de 2 segundos para dai fazer o calculo.
    return Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _color = Colors.blue[900]; //muda de cora tela inicial
        //no setState que faz o calculo para ver o que compensa.
        if (res >= 0.7) {
          _resultText = "Compensa Utilizar Gasolina";
        } else {
          _resultText = "Compensa Utilizar Álcool";
        }
        _busy = false;
        _completed = true;
        
      });
    });
  }

  reset() {
    setState(() {
      _gasCtrl = MoneyMaskedTextController();
      _alcCtrl = MoneyMaskedTextController();
      _busy = false;
      _completed = false;
      _color = Colors.lightBlue;
    });
  }

  _loadBanner(){
    _banner..load()..show(anchorType: AnchorType.top);
  }



}
