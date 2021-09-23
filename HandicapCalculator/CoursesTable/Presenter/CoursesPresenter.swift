//
//  CoursesPresenter.swift
//  HandicapCalculator
//
//  Created by Артём on 21.09.2021.
//

import Foundation

protocol CoursesView: AnyObject {
    
    func showCourses(_ courses: [CourseViewData])
    
    func showCourseInfo(_ course: CourseViewData)
    
    func hideCourseInfo()
    
    func showAlertMessage(_ message: String, titled title: String)
}

protocol CoursesRepository {
    
    func createCourse(name: String, slope: Int64, rating: Double)
    
    func getCourses() -> [Course]
    
    func updateCourse(_: Course)
    
    func deleteCourse(_: Course)
}

protocol CoursesPresenter {
    
    func updateCourses()
    
    func createCourse(name: String?, slope: String?, rating: String?)
    
    func deleteCourse(with index: Int)
    
    func selectCourse(with index: Int)
}

class CoursesPresenterImp: CoursesPresenter {
    
    private let repository: CoursesRepository
    var view: CoursesView
    
    private var showedCourses: [Course]?
    
    init(view: CoursesView, repository: CoursesRepository) {
        self.view = view
        self.repository = repository
    }
    
    private func showCourses(_ courses: [Course]) {
        let coursesViewData = courses.map {
            getCoursesViewData(from: $0)
        }
        view.showCourses(coursesViewData)
        showedCourses = courses
    }
    
    private func getCoursesViewData(from course: Course) -> CourseViewData {
        let courseName = course.name ?? ""
        return CourseViewData(name: courseName,
                              rating: "\(course.slope)",
                              slope: String.init(format: "%.1f", course.rating))
    }
    
    // MARK: - CoursesPresenter
    
    func updateCourses() {
        let courses = repository.getCourses()
        showCourses(courses)
    }
    
    func createCourse(name: String?, slope: String?, rating: String?) {
        guard let name = name, let slope = slope, let rating = rating else {
            return
        }
        guard let convertedSlope = Int64(slope), let convertedRating = Double(rating) else {
            return
        }
        guard !name.isEmpty, !slope.isEmpty, !rating.isEmpty else {
            return
        }
        
        repository.createCourse(name: name,
                                slope: convertedSlope,
                                rating: convertedRating)
        
        updateCourses()
    }
    
    func deleteCourse(with index: Int) {
        guard let courses = showedCourses else { return }
        let course = courses[index]
        repository.deleteCourse(course)
        updateCourses()
    }
    
    func selectCourse(with index: Int) {
        guard let courses = showedCourses else { return }
        let selectedCourse = courses[index]
        let courseViewData = getCoursesViewData(from: selectedCourse)
        view.showCourseInfo(courseViewData)
        return
    }
}
