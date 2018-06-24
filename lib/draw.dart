import 'package:flutter/material.dart';

class DrawComponent extends StatefulWidget {
  @override
  _DrawComponentState createState() => new _DrawComponentState();
}

class _DrawComponentState extends State<DrawComponent> {
  List<Path> _paths = <Path>[];
  Path _path = new Path();
  bool _repaint = false;
  int back = 0;

  _DrawComponentState(){
    _paths = [new Path()];
  }
  panDown(DragDownDetails details) {
    setState(() {
      _path = new Path();
      _paths.add(_path);
      RenderBox object = context.findRenderObject();
      Offset _localPosition = object.globalToLocal(details.globalPosition);
      _paths.last.moveTo(_localPosition.dx, _localPosition.dy);
      _repaint = true;
    });
  }

  panUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox object = context.findRenderObject();
      Offset _localPosition = object.globalToLocal(details.globalPosition);
      _paths.last.lineTo(_localPosition.dx, _localPosition.dy);
    });
  }

  panEnd(DragEndDetails details) {
    setState(() {
//      _repaint = true;
    });
  }

  backClick() {
    setState(() {
      if (_paths.isNotEmpty) _paths.removeLast();

    });
  }
  forwardClick(){
  }
  reset(){
    setState(() {
      _path = new Path();
      _paths = [new Path()];
      _repaint = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Scaffold(
          backgroundColor: Colors.white,
          body: new GestureDetector(
            onPanDown: (DragDownDetails details) => panDown(details),
            onPanUpdate: (DragUpdateDetails details) => panUpdate(details),
            onPanEnd: (DragEndDetails details) => panEnd(details),
            child: new ClipRect(
              child: new CustomPaint(
                painter: new PathPainter(paths: _paths, repaint: _repaint),
                size: Size.infinite,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        height: 40.0,
        margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        child: new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new FlatButton(
                onPressed: () => backClick(),
                child: new Icon(Icons.arrow_left),
                color: Colors.lightGreen,
              ),
              new FlatButton(
                onPressed: () => reset(),
                child: new Icon(Icons.cancel),
                color: Colors.lightGreen,
              ),
              new FlatButton(
                onPressed: () => forwardClick(),
                child: new Icon(Icons.arrow_right),
                color: Colors.lightGreen,
              ),
            ],
          ),

        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}

class PathPainter extends CustomPainter {
  List<Path> paths;
  bool repaint;
  PathPainter({this.paths, this.repaint});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.2;

    paths.forEach((path){
      canvas.drawPath(path, paint);
    });

    repaint = false;
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => repaint;
}