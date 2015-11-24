--Domain of the Dark Ruler
function c511000464.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000464.condition)
	e1:SetTarget(c511000464.target)
	e1:SetOperation(c511000464.activate)
	e1:SetLabel(1)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE+LOCATION_GRAVE,LOCATION_SZONE+LOCATION_GRAVE)
	e2:SetTarget(c511000464.disable)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511000464.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp and Duel.IsChainNegatable(ev)
end
function c511000464.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511000464.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	e:SetLabel(re:GetHandler():GetOriginalCode())
end
function c511000464.disable(e,c)
	return c:IsCode(e:GetLabelObject():GetLabel())
end
