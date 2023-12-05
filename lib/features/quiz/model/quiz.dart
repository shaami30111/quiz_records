import 'package:equatable/equatable.dart';

typedef QuizID = String;

class Quiz extends Equatable {
  final QuizID id;
  final String name;
  final String total;
  final String obtained;


  const Quiz({
    required this.id,
    required this.name,
    required this.total,
    required this.obtained, 
  });

  factory Quiz.fromMap(Map<String, dynamic> map) => Quiz(
        id: map['id'] as String,
        name: map['name'] ?? '',
        total: map['total'] ?? '',
        obtained: map['obtained'] ?? '',

      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'total': total,
        'obtained':obtained,
      };

  // this is a function used for update quiz details
  // in existing instance/object of class
  Quiz copyWith({QuizID? id, String? name, String? total,String? obtained}) => Quiz(
        id: id ?? this.id,
        name: name ?? this.name,
        total: total ?? this.total, obtained: obtained ?? this.obtained,
      );

  @override
  List<Object?> get props => [id, name, total,obtained];

  @override
  bool? get stringify => true;
}
