import Foundation
import SwiftData

struct InitialDataLoader {
    static func loadIfEmpty(context: ModelContext) {
        let descriptor = FetchDescriptor<CompletedWorkout>()
        let count = (try? context.fetchCount(descriptor)) ?? 0
        if count > 0 { return }
        
        let jsonString = """
{
  "version": 1,
  "exportDate": "2026-10-04T12:00:00Z",
  "workouts": [
    {
      "date": "2025-10-11T08:00:00Z",
      "startedAt": "2025-10-11T08:00:00Z",
      "finishedAt": "2025-10-11T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 32.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 59.0,
              "reps": 1,
              "setNumber": 3
            },
            {
              "weight": 52.0,
              "reps": 1,
              "setNumber": 4
            },
            {
              "weight": 45.0,
              "reps": 8,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 11,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 11,
              "setNumber": 3
            },
            {
              "weight": 50.0,
              "reps": 6,
              "setNumber": 4
            },
            {
              "weight": 45.0,
              "reps": 10,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 25.0,
              "reps": 6,
              "setNumber": 3
            },
            {
              "weight": 20.0,
              "reps": 2,
              "setNumber": 4
            },
            {
              "weight": 20.0,
              "reps": 8,
              "setNumber": 5
            },
            {
              "weight": 15.0,
              "reps": 4,
              "setNumber": 6
            }
          ]
        }
      ]
    },
    {
      "date": "2025-10-12T08:00:00Z",
      "startedAt": "2025-10-12T08:00:00Z",
      "finishedAt": "2025-10-12T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 20,
              "setNumber": 1
            },
            {
              "weight": 95.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 4
            },
            {
              "weight": 155.0,
              "reps": 5,
              "setNumber": 5
            },
            {
              "weight": 135.0,
              "reps": 5,
              "setNumber": 6
            },
            {
              "weight": 115.0,
              "reps": 5,
              "setNumber": 7
            },
            {
              "weight": 95.0,
              "reps": 5,
              "setNumber": 8
            },
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 9
            }
          ]
        },
        {
          "exerciseName": "Leg extension",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 66.0,
              "reps": 8,
              "setNumber": 3
            },
            {
              "weight": 59.0,
              "reps": 6,
              "setNumber": 4
            },
            {
              "weight": 52.0,
              "reps": 6,
              "setNumber": 5
            },
            {
              "weight": 45.0,
              "reps": 5,
              "setNumber": 6
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        }
      ]
    },
    {
      "date": "2025-10-18T08:00:00Z",
      "startedAt": "2025-10-18T08:00:00Z",
      "finishedAt": "2025-10-18T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Traction puis tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 5.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 8,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 50.0,
              "reps": 3,
              "setNumber": 4
            },
            {
              "weight": 45.0,
              "reps": 5,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 8,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 15.0,
              "reps": 6,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 12,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-10-19T08:00:00Z",
      "startedAt": "2025-10-19T08:00:00Z",
      "finishedAt": "2025-10-19T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 105.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 4
            },
            {
              "weight": 175.0,
              "reps": 10,
              "setNumber": 5
            },
            {
              "weight": 155.0,
              "reps": 3,
              "setNumber": 6
            },
            {
              "weight": 115.0,
              "reps": 5,
              "setNumber": 7
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 40.5,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025-10-25T08:00:00Z",
      "startedAt": "2025-10-25T08:00:00Z",
      "finishedAt": "2025-10-25T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 20.0,
              "reps": 11,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 50.0,
              "reps": 3,
              "setNumber": 4
            },
            {
              "weight": 60.0,
              "reps": 1,
              "setNumber": 5
            },
            {
              "weight": 40.0,
              "reps": 8,
              "setNumber": 6
            }
          ]
        },
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 47.3,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 45.0,
              "reps": 3,
              "setNumber": 4
            },
            {
              "weight": 41.3,
              "reps": 3,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 6,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 25.0,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 20.0,
              "reps": 4,
              "setNumber": 4
            },
            {
              "weight": 15.0,
              "reps": 5,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 12,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-10-26T08:00:00Z",
      "startedAt": "2025-10-26T08:00:00Z",
      "finishedAt": "2025-10-26T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 105.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 175.0,
              "reps": 10,
              "setNumber": 4
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 15,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025 valeur changer sans faire exprès-11-01T08:00:00Z",
      "startedAt": "2025 valeur changer sans faire exprès-11-01T08:00:00Z",
      "finishedAt": "2025 valeur changer sans faire exprès-11-01T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 34.3,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 41.3,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 6,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 50.0,
              "reps": 10,
              "setNumber": 4
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-02T08:00:00Z",
      "startedAt": "2025-11-02T08:00:00Z",
      "finishedAt": "2025-11-02T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Leg extension",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 39.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 15,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 39.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 15,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 30.0,
              "reps": 20,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 20,
              "setNumber": 2
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-08T08:00:00Z",
      "startedAt": "2025-11-08T08:00:00Z",
      "finishedAt": "2025-11-08T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 34.3,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 41.3,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 6,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 50.0,
              "reps": 10,
              "setNumber": 4
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        },
        {
          "exerciseName": "Élévations latérales poulie",
          "displayOrder": 7,
          "sets": [
            {
              "weight": 15.0,
              "reps": 4,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-09T08:00:00Z",
      "startedAt": "2025-11-09T08:00:00Z",
      "finishedAt": "2025-11-09T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 195.0,
              "reps": 5,
              "setNumber": 4
            },
            {
              "weight": 175.0,
              "reps": 5,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 52.0,
              "reps": 12,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 15,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-22T08:00:00Z",
      "startedAt": "2025-11-22T08:00:00Z",
      "finishedAt": "2025-11-22T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 27.3,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 10.0,
              "reps": 2,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        },
        {
          "exerciseName": "Élévations latérales poulie",
          "displayOrder": 7,
          "sets": [
            {
              "weight": 15.0,
              "reps": 4,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-23T08:00:00Z",
      "startedAt": "2025-11-23T08:00:00Z",
      "finishedAt": "2025-11-23T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 52.0,
              "reps": 12,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-29T08:00:00Z",
      "startedAt": "2025-11-29T08:00:00Z",
      "finishedAt": "2025-11-29T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 55.0,
              "reps": 2,
              "setNumber": 4
            },
            {
              "weight": 50.0,
              "reps": 2,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 8,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-11-30T08:00:00Z",
      "startedAt": "2025-11-30T08:00:00Z",
      "finishedAt": "2025-11-30T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 125.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 165.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 205.0,
              "reps": 6,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 40.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 50.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-06T08:00:00Z",
      "startedAt": "2025-12-06T08:00:00Z",
      "finishedAt": "2025-12-06T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical v",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 5,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 55.0,
              "reps": 2,
              "setNumber": 4
            },
            {
              "weight": 50.0,
              "reps": 3,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 25.0,
              "reps": 5,
              "setNumber": 3
            },
            {
              "weight": 20.0,
              "reps": 5,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-07T08:00:00Z",
      "startedAt": "2025-12-07T08:00:00Z",
      "finishedAt": "2025-12-07T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 175.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Leg extension",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 52.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 59.0,
              "reps": 15,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            },
            {
              "weight": 52.0,
              "reps": 15,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 40.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 50.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-13T08:00:00Z",
      "startedAt": "2025-12-13T08:00:00Z",
      "finishedAt": "2025-12-13T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical barre",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 5,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 3,
              "setNumber": 3
            },
            {
              "weight": 55.0,
              "reps": 2,
              "setNumber": 4
            },
            {
              "weight": 50.0,
              "reps": 5,
              "setNumber": 5
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl haltère",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 10.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 8,
              "setNumber": 2
            },
            {
              "weight": 7.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 1.0,
              "reps": 6,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 15,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-14T08:00:00Z",
      "startedAt": "2025-12-14T08:00:00Z",
      "finishedAt": "2025-12-14T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Leg extension",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 32.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 30.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-20T08:00:00Z",
      "startedAt": "2025-12-20T08:00:00Z",
      "finishedAt": "2025-12-20T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Tirage vertical v",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 32.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 39.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 45.0,
              "reps": 44,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Rowing haltères",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 18.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé couché barre",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 25.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Développé incliné haltères (30–40°)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 16.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Développé militaire",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 12.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 14.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 15.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Curl barre",
          "displayOrder": 5,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Extension triceps poulie",
          "displayOrder": 6,
          "sets": [
            {
              "weight": 18.0,
              "reps": 13,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2025-12-21T08:00:00Z",
      "startedAt": "2025-12-21T08:00:00Z",
      "finishedAt": "2025-12-21T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 175.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Leg extension",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 52.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Leg curl",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 39.0,
              "reps": 12,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 12,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Mollets (perfect squat machine)",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 30.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 15,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 15,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2026-01-25T08:00:00Z",
      "startedAt": "2026-01-25T08:00:00Z",
      "finishedAt": "2026-01-25T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "45+2,",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 54.3,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 61.3,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2026-03-22T08:00:00Z",
      "startedAt": "2026-03-22T08:00:00Z",
      "finishedAt": "2026-03-22T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 80.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 100.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 160.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 200.0,
              "reps": 8,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Hip thrust machine",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    },
    {
      "date": "2026-04-12T08:00:00Z",
      "startedAt": "2026-04-12T08:00:00Z",
      "finishedAt": "2026-04-12T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Hip thrust machine",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        }
      ]
    },
    {
      "date": "2026-04-26T08:00:00Z",
      "startedAt": "2026-04-26T08:00:00Z",
      "finishedAt": "2026-04-26T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Hip thrust machine",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-05-03T08:00:00Z",
      "startedAt": "2026-05-03T08:00:00Z",
      "finishedAt": "2026-05-03T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Hip thrust machine",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 20.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-05-10T08:00:00Z",
      "startedAt": "2026-05-10T08:00:00Z",
      "finishedAt": "2026-05-10T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        }
      ]
    },
    {
      "date": "2026-05-17T08:00:00Z",
      "startedAt": "2026-05-17T08:00:00Z",
      "finishedAt": "2026-05-17T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 127.0,
              "reps": 75,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 205.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Hip thrust machine",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 35.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 40.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "52+2,",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 56.6,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 61.3,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "45+2,",
          "displayOrder": 3,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 54.3,
              "reps": 10,
              "setNumber": 2
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 4,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-06-14T08:00:00Z",
      "startedAt": "2026-06-14T08:00:00Z",
      "finishedAt": "2026-06-14T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-06-21T08:00:00Z",
      "startedAt": "2026-06-21T08:00:00Z",
      "finishedAt": "2026-06-21T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 123.0,
              "reps": 75,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-06-28T08:00:00Z",
      "startedAt": "2026-06-28T08:00:00Z",
      "finishedAt": "2026-06-28T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-07-05T08:00:00Z",
      "startedAt": "2026-07-05T08:00:00Z",
      "finishedAt": "2026-07-05T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 15,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-07-12T08:00:00Z",
      "startedAt": "2026-07-12T08:00:00Z",
      "finishedAt": "2026-07-12T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 125.0,
              "reps": 75,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 235.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-07-18T08:00:00Z",
      "startedAt": "2026-07-18T08:00:00Z",
      "finishedAt": "2026-07-18T09:00:00Z",
      "programName": "Import",
      "workoutName": "Upper",
      "exercises": [
        {
          "exerciseName": "Élévations latérales",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 2.0,
              "reps": 8,
              "setNumber": 1
            },
            {
              "weight": 4.5,
              "reps": 6,
              "setNumber": 2
            }
          ]
        }
      ]
    },
    {
      "date": "2026-07-19T08:00:00Z",
      "startedAt": "2026-07-19T08:00:00Z",
      "finishedAt": "2026-07-19T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 235.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-08-09T08:00:00Z",
      "startedAt": "2026-08-09T08:00:00Z",
      "finishedAt": "2026-08-09T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 75.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-08-16T08:00:00Z",
      "startedAt": "2026-08-16T08:00:00Z",
      "finishedAt": "2026-08-16T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-08-23T08:00:00Z",
      "startedAt": "2026-08-23T08:00:00Z",
      "finishedAt": "2026-08-23T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 90.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 120.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 150.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "32+2,",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 45.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 52.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 2,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-09-06T08:00:00Z",
      "startedAt": "2026-09-06T08:00:00Z",
      "finishedAt": "2026-09-06T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-09-13T08:00:00Z",
      "startedAt": "2026-09-13T08:00:00Z",
      "finishedAt": "2026-09-13T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 115.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-09-20T08:00:00Z",
      "startedAt": "2026-09-20T08:00:00Z",
      "finishedAt": "2026-09-20T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 125.0,
              "reps": 95,
              "setNumber": 1
            },
            {
              "weight": 155.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            },
            {
              "weight": 235.0,
              "reps": 10,
              "setNumber": 4
            }
          ]
        },
        {
          "exerciseName": "Abdos",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 30.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-09-27T08:00:00Z",
      "startedAt": "2026-09-27T08:00:00Z",
      "finishedAt": "2026-09-27T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Presse inclinée",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 95.0,
              "reps": 10,
              "setNumber": 1
            },
            {
              "weight": 135.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 195.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        },
        {
          "exerciseName": "Crunch poulie",
          "displayOrder": 1,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            }
          ]
        }
      ]
    },
    {
      "date": "2026-10-04T08:00:00Z",
      "startedAt": "2026-10-04T08:00:00Z",
      "finishedAt": "2026-10-04T09:00:00Z",
      "programName": "Import",
      "workoutName": "Lower",
      "exercises": [
        {
          "exerciseName": "Abdominal machine en bas",
          "displayOrder": 0,
          "sets": [
            {
              "weight": 10.0,
              "reps": 3,
              "setNumber": 1
            },
            {
              "weight": 41.0,
              "reps": 10,
              "setNumber": 2
            },
            {
              "weight": 50.0,
              "reps": 10,
              "setNumber": 3
            }
          ]
        }
      ]
    }
  ]
}
"""
        
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let backup = try? decoder.decode(BackupData.self, from: jsonData) {
            for bw in backup.workouts {
                let workout = CompletedWorkout(date: bw.date, startedAt: bw.startedAt, finishedAt: bw.finishedAt ?? bw.startedAt.addingTimeInterval(3600), programName: bw.programName, workoutName: bw.workoutName)
                for be in bw.exercises {
                    let exercise = CompletedExercise(exerciseName: be.exerciseName, displayOrder: be.displayOrder)
                    for bs in be.sets {
                        let set = CompletedSet(weight: bs.weight, reps: bs.reps, setNumber: bs.setNumber)
                        exercise.sets.append(set)
                    }
                    workout.exercises.append(exercise)
                }
                context.insert(workout)
            }
            try? context.save()
            print("Auto-loaded \(backup.workouts.count) workouts successfully!")
        }
    }
}
