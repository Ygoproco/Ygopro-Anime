--Damage Pot
function c511000185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000185.activate)
	c:RegisterEffect(e1)
end
function c511000185.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
	if chk==0 then return true end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000185,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetLabel(ev)
	e1:SetTarget(c511000185.damtg)
	e1:SetOperation(c511000185.damop)
	c:RegisterEffect(e1)
end
function c511000185.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,e:GetLabel())
end
function c511000185.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,e:GetLabel(),REASON_EFFECT)
	Duel.Damage(1-tp,e:GetLabel(),REASON_EFFECT)
end
