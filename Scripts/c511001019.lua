--シャイニング・リバース
function c511001019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001019.target)
	e1:SetOperation(c511001019.activate)
	c:RegisterEffect(e1)
end
function c511001019.matfilter1(c,syncard,g2,slv)
	local lv=c:GetLevel()
	return c:IsType(TYPE_TUNER) and c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and g2:CheckWithSumEqual(Card.GetLevel,slv-lv,1,99)
end
function c511001019.matfilter2(c,syncard)	
	return c:IsFaceup() and c:IsCanBeSynchroMaterial(syncard) and not c:IsType(TYPE_TUNER)
end
function c511001019.spfilter(c,e,tp)
	local lv=c:GetLevel()
	local g2=Duel.GetMatchingGroup(c511001019.matfilter2,tp,LOCATION_MZONE,0,nil,c)
	local g1=Duel.GetMatchingGroup(c511001019.matfilter1,tp,LOCATION_MZONE,0,nil,c,g2,lv)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,true) and g1:GetCount()>0
end
function c511001019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return false end
		return Duel.IsExistingTarget(c511001019.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511001019.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511001019.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local lv=tc:GetLevel()
		local g2=Duel.GetMatchingGroup(c511001019.matfilter2,tp,LOCATION_MZONE,0,nil,tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local tuner=Duel.SelectMatchingCard(tp,c511001019.matfilter1,tp,LOCATION_MZONE,0,1,1,nil,tc,g2,lv)
		local sg=g2:SelectWithSumEqual(tp,Card.GetLevel,lv-tuner:GetFirst():GetLevel(),1,99)
		tuner:Merge(sg)
		Duel.SendtoGrave(tuner,REASON_MATERIAL+REASON_SYNCHRO+REASON_EFFECT)
		tc:SetMaterial(tuner)
		if Duel.SpecialSummonStep(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,true,POS_FACEUP)~=0 then
			--indes
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			tc:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
			tc:CompleteProcedure()
		end
	end
end
