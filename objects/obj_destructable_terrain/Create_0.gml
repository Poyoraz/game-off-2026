// Inherit the parent event
event_inherited();


transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
	if(type == TransmitMomentumType.COLLISION && momentum > 20) instance_destroy()
})