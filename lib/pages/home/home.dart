import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_application/application/bloc/exersices/exersices_bloc.dart';
import 'package:webview_application/application/models/exercise_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Physical exersices",
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            ExersicesBloc()..add(ExersicesEvent.loadExersices()),
        child: BlocBuilder<ExersicesBloc, ExersicesState>(
          builder: (context, state) {
            if (state.state == ExersicesStateEnum.success) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) => ListViewItem(
                  item: state.list.elementAt(index),
                ),
                itemCount: state.list.length,
              );
            }
            if (state.state == ExersicesStateEnum.error) {
              return Center(
                child: Text(state.errorMessaage ?? "Error..."),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final ExersiceModel item;
  const ListViewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 0,
        color: Color.fromARGB(255, 219, 219, 219),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkResponse(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => ExersiceDescription(item: item),
            );
          },
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        "Mucle groups: ${item.muscleGroups.toString()}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    item.imageUrl,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExersiceDescription extends StatelessWidget {
  final ExersiceModel item;
  const ExersiceDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(25),
            child: Image.asset(
              item.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Text("Muscle groups: ${item.muscleGroups.toString()}"),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Text(
            "Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(item.description),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Text(
            "Performing",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(item.performing),
        ],
      ),
    );
  }
}
