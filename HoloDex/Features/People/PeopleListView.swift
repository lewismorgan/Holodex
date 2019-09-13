//
//  PeopleListView.swift
//  HoloDex
//
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Combine
import RxSwift
import SwiftUI

struct PeopleListView: View {
  @ObservedObject var viewModel: PeopleListViewModel

  var body: some View {
    NavigationView {
      VStack {
        List(viewModel.people, id: \.name) { person in
          Text(person.name)
        }
      }
    .navigationBarTitle("People")
    }
  }
}

#if DEBUG
struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
      PeopleListView(viewModel: PeopleListViewModel(endpoint: PreviewPeopleService()))
        .colorScheme(.dark)
    }
}

class PreviewPeopleService: PersonService {
  let people: [Person] = [
    Person(name: "Luke Skywalker"),
    Person(name: "Jyn Erso"),
    Person(name: "Watto")
  ]

  func getAll() -> Observable<[Person]> {
    return Observable.of(people)
  }

  func getPeople(from page: Int) -> Observable<[Person]> {
    return Observable.of(people)
  }

  func getPerson(from personId: Int) -> Observable<Person> {
    return Observable.just(people[personId])
  }
}
#endif
