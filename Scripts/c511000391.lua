--Forbidden Beast Nibunu
function c511000391.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000391,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511000391.sumtg)
	e1:SetOperation(c511000391.sumop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511000391.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000380)
end
function c511000391.spfilter(c,e,tp)
	return c:IsSetCard(0x201) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000391.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.IsExistingMatchingCard(c511000391.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		or (Duel.IsExistingMatchingCard(c511000391.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
		and Duel.IsExistingMatchingCard(c511000391.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp))) end
	if Duel.IsExistingMatchingCard(c511000391.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	end
end
function c511000391.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if Duel.IsExistingMatchingCard(c511000391.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then
		g=Duel.SelectMatchingCard(tp,c511000391.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	else
		g=Duel.SelectMatchingCard(tp,c511000391.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
