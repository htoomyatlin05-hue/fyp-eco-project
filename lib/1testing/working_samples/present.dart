import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/design/apptheme/colors.dart';
import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/dropdown_attributes.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/dropdown_attributes_linked.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/widgets1.dart';

class DynamicDropdownMaterialAcquisitionpresent extends StatefulWidget {
  final List<String> columnTitles;
  final List<bool> isTextFieldColumn;
  final List<String> apiEndpoints;
  final List<String?> jsonKeys;
  final String addButtonLabel;
  final double padding;
  final Function(List<List<String?>> data)? onDataChanged;



  const DynamicDropdownMaterialAcquisitionpresent({
    super.key,
    required this.columnTitles,
    required this.isTextFieldColumn,
    required this.apiEndpoints,
    required this.jsonKeys,
    required this.addButtonLabel,
    required this.padding,
    this.onDataChanged,
  });

  @override
  State<DynamicDropdownMaterialAcquisitionpresent> createState() =>
      _DynamicDropdownMaterialAcquisitionpresentState();
}

class _DynamicDropdownMaterialAcquisitionpresentState
    extends State<DynamicDropdownMaterialAcquisitionpresent> {
  late List<List<String?>> selections;
  Map<int, List<String>> dropdownData = {};

  @override
  void initState() {
    super.initState();
    selections = List.generate(
      widget.columnTitles.length,
      (col) => [''],
    );
    fetchAllColumnData();
  }

  List<Map<String, String?>> formattedRows() {
  final rows = <Map<String, String?>>[];
  final rowCount = selections[0].length;

  for (int row = 0; row < rowCount; row++) {
    final rowData = <String, String?>{};
    for (int col = 0; col < widget.columnTitles.length; col++) {
      rowData[widget.columnTitles[col]] = selections[col][row];
    }
    rows.add(rowData);
  }
  return rows;
}

String? getCell(int col, int row) => selections[col][row];

double getCellAsDouble(int col, int row) =>
    double.tryParse(selections[col][row] ?? '') ?? 0.0;

List<String?> getColumn(int col) => selections[col];

List<double> getColumnAsDouble(int col) => selections[col]
    .map((v) => double.tryParse(v ?? '0') ?? 0.0)
    .toList();

void _notifyParent() {
  if (widget.onDataChanged != null) {
    widget.onDataChanged!(selections);
  }
}

// assign a numeric value to each dropdown item
final Map<String, double> dropdownValues = {
  "Steel": 2.0,
  "Aluminium": 1.5,
  "Van": 2.0,
  "Truck": 4.0,
  "": 0,
  "(E)-HFC-1225ye": 1,
"(Z)-1,1,1,4,4,4-Hexafluoro-2-butene": 1.6,
"1,1,1,3,3,3-Hexafluoro-2-propanol" : 1.8,
"1,1,1,3,3,3-Hexafluoropropan-2-yl formate": 1.5,
"1,1,1-Trichloroethane": 1.3,
"1,1,2,2-Tetrafluoro-1-methoxyethane": 1.2,
"1,1,2,2-Tetrafluoro-3-methoxy-propane": 125,

  //--ADD MORE HERE--
};

double computeRowFormula(int row) {
  double result = 1.0;

  for (int col = 0; col < selections.length; col++) {
    if (widget.isTextFieldColumn[col]) {
      // TextField → numeric input
      result *= getCellAsDouble(col, row);
    } else {
      // Dropdown → lookup numeric value
      final selected = getCell(col, row);
      result *= dropdownValues[selected] ?? 1.0;
    }
  }

  return result;
}



  void loopExample() {
    for (int row = 0; row < selections[0].length; row++) {
      print("Row $row first column = ${getCell(0, row)}");
    }
  }


  Future<void> fetchAllColumnData() async {
    dropdownData.clear();

    for (int i = 0; i < widget.apiEndpoints.length; i++) {
      String endpoint = widget.apiEndpoints[i];
      String? jsonKey = widget.jsonKeys[i];

      if (endpoint.isEmpty || jsonKey == null) continue;

      try {
        final response = await http.get(Uri.parse(endpoint));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          List<String> items = [];
          if (data[jsonKey] != null && data[jsonKey] is List) {
            items = List<String>.from(data[jsonKey]);
          }

          setState(() {
            dropdownData[i] = items;
            selections[i][0] = items.isNotEmpty ? items.first : '';
          });
        }
      } catch (e) {
        debugPrint("Failed load col $i : $e");
      }
    }
  }

  void _addRow() {
    setState(() {
      for (int col = 0; col < selections.length; col++) {
        if (widget.isTextFieldColumn[col]) {
          selections[col].add('');
        } else {
          final items = dropdownData[col] ?? [];
          selections[col].add(items.isNotEmpty ? items.first : '');
        }
      }
    });
    _notifyParent();
  }

  void _removeRow(int index) {
    setState(() {
      for (final col in selections) {
        if (index < col.length) col.removeAt(index);
      }
    });
    _notifyParent();
  }

  void postSelections() {
  final body = formattedRows();
  print(body);
}

  @override
  Widget build(BuildContext context) {
    final numRows = selections.isNotEmpty ? selections[0].length : 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        const double columnwidthmin = 180;
        final double parentwidth = constraints.maxWidth;
        final int columnno = widget.columnTitles.length;

        double paddingcompensate = ((widget.padding*2) * columnno);

        double calculatedwidth = (parentwidth - paddingcompensate)/columnno;

        double columnwidth = calculatedwidth < columnwidthmin
        ? columnwidthmin
        : calculatedwidth;


        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: 
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int col = 0; col < widget.columnTitles.length; col++)
                  Padding(
                    padding: EdgeInsets.all(widget.padding),
                    child: 
                    Container(
                      width: columnwidth,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1, 
                          color: Apptheme.drawer
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: 
                      ListView(
                        children: [
                          Text(
                            widget.columnTitles[col],
                            style: TextStyle(
                              fontSize: 15,
                              color: Apptheme.textclrdark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          for (int row = 0; row < numRows; row++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: 
                              Container(
                                height: 30,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Apptheme.widgetsecondaryclr,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                              child: Row(
                                children: [

                                  Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Apptheme.widgetclrlight,
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                          child:
                                          Center(
                                          child: 
                                            Text('${row + 1}',
                                            style: TextStyle(
                                              color: Apptheme.textclrdark,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                            ),
                                            ),
                                          ),
                                        ),
                                    ),
                                  
                                  Expanded(
                                    child: widget.isTextFieldColumn[col]
                                        ? TextField(
                                          enabled: true,
                                            cursorColor: Apptheme.textclrlight,
                                            cursorHeight: 15,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp(r'[0-9.]')),
                                              ],
                                              style: TextStyle(
                                                  color: Apptheme.textclrlight),
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                                                                
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Apptheme.unselected,
                                                  )
                                                ),

                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Apptheme.widgetborderlight
                                                  )
                                                ),

                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Apptheme.error,
                                                  )
                                                ),

                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Apptheme.error,
                                                  )
                                                ),

                                                disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Apptheme.widgetsecondaryclr,
                                                  )
                                                ),

                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 0),
                                              ),
                                              onChanged: (val) {
                                                setState(() {
                                                  selections[col][row] = val;
                                                });
                                                _notifyParent();
                                              },
                                            )
                                        : DropdownButtonHideUnderline(
                                            child: 
                                            DropdownButton<String>(
                                              dropdownColor: Apptheme.widgetsecondaryclr,
                                                icon:
                                                 Icon(Icons.arrow_drop_down,
                                                   color: Apptheme.iconslight,
                                                   size: 20,
                                                 ),
                                                padding: EdgeInsets.zero,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Apptheme.textclrlight,
                                                  fontWeight: FontWeight.w500
                                                ),
                                                value: selections[col][row],
                                                isExpanded: true,
                                              items: (dropdownData[col] ?? [])
                                                  .map((item) =>
                                                      DropdownMenuItem(
                                                        value: item,
                                                        child: 
                                                        Text(item,
                                                        overflow: TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selections[col][row] = value;
                                                });
                                                _notifyParent();
                                              },
                                            ),
                                          ),
                                  ),

                                  if (col == 0)
                                    Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Apptheme.widgetclrlight,
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(Icons.delete,
                                              size: 16, color: Apptheme.iconsprimary),
                                          onPressed: () => _removeRow(row),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        if (col == 0)
                          Center(
                            child: 
                            SizedBox(
                              width: 200,
                              height: 20,
                              child: ElevatedButton.icon(
                                onPressed: _addRow,
                                icon: const Icon(Icons.add, size: 16),
                                label: Text(widget.addButtonLabel),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Apptheme.auxilary,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),


                          if (widget.isTextFieldColumn[col])
                            Center(
                              child: SizedBox(
                                width: 200,
                                height: 20,
                                child: ElevatedButton(
                                  onPressed: () {
                                    postSelections();
                                    double result = computeRowFormula(0);
                                    print("Emissions from material acquisition: $result");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Apptheme.widgetsecondaryclr,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text("Save"),
                                ),
                              ),
                            )
                       
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}


class Dynamicprdanalysispresent extends StatefulWidget {
  final VoidCallback settingstogglee;
  const Dynamicprdanalysispresent({super.key, required this.settingstogglee});

  @override
  State<Dynamicprdanalysispresent> createState() => _DynamicprdanalysispresentState();
}

class _DynamicprdanalysispresentState extends State<Dynamicprdanalysispresent> {
  String? selectedBoundary = 'Cradle';

  @override
  Widget build(BuildContext context) {

    final List<Widget> widgetofthispage=[

      //--Buffer--

      SizedBox(
        width: double.infinity,
        height: 180,
      ),

      //--ROW 1--
      Labels(title: 'Attribute: Materials',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Material', 'Mass', 'Distance', 'Transport Mode'], 
        isTextFieldColumn: [false, true, true, false,], 
        addButtonLabel: 'Add material', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options', '', '', 'http://127.0.0.1:8000/meta/options' ],
        jsonKeys: [ 'materials', '', '', 'transport_types'],
        ),
      ),
     
      //--ROW 2--
      Labels(title: 'Attribute: Production',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Select GHG', 'Total Charge', 'Remaining Charge'], 
        isTextFieldColumn: [false, true, true,], 
        addButtonLabel: 'Add GHG', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options'],
        jsonKeys: [ 'GHG'],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),

      if (selectedBoundary == 'Grave') ...[
      //--ROW 3--
      Labels(title: 'Attribute: Distribution',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Transportation', 'Distance'], 
        isTextFieldColumn: [false, true], 
        addButtonLabel: 'Add transport cycle', 
        padding: 5, 
        apiEndpoints: ['http://127.0.0.1:8000/meta/options'],
        jsonKeys: ['transport_types'],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),

      //--ROW 3.A--
      Labels(title: 'Attribute: Storage',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Facilities', 'Stored duration', 'Area', 'Select GHG'], 
        isTextFieldColumn: [false, true, true, false,], 
        addButtonLabel: 'Add facility', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options', '', '', 'http://127.0.0.1:8000/meta/options' ],
        jsonKeys: [ 'facilities', '', '', 'GHG'],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),
      

      //--ROW 4--
      Labels(title: 'Attribute: Usage Cycle',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Use activity', 'Expected use cycle', 'Unit'], 
        isTextFieldColumn: [false, true, true,], 
        addButtonLabel: 'Add use cycle', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options'],
        jsonKeys: [ 'usage_types'],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),

      //--ROW 5--
      Labels(title: 'Attribute: Disassembly',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Product Type', 'Mass', 'Energy required',], 
        isTextFieldColumn: [false, true, true,], 
        addButtonLabel: 'Add disassembly cycle', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options'],
        jsonKeys: [ 'disassembly_by_industry'],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),

      //--ROW 6--
      Labels(title: 'Attribute: End of Life',),
      Widgets1(aspectratio: 16/9, maxheight: 200,
      child:
      DynamicDropdownMaterialAcquisitionpresent(
        columnTitles: ['Process', 'Material', 'Amount',], 
        isTextFieldColumn: [false, false, true,], 
        addButtonLabel: 'Add process', 
        padding: 5, 
        apiEndpoints: [ 'http://127.0.0.1:8000/meta/options', 'http://127.0.0.1:8000/meta/options'],
        jsonKeys: [ 'process', 'materials', ''],
        onDataChanged: (data) {
          print("Updated: $data");
        },
        ),
      ),

      //--ROW Example--
      Labels(title: 'Example',),
      Widgets1(aspectratio: 16/9, maxheight: 400,
      child:
      DynamicDropdownGroup(
        columnTitles: ['Example', 'Example', 'Example',], 
        dropdownItems: [
          ['Aluminium', 'Copper', 'Brass'],
          ['Aluminium', 'Copper', 'Brass']
        ], 
        isTextFieldColumn: [false, false, true,], 
        addButtonLabel: 'Add Example',
        padding: 5,
        ),
      ),
    ]

    ];

    return SizedBox(
        child: 
          Stack(
          children: [

            //--Main Page--
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Padding(padding: EdgeInsetsGeometry.all(15),
              child: 
              ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: widgetofthispage.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Apptheme.transparentcheat,
                    child: widgetofthispage[index],
                  );
                },
                )
              ),
            ),

            //--Custom Header for Home--
            Container(
            height: 200,
            width: double.infinity,
            decoration: 
            BoxDecoration(
              color: Apptheme.header,
                boxShadow: [
                  BoxShadow(
                    color: Apptheme.header,
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 4)
                  )
                ]
            ),
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                      //--"Title"--
                      Expanded(
                        child: 
                          Center(
                            child: Padding (padding: EdgeInsetsGeometry.only(left:20, right: 20, top: 15),
                                child:
                                ListView(
                                  children: [

                                    //--TITLE--
                                    Text('Attributes',
                                    style: TextStyle(
                                      color: Apptheme.textclrlight,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    ),

                                    //--Summary--
                                    Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Subtitlesummary(
                                        words: 'Define product parameters. All excluded categories must be declared in the declaration section', 
                                        color: Apptheme.widgetsecondaryclr,),
                                    ),
                                  
                                    //--Boundary Definer--
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: 
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                        
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedBoundary = 'Cradle';
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: Apptheme.widgetsecondaryclr,
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Tabtext(words: 'Cradle', specifysize: 20),
                                                ),
                                              ),
                                            ),
                                        
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedBoundary = 'Gate';
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: selectedBoundary == 'Gate'
                                                    ? Apptheme.widgetsecondaryclr
                                                    : Apptheme.unselected,
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Tabtext(words: 'Gate', specifysize: 20),
                                                ),
                                              ),
                                            ),
                                        
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedBoundary == 'Cradle') {
                                                            selectedBoundary = null;
                                                          } else {
                                                            selectedBoundary = 'Grave';
                                                          }
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: selectedBoundary == 'Grave'
                                                    ? Apptheme.widgetsecondaryclr
                                                    : Apptheme.unselected,
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Tabtext(words: 'Grave', specifysize: 20),
                                                ),
                                              ),
                                            ),
                                        
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ),
                          ),
                        ),
                      
                      //--Settings (Trailing)--
                      Align(
                        alignment: AlignmentGeometry.center,
                        child:
                          Padding (padding: EdgeInsetsGeometry.only(right:35, left: 0, top: 5),
                            child: 
                              SizedBox(
                                height: double.infinity,
                                width: 40,
                                child:
                                  IconButton(
                                  onPressed: widget.settingstogglee,
                                  icon: 
                                    Icon(Icons.settings,
                                    size: 25,
                                    color: Apptheme.iconslight,
                                    ),
                                    alignment: AlignmentDirectional.center,
                                    padding: EdgeInsets.zero,
                                  ),                          
                              ),        
                            ), 
                      ),
                      
                    ],
                  ) ,
            ),
            
          ],
          ),
      );

      
  }
}
