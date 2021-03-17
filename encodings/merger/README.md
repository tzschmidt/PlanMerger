# Plan merger Encodings

This directory includes several approaches of our plan merger implementation.

- **Approach 1**
    + Check for collisions
    + try to fix collisions by waiting and evading
    + repeat until all collisions are solved or the horizon is exceeded
- **Approach 2**
    + Generates possible movement delays and alternations at different moments in time
    + remove invalid plans through constraints


