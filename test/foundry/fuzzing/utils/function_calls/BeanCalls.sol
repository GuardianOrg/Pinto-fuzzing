// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@perimetersec/fuzzlib/src/FuzzBase.sol";
// import "../../helpers/FuzzStorageVariables.sol";

// contract BeanCalls is FuzzBase, FuzzStorageVariables {

//     function _seasonCall() internal returns (bool success, bytes memory returnData) {

//         vm.prank(currentActor);
//         (success, returnData) =
//             address(diamond).call(abi.encodeWithSelector(Bean.season.selector));
//     }

// }