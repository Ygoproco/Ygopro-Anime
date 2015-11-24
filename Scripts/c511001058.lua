--Parallel Unit
function c511001058.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001058.target)
	e1:SetOperation(c511001058.operation)
	c:RegisterEffect(e1)
end
function c511001058.filter(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup() and Duel.IsExistingMatchingCard(c511001058.spfilter,tp,LOCATION_EXTRA,0,1,nil,lv,e,tp)
end
function c511001058.spfilter(c,rk,e,tp)
    return c:GetRank()==rk and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,true,false) and c.xyz_count==2
end
function c511001058.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511001058.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001058.filter,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001058.filter,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001058.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local xyzg=Duel.GetMatchingGroup(c511001058.spfilter,tp,LOCATION_EXTRA,0,nil,tc:GetLevel(),e,tp)
		if xyzg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
			Duel.Overlay(xyz,Group.FromCards(tc,e:GetHandler()))
			xyz:SetMaterial(Group.FromCards(tc,e:GetHandler()))
			Duel.SpecialSummon(xyz,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
			xyz:CompleteProcedure()
		end
	end
end