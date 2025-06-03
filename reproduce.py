import re


def convert_to_solidity(call_sequence):
    # Regex patterns to extract the necessary parts
    call_pattern = re.compile(
        r"(?:Fuzz\.)?(\w+\([^\)]*\))(?: from: (0x[0-9a-fA-F]{40}))?(?: Gas: (\d+))?(?: Time delay: (\d+) seconds)?(?: Block delay: (\d+))?"
    )
    wait_pattern = re.compile(
        r"\*wait\*(?: Time delay: (\d+) seconds)?(?: Block delay: (\d+))?"
    )

    solidity_code = "function test_replay() public {\n"

    lines = call_sequence.strip().split("\n")
    last_index = len(lines) - 1

    for i, line in enumerate(lines):
        call_match = call_pattern.search(line)
        wait_match = wait_pattern.search(line)
        if call_match:
            call, from_addr, gas, time_delay, block_delay = call_match.groups()

            # Add prank line if from address exists
            # if from_addr:
            #     solidity_code += f'    vm.prank({from_addr});\n'

            # Add warp line if time delay exists
            if time_delay:
                solidity_code += f"    vm.warp(block.timestamp + {time_delay});\n"

            # Add roll line if block delay exists
            if block_delay:
                solidity_code += f"    vm.roll(block.number + {block_delay});\n"

            if "collateralToMarketId" in call:
                continue

            # Add function call
            if i < last_index:
                solidity_code += f"    try this.{call} {{}} catch {{}}\n"
            else:
                solidity_code += f"    {call};\n"
            solidity_code += "\n"
        elif wait_match:
            time_delay, block_delay = wait_match.groups()

            # Add warp line if time delay exists
            if time_delay:
                solidity_code += f"    vm.warp(block.timestamp + {time_delay});\n"

            # Add roll line if block delay exists
            if block_delay:
                solidity_code += f"    vm.roll(block.number + {block_delay});\n"
            solidity_code += "\n"

    solidity_code += "}\n"

    return solidity_code


call_sequence = """[{"call":{"contents":["fuzz_pipeline_convert_LP2LP_facet",[{"contents":[256,"510"],"tag":"AbiUInt"},{"contents":[256,"95123481766460925833394310824985741653100412629357356704151337958890613010862"],"tag":"AbiUInt"},{"contents":[256,"115792089237316195423570985008687907853269984665640564039457584007913129639935"],"tag":"AbiUInt"},{"contents":[256,"101694167631085207398957492965905721687578730956072830927499896199221016878983"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x00000000000000000000000000000000000000000000000000000000000668ee","0x0000000000000000000000000000000000000000000000000000000000003c09"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000030000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"},{"call":{"contents":["fuzz_guided_multi_transfer_from_silo_facet",[{"contents":[256,"17615620778672090302514516431516087048509597264199526147994803564487130554018"],"tag":"AbiUInt"},{"contents":[256,"4369999"],"tag":"AbiUInt"},{"contents":[256,"1524785992"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x000000000000000000000000000000000000000000000000000000000000c247","0x0000000000000000000000000000000000000000000000000000000000007fff"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000010000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"},{"call":{"contents":["fuzz_multi_withdraw_silo_facet",[{"contents":[256,"60"],"tag":"AbiUInt"},{"contents":[256,"1524785992"],"tag":"AbiUInt"},{"contents":[256,"82305106572126177573846257842936065637876323671442184209203050709684649944473"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x0000000000000000000000000000000000000000000000000000000000046b47","0x0000000000000000000000000000000000000000000000000000000000001c9b"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000010000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"},{"call":{"contents":["fuzz_withdraw_silo_facet",[{"contents":[256,"40245346303309219742977700843091855849215140603352066962418176753536032858204"],"tag":"AbiUInt"},{"contents":[256,"80074166578165786532919338829113301602947985044118060224057978819091751765742"],"tag":"AbiUInt"},{"contents":[256,"104133183223103690307687232642059915818068953413623478474006598315346634209901"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x00000000000000000000000000000000000000000000000000000000000924c8","0x0000000000000000000000000000000000000000000000000000000000007a98"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000020000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"},{"call":{"contents":["fuzz_guided_increase_approval_facet",[{"contents":[256,"35927852514357645119612002745507410472925078966731801836424088822359196570838"],"tag":"AbiUInt"},{"contents":[256,"0"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x000000000000000000000000000000000000000000000000000000000000ffff","0x00000000000000000000000000000000000000000000000000000000000009de"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000030000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"},{"call":{"contents":["fuzz_withdraw_silo_facet",[{"contents":[256,"101574910437846442888702298510384443773402834260234804037680906908114009422196"],"tag":"AbiUInt"},{"contents":[256,"7"],"tag":"AbiUInt"},{"contents":[256,"4370001"],"tag":"AbiUInt"}]],"tag":"SolCall"},"delay":["0x0000000000000000000000000000000000000000000000000000000000077bce","0x00000000000000000000000000000000000000000000000000000000000026c0"],"dst":"0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496","gas":10000000000000,"gasprice":"0x0000000000000000000000000000000000000000000000000000000000000000","src":"0x0000000000000000000000000000000000020000","value":"0x0000000000000000000000000000000000000000000000000000000000000000"}]"""
solidity_code = convert_to_solidity(call_sequence)
print(solidity_code)