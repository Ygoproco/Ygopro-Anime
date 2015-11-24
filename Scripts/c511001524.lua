--Tears of a Mermaid
function c511001524.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c511001524.con1)
	e1:SetOperation(c511001524.act1)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511001524.con2)
	e2:SetOperation(c511001524.act2)
	c:RegisterEffect(e2)
end
function c511001524.filter(c,tp)
	return c:IsControler(1-tp) and bit.band(c:GetPreviousPosition(),POS_FACEDOWN)~=0 and c:IsFaceup()
end
function c511001524.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001524.filter,1,nil,tp)
end
function c511001524.act1(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetOperation(c511001524.disop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_ACTIVATING)
	e2:SetOperation(c511001453.disop2)
	e2:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e2,tp)
end
function c511001524.act2(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph>PHASE_MAIN1 and ph<PHASE_MAIN2 and Duel.IsChainDisablable(ev) then
		Duel.NegateEffect(ev)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetOperation(c511001524.disop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_ACTIVATING)
	e2:SetOperation(c511001524.disop2)
	e2:SetReset(RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e2,tp)
end
function c511001524.con2(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and bit.band(rc:GetPreviousPosition(),POS_FACEDOWN)~=0 and rc:IsFaceup()
end
function c511001524.disop(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph>PHASE_MAIN1 and ph<PHASE_MAIN2 and Duel.GetAttacker():IsControler(1-tp) then
		Duel.Hint(HINT_CARD,0,511001524)
		Duel.NegateAttack()
	end
end
function c511001524.disop2(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph>PHASE_MAIN1 and ph<PHASE_MAIN2 and re:GetHandler():IsControler(1-tp) then
		Duel.Hint(HINT_CARD,0,511001524)
		Duel.NegateEffect(ev)
	end
end
