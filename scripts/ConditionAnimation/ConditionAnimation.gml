function ConditionAnimation(condition) constructor{
	self.condition = condition
	
	script_execute(BaseAnimation, undefined, condition)
}