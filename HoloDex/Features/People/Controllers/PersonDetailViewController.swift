//
//  PersonDetailViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/16/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class PersonDetailViewController: UITableViewController, ViewModelBinding {
  var viewModel: PersonDetailViewModel!

  // MARK: Private
  private let bag = DisposeBag()
  private let sections = PublishSubject<[SectionOfDetailData]>()
  // MARK: Init

  init(model: PersonDetailViewModel) {
    self.viewModel = model
    super.init(style: .grouped)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - UIViewController

  // swiftlint:disable line_length
  override func viewDidLoad() {
    super.viewDidLoad()

    // Setup the table
    self.tableView.register(PersonDetailCell.self, forCellReuseIdentifier: "PersonDetailCell")
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfDetailData>(
      configureCell: { _, tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailCell", for: indexPath) as? PersonDetailCell else {
          fatalError("🛑 Not a PersonDetailCell")
        }
        cell.setup(glyph: item.glyph, text: item.label)
        return cell
      })

    dataSource.titleForHeaderInSection = { dataSource, index in
      return dataSource.sectionModels[index].header
    }

    self.sections.asObservable().bind(to: self.tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)

    addViewModelBindings()
  }
  // swiftlint:enable line_length

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupNavigationBar()

    self.view.backgroundColor = .black
    self.tableView.backgroundColor = .black
  }

  // MARK: - Functions

  private func createVehicleSection(for person: Person) -> SectionOfDetailData {
    var items: [DetailData] = []

    if let vehicles = person.vehicles {
      vehicles.forEach { vehicle in
        items.append(DetailData(glyph: nil, label: vehicle))
      }
    }

    return SectionOfDetailData(header: "Vehicles & Spacecraft", items: items)
  }

  private func createFilmSection(for person: Person) -> SectionOfDetailData {
    var items: [DetailData] = []

    if let films = person.films {
      films.forEach { film in
        items.append(DetailData(glyph: nil, label: film))
      }
    }

    return SectionOfDetailData(header: "Films", items: items)
  }

  private func createBiographySection(for person: Person) -> SectionOfDetailData {
    var items: [DetailData] = []

    if let born = person.birthYear {
      items.append(DetailData(glyph: .baby, label: born))
    }

    if let sex = person.gender {
      items.append(DetailData(glyph: (sex == "male" ? Glyph.male : Glyph.female), label: sex.capitalized))
    }

    if let skin = person.skinColor {
      items.append(DetailData(glyph: .palette, label: skin.capitalized))
    }

    if let eyes = person.eyeColor {
      items.append(DetailData(glyph: .eye, label: eyes.capitalized))
    }

    if let hair = person.hairColor {
      items.append(DetailData(glyph: .scissors, label: hair.capitalized))
    }

    if let height = person.height {
      items.append(DetailData(glyph: .ruler, label: "\(height) cm"))
    }

    if let weight = person.mass, let kilograms = Int(weight) {
      let lbs = Double(kilograms) / 0.453_592_37
      items.append(DetailData(glyph: .weight, label: "\(String(format: "%.3f", lbs)) lbs"))
    }

    if let homeworld = person.homeworld {
      items.append(DetailData(glyph: .planet, label: homeworld))
    }

    return SectionOfDetailData(header: "Biography", items: items)
  }

  private func addViewModelBindings() {
    let person = viewModel.person.asDriver()

    let name = person.map { $0.name ?? "<UNKNOWN>" }

    name.drive(self.navigationItem.rx.title)
      .disposed(by: bag)

    // Bind section details

    let biography = person.map { [weak self] person -> SectionOfDetailData in
      return self?.createBiographySection(for: person) ?? SectionOfDetailData(header: "Biography", items: [])
    }.asObservable()

    let films = person.map { [weak self] person -> SectionOfDetailData in
      return self?.createFilmSection(for: person) ?? SectionOfDetailData(header: "Films", items: [])
    }.asObservable()

    let vehicles = person.map { [weak self] person -> SectionOfDetailData in
      return self?.createVehicleSection(for: person) ?? SectionOfDetailData(header: "Vehicles & Spacecraft", items: [])
    }.asObservable()

    // Merge the 3 section observables into one and send to sections publisher
    Observable.combineLatest([biography, films, vehicles])
      .bind(to: self.sections)
      .disposed(by: bag)
  }
}

// MARK: - TableView Data Structs

struct DetailData {
  var glyph: Glyph?
  var label: String
}

struct SectionOfDetailData {
  var header: String
  var items: [DetailData]
}

extension SectionOfDetailData: SectionModelType {
  typealias Item = DetailData

  init(original: SectionOfDetailData, items: [Item]) {
    self = original
    self.items = items
  }
}
