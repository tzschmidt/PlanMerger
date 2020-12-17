# Plan merger Encodings

This directory includes several approaches of our plan merger implementation.

- **Approach 1**
    + Generates possible movement delays and alternations at different moments in time
    + remove invalid plans through constraints
- **Approach 2**
    + Check for collisions
    + try to fix collisions by waiting and evading
    + repeat until all collisions are solved or the horizon is exceeded


