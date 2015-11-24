--Treasures of the Dead
function c511000551.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000551.target)
	e1:SetOperation(c511000551.activate)
	c:RegisterEffect(e1)
end
function c511000551.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511000551.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511000551.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetFieldGroupCount(1-tp,LOCATION_REMOVED,0)*300
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,rec)
end
function c511000551.activate(e,tp,eg,ep,ev,re,r,rp)
	local val=Duel.GetMatchingGroupCount(c511000551.filter,tp,LOCATION_GRAVE,0,e:GetHandler())*300
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,val,REASON_EFFECT)
end
