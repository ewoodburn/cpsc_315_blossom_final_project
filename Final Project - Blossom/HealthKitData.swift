//
//  HealthKitData.swift
//  Final Project - Blossom
//
//  Created by Ariana Hibbard on 12/2/18.
//  Copyright © 2018 Emma Woodburn. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitData {
    let healthStore = HKHealthStore()
    
   var steps: Double = 0
    // define the Mindful Session HealthKit Category
    let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession)
    
    func activateHealthKit() {
        // Define what HealthKit data we want to ask to read
        let typesToRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!,
            HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
            ])
        
        // Define what HealthKit data we want to ask to write
        let typesToShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        // Prompt the User for HealthKit Authorization
        self.healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) -> Void in
            if !success {
                print("Health Kit Auth error \(error)")
            }
            self.retrieveMindfulnessMinutes()
            //self.retrieveStepCount()
        }
    }
    
    // put this in a closure
    // func retrieveStepCount(completion: (stepRetrieved: Double) -> Void)
    func retrieveStepCount(completion: @escaping (_ stepsRetrieved: Double) -> Void) {
        let stepCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
//        // get the start of day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        
//        // Set the Predicates and Interval
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        var interval = DateComponents()
        interval.day = 1
        
        // Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: stepCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents: interval)
        
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                print("Something went wrong with getting query results")
                return
            }
            
            if let myResults = results {
                myResults.enumerateStatistics(from: yesterday, to: date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        
                        print("Steps = \(steps)")
                        
                        DispatchQueue.main.async {
                            completion(steps)
                        }
                    }
                }
            }
        }
        healthStore.execute(query)
    }
    // Display a users mindful minutes for the last 24 hours
    func retrieveMindfulnessMinutes() {
        // use a sortDescriptor to get the recent data first (optional)
        let sortDescriptor = NSSortDescriptor (
            key: HKSampleSortIdentifierEndDate,
            ascending: false
        )
        
        // Get all samples from the last 24 hours
        let endDate = Date()
        let startDate = endDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
        
        // Create the HealthKit Query
        let query = HKSampleQuery (
            sampleType: mindfulType!,
            predicate: predicate,
            limit: 0,
            sortDescriptors: [sortDescriptor],
            resultsHandler: updateMeditationTime
        )
        //Execute our query
        healthStore.execute(query)
    }
    
    // Sum the meditation time
    func updateMeditationTime(query: HKSampleQuery, results: [HKSample]?, error: Error?) {
        if error != nil {return}
        
        let totalMeditationTime = results?.map(calculateTotalTime).reduce(0, { $0 + $1 }) ?? 0
        
        print("\n Total: \(totalMeditationTime)")
        
        renderMeditationMinuteText(totalMeditationSeconds: totalMeditationTime)
    }
    
    func calculateTotalTime(sample: HKSample) -> TimeInterval {
        let totalTime = sample.endDate.timeIntervalSince(sample.startDate)
        let wasUserEntered = sample.metadata?[HKMetadataKeyWasUserEntered] as? Bool ?? false
        
        return totalTime
    }
    
    // Update the Meditation Minute Label
    func renderMeditationMinuteText(totalMeditationSeconds: Double) {
        let minutes = Int(totalMeditationSeconds / 60)
        let labelText = "\(minutes) Mindful Minutes in the last 24 hours"
    }
}

