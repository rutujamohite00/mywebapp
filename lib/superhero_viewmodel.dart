import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/superheroRepository.dart';
import 'package:mvvm_flutter_app/task_model.dart';

/*
class TaskViewModel extends ChangeNotifier
{
  List<TaskModel> tasks= [];

  List<TaskModel> get tasks1 => tasks;

  void addTask(TaskModel task) {
    tasks.add(task);
    print(tasks.length.toString());
    notifyListeners();
  }

  void toggleTaskComplete(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted!;
    notifyListeners();
  }

}*/



class SuperheroViewModel extends ChangeNotifier {
  final SuperheroRepository _repository = SuperheroRepository();

  List<SuperHero> _superheroes = [];
  bool fetchingData = false;
  List<SuperHero> get superheroes => _superheroes;

  Future<void> fetchSuperheroes() async {
    print("here ");
    fetchingData = true;
    try {
      _superheroes = await _repository.getSuperheroes();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load superheroes: $e');
    }
    fetchingData = false;
  }
}
