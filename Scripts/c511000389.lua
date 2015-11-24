--Forbidden Beast Bronn
function c511000389.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000389.con)
	e1:SetValue(c511000389.efilter)
	c:RegisterEffect(e1)
end
function c511000389.efilter(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP) or te:IsActiveType(TYPE_MONSTER)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c511000389.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000380)
end
function c511000389.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000389.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
