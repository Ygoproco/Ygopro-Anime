--Wing Requital
function c511000736.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000736.cost)
	e1:SetTarget(c511000736.target)
	e1:SetOperation(c511000736.activate)
	c:RegisterEffect(e1)
end
function c511000736.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,600) end
	Duel.PayLPCost(tp,600)
end
function c511000736.drfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST)
end
function c511000736.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c511000736.drfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511000736.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(c511000736.drfilter,p,LOCATION_MZONE,0,nil)
	local h=Duel.GetDecktopGroup(p,ct)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000736.regop)
	if Duel.GetCurrentPhase()==PHASE_DRAW then
		e1:SetReset(RESET_PHASE+PHASE_END,1)
	else
		e1:SetReset(RESET_PHASE+PHASE_END,2)
	end
	e1:SetLabel(ct)
	Duel.RegisterEffect(e1,p)
end
function c511000736.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetTarget(c511000736.drtg)
	e1:SetOperation(c511000736.drop)
	e1:SetLabel(e:GetLabel())
	e1:SetReset(RESET_PHASE+PHASE_STANDBY)
	Duel.RegisterEffect(e1,tp)
end
function c511000736.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,e:GetLabel())
end
function c511000736.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,e:GetLabel(),REASON_EFFECT)
end