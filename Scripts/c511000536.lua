--魔水晶
function c511000536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000536.condition)
	e1:SetOperation(c511000536.activate)
	c:RegisterEffect(e1)
end
function c511000536.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511000536.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000536.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511000536.activate(e,tp,eg,ep,ev,re,r,rp)
	local ge1=Effect.CreateEffect(e:GetHandler())
	ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	ge1:SetCode(EVENT_ADJUST)
	ge1:SetReset(RESET_EVENT+0x1fe0000)
	ge1:SetOperation(c511000536.op)
	Duel.RegisterEffect(ge1,0)
end
function c511000536.atkfilter(c)
	return  c:GetAttack()~=c:GetFlagEffectLabel(511000536) and c:IsFaceup() and c:GetFlagEffect(10000)==0
end
function c511000536.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	local tc=g:GetFirst()
	while tc do
		if  tc:GetFlagEffect(511000536)==0 then
			local atk=tc:GetAttack()
			tc:RegisterFlagEffect(511000536,RESET_EVENT+0x1fe0000+EVENT_CHAINING,nil,1,atk) 	
		elseif tc:GetAttack()~=tc:GetFlagEffectLabel(511000536) and  tc:GetFlagEffect(10001)==0 then
			local atk=tc:GetAttack()-tc:GetFlagEffectLabel(511000536)
			tc:RegisterFlagEffect(10001,RESET_EVENT+0x1fe0000+EVENT_CHAINING,nil,1,0) 
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(atk)
			tc:RegisterEffect(e1)
		end	
		wbc=wg:GetNext()
	end	
end
