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
  @State var searchQuery: String
  var body: some View {
    NavigationView {
      VStack {
        SearchBar(query: $store.query)
        List(store.people) { person in
          PersonCellView(model: person)
        }.onAppear(perform: { self.store.request() })
      }
      .navigationBarItems(trailing: ActivityIndicator(isAnimating: $store.requested))
      .navigationBarTitle("People", displayMode: .large)
    }
  }
}

#if DEBUG
struct PeopleListView_Previews: PreviewProvider {
  static let store = PersonStore(service: PreviewPersonService())
  static var previews: some View {
    return PeopleListView(searchQuery: "")
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

// TODO: Move these to own files

struct ActivityIndicator: UIViewRepresentable {
  // Using a binding here instead of a publisher because view is based on state of isAnimating from another source
  @Binding var isAnimating: Bool

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView()
    return view
  }

  func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
    if isAnimating {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }
}

struct SearchBar: UIViewRepresentable {
  @Binding var query: String

  // Coordinator is used to send over delegate events for the search bar
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String

    init(text: Binding<String>) {
        _text = text
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
  }

  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> SearchBar.UIViewType {
    let view = UISearchBar()
    view.delegate = context.coordinator
    return view
  }

  func updateUIView(_ view: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    view.text = query
  }

  // Send the values over to the search bar delegate
  func makeCoordinator() -> SearchBar.Coordinator {
    return Coordinator(text: $query)
  }
}
