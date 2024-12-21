;; ArtNFT Contract

(define-non-fungible-token art-nft uint)

(define-data-var token-id-nonce uint u0)

(define-map token-metadata
  { token-id: uint }
  {
    artist: (string-ascii 100),
    title: (string-ascii 100),
    creation-date: uint,
    image-url: (string-ascii 256),
    is-physical: bool
  }
)

(define-public (mint-artwork (artist (string-ascii 100)) (title (string-ascii 100)) (creation-date uint) (image-url (string-ascii 256)) (is-physical bool))
  (let
    (
      (token-id (var-get token-id-nonce))
      (caller tx-sender)
    )
    (try! (nft-mint? art-nft token-id caller))
    (map-set token-metadata
      { token-id: token-id }
      {
        artist: artist,
        title: title,
        creation-date: creation-date,
        image-url: image-url,
        is-physical: is-physical
      }
    )
    (var-set token-id-nonce (+ token-id u1))
    (ok token-id)
  )
)

(define-read-only (get-token-metadata (token-id uint))
  (map-get? token-metadata { token-id: token-id })
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u403))
    (nft-transfer? art-nft token-id sender recipient)
  )
)

