--Block Dugout
function c511000206.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c511000206.atcon)
	c:RegisterEffect(e2)
end
function c511000206.atcon(e)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),0,LOCATION_MZONE,nil)
	return g1:GetSum(Card.GetLevel)<g2:GetSum(Card.GetLevel)
end
