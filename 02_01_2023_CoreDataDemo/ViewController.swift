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
        //retriveStudentRecords()
        //insertStudentRecords()
        retriveStudentRecords()
        print("Update Records Function Called")
        updateStudentRecord()
        retriveStudentRecords()
        print("Delete Student Records")
        deleteStudentRecord()
        retriveStudentRecords()
    }
    
    func insertStudentRecords(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)
        let student = NSManagedObject(entity: studentEntity!, insertInto: managedContext)
        
       /* student.setValue(104, forKey: "rollNumber")
        student.setValue("Yuvaraj", forKey: "name")
        
        student.setValue(105, forKey: "rollNumber")
        student.setValue("Rohan", forKey: "name")
        
        student.setValue(106, forKey: "rollNumber")
        student.setValue("Mayuri", forKey: "name")*/
        
        for i in 1...5{
            student.setValue(i, forKey: "rollNumber")
            student.setValue("Student\(i)", forKey: "name")
        }
        
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
                print("Roll Number \(eachStudent.value(forKey: "rollNumber") as! Int32) ")
                print("Name \(eachStudent.value(forKey: "name") as! String)")
            }
            
            //try managedContext.save()
        } catch {
            print("Error fetching Data of Students")
        }
    }
    
    func updateStudentRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Student")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@","Mayuri")
        //NSPredicate(format: "rollNumber = %@", 3)
        do{
            let studentObjects = try managedContext.fetch(fetchRequest)
            let studentObject = studentObjects[0] as! NSManagedObject
            studentObject.setValue("Pooja", forKey: "name")
            studentObject.setValue(9, forKey: "rollNumber")
        }catch{
            print("Failed to update record")
        }
    }
    
    func deleteStudentRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequestResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        fetchRequestResult.predicate = NSPredicate(format: "rollNumber = %@", 106)
        do{
            let students = try managedContext.fetch(fetchRequestResult)
            let studentRecordToBeDeleted = students[0] as! NSManagedObject
            managedContext.delete(studentRecordToBeDeleted)
            do{
                try managedContext.save()
            }catch{
                print("Error")
            }
            
        }catch{
            print("Record Deletion Failed")
        }
    }
}
