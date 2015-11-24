--Life Shaver
function c511001125.initial_effect(c)
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001125.discost)
	e1:SetTarget(c511001125.distg)
	e1:SetOperation(c511001125.disop)
	c:RegisterEffect(e1)
	--turn count
	c511001125.global_check=true
	local ge=Effect.CreateEffect(c)
	ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge:SetCode(EVENT_TURN_END)
	ge:SetCondition(c511001125.regcon)
	ge:SetOperation(c511001125.regop)
	Duel.RegisterEffect(ge,0)
end
function c511001125.regcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001125.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetFlagEffectLabel(511001125)
	if not ct then
		c:RegisterFlagEffect(511001125,RESET_EVENT+0x1fe0000,0,1,0)
	else
		c:SetFlagEffectLabel(511001125,ct+1)
	end
end
function c511001125.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	local ct=e:GetHandler():GetFlagEffectLabel(511001125)
	if not ct then ct=0 end
	e:SetLabel(ct)
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511001125.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=e:GetHandler():GetFlagEffectLabel(511001125)
		if not ct then ct=0 end
		return Duel.GetFieldGroupCount(0,0,LOCATION_HAND)>ct-1
	end
	local ct=e:GetLabel()
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,ct-1)
end
function c511001125.disop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	if Duel.GetFieldGroupCount(0,0,LOCATION_HAND)>ct then
		for i=1,ct+1 do
			Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
		end
	end
end
