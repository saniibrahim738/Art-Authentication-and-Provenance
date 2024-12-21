;; Provenance Contract

(define-map provenance-records
  { token-id: uint }
  {
    current-owner: principal,
    previous-owner: (optional principal),
    last-transfer-height: uint
  }
)

(define-public (record-transfer (token-id uint) (new-owner principal))
  (let
    (
      (current-record (default-to
        { current-owner: new-owner, previous-owner: none, last-transfer-height: u0 }
        (map-get? provenance-records { token-id: token-id })))
    )
    (map-set provenance-records
      { token-id: token-id }
      {
        current-owner: new-owner,
        previous-owner: (some (get current-owner current-record)),
        last-transfer-height: block-height
      }
    )
    (ok true)
  )
)

(define-read-only (get-provenance (token-id uint))
  (map-get? provenance-records { token-id: token-id })
)
