import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';

//--THESE ARE THE TABS, IMPORT THIS IN INTENDED PAGE--
class ManualTabpages extends StatefulWidget {
  final String Tab1;
  final double Tab1fontsize;
  final String Tab2;
  final double Tab2fontsize;
  final String Tab3;
  final double Tab3fontsize;

  final Widget Firstchildof1;
  final Widget Firstchildof2;
  final Widget Firstchildof3;
  final Widget Secondchildof1;
  final Widget Secondchildof2;
  final Widget Secondchildof3;
  final int Pg1flexValue1;
  final int Pg1flexValue2;
  final int Pg2flexValue1;
  final int Pg2flexValue2;
  final int Pg3flexValue1;
  final int Pg3flexValue2;

  final Color backgroundcolor;

  const ManualTabpages({Key? key, 
  required this.Tab1,
  required this.Tab1fontsize,
  required this.Tab2,
  required this.Tab2fontsize,
  required this.Tab3,
  required this.Tab3fontsize,

  required this. Pg1flexValue1,
  required this. Pg1flexValue2,
  required this. Pg2flexValue1,
  required this. Pg2flexValue2,
  required this. Pg3flexValue1,
  required this. Pg3flexValue2,

  required this.Firstchildof1,
  required this.Firstchildof2,
  required this.Firstchildof3,
  required this.Secondchildof1,
  required this.Secondchildof2,
  required this.Secondchildof3,

  this.backgroundcolor = Apptheme.backgroundlight,


  required
  
  }) : super(key: key);

  @override
  State<ManualTabpages> createState() => _ManualTabpages();
}

class _ManualTabpages extends State<ManualTabpages> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Apptheme.tabbedpageclr,
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              
              Material(
                color: widget.backgroundcolor,
                child: TabBar(
                  padding: EdgeInsets.all(0),
                  indicatorPadding: EdgeInsetsGeometry.all(0),
                  unselectedLabelColor: Apptheme.textclrlight,
                  labelColor: Apptheme.textclrlight,
                  indicatorColor: Apptheme.tabbedpageclr,  
                  indicator: null,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.only(left: 0, right: 0),
                  tabs: [
                    _getTab(0, Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Center(child: Text(widget.Tab1, style: TextStyle(fontSize: widget.Tab1fontsize, fontWeight: FontWeight.w600),textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1,softWrap: false,)),
                    )),
                    _getTab(1, Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Center(child: Text(widget.Tab2, style: TextStyle(fontSize: widget.Tab2fontsize, fontWeight: FontWeight.w600),textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1,softWrap: false,)),
                    )),
                    _getTab(2, Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Center(child: Text(widget.Tab3, style: TextStyle(fontSize: widget.Tab3fontsize, fontWeight: FontWeight.w600),textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1,softWrap: false,)),
                    )),
                  ],
                ),
              ),


              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    ManualColumn(childof1: widget.Firstchildof1, childof2: widget.Secondchildof1, flexValue1: widget.Pg1flexValue1, flexValue2: widget.Pg1flexValue2),
                    ManualColumn(childof1: widget.Firstchildof2, childof2: widget.Secondchildof2, flexValue1: widget.Pg2flexValue1, flexValue2: widget.Pg2flexValue2),
                    ManualColumn(childof1: widget.Firstchildof3, childof2: widget.Secondchildof3, flexValue1: widget.Pg3flexValue1, flexValue2: widget.Pg3flexValue2)
                  ],
                ),
              ),
            ],
          )),
    );
  }

//--Tabs Displayed--
  _getTab(index, child) {
    return 

    Tab(
      child: 
      SizedBox.expand(
        child: 
            Container(
              child:child,
              decoration: BoxDecoration(
                color: (_selectedTab == index ? Apptheme.tabbedpageclr : Apptheme.unselected),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
        ),
              ),
            )
      );

  }
}

//--COLUMN BASED (EQUIVALENT TO FIRSTTAB)--
class ManualColumn extends StatefulWidget {
  final Widget childof1;
  final Widget childof2;
  final int flexValue1;
  final int flexValue2;

  const ManualColumn({
    Key? key,
    required this.childof1,
    required this.childof2,
    required this.flexValue1,
    required this.flexValue2,
  
  }) : super(key: key);

  @override
  State<ManualColumn> createState() => _ManualColumnState();
}

class _ManualColumnState extends State<ManualColumn> {

  @override
  Widget build(BuildContext context) {
    return
    Padding(padding: EdgeInsetsGeometry.all(15),
    child: 
      Align(
        alignment: AlignmentGeometry.topCenter,
        child:
        FlexboxManual3pg(childof1: widget.childof1, childof2: widget.childof2, flexValue1: widget.flexValue1, flexValue2: widget.flexValue2)
        )
    );
  }
}

//--GENERATES THE ASKED NUMBER OF FLEXIBLE BOXES,--
//--NUMBER OF X AT THE END REPRESENTS THE PAGE (Flexboxx=2nd Tabbed Page)
class FlexboxManual3pg extends StatelessWidget {

  final Widget childof1;
  final Widget childof2;
  final int flexValue1;
  final int flexValue2;

  const FlexboxManual3pg({
    Key? key,
    required this.childof1,
    required this.childof2,
    required this.flexValue1,
    required this.flexValue2,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      children: [

        //--INDIVIDUAL FLEXIBLE BOX 1--
        Flexible(
          fit: FlexFit.tight,
          flex: flexValue1,
          child:
          Padding(padding: EdgeInsetsGeometry.all(5),
          child: 
            Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Apptheme.widgetclrlight,
            ),
            child: childof1,
            ),
          ),
        ),
        //--INDIVIDUAL FLEXIBLE BOX 1--

        //--INDIVIDUAL FLEXIBLE BOX 2--
        Flexible(
          fit: FlexFit.tight,
          flex: flexValue2,
          child:
          Padding(padding: EdgeInsetsGeometry.all(5),
          child: 
            Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Apptheme.widgetclrlight,
            ),
            child: childof2,
            ),
          ),
        ),
        //--INDIVIDUAL FLEXIBLE BOX 2--

      ],
    );

  }
}
