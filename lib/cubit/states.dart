abstract class ToDoStates {}

//States is HERE
class InitialState extends ToDoStates {}

class ChangeBottomNavState extends ToDoStates {}

class ChangeBottomSheetState extends ToDoStates {}

class TaskIsCheckedState extends ToDoStates {}

//DataBase
class CreateDatabaseState extends ToDoStates {}

class GetDatabaseState extends ToDoStates {}

class InsertDatabaseState extends ToDoStates {}

class UpdateDatabaseState extends ToDoStates {}

class DeleteFromDatabaseState extends ToDoStates {}