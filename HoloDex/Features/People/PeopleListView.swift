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
  @EnvironmentObject var store: PersonStore

  var body: some View {
    NavigationView {
      VStack {
        List(store.people) { person in
          PersonCellView(model: person)
        }
      }
      .navigationBarItems(trailing: ActivityIndicator())
      .navigationBarTitle("People", displayMode: .large)
    }
  }
}

#if DEBUG
struct PeopleListView_Previews: PreviewProvider {
  static let store = PersonStore(service: PreviewPersonService())
  static var previews: some View {
    store.request()
    return PeopleListView()
      .environmentObject(store)
      .colorScheme(.dark)
  }
}

class PreviewPersonService: PersonService {
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

// TODO: Move to own class
struct ActivityIndicator: UIViewRepresentable {

  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView()
    return view
  }

  func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
    // TODO: Animate the indicator
  }
}
