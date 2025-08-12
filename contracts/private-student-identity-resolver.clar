;; Private Student Identity Resolver Contract
;; View student identity only if whitelisted

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-whitelisted (err u101))
(define-constant err-student-not-found (err u102))

;; Data structures
(define-map student-identities principal {
    student-id: uint,
    name: (string-ascii 50),
    institution: (string-ascii 100),
    graduation-year: uint,
    is-active: bool
})

(define-map whitelist principal bool)

;; Add student identity (owner only)
(define-public (add-student-identity 
    (student principal) 
    (student-id uint) 
    (name (string-ascii 50)) 
    (institution (string-ascii 100)) 
    (graduation-year uint))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (map-set student-identities student {
            student-id: student-id,
            name: name,
            institution: institution,
            graduation-year: graduation-year,
            is-active: true
        })
        (ok true)))

;; View student identity (whitelisted only)
(define-read-only (get-student-identity (student principal))
    (begin
        (asserts! (default-to false (map-get? whitelist tx-sender)) err-not-whitelisted)
        (match (map-get? student-identities student)
            identity (ok identity)
            err-student-not-found)))

;; Add to whitelist (owner only)
(define-public (add-to-whitelist (user principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (map-set whitelist user true)
        (ok true)))

;; Remove from whitelist (owner only)
(define-public (remove-from-whitelist (user principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (map-set whitelist user false)
        (ok true)))

;; Check if user is whitelisted
(define-read-only (is-whitelisted (user principal))
    (ok (default-to false (map-get? whitelist user))))

;; Get contract owner
(define-read-only (get-owner)
    (ok contract-owner))