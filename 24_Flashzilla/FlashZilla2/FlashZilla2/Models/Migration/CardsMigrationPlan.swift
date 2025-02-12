//
//  CardsMigrationPlan.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/12/25.
//

import SwiftData

enum CardsMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [CardsSchemaV1.self, CardsSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1ToV2]
    }
    
    static let migrateV1ToV2: MigrationStage = MigrationStage.custom(
        fromVersion: CardsSchemaV1.self,
        toVersion: CardsSchemaV2.self) { context in
            let cards = try context.fetch(FetchDescriptor<CardsSchemaV1.Card>())
            for card in cards {
                let cardV2 = CardsSchemaV2.Card(prompt: card.prompt, answer: card.answer, correctCount: 2)
                context.insert(cardV2)
                context.delete(card)
                
            }
            do {
                try context.save()
                
            } catch {
                print("save: \(error)")
            }
            
        } didMigrate: { context in
            let cards = try context.fetch(FetchDescriptor<CardsSchemaV2.Card>())
            for card in cards {
                print("\(card.prompt) - \(card.answer) - \(card.correctCount)")
            }
            print("finished migration")
        }
    
}
