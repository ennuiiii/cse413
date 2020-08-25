CSE 413 
HW # 8
Qiubai Yu
1663777

My calculator has all the basic functionalities in the spec.

Extra feature: Error handling

    1) If the parens are not closed, for instance, sqrt(3, 
    the calculator will give an error message saying that
    "right paren expected, restarting..." Same idea for the 
    left paren

    2) If the user call some undefined variable, the calculator
    will give an error message "No such variable exists" and waiting
    for the next input

    3) If the user delete some variables, the calculator will always 
    give a message saying "variables delete" no matter whether the 
    variable exists

    4) If the the user give exit or quit command, the calculator will
    give a message saying "calculator terminated..."