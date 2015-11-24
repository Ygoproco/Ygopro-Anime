--Curse of Thorns
function c511000266.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000266.target)
	e1:SetOperation(c511000266.activate)
	c:RegisterEffect(e1)
end
function c511000266.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsType(TYPE_EFFECT)
end
function c511000266.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==1-tp end
	if chk==0 then return Duel.IsExistingTarget(c511000266.filter,tp,0,LOCATION_GRAVE,1,nil,e,0,tp,false,false) end
	local g=Duel.SelectTarget(tp,c511000266.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,0,tp,false,false)
end
function c511000266.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetLabelObject(tc)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511000266.aclimit)
	c:RegisterEffect(e1)
end
function c511000266.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return (loc==LOCATION_GRAVE) and re:IsActiveType(TYPE_MONSTER) and re:GetHandler()==e:GetLabelObject()
end
