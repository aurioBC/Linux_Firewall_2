#!/bin/bash

#Script to test inbound traffic. Test results are outputted to a file

DESTINATION="192.168.0.8"

# Test TCP port 80
if [ "`hping3 $DESTINATION -p 80 -c 3 -S 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 1: hping3 $DESTINATION -p 80 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound port 80 TCP test PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 1: hping3 $DESTINATION -p 80 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound port 80 TCP test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi


# Test TCP port 443
if [ "`hping3 $DESTINATION -p 443 -c 3 -S 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 2: hping3 $DESTINATION -p 443 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound port 443 TCP test PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 2: hping3 $DESTINATION -p 443 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound port 443 TCP test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi


# Test UDP port 53
if [ "`hping3 $DESTINATION -p 53 -c 3 -2 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 3: hping3 $DESTINATION -p 53 -c 3 -2" >> inbound_test_results
	echo "Result: Inbound port 53 UDP test PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 3: hping3 $DESTINATION -p 53 -c 3 -2" >> inbound_test_results
	echo "Result: Inbound port 53 UDP test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi

# Test telnot packet droppping
if [ "`hping3 $DESTINATION -p 23 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 4: hping3 $DESTINATION -p 22 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound Telnet test PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 4: hping3 $DESTINATION -p 22 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound Telnet test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi

# Test SYN FIN packet droppping
if [ "`hping3 $DESTINATION -p 80 -c 3 -SF 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 5: hping3 $DESTINATION -p 80 -c 3 -SF" >> inbound_test_results
	echo "Result: Inbound SYN FIN test PASSED" >> inbound_test_results
    echo " " >> inbound_test_resultselse
else
    echo "Test 5: hping3 $DESTINATION -p 80 -c 3 -SF" >> inbound_test_results
	echo "Result: Inbound SYN FIN test FAILED" >> inbound_test_results
    echo " " >> inbound_test_resultselse
fi

# Test ICMP
if [ "`hping3 $DESTINATION -1 -c 3 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 6: hping3 $DESTINATION -1 -c 3" >> inbound_test_results
	echo "Result: Inbound ICMP test PASSED" >> inbound_test_results
    echo " " >> inbound_test_resultselse
else
    echo "Test 6: hping3 $DESTINATION -1 -c 3" >> inbound_test_results
	echo "Result: Inbound ICMP  test FAILED" >> inbound_test_results
    echo " " >> inbound_test_resultselse
fi

# Test TCP port 111 dropping
if [ "`hping3 $DESTINATION -p 111 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 7: hping3 $DESTINATION -p 111 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 111 PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 7: hping3 $DESTINATION -p 111 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 111 FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi

# Test TCP port 515 dropping
if [ "`hping3 $DESTINATION -p 515 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 8: hping3 $DESTINATION -p 515 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 515 PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 8: hping3 $DESTINATION -p 515 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 515 test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi

# Test TCP port 137 dropping
if [ "`hping3 $DESTINATION -p 137 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 9: hping3 $DESTINATION -p 137 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 137 PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 9: hping3 $DESTINATION -p 137 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 137 test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi

# Test TCP port 32768 dropping
if [ "`hping3 $DESTINATION -p 32768 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 10: hping3 $DESTINATION -p 32768 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 32768 PASSED" >> inbound_test_results
    echo " " >> inbound_test_results
else
    echo "Test 10: hping3 $DESTINATION -p 32768 -c 3 -S" >> inbound_test_results
	echo "Result: Inbound TCP to port 32768 test FAILED" >> inbound_test_results
    echo " " >> inbound_test_results
fi
