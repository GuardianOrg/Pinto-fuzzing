// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../helpers/preconditions/silo/PreconditionsPipelineConvertFacet.sol";
import "../../helpers/postconditions/silo/PostconditionsPipelineConvertFacet.sol";

contract FuzzPipelineConvertFacet is PreconditionsPipelineConvertFacet, PostconditionsPipelineConvertFacet {


    function fuzz_pipeline_convert_B2LP_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 pipeAmount = fl.clamp(_pipeSalt, 1, tokenAmount);
        uint256 convertAmount = fl.clamp(_convertSalt, 1, tokenAmount);
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell well = wells[wellIndex];
        
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        

        address outToken = address(well); // @TODO make this random


        _setWellLiquidity();
        (uint256 amount, int96 stem) = _depositSilo(tokenAmount, currentActor); //@note should change this to a random amount of deposits from random users

        // move seasons (3) so the stalk is elgible for convert
        _skipGermination();

        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stem;
        amounts[0] = convertAmount;

        AdvancedPipeCall[] memory extraPipeCalls = _createBeanToLPPipeCalls(pipeAmount);

        _before(actorsToUpdate);  

        (bool success, bytes memory returnData) = _pipelineConvertCall(address(token), stems, amounts, outToken, extraPipeCalls);

        //@TODO add post conditions here
        _pipelineConvertPostConditions(address(token), outToken, stem,  success, returnData, actorsToUpdate);

    }

    function fuzz_pipeline_convert_LP2B_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell well = wells[wellIndex];
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        

        address outToken = address(beanToken);

        _setWellLiquidity();

        (uint256 amount, int96 stemBean) = _depositSilo(tokenAmount, currentActor);

        //@TODO make well random
        (uint256 amountWellLp,,int96 stem)= _depositWellSilo(address(well), currentActor);

        _skipGermination();

        uint256 pipeAmount = fl.clamp(_pipeSalt, 1, amountWellLp);
        uint256 convertAmount = fl.clamp(_convertSalt, 1, amountWellLp);


        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stem;
        amounts[0] = convertAmount;

        AdvancedPipeCall[] memory extraPipeCalls = _createLPToBeanPipeCalls(pipeAmount); //@note works with / 2

        _before(actorsToUpdate);  

        (bool success, bytes memory returnData) = _pipelineConvertCall(address(well), stems, amounts, outToken, extraPipeCalls);


        //@TODO add post conditions here
        // _pipelineConvertPostConditions(address(well), outToken, stem,  success, returnData, actorsToUpdate);



    }



    // function fuzz_pipeline_convert_LP2B_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {
    //     MockToken token = mockTokens[0];
    //     uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        
        
    //     address[] memory actorsToUpdate = new address[](2);
    //     actorsToUpdate[0] = currentActor;
        

    //     address outToken = address(beanToken);

    //     _setWellLiquidity();

    //     (uint256 amount, int96 stemBean) = _depositSilo(tokenAmount, currentActor);

    //     //@TODO make well random
    //     (uint256 amountWellLp,,int96 stem)= _depositWellSilo(address(beanEthWell), currentActor);

    //     _skipGermination();


    //     int96[] memory stems = new int96[](1);
    //     uint256[] memory amounts = new uint256[](1);

    //     stems[0] = stem;
    //     amounts[0] = amountWellLp;

    //     AdvancedPipeCall[] memory extraPipeCalls = _createLPToBeanPipeCalls(amountWellLp); //@note works with / 2

    //     _before(actorsToUpdate);  

    //     (bool success, bytes memory returnData) = _pipelineConvertCall(address(beanEthWell), stems, amounts, outToken, extraPipeCalls);


    //     //@TODO add post conditions here
    //     _pipelineConvertPostConditions(success,returnData, actorsToUpdate);



    // }


    // @note for FUZZING
    function fuzz_pipeline_convert_LP2LP_facet(uint256 _amountSalt, uint256 _wellSalt, uint256 _pipeSalt, uint256 _convertSalt) public setCurrentActor {
        MockToken token = mockTokens[0];
        console.log((10000) * (10 ** token.decimals()));
        uint256 tokenAmount = fl.clamp(_amountSalt, 1e6, 10000e6) * (10 ** token.decimals()); //@TODO consider incrementing
        uint256 wellIndex = fl.clamp(_wellSalt, 0, 1);
        IWell wellOut = wells[wellIndex];
        IWell wellIn = wells[(wellIndex + 1) % wells.length];
        
        address[] memory actorsToUpdate = new address[](2);
        actorsToUpdate[0] = currentActor;
        

        address outToken = address(wellOut);

        _setWellLiquidity();


        //@TODO make well random
        (uint256 amountWellLPIn,,int96 stemWellIn)= _depositWellSilo(address(wellIn), currentActor);
        // (uint256 amountWellLPOut,,)= _depositWellSilo(address(wellOut), currentActor);

        _skipGermination();

        uint256 pipeAmount = fl.clamp(_pipeSalt, 1e6, amountWellLPIn);
        uint256 convertAmount = fl.clamp(_convertSalt, 1e6, amountWellLPIn);

        int96[] memory stems = new int96[](1);
        uint256[] memory amounts = new uint256[](1);

        stems[0] = stemWellIn;
        amounts[0] = convertAmount;

        // console.log("");
        // console.log("Convert Amount : ", convertAmount); // 1000004
        // console.log("Pipe Amount    : ", pipeAmount);    // 1000003
        // console.log("");
        // revert();

        

        _before(actorsToUpdate); 

        {
            // @note cant do all here or it reverts from the supply being out
            AdvancedPipeCall[] memory extraPipeCalls = _createLPToLPPipeCalls(pipeAmount / 2, address(wellIn), address(wellOut));
            (bool success, bytes memory returnData) = _pipelineConvertCall(address(wellIn), stems, amounts, outToken, extraPipeCalls);
            //@TODO add post conditions here
            // _pipelineConvertPostConditions(address(wellIn), outToken, stemWellIn,  success, returnData, actorsToUpdate);
        }

        
    }


    // function fuzz_pipeline_convert_LP2LP_facet(uint256 _amountSalt, uint256 _receiverSalt) public setCurrentActor {
    //     MockToken token = mockTokens[0];
    //     uint256 tokenAmount = fl.clamp(_amountSalt, 1, 10000) * (10 ** token.decimals()); //@TODO consider incrementing
        
        
    //     address[] memory actorsToUpdate = new address[](2);
    //     actorsToUpdate[0] = currentActor;
        

    //     address outToken = address(beanWstEthWell);

    //     _setWellLiquidity();


    //     //@TODO make well random
    //     (uint256 amountWellLp1,,int96 stemLP1)= _depositWellSilo(address(beanEthWell), currentActor);
    //     (uint256 amountWellLp2,,int96 stemLP2)= _depositWellSilo(address(beanWstEthWell), currentActor);

    //     _skipGermination();

    //     int96[] memory stems = new int96[](1);
    //     uint256[] memory amounts = new uint256[](1);

    //     stems[0] = stemLP1;
    //     amounts[0] = amountWellLp1;

    //     // @note cant do all ahere or it reverts from the supply being out
    //     AdvancedPipeCall[] memory extraPipeCalls = _createLPToLPPipeCalls(amountWellLp1 / 2, address(beanEthWell), address(beanWstEthWell));

    //     _before(actorsToUpdate); 

    //     (bool success, bytes memory returnData) = _pipelineConvertCall(address(beanEthWell), stems, amounts, outToken, extraPipeCalls);

    //     //@TODO add post conditions here
    //     _pipelineConvertPostConditions(success,returnData, actorsToUpdate);
    // }

}