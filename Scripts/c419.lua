--        
function c419.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetOperation(c419.op)
	c:RegisterEffect(e1)
end
function c419.op(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_RULE)
	if Duel.GetFlagEffect(tp,419)==0 then
		Duel.RegisterFlagEffect(tp,419,0,0,0)
		local dis=Duel.SelectDisableField(tp,10,LOCATION_ONFIELD,0,0)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE_FIELD)
		e1:SetOperation(c419.disop)
		e1:SetLabel(dis)
		Duel.RegisterEffect(e1,tp)
	end
end
function c419.disop(e,tp)
	return e:GetLabel()
end
