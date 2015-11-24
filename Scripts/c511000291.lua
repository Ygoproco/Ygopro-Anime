--Infernity Pawn
function c511000291.initial_effect(c)
	--skip draw 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000291,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511000291.scon1)
	e1:SetOperation(c511000291.sop1)
	c:RegisterEffect(e1)
	--skip draw 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000291,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000291.scon2)
	e2:SetOperation(c511000291.sop1)
	c:RegisterEffect(e2)
	--draw 3
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000291,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000291.scon3)
	e3:SetTarget(c511000291.stg3)
	e3:SetOperation(c511000291.sop3)
	c:RegisterEffect(e3)
end
function c511000291.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xb) and c:GetCode()~=511000291
end
function c511000291.scon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN) and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0 and Duel.GetTurnPlayer()~=e:GetHandler():GetControler() and Duel.IsExistingMatchingCard(c511000291.sfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c511000291.scon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0 and Duel.IsExistingMatchingCard(c511000291.sfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c511000291.sop1(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
function c511000291.scon3(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
function c511000291.stg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000291.sop3(e,tp,eg,ep,ev,re,r,rp)
	_replace_count=_replace_count+1
	if _replace_count>_replace_max or not e:GetHandler():IsRelateToEffect(e) then return end
end
