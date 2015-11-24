--Emperor's Staff
function c511001099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001099.target)
	e1:SetOperation(c511001099.activate)
	c:RegisterEffect(e1)
end
function c511001099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511001099.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1-tp,1,REASON_EFFECT)
	--indestructable
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetValue(c511001099.indval)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	Duel.RegisterEffect(e1,tp)
end
function c511001099.indval(e,re,rp)
	return re:GetOwner()~=e:GetOwner()
end
