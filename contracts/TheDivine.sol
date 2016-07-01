contract TheDivine{
    uint256 private WorldTree;
    
    function TheDivine(){
        WorldTree = uint256(address(this));
    }
    
    function GetPower() returns(uint256){
        WorldTree = uint256(sha3(WorldTree,
            msg.sender,
            block.difficulty));
        return WorldTree;
    }
    
}