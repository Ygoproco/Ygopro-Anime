--Zombie's Jewel
function c511000170.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetDescription(aux.Stringid(511000170,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c511000170.target)
	e1:SetOperation(c511000170.activate)
	c:RegisterEffect(e1)
end
function c511000170.filter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()~=tp and c:IsAbleToHand()
end
function c511000170.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511000170.filter,nil,e,tp)
	e:SetLabelObject(g:GetFirst())
	if chk==0 then
		return g:GetCount()~=0
	end
	local sg=e:GetLabelObject()
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
end
function c511000170.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end	
end
