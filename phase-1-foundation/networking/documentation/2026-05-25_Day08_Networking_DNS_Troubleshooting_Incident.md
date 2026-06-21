#### **Date: 2026-05-25**

#### **Day: 08**

#### **Severity: Low**

#### **Category: Incident Response (Networking & DNS Troubleshooting)**

---

#### **What I Was Doing**

I was performing a Linux networking diagnostics session in WSL2 to understand network interfaces, routing, DNS resolution, and connectivity behavior.

I started by inspecting network interfaces using:

```bash
ip a
```

Then I tested routing, DNS resolution, connectivity, and system networking behavior using commands such as:

```bash
ip route
ping
cat /etc/resolv.conf
ss -tuln
dig
curl
```

---

#### **Error / Investigation**

During the session, I encountered multiple networking-related issues.

##### **1. Missing Command Error**

Command:

```bash
dig google.com
```

Output:

```text
Command 'dig' not found
```

##### **2. Package Installation Failure**

Command:

```bash
sudo apt install bind9-dnsutils
```

Error:

```text
404 Not Found
```

(repository mismatch or outdated package index)

##### **3. DNS Resolution Failure After Manual Modification**

Command:

```bash
ping google.com
```

Result:

```text
Resolved to incorrect IP (1.2.3.4) and failed completely
```

##### **4. DNS Resolution Failure for Invalid Domain**

Command:

```bash
ping googllle.com
```

Output:

```text
Temporary failure in name resolution
```

##### **5. API Resolution Failure**

Command:

```bash
curl https://api.github.com/invalidendpoint
```

Output:

```text
Could not resolve host
```

#### **Investigation Steps**

- Checked network interfaces using `ip a`
- Checked routing table using `ip route`
- Verified DNS configuration using `cat /etc/resolv.conf`
- Checked local DNS resolver service using `ss -tuln`
- Tested external connectivity using `ping` and `curl`
- Modified `/etc/hosts` to test DNS override behavior

---

#### **Fix Applied**

##### **1. Fixed Package Manager Issue**

Command:

```bash
sudo apt update --fix-missing
```

This restored the package index and corrected repository metadata.

##### **2. Verified DNS Resolver Service**

Command:

```bash
ss -tuln
```

Verified that the DNS resolver service was active.

No permanent system fix was applied for the `/etc/hosts` modification because it was intentional for testing.

##### **3. Identified DNS Override Issue**

No rollback was required, but the DNS override entry in `/etc/hosts` was identified as the direct cause of the domain resolution failure.

---

#### **Root Cause**

The primary root cause of the incident was a manual modification of the `/etc/hosts` file that introduced an incorrect DNS override:

```text
1.2.3.4 google.com
```

This forced the system to bypass real DNS resolution and map `google.com` to an invalid IP address.

#### **Secondary Contributing Factors**

- Missing DNS utility package (`bind9-dnsutils`)
- Outdated package index causing 404 installation errors
- Lack of initial verification before modifying system-level DNS configuration

---

#### **What I Learned**

- Linux DNS resolution follows a strict hierarchy:

  ```text
  /etc/hosts → resolv.conf → system DNS → gateway
  ```

- Incorrect entries in `/etc/hosts` can completely override valid DNS resolution.
- "Could not resolve host" indicates a DNS failure, not necessarily a network failure.
- Package installation issues often stem from outdated apt indexes rather than missing software.
- Tools such as `ip a`, `ip route`, `ss -tuln`, and `ping` are essential for layered network debugging.
- DNS is a layered system where failures can occur at multiple points (local, resolver, or external).

---

#### **Impact**

- DNS resolution for `google.com` was intentionally broken during testing.
- External API requests failed due to hostname resolution failure.
- Package installation was temporarily blocked because of repository mismatch.
- No system damage occurred, but normal network name resolution was disrupted during testing.

---

#### **Prevention**

- Avoid modifying `/etc/hosts` without validating entries.
- Always verify DNS changes using `ping` or `dig`.
- Run `sudo apt update` before installing network-related packages.
- Use layered troubleshooting:

  ```text
  Interface → Route → DNS → Application
  ```

- Document all manual DNS overrides to prevent accidental persistence.
