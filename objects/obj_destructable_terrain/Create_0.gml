// Inherit the parent event
event_inherited();

transmit_momentum = method(self, function(momentum, vertical = false, type = TransmitMomentumType.COLLISION) {
	if(type == TransmitMomentumType.COLLISION && abs(momentum) > resistance) instance_destroy()
})