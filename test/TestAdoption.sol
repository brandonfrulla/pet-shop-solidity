pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {

    //the address to be tested via the adoption contract
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    //the id of the pet to be used in the test
    uint expectedPetId = 7;

    //the expected owner of adopted pet is this contract
    address expectedAdopter = address(this);

    //testing the adopt() function                                              
    function testUserCanAdoptPet() public {                                     
        uint returnedId = adoption.adopt(expectedPetId);                        
                                                                                  
        Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match the return value.");
    }
    
    //testing retrieval of a single pet's owner
    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);
        
        Assert.equal(adopter,expectedAdopter,"Owner of the expected pet should be this contract.");
           
    } 

    //testing getter of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        //store adopters in memory rather than contract
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract.");
    }

}


