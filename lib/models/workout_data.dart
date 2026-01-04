class Exercise {
  final int number;
  final String name;
  final String instruction;

  const Exercise({
    required this.number,
    required this.name,
    required this.instruction,
  });
}

class Workout {
  final String day;
  final String name;
  final String description;
  final int workSeconds;
  final int restSeconds;
  final int roundRestSeconds;
  final int totalRounds;
  final List<Exercise> exercises;

  const Workout({
    required this.day,
    required this.name,
    required this.description,
    required this.workSeconds,
    required this.restSeconds,
    required this.roundRestSeconds,
    required this.totalRounds,
    required this.exercises,
  });
}

class WorkoutData {
  static const List<Workout> workouts = [
    // Monday: Total Body Metabolic Circuit
    Workout(
      day: 'Monday',
      name: 'Total Body Metabolic Circuit',
      description: 'Perform each exercise for 45 seconds. Rest 15 seconds to switch. Complete all 6 exercises (1 Round). Rest 90 seconds. Repeat for 4 Rounds total.',
      workSeconds: 45,
      restSeconds: 15,
      roundRestSeconds: 90,
      totalRounds: 4,
      exercises: [
        Exercise(
          number: 1,
          name: 'Two-Handed Swing',
          instruction: 'Continuous explosive movement. Snap hips hard.',
        ),
        Exercise(
          number: 2,
          name: 'Push-Ups',
          instruction: 'Standard or on knees. Keep pace steady.',
        ),
        Exercise(
          number: 3,
          name: 'Goblet Squat',
          instruction: 'Hold bell at chest. Squat to parallel.',
        ),
        Exercise(
          number: 4,
          name: 'Single-Arm Row',
          instruction: 'Switch arms halfway (at 22 seconds).',
        ),
        Exercise(
          number: 5,
          name: 'Reverse Lunge',
          instruction: 'Bodyweight or hold bell. Alternating legs.',
        ),
        Exercise(
          number: 6,
          name: 'Mountain Climbers',
          instruction: 'Hands on floor/bench. Drive knees to chest. (Cardio focus).',
        ),
      ],
    ),
    
    // Tuesday: The "Swing" Cardio Intervals
    Workout(
      day: 'Tuesday',
      name: 'The "Swing" Cardio Intervals',
      description: 'High volume swings for maximum heart rate. 4 Rounds. Work 45s / Rest 15s.',
      workSeconds: 45,
      restSeconds: 15,
      roundRestSeconds: 90,
      totalRounds: 4,
      exercises: [
        Exercise(
          number: 1,
          name: 'Two-Handed Swing',
          instruction: 'Focus on breathing. Sharp exhale at top.',
        ),
        Exercise(
          number: 2,
          name: 'Plank Hold',
          instruction: 'Active recovery for lungs, hard work for abs.',
        ),
        Exercise(
          number: 3,
          name: 'Two-Handed Swing',
          instruction: 'Second set. Keep the power high.',
        ),
        Exercise(
          number: 4,
          name: 'Step-Back Jacks',
          instruction: 'Low impact jumping jacks (step side-to-side, don\'t jump).',
        ),
        Exercise(
          number: 5,
          name: 'Two-Handed Swing',
          instruction: 'Third set. Grip might be tired—hold tight.',
        ),
        Exercise(
          number: 6,
          name: 'Farmer\'s Walk',
          instruction: 'Hold bell in one hand (Switch halfway). Walk circles in room.',
        ),
      ],
    ),
    
    // Wednesday: Upper Body & Core Endurance
    Workout(
      day: 'Wednesday',
      name: 'Upper Body & Core Endurance',
      description: '4 Rounds. Work 40s / Rest 20s. (Slightly more rest to focus on form).',
      workSeconds: 40,
      restSeconds: 20,
      roundRestSeconds: 90,
      totalRounds: 4,
      exercises: [
        Exercise(
          number: 1,
          name: 'Overhead Press',
          instruction: 'Right arm for 20s, Left arm for 20s. Strict press.',
        ),
        Exercise(
          number: 2,
          name: 'Halo',
          instruction: 'Rotate bell around head. Alternate directions.',
        ),
        Exercise(
          number: 3,
          name: 'Deadlift',
          instruction: 'Touch floor and stand. Slower pace, heavy squeeze.',
        ),
        Exercise(
          number: 4,
          name: 'Push-Ups',
          instruction: 'Do as many as possible, then hold plank position.',
        ),
        Exercise(
          number: 5,
          name: 'Russian Twist',
          instruction: 'Sit on floor, lean back, twist torso side to side (No weight).',
        ),
        Exercise(
          number: 6,
          name: 'Rack Carry',
          instruction: 'Hold bell at chest height. Walk. Switch arms halfway.',
        ),
      ],
    ),
    
    // Thursday: Leg Stamina (The Burner)
    Workout(
      day: 'Thursday',
      name: 'Leg Stamina (The Burner)',
      description: '4 Rounds. Work 45s / Rest 15s. Legs will burn; keep moving.',
      workSeconds: 45,
      restSeconds: 15,
      roundRestSeconds: 90,
      totalRounds: 4,
      exercises: [
        Exercise(
          number: 1,
          name: 'Goblet Squat',
          instruction: 'Steady rhythm. Don\'t pause at the top.',
        ),
        Exercise(
          number: 2,
          name: 'Glute Bridge',
          instruction: 'Lying on back, lift hips. Squeeze glutes. (Active recovery).',
        ),
        Exercise(
          number: 3,
          name: 'Reverse Lunge',
          instruction: 'Hold bell at chest (Goblet style). Alternating legs.',
        ),
        Exercise(
          number: 4,
          name: 'Two-Handed Swing',
          instruction: 'Use the hips to give the legs a break from squatting.',
        ),
        Exercise(
          number: 5,
          name: 'Wall Sit',
          instruction: 'Sit against wall, thighs parallel to floor. Hold!',
        ),
        Exercise(
          number: 6,
          name: 'Suitcase Deadlift',
          instruction: 'Bell on side of foot. Stand up. Switch hands halfway.',
        ),
      ],
    ),
    
    // Friday: The "Friday Finisher"
    Workout(
      day: 'Friday',
      name: 'The "Friday Finisher"',
      description: 'Fast pace. 5 Rounds. 30s Work / 15s Transition.',
      workSeconds: 30,
      restSeconds: 15,
      roundRestSeconds: 60,
      totalRounds: 5,
      exercises: [
        Exercise(
          number: 1,
          name: 'Two-Handed Swing',
          instruction: 'Fast & explosive.',
        ),
        Exercise(
          number: 2,
          name: 'Push-Ups',
          instruction: 'Fast pace.',
        ),
        Exercise(
          number: 3,
          name: 'Bodyweight Squat',
          instruction: 'No weight. Move fast.',
        ),
        Exercise(
          number: 4,
          name: 'Mountain Climbers',
          instruction: 'Drive the knees.',
        ),
        Exercise(
          number: 5,
          name: 'Suitcase Carry (Left)',
          instruction: 'Hold bell in left hand, walk. Core tight.',
        ),
        Exercise(
          number: 6,
          name: 'Suitcase Carry (Right)',
          instruction: 'Hold bell in right hand, walk. Core tight.',
        ),
        Exercise(
          number: 7,
          name: 'Plank',
          instruction: 'Hold steady.',
        ),
      ],
    ),
  ];
}
