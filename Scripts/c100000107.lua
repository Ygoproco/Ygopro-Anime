--ザ・マテリアル・ロード
function c100000107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c100000107.condition)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000107,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c100000107.cost)
	e3:SetTarget(c100000107.target)
	e3:SetOperation(c100000107.operation)
	c:RegisterEffect(e3)
end
function c100000107.filter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5)
end
function c100000107.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000107.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c100000107.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(c100000107.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c100000107.costfilter(c)
	return c:IsSetCard(0x5) and (c:GetLevel()==5 or c:GetLevel()==6) and c:IsAbleToGraveAsCost()
end
function c100000107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000107.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000107.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000107.defilter(c)
	return c:IsCode(100000108) and c:IsAbleToHand()
end
function c100000107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end 
	if Duel.IsExistingMatchingCard(c100000107.defilter,tp,LOCATION_DECK,0,1,nil,e,tp) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end
function c100000107.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local dg=Duel.SelectMatchingCard(tp,c100000107.defilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if dg:GetCount()>0 then	
		Duel.SendtoHand(dg:GetFirst(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,dg:GetFirst())
	end
end