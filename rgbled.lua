-- PWM RGB LED controller
rgbled = {};

function rgbled.init(pin_r, pin_g, pin_b)
	local self = {}
	self.pin_r = pin_r or 1
	self.pin_g = pin_g or 2
	self.pin_b = pin_b or 3
	pwm.setup(self.pin_r, 500, 512)
	pwm.setup(self.pin_g, 500, 512)
	pwm.setup(self.pin_b, 500, 512)
	pwm.start(self.pin_r)
	pwm.start(self.pin_g)
	pwm.start(self.pin_b)

	function self.set(color)
        pwm.setduty(self.pin_r, color[1])
        pwm.setduty(self.pin_g, color[2])
        pwm.setduty(self.pin_b, color[3])
	end

	return self
end
