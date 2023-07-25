//
//  APICaller.swift
//  Spotify_App
//
//  Created by Jae hyuk Yim on 2023/06/29.
//

import Foundation

// TODO: - Profile (Auth를 통해 사용자 인증을 마친 후 -> 관련된 정보를 불러오는 작업)

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    // 기본 API URL
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    // 사용자 정의 Error
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Commom API Call
    
    // Albums
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
                      type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decorder = JSONDecoder()
                    let result = try decorder.decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // Playlists
    public func getPlaylistsDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
                      type: .GET) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decorder = JSONDecoder()
                    let result = try decorder.decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Home API Call
    
    // UserProfile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decorder = JSONDecoder()
                    let result = try decorder.decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - New Release
    public func getNewRelease(completion: @escaping (Result<NewReleaseResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"),
                      type: .GET) { request in
            

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(NewReleaseResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // Featured Playlists
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse, Error>) -> Void) {
        
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=8"),
                      type: .GET) { request in

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // Recommandation Artists&Tracks
    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<RecommendationsResponse, Error>) -> Void) {
        
        // seeds란 Genres 파라미터의 값을 쉼표(,)를 통해 분리하고 함께 추가하여 Set 형식으로 나타냄
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=10&seed_genres=\(seeds)"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // Genre Seeds
    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Search API Call
    
    // Category(All or Several)
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // Category (Single)
    public func getCategoryPlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=20"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(FeaturedPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // searchFunction
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult],Error>) -> Void) {
        // addingPercentEncoding (인코딩을 실시할 때, Set에 없는 문자(한글, 띄어쓰기)를 %로 변환, 인코딩을 실시)
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SearchResultResponse.self, from: data)
                    
                    // MARK: - Enum 타입의 빈 배열로 저장해 놓고, Parsing을 통해 받아오는 데이터를 searchResult Case 별로 저장
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0)}))
                    searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0)}))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0)}))
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0)}))
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Library API Call
    
    // 현재 UserProfile에 저장된 playlists 확인
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(LibraryPlaylistsResponse.self, from: data)
                    completion(.success(result.items))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // createPlaylist (생성된 playlists에 따라 playlists 정보를 POST)
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        
        // 1. 현재 프로필을 불러오기
        getCurrentUserProfile { [weak self] result in
            switch result {
                
                //성공할 경우
            case .success(let profile):
                
                // profile.id를 활용하여 playlist URL을 생성함
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                // createRequest를 통해, URL과 Post 타입으로 실행
                self?.createRequest(with: URL(string: urlString), type: .POST, completion: { baseRequest in
                    
                
                    var request = baseRequest
                    
                    // name은 플레이리스트의 명칭으로, createPlaylist 메서드의 파라미터 값으로 받아옴
                    let json = [
                        "name" : name
                    ]
                    
                    // httpBody를 생성함 -> json 형식의 파일
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    
                    // request(baseRequest + httpBody)가 생성되면, 이를 통해 URLSession task 객체를 생성하여 파싱한 결과값을 확인함
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                                print("Created")
                                completion(true)
                                //                            let decoder = JSONDecoder()
                                //                            let result = try decoder.decode(Playlist.self, from: data)
                                //                            print(result)
                                //                            completion(true)
                            }
                        }
                        catch {
                            print("Failed")
                            completion(false)
                        }
                    }
                    task.resume()
                })
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    // addTrackToPlay (POST / 트랙 등록)
    public func addTrackToPlaylist(track: AudioTrack,
                                   playlist: Playlist,
                                   completion: @escaping (Bool) -> Void) {
        //
    }
    
    // removeTrackFromPlaylists (addTrackToPlaylists 내 Track을 삭제함)
    public func removeTrackFromPlaylists(track: AudioTrack,
                                   playlist: Playlist,
                                   completion: @escaping (Bool) -> Void) {
        //
    }
    
    // MARK: - Private
    // HTTP Method
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    // MARK: - API 요청을 위하여 해당 User의 Token 유효성 여부 파악(withValidToken)
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        /// Supplies valid token to be used API Callers
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            // API URL을 통해 요청을 보내기 위해선, 아래와 같은 setValue가 필요함(Header는 Authorization)
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            
            // HTTP Method
            request.httpMethod = type.rawValue
            request.timeoutInterval = 10
            completion(request)
        }
    }
}
