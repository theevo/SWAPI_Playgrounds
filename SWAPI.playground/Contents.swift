import Foundation

// MARK: - Models

struct Person: Decodable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: URL
}

struct Film: Decodable {
    let title: String
    let opening_crawl: String
    let release_date: String
}


// MARK: - Controller

class SwapiService {
    static private let baseURL = URL(string: "https://swapi.co/api/")
    static private let peopleEndpoint = "people"
    
    static func fetchPerson(id: Int, completion: @escaping (Person?) -> Void) {
        // 1 - Prepare URL
        guard let url = baseURL else { return completion(nil) }
        let endpointURL = url.appendingPathComponent(peopleEndpoint)
        print(endpointURL)
        
        let finalURL = personURL.appendingPathComponent(String(id))
        print(finalURL)
        
        // 2 - Contact server
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            // 3. Error Handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(nil)
            }
            
            // 4. Check for Data
            guard let data = data else { return completion(nil) }
            
            // 5. Decode Data
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                return completion(person)
            } catch {
                print(error, error.localizedDescription)
                return completion(nil)
            }
            
        }.resume()
    }
}

SwapiService.fetchPerson(id: 10) { person in
    if let person = person {
        print(person)
    }
}
