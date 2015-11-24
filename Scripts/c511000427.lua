--Aid to the Doomed
function c511000427.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c511000427.cost)
	e1:SetOperation(c511000427.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000427.condition)
	e2:SetCost(c511000427.cost)
	e2:SetTarget(c511000427.tg)
	e2:SetOperation(c511000427.activate)
	c:RegisterEffect(e2)
end
function c511000427.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511000427.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,2,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
    local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,2,2,e:GetHandler())
    Duel.SendtoGrave(g,REASON_EFFECT)
end
function c511000427.filter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE)
end
function c511000427.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
function c511000427.activate(e,tp,eg,ep,ev,re,r,rp)
    local sk=Duel.GetTurnPlayer()
    Duel.BreakEffect()
    Duel.SkipPhase(sk,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	Duel.SkipPhase(sk,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
    Duel.SkipPhase(sk,PHASE_MAIN2,RESET_PHASE+PHASE_MAIN2,1)
    Duel.SkipPhase(sk,PHASE_END,RESET_PHASE+PHASE_END,1)
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
