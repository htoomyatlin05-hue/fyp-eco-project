import 'package:flutter/material.dart';

class Leftdrawerlisttilelightanimated extends StatefulWidget {
  final String title;
  final VoidCallback? whathappens;

  const Leftdrawerlisttilelightanimated({
    Key? key,
    required this.title,
    required this.whathappens,
  }) : super(key: key);

  @override
  State<Leftdrawerlisttilelightanimated> createState() => _LeftdrawerlisttilelightanimatedState();
}

class _LeftdrawerlisttilelightanimatedState extends State<Leftdrawerlisttilelightanimated>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    // auto-scroll back and forth
    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _animationController.value *
              (_scrollController.position.maxScrollExtent),
        );
      }
    });

    // loop animation
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200], // Apptheme.drawerlight
      ),
      padding: const EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.bookmark, size: 15),
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black, Colors.transparent],
                  stops: [0.0, 0.9, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: TextButton(
                  onPressed: widget.whathappens,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black, // Apptheme.textclrdark
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
