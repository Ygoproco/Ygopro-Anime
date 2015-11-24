--Mind Monster
function c511000836.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000836.activate)
	c:RegisterEffect(e1)
end
function c511000836.filter(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsCode(code)
end
function c511000836.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,564)
	local code=Duel.AnnounceCard(tp)
	local sg=Duel.GetMatchingGroup(c511000836.filter,1-tp,LOCATION_DECK+LOCATION_EXTRA,0,nil,code)
	Duel.ConfirmCards(tp,sg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=sg:Select(tp,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Damage(1-tp,tc:GetAttack()/2,REASON_EFFECT)
	else
		local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK+LOCATION_EXTRA)
		Duel.ConfirmCards(tp,dg)
		Duel.ShuffleDeck(1-tp)
	end
end
