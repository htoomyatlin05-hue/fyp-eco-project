import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:window_manager/window_manager.dart';

const double barheight= 20;

class Spherebar extends StatelessWidget implements PreferredSizeWidget {


  const Spherebar({super.key});


  @override
  Size get preferredSize => const Size.fromHeight(barheight);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Apptheme.systemUI,
      actions: [
        DragToMoveArea(child:

          Container(
            height: barheight,
            width: screenWidth,
            color: Apptheme.systemUI,
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              //--MINIMIZE--
              Padding(padding: EdgeInsetsGeometry.only(bottom: 0),
              child: 
                SizedBox(
                  height: double.infinity,
                  child: IconButton(onPressed: () => windowManager.minimize(), icon: const Icon(Icons.minimize_rounded),iconSize: 15,padding: EdgeInsets.only(bottom: 10),color: Apptheme.windowcontrols,),
                ),
              ),
      
              //--MAXIMISE/RESTORE--
              SizedBox(
                height: double.infinity,
                width: 50,
                child: IconButton(onPressed: () async {
                          bool isMaximized = await windowManager.isMaximized();
                          if (isMaximized) {
                            await windowManager.unmaximize();
                          } else {
                            await windowManager.maximize();
                          }
                        },
                        icon: const Icon(Icons.expand),iconSize: 15,padding: EdgeInsets.zero,color: Apptheme.windowcontrols,),
              ),

              //--CLOSE--
              SizedBox(
                height: double.infinity,
                width: 50,
                child: IconButton(onPressed: () => windowManager.close(), icon: const Icon(Icons.close),iconSize: 15,padding: EdgeInsets.zero,color: Apptheme.windowcontrols,),
              ),

            ],
            ),
            ),
            )

      ]
    );
  }
}


