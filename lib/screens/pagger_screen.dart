import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_widget.dart';
import 'package:mix_cosmetics/reusable_directory/reusable_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mix_cosmetics/Utils.dart';
import 'package:mix_cosmetics/screens/home_page.dart';


class IntroPageView extends StatefulWidget {

  final bool reversePager;

  IntroPageView({Key key, @required this.reversePager}) : super(key: key);

  @override
  _IntroPageViewState createState() => _IntroPageViewState(reversePager);
}

class _IntroPageViewState extends State<IntroPageView> {

  bool reversePager;

  final arController = PageController(
    initialPage: 2,
  );
  final enController = PageController(
    initialPage: 0,
  );
  String _locale = '';

  _IntroPageViewState(bool reversePager){
    this.reversePager = reversePager;
  }



  @override
  void initState() {
    super.initState();
    getLocale().then(updateLocale);
  }

  void updateLocale(String locale) {
    //  print('yYy $_locale');
    this._locale = locale;
    print('zZz $_locale');
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          body: Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.symmetric(vertical: 50.0,),
            child: PageIndicatorContainer(
              pageView: PageView(
                //scrollDirection: Axis.vertical,

                pageSnapping: true,
                reverse: !reversePager,
                controller: reversePager?enController:arController,
                children:
                reversePager?
                <Widget>[
                  new ReusableBG(
                    imgB: "assets/bg_intro_1.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('discover'),
                      txt2: AppLocalizations.of(context).tr('latest'),
                      txt3: AppLocalizations.of(context).tr('shop'),
                      txt4: AppLocalizations.of(context).tr('we'),
                    ),
                  ),
                  new ReusableBG(
                    imgB: "assets/bg_intro_2.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('new'),
                      txt2: AppLocalizations.of(context).tr('products'),
                      txt3: AppLocalizations.of(context).tr('collections'),
                      txt4: AppLocalizations.of(context).tr('exclusive'),
                    ),
                  ),
                  new ReusableBG(
                    imgB: "assets/bg_intro_3.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('be'),
                      txt2: AppLocalizations.of(context).tr('beauty'),
                      txt3: AppLocalizations.of(context).tr('best'),
                      txt4: AppLocalizations.of(context).tr('eye'),
                    ),
                  ),
                ]
                    :<Widget>[
                  new ReusableBG(
                    imgB: "assets/bg_intro_3.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('be'),
                      txt2: AppLocalizations.of(context).tr('beauty'),
                      txt3: AppLocalizations.of(context).tr('best'),
                      txt4: AppLocalizations.of(context).tr('eye'),
                    ),
                  ),
                  new ReusableBG(
                    imgB: "assets/bg_intro_2.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('new'),
                      txt2: AppLocalizations.of(context).tr('products'),
                      txt3: AppLocalizations.of(context).tr('collections'),
                      txt4: AppLocalizations.of(context).tr('exclusive'),
                    ),
                  ),
                  new ReusableBG(
                    imgB: "assets/bg_intro_1.png",
                    textB: new ReusableTxt(
                      txt1: AppLocalizations.of(context).tr('discover'),
                      txt2: AppLocalizations.of(context).tr('latest'),
                      txt3: AppLocalizations.of(context).tr('shop'),
                      txt4: AppLocalizations.of(context).tr('we'),
                    ),
                  ),


                ],
                //pageSnapping: true,
              ),
              align: IndicatorAlign.bottom,
              length: 3,
              indicatorSpace:10.0,
              indicatorColor: Colors.blue,
              indicatorSelectorColor: Colors.white,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(

            onPressed: () {
              setUserWatchIntroFlag(1);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePV()),
              );
            },
            backgroundColor: Color.fromARGB(100, 1, 126, 187),
            elevation: 0.0,
            label: Text(
              AppLocalizations.of(context).tr('skip'),
              style: TextStyle(
                  fontFamily: 'BerlinBold',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23),
            ),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
