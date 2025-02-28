(define-data-var artwork-creator principal tx-sender)
(define-data-var interested-collector (optional principal) none)
(define-data-var artwork-price uint u0)
(define-data-var sale-finalized bool false)
(define-data-var digital-art-id uint u0)
;; Define an NFT to represent the digital artwork
(define-non-fungible-token digital-art-nft uint)
;; Define a trait for transferring the artwork NFT
(define-trait nft-transfer-trait
  ((transfer (uint principal principal) (response bool uint))))
;; Function to list artwork with a given price and asset ID
(define-public (list-artwork (price uint) (art-id uint))
  (begin
    ;; Check that the caller is the artwork creator
    (asserts! (is-eq (var-get artwork-creator) tx-sender) (err u100))
    ;; Check that the sale hasn't been finalized yet
    (asserts! (is-eq (var-get sale-finalized) false) (err u101))
    ;; Validate price is greater than zero
    (asserts! (> price u0) (err u110))
    ;; Validate art-id
    (asserts! (> art-id u0) (err u111))
    ;; Set the validated values
    (var-set artwork-price price)
    (var-set digital-art-id art-id)
    (ok "Digital artwork listed successfully")
  )
)
;; Function to express interest in buying the artwork
(define-public (place-bid)
  (begin
    (asserts! (is-none (var-get interested-collector)) (err u102))
    (asserts! (is-eq (var-get sale-finalized) false) (err u103))
    (var-set interested-collector (some tx-sender))
    (ok "Bid placed successfully")
  )
)
;; Function to finalize the sale and transfer the artwork
(define-public (finalize-sale)
  (let ((collector (unwrap! (var-get interested-collector) (err u104)))
        (price (var-get artwork-price))
        (art-id (var-get digital-art-id))
        (is-finalized (var-get sale-finalized)))
    (begin
      (asserts! (is-eq tx-sender collector) (err u105))
      (asserts! (is-eq is-finalized false) (err u106))
      ;; Transfer the artwork NFT from creator to collector
      (try! (nft-transfer? digital-art-nft art-id (var-get artwork-creator) collector))
      ;; Transfer funds from collector to creator
      (try! (stx-transfer? price collector (var-get artwork-creator)))
      ;; Mark sale as finalized
      (var-set sale-finalized true)
      (ok "Sale finalized successfully")
    )
  )
)
;; Function to withdraw the bid and reset the interested collector
(define-public (withdraw-bid)
  (let ((collector (unwrap! (var-get interested-collector) (err u107))))
    (asserts! (is-eq tx-sender collector) (err u108))
    (asserts! (is-eq (var-get sale-finalized) false) (err u109))
    (var-set interested-collector none)
    (ok "Bid withdrawn successfully")
  )
)