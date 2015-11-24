-- Stardust Flash
-- scripted by: UnknownGuest
function c810000057.initial_effect(c)
	-- Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000057,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c810000057.spcon)
	e1:SetTarget(c810000057.sptg)
	e1:SetOperation(c810000057.spop)
	c:RegisterEffect(e1)
end
function c810000057.spfilter(c,e,tp)
	return c:IsCode(44508094) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c810000057.spcon(e,tp,eg,ep,ev,re,r,rp,chk)
	return re:GetHandler():IsCode(44508094) and re:GetHandler():IsControler(tp)
end
function c810000057.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c810000057.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c810000057.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c810000057.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end
