# Date: 2026-05-25
# Day: 08
# Severity: Low
# Category: Incident Response (Networking & DNS Troubleshooting)

## What I was doing
I was performing a Linux networking diagnostics session in WSL2 to understand network interfaces, routing, DNS resolution, and connectivity behavior.

I started by inspecting network interfaces using:
ip a

Then I tested routing, DNS resolution, connectivity, and system networking behavior using commands such as:
ip route, ping, cat /etc/resolv.conf, ss -tuln, dig, curl

## Error / Investigation
During the session, I encountered multiple networking-related issues:

1. Missing command error:
dig google.com
Output:
Command 'dig' not found

2. Package installation failure:
sudo apt install bind9-dnsutils
Error:
404 Not Found (repository mismatch / outdated package index)

3. DNS resolution failure after manual modification:
ping google.com
Result:
Resolved to incorrect IP (1.2.3.4) and failed completely

4. DNS resolution failure for invalid domain:
ping googllle.com
Output:
Temporary failure in name resolution

5. API resolution failure:
curl https://api.github.com/invalidendpoint
Output:
Could not resolve host

Investigation steps included:
- Checking network interfaces (ip a)
- Checking routing table (ip route)
- Verifying DNS configuration (/etc/resolv.conf)
- Checking local DNS resolver service (ss -tuln)
- Testing external connectivity via ping and curl
- Modifying /etc/hosts to test DNS override behavior

## Fix applied
1. Fixed package manager issue using:
sudo apt update --fix-missing

This restored package index and corrected repository metadata.

2. Verified DNS resolver service was active via:
ss -tuln

No permanent system fix was applied for /etc/hosts modification because it was intentional for testing.

3. No rollback was required, but DNS override entry in /etc/hosts was identified as the cause of domain resolution failure.

## Root cause
The primary root cause of the incident was a manual modification of the /etc/hosts file that introduced an incorrect DNS override:

1.2.3.4 google.com

This forced the system to bypass real DNS resolution and map google.com to an invalid IP address.

Secondary contributing factors:
- Missing DNS utility package (bind9-dnsutils)
- Outdated package index causing 404 installation errors
- Lack of initial verification before modifying system-level DNS configuration

## What I learned
- Linux DNS resolution follows a strict hierarchy: /etc/hosts → resolv.conf → system DNS → gateway
- Incorrect entries in /etc/hosts can completely override valid DNS resolution
- “Could not resolve host” indicates DNS failure, not necessarily network failure
- Package installation issues often stem from outdated apt indexes, not missing software
- Tools like ip a, ip route, ss -tuln, and ping are essential for layered network debugging
- DNS is a layered system where failure can occur at multiple points (local, resolver, or external)

## Impact
- DNS resolution for google.com was intentionally broken during testing
- External API request failed due to hostname resolution failure
- Package installation was temporarily blocked due to repository mismatch
- No system damage occurred, but normal network name resolution was disrupted during testing

## Prevention
- Avoid modifying /etc/hosts without clear validation of entries
- Always verify DNS changes using ping or dig before assuming correctness
- Run sudo apt update before installing network-related packages
- Use layered troubleshooting (interface → route → DNS → application) instead of isolated checks
- Document all manual DNS overrides to prevent accidental persistence
