//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query Users {
      users {
        __typename
        id
        name
      }
    }
    """

  public let operationName = "Users"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .nonNull(.list(.nonNull(.object(User.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]) {
      self.init(unsafeResultMap: ["__typename": "Query", "users": users.map { (value: User) -> ResultMap in value.resultMap }])
    }

    /// ユーザ情報を全件取得する
    public var users: [User] {
      get {
        return (resultMap["users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public final class MicropostMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation Micropost($content: String!, $picture: String!) {
      createMicropost(input: {userId: 1, content: $content, picture: $picture}) {
        __typename
        micropost {
          __typename
          id
          content
          picture
        }
      }
    }
    """

  public let operationName = "Micropost"

  public var content: String
  public var picture: String

  public init(content: String, picture: String) {
    self.content = content
    self.picture = picture
  }

  public var variables: GraphQLMap? {
    return ["content": content, "picture": picture]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createMicropost", arguments: ["input": ["userId": 1, "content": GraphQLVariable("content"), "picture": GraphQLVariable("picture")]], type: .object(CreateMicropost.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createMicropost: CreateMicropost? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createMicropost": createMicropost.flatMap { (value: CreateMicropost) -> ResultMap in value.resultMap }])
    }

    public var createMicropost: CreateMicropost? {
      get {
        return (resultMap["createMicropost"] as? ResultMap).flatMap { CreateMicropost(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createMicropost")
      }
    }

    public struct CreateMicropost: GraphQLSelectionSet {
      public static let possibleTypes = ["CreateMicropostPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("micropost", type: .nonNull(.object(Micropost.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(micropost: Micropost) {
        self.init(unsafeResultMap: ["__typename": "CreateMicropostPayload", "micropost": micropost.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var micropost: Micropost {
        get {
          return Micropost(unsafeResultMap: resultMap["micropost"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "micropost")
        }
      }

      public struct Micropost: GraphQLSelectionSet {
        public static let possibleTypes = ["Micropost"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("content", type: .nonNull(.scalar(String.self))),
          GraphQLField("picture", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, content: String, picture: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Micropost", "id": id, "content": content, "picture": picture])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var content: String {
          get {
            return resultMap["content"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "content")
          }
        }

        public var picture: String? {
          get {
            return resultMap["picture"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "picture")
          }
        }
      }
    }
  }
}

public final class MicropostsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query Microposts {
      microposts {
        __typename
        content
        picture
      }
    }
    """

  public let operationName = "Microposts"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("microposts", type: .nonNull(.list(.nonNull(.object(Micropost.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(microposts: [Micropost]) {
      self.init(unsafeResultMap: ["__typename": "Query", "microposts": microposts.map { (value: Micropost) -> ResultMap in value.resultMap }])
    }

    /// ユーザ情報を全件取得する
    public var microposts: [Micropost] {
      get {
        return (resultMap["microposts"] as! [ResultMap]).map { (value: ResultMap) -> Micropost in Micropost(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Micropost) -> ResultMap in value.resultMap }, forKey: "microposts")
      }
    }

    public struct Micropost: GraphQLSelectionSet {
      public static let possibleTypes = ["Micropost"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("content", type: .nonNull(.scalar(String.self))),
        GraphQLField("picture", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(content: String, picture: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Micropost", "content": content, "picture": picture])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var content: String {
        get {
          return resultMap["content"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "content")
        }
      }

      public var picture: String? {
        get {
          return resultMap["picture"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "picture")
        }
      }
    }
  }
}
