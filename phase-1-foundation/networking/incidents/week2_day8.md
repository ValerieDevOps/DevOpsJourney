# Date: 2026-05-27
# Day: 08
# Severity: Low
# Category: Process

## What I was doing
Added a manual IP entry "1.2.3.4 google.com" to /etc/hosts file to override domain resolution.
Then tested network connectivity using ping google.com.

## What went wrong
Command:
ping google.com

Output:
PING google.com (1.2.3.4) 56(84) bytes of data.

--- google.com ping statistics ---
2 packets transmitted, 0 received, 100% packet loss

Result:
google.com resolved to 1.2.3.4 instead of its real IP address, causing failed connectivity.

## Investigation

1. Internet connectivity test
Command:
ping 8.8.8.8

Result:
ICMP responses received (network is reachable)

Conclusion:
Internet connectivity is working fine

---

2. DNS resolution test
Command:
nslookup google.com

Output:
Server: 172.24.96.1
Non-authoritative answer:
Name: google.com
Address: 142.251.216.110

Result:
DNS is working correctly and returning valid Google IPs

---

3. Direct IP test
Command:
ping 142.251.216.110

Output:
Successful replies received

Result:
Target host is reachable and network path is valid

---

4. Hosts file verification
Command:
cat /etc/hosts

Output:
1.2.3.4 google.com present in file

Result:
Manual override exists in /etc/hosts causing incorrect resolution

## Fix applied
Command:
sudo nano /etc/hosts

Action:
Removed line:
1.2.3.4 google.com

Saved and exited file

## Verification
Command:
cat /etc/hosts

Result:
Only default system entries remain
No manual DNS override present

## Root cause
Incorrect manual entry in /etc/hosts forced hostname resolution of google.com to invalid IP address (1.2.3.4), bypassing DNS resolution.

## What I learned
- /etc/hosts overrides DNS resolution
- ping failure does not always indicate internet failure
- always verify DNS, IP connectivity, and hosts file during debugging
- proper network debugging follows layered approach:
  1. Check IP connectivity
  2. Check DNS resolution
  3. Check local host overrides (/etc/hosts)
