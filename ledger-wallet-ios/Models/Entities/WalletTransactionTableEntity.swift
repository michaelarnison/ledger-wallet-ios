//
//  WalletTransactionTableEntity.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 15/12/2015.
//  Copyright © 2015 Ledger. All rights reserved.
//

import Foundation

struct WalletTransactionTableEntity: SQLiteTableEntityType {
    
    static let tableName = "transaction"
    
    static let hashKey = "hash"
    static let receptionDateKey = "reception_date"
    static let lockTimeKey = "lock_time"
    static let feesKey = "fees"
    static let blockHashKey = "block_hash"
    static let blockHeightKey = "block_height"
    static let blockTimeKey = "block_time"
    
}