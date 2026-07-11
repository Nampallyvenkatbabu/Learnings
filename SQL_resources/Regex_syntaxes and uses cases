# SQL REGEXP Cheat Sheet (MySQL)

A quick reference for Regular Expressions (`REGEXP`) used in MySQL and LeetCode SQL problems.

---

# Basic Syntax

```sql
SELECT *
FROM Users
WHERE column_name REGEXP 'pattern';
```

Example:

```sql
SELECT *
FROM Users
WHERE name REGEXP '^A';
```

---

# Anchors

## `^` - Start of String

```regex
^A
```

Matches:

```
Alice
Andrew
```

Doesn't Match:

```
Bob
MarkA
```

---

## `$` - End of String

```regex
e$
```

Matches:

```
Alice
Joe
```

---

## Exact Match

```regex
^John$
```

Matches:

```
John
```

Doesn't Match:

```
Johnny
John1
```

---

# Character Classes

## Any Uppercase Letter

```regex
[A-Z]
```

---

## Any Lowercase Letter

```regex
[a-z]
```

---

## Any Letter

```regex
[A-Za-z]
```

---

## Any Digit

```regex
[0-9]
```

---

## Letter or Digit

```regex
[A-Za-z0-9]
```

---

## Anything Except Digits

```regex
[^0-9]
```

Matches:

```
A
a
_
@
```

Doesn't Match:

```
0
5
9
```

---

## Anything Except Letters

```regex
[^A-Za-z]
```

---

# Important: Meaning of `^`

Outside `[]`

```regex
^A
```

Means:

> Starts with A

---

Inside `[]`

```regex
[^0-9]
```

Means:

> NOT a digit

**Memory Trick**

- Outside `[]` → Start
- Inside `[]` → NOT

---

# Quantifiers

## `*` (Zero or More)

```regex
A*
```

Matches:

```
""
A
AA
AAA
```

---

## `+` (One or More)

```regex
A+
```

Matches:

```
A
AA
AAA
```

Doesn't Match:

```
""
```

---

## `?` (Zero or One)

```regex
colou?r
```

Matches:

```
color
colour
```

---

## Exactly n Times

```regex
[0-9]{4}
```

Matches:

```
2024
1234
```

---

## At Least n Times

```regex
[0-9]{3,}
```

Matches:

```
123
1234
12345
```

---

## Between n and m Times

```regex
[0-9]{2,5}
```

Matches:

```
12
123
1234
12345
```

---

# Wildcards

## `.` (Any Character)

```regex
a.c
```

Matches:

```
abc
a1c
a-c
a?c
```

---

## `\.` (Literal Dot)

```regex
leetcode\.com
```

Matches:

```
leetcode.com
```

Doesn't Match:

```
leetcodeXcom
leetcode?com
```

---

# OR Operator

```regex
cat|dog
```

Matches:

```
cat
dog
```

---

# Groups

```regex
(abc)+
```

Matches:

```
abc
abcabc
abcabcabc
```

---

# Common MySQL REGEXP Examples

## Starts with A

```sql
SELECT *
FROM Employees
WHERE name REGEXP '^A';
```

---

## Ends with n

```sql
SELECT *
FROM Employees
WHERE name REGEXP 'n$';
```

---

## Contains "li"

```sql
SELECT *
FROM Employees
WHERE name REGEXP 'li';
```

---

## Exactly "John"

```sql
SELECT *
FROM Employees
WHERE name REGEXP '^John$';
```

---

## Only Alphabets

```sql
SELECT *
FROM Employees
WHERE name REGEXP '^[A-Za-z]+$';
```

---

## Only Numbers

```sql
SELECT *
FROM Employees
WHERE code REGEXP '^[0-9]+$';
```

---

## Only Uppercase

```sql
SELECT *
FROM Employees
WHERE code REGEXP '^[A-Z]+$';
```

---

## Only Lowercase

```sql
SELECT *
FROM Employees
WHERE code REGEXP '^[a-z]+$';
```

---

## No Digits Allowed

```sql
SELECT *
FROM Employees
WHERE name REGEXP '^[^0-9]+$';
```

---

## Exactly 10 Digits

```sql
SELECT *
FROM Customers
WHERE phone REGEXP '^[0-9]{10}$';
```

---

## Product Code

Format:

```
PRD-1234
```

Regex:

```regex
^PRD-[0-9]{4}$
```

---

## Gmail Users

```regex
^[A-Za-z0-9._-]+@gmail\.com$
```

---

## Yahoo Users

```regex
^[A-Za-z0-9._-]+@yahoo\.com$
```

---

# LeetCode 1517 - Find Users With Valid E-Mails

```sql
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';
```

Explanation:

| Pattern | Meaning |
|----------|---------|
| `^` | Start of string |
| `[A-Za-z]` | First character must be a letter |
| `[A-Za-z0-9_.-]*` | Zero or more valid characters |
| `@leetcode\\.com` | Exact domain |
| `$` | End of string |

---

# Escape Characters

These characters have special meanings:

```
.
+
*
?
^
$
(
)
[
]
{
}
|
\
```

To match them literally, use a backslash.

Example:

```regex
\.
```

Matches:

```
.
```

---

# Quick Reference

| Pattern | Meaning |
|----------|---------|
| `^A` | Starts with A |
| `e$` | Ends with e |
| `^John$` | Exactly John |
| `[A-Z]` | Uppercase |
| `[a-z]` | Lowercase |
| `[A-Za-z]` | Letter |
| `[0-9]` | Digit |
| `[^0-9]` | Not a digit |
| `*` | Zero or more |
| `+` | One or more |
| `?` | Zero or one |
| `{3}` | Exactly 3 |
| `{2,5}` | Between 2 and 5 |
| `.` | Any character |
| `\.` | Literal dot |
| `|` | OR |
| `()` | Group |

---

# Recommended LeetCode Problems

- ✅ 1517. Find Users With Valid E-Mails
- ✅ 1527. Patients With a Condition
- ✅ 1667. Fix Names (String Functions)
