//
//  ViewController.swift
//  02_01_2023_CoreDataDemo
//
//  Created by Vishal Jagtap on 01/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("----- The Insert Records Function is called -----")
        
        print("Retrive All Records")
        retriveStudentRecords()
        insertStudentRecords()
        retriveStudentRecords()
        
        
    }
    
    func insertStudentRecords(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)
        let student = NSManagedObject(entity: studentEntity!, insertInto: managedContext)
        
        student.setValue(104, forKey: "rollNumber")
        student.setValue("Yuvaraj", forKey: "name")
        
        student.setValue(105, forKey: "rollNumber")
        student.setValue("Rohan", forKey: "name")
        
        student.setValue(106, forKey: "rollNumber")
        student.setValue("Mayuri", forKey: "name")
        
        do{
            try managedContext.save()
            
        } catch let error as NSError{
            print("The data not inserted -- \(error)")
        }
    }
    
    func retriveStudentRecords(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do{
            let fetchResult = try managedContext.fetch(fetchRequest)
            for eachStudent in fetchResult as! [NSManagedObject]{
                print("The Student details are \(eachStudent.value(forKey: "rollNumber")!) -- \(eachStudent.value(forKey: "name")!)")
            }
        } catch {
            print("Error fetching Data of Students")
        }
        
    }
}
