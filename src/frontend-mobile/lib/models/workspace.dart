class Workspace {
  final int? workspaceId;
  final String name;
  final int capacity;
  final String location;
  final String status;
  final String? description;

  Workspace({
    this.workspaceId,
    required this.name,
    required this.capacity,
    required this.location,
    required this.status,
    this.description,
  });

  factory Workspace.fromJson(Map<String, dynamic> json) => Workspace(
        workspaceId: json["workspaceId"] as int?,
        name: json["name"] as String,
        capacity: json["capacity"] as int,
        location: json["location"] as String,
        status: json["status"] as String,
        description: json["description"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "workspaceId": workspaceId,
        "name": name,
        "capacity": capacity,
        "location": location,
        "status": status,
        "description":description,
      };
}


