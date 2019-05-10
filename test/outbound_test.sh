#!/bin/bash

#Script to test outbound traffic. Test results are outputted to a file

DESTINATION="192.168.0.3"

# Test TCP port 80
if [ "`hping3 $DESTINATION -p 80 -c 3 -S 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 1: hping3 $DESTINATION -p 80 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound port 80 TCP test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 1: hping3 $DESTINATION -p 80 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound port 80 TCP test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi


# Test TCP port 443
if [ "`hping3 $DESTINATION -p 443 -c 3 -S 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 2: hping3 $DESTINATION -p 443 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound port 443 TCP test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 2: hping3 $DESTINATION -p 443 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound port 443 TCP test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi


# Test UDP port 53
if [ "`hping3 $DESTINATION -p 53 -c 3 -2 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 3: hping3 $DESTINATION -p 53 -c 3 -2" >> outbound_test_results
	echo "Result: Outbound port 53 UDP test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 3: hping3 $DESTINATION -p 53 -c 3 -2" >> outbound_test_results
	echo "Result: Outbound port 53 UDP test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi

# Test telnot packet droppping
if [ "`hping3 $DESTINATION -p 23 -c 3 -S 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 4: hping3 $DESTINATION -p 22 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound Telnet test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 4: hping3 $DESTINATION -p 22 -c 3 -S" >> outbound_test_results
	echo "Result: Outbound Telnet test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi

# Test SYN FIN packet droppping
if [ "`hping3 $DESTINATION -p 80 -c 3 -SF 2>&1 | grep -o ' 100%'`" == " 100%" ]
then
    echo "Test 5: hping3 $DESTINATION -p 80 -c 3 -SF" >> outbound_test_results
	echo "Result: Outbound SYN FIN test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 5: hping3 $DESTINATION -p 80 -c 3 -SF" >> outbound_test_results
	echo "Result: Outbound SYN FIN test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi

# Test ICMP
if [ "`hping3 $DESTINATION -1 -c 3 2>&1 | grep -o ' 0%'`" == " 0%" ]
then
    echo "Test 6: hping3 $DESTINATION -1 -c 3" >> outbound_test_results
	echo "Result: Outbound ICMP test PASSED" >> outbound_test_results
    echo " " >> outbound_test_results
else
    echo "Test 6: hping3 $DESTINATION -1 -c 3" >> outbound_test_results
	echo "Result: Outbound ICMP  test FAILED" >> outbound_test_results
    echo " " >> outbound_test_results
fi
