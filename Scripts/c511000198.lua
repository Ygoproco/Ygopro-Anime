--Enduring Soul
function c511000198.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511000198.destg)
	e2:SetValue(c511000198.value)
	e2:SetOperation(c511000198.desop)
	c:RegisterEffect(e2)
end
function c511000198.dfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE) and c:IsPosition(POS_FACEUP_ATTACK) and c:GetAttack()>=800
end
function c511000198.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000198.dfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(511000198,0)) then
		Duel.SetTargetCard(eg)
		return  true
	else
		return false
	end
end
function c511000198.value(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE)
end
function c511000198.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:IsFaceup() and c:GetAttack()>=800 end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e2:SetReset(RESET_EVENT+0x1ff0000)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(-800)
	tc:RegisterEffect(e2)
	return true
end
