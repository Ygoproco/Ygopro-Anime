--おろかな埋葬
function c511001056.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001056.tg)
	e1:SetOperation(c511001056.op)
	c:RegisterEffect(e1)
end
function c511001056.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND+LOCATION_DECK) and chkc:GetControler()==tp and chkc:IsAbleToGrave() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToGrave,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001056.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local op=Duel.SelectOption(tp,aux.Stringid(511001056,0),aux.Stringid(511001056,1))
		if op==0 then
			Duel.SendtoGrave(tc,REASON_EFFECT)
		else
			local g1=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
			local g2=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
			Duel.SendtoDeck(tc,1-tp,0,REASON_RULE)
			Duel.SwapDeckAndGrave(1-tp)
			Duel.SendtoDeck(g1,1-tp,0,REASON_RULE)
			Duel.SendtoGrave(g2,REASON_RULE+REASON_RETURN)
			Duel.SendtoGrave(g2,REASON_RULE+REASON_RETURN)
		end
	end
end
