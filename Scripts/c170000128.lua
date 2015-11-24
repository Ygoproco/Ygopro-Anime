--Amber Crystal Circle
function c170000128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c170000128.condition)
	e1:SetTarget(c170000128.target)
	e1:SetOperation(c170000128.activate)
	c:RegisterEffect(e1)
end
function c170000128.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget():GetCode()==69937550
end
function c170000128.filter1(c)
	return c:IsSetCard(0x34) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c170000128.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local tc=Duel.GetAttackTarget()
	if chk==0 then return Duel.IsExistingMatchingCard(c170000128.filter1,tp,LOCATION_MZONE,0,1,tc)
end
end
function c170000128.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if tc:IsFaceup() then
		local atk=0
		local g=Duel.GetMatchingGroup(c170000128.filter1,tp,LOCATION_MZONE,0,tc)
		local bc=g:GetFirst()
		while bc do
			atk=atk+bc:GetAttack()
			bc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	end