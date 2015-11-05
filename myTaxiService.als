module  myTaxiService

/*** Class declaration ***/

//SIGNATURES

sig Date {}

sig Time {}

sig seqChar {}

sig User {
	name : one  seqChar,
	surname: one  seqChar,
	telephone: one  seqChar,
	email : one  seqChar,
	password: one  seqChar,
	creditCard: one CreditCard,
	rides: set Call
}


sig CreditCard {
	owner: one User,
	number: one  seqChar,
	type: one  seqChar,
	ccv : one  seqChar,
	expireDate: one Date
}


sig Taxi {
	owner: one TaxiDriver,
	identification: one  seqChar,
	plate:one  seqChar
}


sig TaxiDriver {
	username: one  seqChar, 
	passcode : one  seqChar,
	telephone: one  seqChar,
	taxi: one Taxi,
	calls: set Call
}


sig Call {
	idCall:one  seqChar
}


sig QuickCall extends Call {
	departureLocation: one  seqChar 
}


sig Reservation extends Call {
	departureTime: one Time,
	departureDate : one Date,
	departureLocation: one  seqChar,
	arrivalLocation: one  seqChar
}


/*** Definition of the constraints ***/
//FACTS

// each user has only one credit card and each credit card is of a user

fact creditCardProperty {
	all u : User | ( all c : CreditCard | u.creditCard = c <=> c.owner = u)
}

// each driver has only one taxi  and each taxi  is of a driver
fact taxiProperty {
	all d : TaxiDriver | ( all t : Taxi | d.taxi = t <=> t.owner = d)
}


// each call in taxi driver's calls must be in a user rides

fact callConsistency {
	all c: Call | some u : User | some t : TaxiDriver |
		c in u.rides && c in t.calls
}	

/*** Verify the model ***/
//ASSERT

//Each user has only one creditcard and that credit card is of that user

assert onlyOneOwnerCreditCard{
	all u: User |
		( all c:CreditCard |
			( u.creditCard = c <=> c.owner = u) )
}
check onlyOneOwnerCreditCard

//Each taxi driver has only one taxi and that taxi is of that taxi driver

assert onlyOneOwnerTaxi{
	all d: TaxiDriver |
		( all t:Taxi |
			(d.taxi = t <=> t.owner = d) )
}
check onlyOneOwnerTaxi

//Each call exists only if it is in user's rides and in driver's calls

assert callExistance {
	all c : Call |	some u : User | some t: TaxiDriver |
		c in u.rides && c in t.calls
}	
check callExistance


//PREDICATES

//add a ride to a user

pred addRideUser [u: User, r: Call] {
	u.rides = u.rides+r
}

//add a call to a taxi driver

pred addCallTaxi [ t: TaxiDriver, c:Call] {
	t.calls = t.calls + c
}

//delete a call

pred removeCall[c:Call, u:User] {
u.rides = u.rides - c
}


pred show {}

run show
run addCallTaxi 
run addRideUser
run removeCall
