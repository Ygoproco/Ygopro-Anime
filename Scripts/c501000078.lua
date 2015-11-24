--Leonardo's Silver Skyship
function c501000078.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--match winner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c501000078.cost)
	e2:SetTarget(c501000078.tg)
	e2:SetOperation(c501000078.op)
	c:RegisterEffect(e2)
end
function c501000078.cfilter(c,tp)
	return c:IsRace(RACE_MACHINE) and c:IsType(TYPE_PENDULUM) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingTarget(c501000078.filter,tp,LOCATION_MZONE,0,1,c) 
end
function c501000078.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c501000078.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,nil,TYPE_PENDULUM):GetCount()
	if chk==0 then return Duel.IsExistingMatchingCard(c501000078.cfilter,tp,LOCATION_MZONE,0,3,nil,tp) and ct>3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c501000078.cfilter,tp,LOCATION_MZONE,0,3,3,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c501000078.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c501000078.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c501000078.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c501000078.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c501000078.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MATCH_KILL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
