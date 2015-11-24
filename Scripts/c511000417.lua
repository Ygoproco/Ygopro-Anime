--Reduction Barrier
function c511000417.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c511000417.condition)
	e1:SetOperation(c511000417.operation)
	c:RegisterEffect(e1)
end
function c511000417.condition(e,tp,eg,ep,ev,re,r,rp)
	return  ep==tp
end
function c511000417.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/10)
end
