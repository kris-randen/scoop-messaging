// main.swift
import AlgoliaSearchClient

// A simple record for your index
struct Record: Encodable {
   let objectID: ObjectID
   let name: String
}

// Add the client to the dependencies of your targets
let client = SearchClient(appID: "1IVHD013XT", apiKey: "7a4b938353c09132f6cb45d55ef58cf4")
let index = client.index(withName: "test_index")

 // Create a new index and add a record
let record: Record = .init(objectID: "1", name: "test_record")
let indexing: ()? = try? index.saveObject(record).wait()

 // Search the index and print the results
let results = try index.search(query: "test_record")
print(results.hits[0])
