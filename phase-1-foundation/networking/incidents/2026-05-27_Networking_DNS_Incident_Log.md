#### **Date: 2026-05-27**

#### **Day: 08**

#### **Severity: Low**

#### **Category: Process**

---

#### **What I Was Doing**

Added a manual IP entry `1.2.3.4 google.com` to the `/etc/hosts` file to override domain resolution. Then tested network connectivity using `ping google.com`.

---

#### **What Went Wrong**

Command:

```bash
ping google.com
```

Output:

```text
PING google.com (1.2.3.4) 56(84) bytes of data.

--- google.com ping statistics ---
2 packets transmitted, 0 received, 100% packet loss
```

Result:

`google.com` resolved to `1.2.3.4` instead of its real IP address, causing failed connectivity.

---

#### **Investigation**

#### **1. Internet Connectivity Test**

Command:

```bash
ping 8.8.8.8
```

Result:

ICMP responses received (network is reachable)

Conclusion:

Internet connectivity is working fine.

---

#### **2. DNS Resolution Test**

Command:

```bash
nslookup google.com
```

Output:

```text
Server: 172.24.96.1
Non-authoritative answer:
Name: google.com
Address: 142.251.216.110
```

Result:

DNS is working correctly and returning valid Google IPs.

---

#### **3. Direct IP Test**

Command:

```bash
ping 142.251.216.110
```

Output:

Successful replies received.

Result:

Target host is reachable and network path is valid.

---

#### **4. Hosts File Verification**

Command:

```bash
cat /etc/hosts
```

Output:

```text
1.2.3.4 google.com present in file
```

Result:

Manual override exists in `/etc/hosts`, causing incorrect resolution.

---

#### **Fix Applied**

Command:

```bash
sudo nano /etc/hosts
```

Action:

Removed line:

```text
1.2.3.4 google.com
```

Saved and exited file.

---

#### **Verification**

Command:

```bash
cat /etc/hosts
```

Result:

Only default system entries remain. No manual DNS override present.

---

#### **Root Cause**

Incorrect manual entry in `/etc/hosts` forced hostname resolution of `google.com` to invalid IP address `1.2.3.4`, bypassing DNS resolution.

---

#### **What I Learned**

- `/etc/hosts` overrides DNS resolution
- Ping failure does not always indicate internet failure
- Always verify DNS, IP connectivity, and hosts file during debugging
- Proper network debugging follows a layered approach:
  1. Check IP connectivity
  2. Check DNS resolution
  3. Check local host overrides (`/etc/hosts`)
