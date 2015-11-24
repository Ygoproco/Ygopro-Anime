--Forbidden Beast Inun
function c511000379.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000379,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511000379.srcon)
	e1:SetTarget(c511000379.srtg)
	e1:SetOperation(c511000379.srop)
	c:RegisterEffect(e1)
end
function c511000379.srcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000379.fmfilter(c)
	return c:IsFaceup() and c:IsCode(511000380)
end
function c511000379.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(c511000379.fmfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	else
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end
function c511000379.filter(c)
	return c:IsCode(511000380) and c:IsAbleToHand()
end
function c511000379.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=nil
	if Duel.IsExistingMatchingCard(c511000379.fmfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		g=Duel.SelectMatchingCard(tp,c511000379.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	else
		g=Duel.SelectMatchingCard(tp,c511000379.filter,tp,LOCATION_DECK,0,1,1,nil)
	end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
