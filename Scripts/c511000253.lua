--Chaos Phantom Demon Armityle
function c511000253.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,511000253)
	--Special Summon with Dimension Fusion Destruction
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511000253.splimit)
	c:RegisterEffect(e1)
	--Cannot be Destroyed by Battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--10,000  Battle Damage to a Opponent's Monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DAMAGE_CALCULATING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000253.atkcon)
	e3:SetOperation(c511000253.atkop)
	c:RegisterEffect(e3)
	--Phantom of Fury
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000253,0))
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c511000253.phantomop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000253,1))
	e5:SetCategory(CATEGORY_REMOVE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c511000253.furycon)
	e5:SetTarget(c511000253.furytg)
	e5:SetOperation(c511000253.furyop)
	c:RegisterEffect(e5)
	--Cannot Attack Directly
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	end
function c511000253.splimit(e,se,sp,st)
	return st==(SUMMON_TYPE_SPECIAL+511000254)
end
function c511000253.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker()
end
function c511000253.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+RESET_DAMAGE_CAL)
	e1:SetValue(10000)
	c:RegisterEffect(e1)
end
function c511000253.phantomop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.GetControl(c,1-tp,PHASE_END,1)
	c:RegisterFlagEffect(511000253,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000253.furycon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000253)~=0
end
function c511000253.furytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000253.furyop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end