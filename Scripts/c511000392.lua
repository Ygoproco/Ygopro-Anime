--Forbidden Beast Nunurao
function c511000392.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000392.spcon)
	c:RegisterEffect(e1)
end
function c511000392.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000380)
end
function c511000392.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000392.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
