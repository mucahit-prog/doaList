import 'package:flutter/material.dart';

class DoaList extends StatefulWidget {
  DoaList({Key key}) : super(key: key);

  @override
  _DoaListState createState() => _DoaListState();
}

class _DoaListState extends State<DoaList> {
  int leng = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      // bottomSheet: addBottomButton(),
      body: Container(
        child: leng < 1 ? Container(
          child: Image.asset("assets/images/background.png",fit: BoxFit.cover,),
        ): Container(
          child: Text('Hello'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 15.0,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  AppBar setAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.list_sharp,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      title: Text('TO DO LIST'),
      centerTitle: true,
    );
  }

  Container addBottomButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Colors.green,
          onPrimary: Colors.white,
          shadowColor: Colors.red,
          elevation: 50,
        ),
        child: Text('MAKE SOME'),
      ),
    );
  }
}
