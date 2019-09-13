//
//  RandomPersonService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift

/// Provides randomized data in conformance with the PeopleEndpoint protocol
class RandomPersonService: PersonService {
  static let worlds: [String] = ["Tatooine", "Naboo", "Jakku", "Yavin IV", "Alderaan", "Hutta", "Lokath",
                                 "Lothal", "Tython", "Dromund Kaas", "Korriban"]
  static let colors: [String] = ["Red", "Green", "Blue", "Blonde", "Brown", "Black", "Purple"]
  static let firstNames: [String] = ["Anakin", "Luke", "Leia", "Han", "Poe", "Jyn", "John", "Jane", "Lassicar",
                                     "Brendol", "Chewbacca", "Yoda", "Obi-Wan"]
  static let lastNames: [String] = ["Skywalker", "Organa", "Solo", "Amadala", "Ren", "Damaran", "Erso",
                                    "Smith", "Hutt", "Hux", "Kenobi"]

  public init() {}

  // MARK: PersonService

  public func getPeople(from page: Int) -> Observable<[Person]> {
    return Observable.create { [weak self] emitter in
      var items: [Person] = []

      // Create 10 random people to emit
      for _ in 0..<10 {
        guard let person = self?.createPerson() else {
          emitter.onError(RandomPersonError.nilPerson)
          return Disposables.create()
        }
        items.append(person)
      }

      emitter.onNext(items)
      emitter.onCompleted()
      return Disposables.create()
    }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
  }

  public func getAll() -> Observable<[Person]> {
    // Send out 50 pages each containing 10 random people (100 total), delay of .25 to simulate network
    return Observable.range(start: 1, count: 50)
      .concatMap({ Observable.just($0).delay(0.25, scheduler: ConcurrentDispatchQueueScheduler(qos: .background)) })
      .flatMap { [weak self] page -> Observable<[Person]> in
        return self?.getPeople(from: page) ?? Observable.empty()
      }
  }

  public func getPerson(from personId: Int) -> Observable<Person> {
    return Observable.of(createPerson())
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
  }

  // MARK: Private Functions

  private func createName() -> String {
    let addLastName = Int.random(in: 0...100) <= 75 ? true : false

    if addLastName {
    return RandomPersonService.firstNames[Int.random(in: 0..<RandomPersonService.firstNames.count)] + " "
      + RandomPersonService.lastNames[Int.random(in: 0..<RandomPersonService.lastNames.count)]
    } else {
      return RandomPersonService.firstNames[Int.random(in: 0..<RandomPersonService.firstNames.count)]
    }
  }

  private func createColor() -> String {
    return RandomPersonService.colors[Int.random(in: 0..<RandomPersonService.colors.count)]
  }

  private func createRandomNumbers(min: Int, max: Int) -> [String] {
    var randoms: [String] = []
    for ran in min...Int.random(in: min...max) {
      randoms.append(String(ran))
    }
    return randoms
  }

  private func createPerson() -> Person {
    let person = Person(name: createName())
//
//    person.name = createName()
//    person.homeworld = RandomPeopleEndpoint.worlds[Int.random(in: 0..<RandomPeopleEndpoint.worlds.count)]
//    person.gender = (Int.random(in: 0...1) == 0 ? "male" : "female")
//    person.birthYear = "\(Int.random(in: 200...300))BBY"
//    person.mass = "\(Int.random(in: 1...100))"
//    person.height = "\(Int.random(in: 100...200))"
//    person.eyeColor = createColor()
//    person.hairColor = createColor()
//    person.films = createRandomNumbers(min: 0, max: 10)
//    person.vehicles = (Int.random(in: 0...100) >= 45 ? createRandomNumbers(min: 0, max: 3) : [])
//    person.species = createRandomNumbers(min: 0, max: 1)

    return person
  }
}

public enum RandomPersonError: Error {
  case nilPerson
}
