//
//  CoreDataRelationshipBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 25/10/21.
//

import SwiftUI
import CoreData

// 3 entities
// BussinesEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    
    static let instance = CoreDataManager() // singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description,error) in
            if let error = error {
                print("Errror laoding core data.\(error)")
            }
        }
        context = container.viewContext
    }
    
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully")
        } catch let error {
            print("ERROR Save Data..\(error)")
        }
    }
    
}


class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepatments()
        getEmployee()
    }
    
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        let filter = NSPredicate(format: "name == %@","Apple")
        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    
    func getDepatments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployee() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployee(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@",business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func deleteDepartment() {
        let department = departments[2]
        manager.context.delete(department)
        
        save()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
//        newBusiness.departments = [departments[0],departments[1]]
        
        // add existing employees to the new business
//         newBusiness.employees = [employees[1]]
        
        // add new business to existing department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing department
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
//        newDepartment.businesses = [businesses[0]]
//        newDepartment.employees = [employees[1]]
        
        newDepartment.businesses = [businesses[0],businesses[1],businesses[2]]
        newDepartment.addToEmployees(employees[1])
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
        newEmployee.name = "John"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
//        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.manager.save()
            self.getBusinesses()
            self.getDepatments()
//            self.getEmployee()
        }
       
    }
    
}

struct CoreDataRelationshipBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button(action: {
//                        vm.addBusiness()
//                        vm.addDepartment()
//                        vm.addEmployee()
//                        vm.updateBusiness()
//                        vm.getEmployee(forBusiness: vm.businesses[0])
                        vm.deleteDepartment()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                                
                            }
                        }
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                                
                            }
                        }
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                                
                            }
                        }
                    })
                }
                .padding()
            }
            .navigationTitle("Relationship")
        }
    }
}

struct CoreDataRelationshipBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootcamp()
    }
}


struct BusinessView: View {
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }

        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10.0)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }

        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10.0)
        .shadow(radius: 10)
    }
}


struct EmployeeView: View {
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Data joined: \(entity.dateJoined ?? Date())")
            
            Text("Business: ")
                .bold()
            
            Text(entity.business?.name ?? "")
         
            
            Text("Department: ")
                .bold()
            Text(entity.department?.name ?? "")
            
            
          
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10.0)
        .shadow(radius: 10)
    }
}
