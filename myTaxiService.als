module  myTaxiService

/*** Class declaration ***/

//SIGNATURES

sig Date {}

sig Time {}

sig seqChar {}

sig User {
	name : one  seqChar,
	surname: one seqChar,
	telephone: one seqChar,
	email : one seqChar,
	password: one seqChar,
	creditCard: one CreditCard,
	notification: set Notification
}

sig CreditCard {
	number: one seqChar,
	type: one seqChar,
	ccv : one seqChar,
	expireDate: one Date
}

sig Notification {
	message: one seqChar 
}

sig Taxi {
	identification: one seqChar,
	plate:one seqChar
}

sig TaxiDriver {
	username: one seqChar, 
	passcode : one seqChar,
	telephone: one seqChar,
	taxi: one Taxi,
	notification: set Notification
}

sig Call {
	idCall:one seqChar
}

sig QuickCall extends Call {
	departureLocation: one seqChar 
}

sig Reservation extends Call {
	departureTime: one Time,
	departureDate : one Date,
	departureLocation: one seqChar,
	arrivalLocation: one seqChar
} 
