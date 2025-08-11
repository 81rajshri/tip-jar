# Private Student Identity Resolver – Clarity Contract

## Project Title
Private Student Identity Resolver – View Only If Whitelisted

## Project Description
This contract provides a mechanism to securely store student identity information in a decentralized way, ensuring that only whitelisted users can view sensitive details. The contract allows adding accounts to a whitelist and provides the functionality to retrieve student identity information if the requestor is on that whitelist.

## Project Vision
The goal of this project is to create a private and secure method for managing student identities on a blockchain using the Clarity language. By restricting access to student identity data to only trusted parties (whitelisted users), it helps protect sensitive student information while still allowing authorized users to access it when necessary.

## Future Scope
- **Expand the data storage**: Currently, the contract only stores a student's name, date of birth, and email. The scope can be extended to include additional details such as address, student ID, courses, etc.
- **More Granular Access Control**: Implement different levels of access depending on the user's role (e.g., faculty, admin, etc.).
- **Integration with other DApps**: Extend functionality to allow other decentralized applications to interact with student identity data based on whitelisted access.

## Contract Add

### Function 1: `add-to-whitelist`

**Purpose**: This function allows the contract owner to add an account to the whitelist. Only whitelisted accounts can view student identities.

**Parameters**:
- `account (principal)`: The account principal to be added to the whitelist.

**Usage**:
- Only the contract owner can call this function.
- Adds a given account to the whitelist.

```lisp
(define-public (add-to-whitelist (account principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (map-set whitelist account true)
    (ok true)))
