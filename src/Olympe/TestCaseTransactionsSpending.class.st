Class {
	#name : #TestCaseTransactionsSpending,
	#superclass : #TestCase,
	#instVars : [
		'olympe',
		'root'
	],
	#category : #'Olympe-Core'
}

{ #category : #running }
TestCaseTransactionsSpending >> setUp [
	| ledger state |
	super setUp.
	olympe := Olympe new.
	state := OLState new.
	ledger := OLLedger new.
	state install: ledger named: #ledger.
	olympe root: state.
	
]

{ #category : #running }
TestCaseTransactionsSpending >> testTransactionApplied [
	| transaction |
	transaction := OLTransaction new.
	transaction
		sender: 'sender';
		receiver: #'root.ledger';
		message: #move:from:to:;
		arguments: {20 . 'sender' . 'receiver'}.
	olympe apply: transaction.
]
