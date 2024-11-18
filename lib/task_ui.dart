// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mvvm_flutter_app/task_model.dart';
// import 'package:mvvm_flutter_app/superhero_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// class TaskListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => TaskViewModel(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Tasks')),
//         body: Consumer<TaskViewModel>(
//           builder: (context, viewModel, child) {
//             return ListView.builder(
//               itemCount: viewModel.tasks.length,
//               itemBuilder: (context, index) {
//                 final task = viewModel.tasks[index];
//                 return ListTile(
//                   title: Text(task.title!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 30),),
//                   trailing: Checkbox(
//                     value: task.isCompleted,
//                     onChanged: (_) {
//                       viewModel.toggleTaskComplete(index);
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             print("Add Task");
//             viewModel.addTask(TaskModel(title: 'New Task'));
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/superhero_viewmodel.dart';
import 'package:mvvm_flutter_app/task_model.dart';
import 'package:provider/provider.dart';

class SuperheroView extends StatelessWidget {
  const SuperheroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Marvel Superheroes'),
      ),
      body: Consumer<SuperheroViewModel>(builder: (context, viewModel, child) {
        print("viewModel.fetchingData"+viewModel.fetchingData.toString());
        if (!viewModel.fetchingData && viewModel.superheroes.isEmpty) {
          print("viewModel.fetchingData"+viewModel.fetchingData.toString());

          Provider.of<SuperheroViewModel>(context)
              .fetchSuperheroes();
        }
        if (viewModel.fetchingData) {
          // While data is being fetched
          return const LinearProgressIndicator();
        } else {
          // If data is successfully fetched
          List<SuperHero> heroes = viewModel.superheroes;
          return Column(
            children: [
              Flexible(
                  child: ListView.builder(
                    itemCount: heroes.length,
                    itemBuilder: (context, index) {
                      return ListCard(character: heroes[index]);
                    },
                  ))
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<SuperheroViewModel>(context, listen: false)
              .fetchSuperheroes();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

//class for List Card
class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.character});

  final SuperHero character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetailScreen(characterDetail: character)));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      image: NetworkImage(character.imageUrl ?? ""),
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                character.realName ?? "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

// class for hero detail screen
class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.characterDetail});

  final SuperHero characterDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(characterDetail.name ?? "")),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Image(
            image: NetworkImage(characterDetail.imageUrl ?? ""),
          ),
        ));
  }
}
