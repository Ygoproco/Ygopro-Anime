--The Fool's Ruling
function c511000815.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c511000815.con)
	e1:SetOperation(c511000815.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c511000815.handcon)
	c:RegisterEffect(e2)
end
function c511000815.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000815.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
end
function c511000815.handcon(e)
	return Duel.GetTurnPlayer()==e:GetHandler():GetControler()
end
