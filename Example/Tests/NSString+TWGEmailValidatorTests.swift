
import Foundation
import XCTest
import TWGExtensions

class NSString_TWGEmailValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmailValidation() {
        
        let invalidEmail1 = "thisisaninvalidemail@dsds.co m"
        let invalidEmail2 = "thisisan invalidemail@dsds.com"
        let invalidEmail3 = "thisisaninvalidemail@dsd s.com"
        let invalidEmail4 = "thisisaninvalidemail@dsds."
        let invalidEmail5 = "thisisaninvalidemail@dsds"
        let invalidEmail6 = "thisisaninvalidemail@"
        let invalidEmail7 = "thisisaninvalidemail"
        let validEmail = "thisisavalidemail@address.com"
        
        XCTAssertFalse(invalidEmail1.isValidEmail())
        XCTAssertFalse(invalidEmail2.isValidEmail())
        XCTAssertFalse(invalidEmail3.isValidEmail())
        XCTAssertFalse(invalidEmail4.isValidEmail())
        XCTAssertFalse(invalidEmail5.isValidEmail())
        XCTAssertFalse(invalidEmail6.isValidEmail())
        XCTAssertFalse(invalidEmail7.isValidEmail())
        
        XCTAssertTrue(validEmail.isValidEmail())
    }
}
