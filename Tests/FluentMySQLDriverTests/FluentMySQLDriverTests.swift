import FluentBenchmark
import FluentMySQLDriver
import XCTest

final class FluentMySQLDriverTests: XCTestCase {
    var benchmarker: FluentBenchmarker {
        return .init(database: self.pool)
    }
    var pool: ConnectionPool<MySQLConnectionSource>!
    
    func testAll() throws {
        try self.benchmarker.testAll()
    }
    
    func testCreate() throws {
        try self.benchmarker.testCreate()
    }
    
    func testRead() throws {
        try self.benchmarker.testRead()
    }
    
    func testUpdate() throws {
        try self.benchmarker.testUpdate()
    }
    
    func testDelete() throws {
        try self.benchmarker.testDelete()
    }
    
    func testEagerLoadChildren() throws {
        try self.benchmarker.testEagerLoadChildren()
    }
    
    func testEagerLoadParent() throws {
        try self.benchmarker.testEagerLoadParent()
    }
    
    func testEagerLoadParentJoin() throws {
        try self.benchmarker.testEagerLoadParentJoin()
    }
    
    func testEagerLoadSubqueryJSONEncode() throws {
        try self.benchmarker.testEagerLoadSubqueryJSONEncode()
    }
    
    func testEagerLoadJoinJSONEncode() throws {
        try self.benchmarker.testEagerLoadJoinJSONEncode()
    }
    
    func testMigrator() throws {
        try self.benchmarker.testMigrator()
    }
    
    func testMigratorError() throws {
        try self.benchmarker.testMigratorError()
    }
    
    func testJoin() throws {
        try self.benchmarker.testJoin()
    }
    
    func testBatchCreate() throws {
        try self.benchmarker.testBatchCreate()
    }
    
    func testBatchUpdate() throws {
        try self.benchmarker.testBatchUpdate()
    }
    
    func testNestedModel() throws {
        try self.benchmarker.testNestedModel()
    }
    
    func testAggregates() throws {
        try self.benchmarker.testAggregates()
    }
    
    func testIdentifierGeneration() throws {
        try self.benchmarker.testIdentifierGeneration()
    }
    
    func testNullifyField() throws {
        try self.benchmarker.testNullifyField()
    }
    
    func testChunkedFetch() throws {
        try self.benchmarker.testChunkedFetch()
    }
    
    func testUniqueFields() throws {
        try self.benchmarker.testUniqueFields()
    }
    
    override func setUp() {
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 1).next()
        let hostname: String
        #if os(Linux)
        hostname = "mysql"
        #else
        hostname = "localhost"
        #endif
        let configuration = MySQLConfiguration(
            hostname: hostname,
            port: 3306,
            username: "vapor_username",
            password: "vapor_password",
            database: "vapor_database",
            tlsConfiguration: nil
        )
        let db = MySQLConnectionSource(configuration: configuration, on: eventLoop)
        self.pool = ConnectionPool(config: .init(maxConnections: 1), source: db)
    }
    
    override func tearDown() {
        try! self.pool.close().wait()
        self.pool = nil
    }
}
