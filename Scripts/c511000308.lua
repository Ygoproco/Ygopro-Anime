--D3
function c511000308.initial_effect(c)
	--atk/lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000308,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511000308.cost)
	e1:SetOperation(c511000308.operation)
	c:RegisterEffect(e1)
end
function c511000308.costfilter(c)
	return c:IsCode(511000308) and c:IsAbleToGraveAsCost()
end
function c511000308.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000308.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000308.costfilter,tp,LOCATION_HAND,0,1,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c511000308.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(511000308,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c511000308.spcost1)
		e1:SetTarget(c511000308.sptg1)
		e1:SetOperation(c511000308.spop1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	else
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(511000308,2))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c511000308.spcost2)
		e1:SetTarget(c511000308.sptg1)
		e1:SetOperation(c511000308.spop1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511000308.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and Duel.CheckReleaseGroup(tp,c511000308.costfilter2,1,nil) end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	local sg=Duel.SelectReleaseGroup(tp,c511000308.costfilter2,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c511000308.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000308.costfilter2(c)
	return c:IsSetCard(0xc008)
end
function c511000308.spfilter(c,e,tp)
	return (c:IsCode(83965310) or c:IsCode(17132130)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000308.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000308.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c511000308.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000308.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
