--Infernity Sage
function c511000292.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000292,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511000292.target)
	e1:SetOperation(c511000292.operation)
	c:RegisterEffect(e1)
end
function c511000292.disfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xb) and c:GetCode()~=511000292
end
function c511000292.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c511000292.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if Duel.IsExistingMatchingCard(c511000292.disfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil) then
		local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	else
		Duel.DiscardHand(p,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
