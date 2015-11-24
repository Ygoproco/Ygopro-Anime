--Sand Fortress
function c511000467.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000467.atkcon)
	e2:SetOperation(c511000467.atkop)
	e2:SetLabel(0)
	c:RegisterEffect(e2)
end
function c511000467.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and ep==tp and tp~=Duel.GetTurnPlayer()
end
function c511000467.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
	e:SetLabel(e:GetLabel()+ev)
	if e:GetLabel()>3000 then
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
