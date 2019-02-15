//
//  RandomPeopleEndpoint.swift
//  People
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Networking
import RxSwift

/// Provides randomized data in conformance with the PeopleEndpoint protocol
public class RandomPeopleEndpoint: PeopleEndpoint {
  static let colors: [String] = ["Red", "Green", "Blue", "Blonde", "Brown", "Black", "Purple"]
  static let firstNames: [String] = ["Anakin", "Luke", "Leia", "Han", "Poe", "Jyn", "John", "Jane"]
  static let lastNames: [String] = ["Skywalker", "Organa", "Solo", "Amadala", "Ren", "Damaran", "Erso", "Smith"]

  public init() {
  }

  public func getPeople(from page: Int) -> Observable<[Person]> {
    return Observable.create { [weak self] emitter in
      var items: [Person] = []
      
      // Create an id from 0 to 2-50
      for id in 0...Int.random(in: 2...Int.random(in: 20...50)) {
        guard let name = self?.createName(), let person = self?.createPerson(from: id, name: name) else {
          emitter.onError(RandomPersonError.nilPerson)
          return Disposables.create()
        }
        items.append(person)
      }
      
      emitter.onNext(items)
      emitter.onCompleted()
      return Disposables.create()
    }
  }

  public func getPerson(from id: Int) -> Observable<Person> {
    return Observable.of(createPerson(from: id, name: createName()))
  }

  private func createName() -> String {
    return RandomPeopleEndpoint.firstNames[Int.random(in: 0..<RandomPeopleEndpoint.firstNames.count)] + " "
      + RandomPeopleEndpoint.lastNames[Int.random(in: 0..<RandomPeopleEndpoint.lastNames.count)]
  }
  
  private func createColor() -> String {
    return RandomPeopleEndpoint.colors[Int.random(in: 0..<RandomPeopleEndpoint.colors.count)]
  }
  
  private func createPerson(from id: Int, name: String) -> Person {
    var person = Person()

    person.name = "\(name) \(id)"
    person.homeworld = "Homeworld \(id)"
    person.gender = (Int.random(in: 0...1) == 0 ? "Male" : "Female")
    person.birthYear = "BY \(id)"
    person.mass = "\(id)"
    person.height = "\(id) ft"
    person.eyeColor = createColor()
    person.hairColor = createColor()
 
    return person
  }
}

public enum RandomPersonError: Error {
  case nilPerson
}
