import 'package:flutter/material.dart';

import 'core/api_service.dart';
import 'core/model/todo.dart';
import 'widgets/custom_card.dart';

class DoaList extends StatefulWidget {
  DoaList({Key? key}) : super(key: key);

  @override
  _DoaListState createState() => _DoaListState();
}

class _DoaListState extends State<DoaList> {
  ApiService service = ApiService.getInstance();
  List<ToDo>? todoList = [];
  // GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKEy");
  TextEditingController todoController = TextEditingController();
  String? validator(val) {
    if (val.isEmpty) {
      return "This area is not accept empty value";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: bodyBuild(),
      bottomSheet: BottomAppBar(
        child: bottomBar(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var model = ToDo(
            todoName: todoController.text,
          );
          // Firebase veritabanına ekleme yapmak için
          await ApiService.getInstance().addTodo(model);
        },
        child: Icon(
          Icons.add,
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  FutureBuilder<List<ToDo>> listPage() {
    return FutureBuilder<List<ToDo>>(
      future: service.getTodos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              todoList = snapshot.data;
              return _listView;
            }
            return Center(
              child: Text("Error"),
            );
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget get _listView => ListView.separated(
      itemCount: todoList!.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => dismiss(
          CustomCard(
            title: todoList![index].todoName,
          ),
          todoList![index].key!));

  Widget dismiss(Widget child, String key) {
    return Dismissible(
      child: child,
      key: UniqueKey(),
      secondaryBackground: Center(
        child: Text("Siliniyor"),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dismissDirection) async {
        await service.removeTodos(key);
      },
    );
  }

  Container bodyBuild() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green, Colors.lightGreen]),
      ),
      child: todoList!.length > 1 ? emptyPage() : listPage(),
    );
  }

  Container bottomBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green, Colors.lightGreen]),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {},
          ),
          Expanded(
            child: TextFormField(
              controller: todoController,
              validator: this.validator,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                // alt çizgiye boşluk verir.
                isDense: true,
                hintText: "Enter Quick Task Here",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Column listPage() {
  //   return Column(
  //     children: <Widget>[
  //       // Expanded maximum alanı alır.
  //       Expanded(
  //         child: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.1,
  //           child: ListView.builder(
  //             scrollDirection: Axis.vertical,
  //             itemBuilder: (context, index) => Card(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Text(
  //                   index.toString(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container emptyPage() {
    return Container(
      child: Image.asset(
        "assets/images/background.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  AppBar setAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.green, Colors.lightGreen])),
      ),
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
}
