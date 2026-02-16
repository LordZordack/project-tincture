---
description: How to work on tickets from the .tickets directory
---

# Ticket Workflow

## Starting a Ticket

1. Read the ticket file from `.tickets/` as requested by the user.
2. Understand the requirements and acceptance criteria in the ticket.
3. Plan the implementation, creating an implementation plan if the ticket is complex.
4. Implement the changes described in the ticket. As each requirement and acceptance criterion is met, mark it with a checkbox (`- [x]`) in the ticket file.

## Completing a Ticket

5. After implementation is complete, ask the user to verify the changes (e.g. run the game with `/run`, review code, test functionality).
6. If the user confirms the work is satisfactory, move the ticket to `.complete/`:
// turbo
```bash
mv .tickets/<ticket-file> .complete/<ticket-file>
```
7. Commit the changes using the `/commit` workflow.
