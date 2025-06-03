// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/silo/PreconditionsPipelineConvertFacet.sol";
import "../../helpers/postconditions/silo/PostconditionsPipelineConvertFacet.sol";

contract FuzzPipelineConvertFacet is PreconditionsPipelineConvertFacet, PostconditionsPipelineConvertFacet {


    function fuzz_pipeline_convert_B2LP_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint256 pipeAmount = fl.clamp(_pipeSalt, 1, tokenAmount);
        uint256 convertAmount = fl.clamp(_convertSalt, 1, tokenAmount);
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell well = wells[wellIndex];
        
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        

        address outToken = address(well);


        _setWellLiquidity();
        (uint256 amount, int96 stem) = _depositSilo(tokenAmount, currentActor); //@note should consider change this to a random amount of deposits from random users

        // move seasons (3) so the stalk is elgible for convert
        _skipGermination();

        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stem;
        amounts[0] = convertAmount;

        AdvancedPipeCall[] memory extraPipeCalls = _createBeanToLPPipeCalls(pipeAmount, 0);

        _before(actorsToUpdate);  

        (bool success, bytes memory returnData) = _pipelineConvertCall(address(token), stems, amounts, outToken, extraPipeCalls);

        _pipelineConvertPostConditions(address(token), outToken, stem,  success, returnData, actorsToUpdate);

    }

    function fuzz_pipeline_convert_LP2B_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell well = wells[wellIndex];
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        
        _setWellLiquidity();

        (uint256 amountWellLp,,int96 stem)= _depositWellSilo(address(well), currentActor);

        _skipGermination();

        uint256 convertAmount = fl.clamp(_convertSalt, 1e18, amountWellLp);
        uint256 pipeAmount = fl.clamp(_pipeSalt, 1e18-1, convertAmount-1);


        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stem;
        amounts[0] = convertAmount;

        AdvancedPipeCall[] memory extraPipeCalls = _createLPToBeanPipeCalls(pipeAmount); //@note works with / 2

        _before(actorsToUpdate);  

        (bool success, bytes memory returnData) = _pipelineConvertCall(address(well), stems, amounts, address(beanToken), extraPipeCalls);

        _pipelineConvertPostConditions(address(well), address(beanToken), stem,  success, returnData, actorsToUpdate);

    }



    // @note for FUZZING
    function fuzz_pipeline_convert_LP2LP_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1e6, 10000e6) * (10 ** token.decimals());
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell wellOut = wells[wellIndex];
        IWell wellIn = wells[(wellIndex + 1) % wells.length];
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;

        _setWellLiquidity();

        (uint256 amountWellLPIn,,int96 stemWellIn)= _depositWellSilo(address(wellIn), currentActor);

        _skipGermination();


        uint256 convertAmount = fl.clamp(_convertSalt, 1e17, amountWellLPIn);
        uint256 pipeAmount = fl.clamp(_pipeSalt, 1e17-1, convertAmount-1);

        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stemWellIn;
        amounts[0] = convertAmount;

        _before(actorsToUpdate); 

        // @note cant do all here or it reverts from the supply being out
        AdvancedPipeCall[] memory extraPipeCalls = _createLPToLPPipeCalls(pipeAmount, address(wellIn), address(wellOut));
        (bool success, bytes memory returnData) = _pipelineConvertCall(address(wellIn), stems, amounts, address(wellOut), extraPipeCalls);
        _pipelineConvertPostConditions(address(wellIn), address(wellOut), stemWellIn,  success, returnData, actorsToUpdate);
            
        
    }


    function fuzz_pipeline_convert_reenter(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals());
        uint256 pipeAmount = fl.clamp(_pipeSalt, 1, tokenAmount);
        uint256 convertAmount = fl.clamp(_convertSalt, 1, tokenAmount);
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell well = wells[wellIndex];
        
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        

        address outToken = address(well);


        _setWellLiquidity();
        (uint256 amount, int96 stem) = _depositSilo(tokenAmount, currentActor);

        // move seasons (3) so the stalk is elgible for convert
        _skipGermination();

        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stem;
        amounts[0] = convertAmount;

        AdvancedPipeCall[] memory extraPipeCalls = _createBeanToLPPipeCalls(pipeAmount, 5); 

        _before(actorsToUpdate);  

        (bool success, bytes memory returnData) = _pipelineConvertCall(address(token), stems, amounts, outToken, extraPipeCalls);


        _pipelineConvertPostConditions(success, returnData, actorsToUpdate);
        

    }

}