import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/design/apptheme/colors.dart';

class DynamicDropdownGroup extends StatefulWidget {
  final List<String> columnTitles; // e.g. ["Material Profiles", "Transport Cycle", "Distance (km)"]
  final List<List<String>> dropdownItems; // per-column dropdowns
  final List<bool> isTextFieldColumn; // marks which column uses TextField instead of Dropdown
  final String addButtonLabel; // e.g. "Add Material"
  final double padding;

  const DynamicDropdownGroup({
    super.key,
    required this.columnTitles,
    required this.dropdownItems,
    required this.isTextFieldColumn,
    required this.addButtonLabel,
    required this. padding
  });

  @override
  State<DynamicDropdownGroup> createState() => _DynamicDropdownGroupState();
}

class _DynamicDropdownGroupState extends State<DynamicDropdownGroup> {
  
  late List<List<String?>> selections;

  @override
  void initState() {
    super.initState();
    selections = List.generate(
      widget.columnTitles.length,
      (col) => [widget.isTextFieldColumn[col] 
      ? '' 
      : widget.dropdownItems[col].first],
    );
  }

  void _addRow() {
  setState(() {
    for (int i = 0; i < selections.length; i++) {
      if (widget.isTextFieldColumn[i]) {
        selections[i].add(''); 
      } else {
        selections[i].add(widget.dropdownItems[i].first);
      }
    }
  });
}

void _removeRow(int index) {
  setState(() {
    for (final column in selections) {
      if (index < column.length) {
        column.removeAt(index);
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    final numRows = selections[0].length;

    return 
    LayoutBuilder(
      builder: (context, constraints) {
        const double columnwidthmin = 180;
        final double parentwidth = constraints.maxWidth;
        final int columnno = widget.columnTitles.length;

        double paddingcompensate = ((widget.padding*2) * columnno);

        double calculatedwidth = (parentwidth - paddingcompensate)/columnno;

        double columnwidth = calculatedwidth < columnwidthmin
        ? columnwidthmin
        : calculatedwidth;

        return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              
            for (int col = 0; col < widget.columnTitles.length; col++) ...[
              Padding(
                padding: EdgeInsets.all(widget.padding),
                child: 
                Container(
                  width: columnwidth,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Apptheme.drawer),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: 
                  Column(
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
                      
                      for (int row = 0; row < numRows; row++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: 
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Apptheme.auxilary,
                            ),
                            child: 
                            Row(
                              children: [
        
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Apptheme.widgetclrlight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${row + 1}',
                                        style: TextStyle(
                                          color: Apptheme.textclrdark,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                    
                                Expanded(
                                  child: widget.isTextFieldColumn[col]
                                      ? TextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                          ],
                                          style: TextStyle(
                                            color: Apptheme.textclrlight,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                          ),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: Apptheme.widgetsecondaryclr,
                                            value: selections[col][row],
                                            isExpanded: true,
                                            style: TextStyle(
                                              color: Apptheme.textclrlight,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            items: widget.dropdownItems[col]
                                                .map((item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(item),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selections[col][row] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                ),
                    
                                if (col == 0)
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Apptheme.widgetclrlight,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.delete, 
                                        size: 16, 
                                        color: Apptheme.iconsprimary,
                                        ),
                                        onPressed: () => _removeRow(row),
                                      ),
                                    ),
                                  ),
                              
                              ],
                            ),
                          ),
                        ),
                      ],
              
                      if (col == 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton.icon(
                            onPressed: _addRow,
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(widget.addButtonLabel),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Apptheme.auxilary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(150, 32),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      );
      }

      

    );
  }
}
