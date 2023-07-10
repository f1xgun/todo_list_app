class NavigationState {
  final bool? _unknown;
  String? selectedTaskId;
  final bool? _isNewTask;

  bool get isDetailsScreen => selectedTaskId != null;

  bool get isUnknown => _unknown ?? false;

  bool get isRoot => !isDetailsScreen && !isUnknown;

  bool get isNewTaskScreen => _isNewTask ?? false;

  NavigationState.root()
      : selectedTaskId = null,
        _isNewTask = false,
        _unknown = false;

  NavigationState.taskDetails(this.selectedTaskId)
      : _unknown = false,
        _isNewTask = false;

  NavigationState.unkown()
      : _unknown = true,
        selectedTaskId = null,
        _isNewTask = false;

  NavigationState.newTask()
      : _unknown = false,
        selectedTaskId = null,
        _isNewTask = true;
}
