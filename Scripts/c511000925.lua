--Soul Shield
function c511000925.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCost(c511000925.cost)
	e1:SetCondition(c511000925.condition)
	e1:SetOperation(c511000925.activate)
	c:RegisterEffect(e1)
end
function c511000925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,Duel.GetLP(tp)/2)
end
function c511000925.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget():IsControler(tp)
end
function c511000925.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end