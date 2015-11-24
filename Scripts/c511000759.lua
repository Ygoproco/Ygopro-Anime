--Instant Tune
function c511000759.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,511000759)
	e1:SetTarget(c511000759.target)
	e1:SetOperation(c511000759.activate)
	c:RegisterEffect(e1)
end
function c511000759.filter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false)
		and Duel.IsExistingMatchingCard(c511000759.matfilter,tp,LOCATION_MZONE,0,1,nil,c:GetLevel())
end
function c511000759.matfilter(c,lv)
	return c:IsFaceup() and c:GetLevel()==lv-1 and not c:IsType(TYPE_TUNER)
end
function c511000759.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000759.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000759.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000759.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		local rg=Group.CreateGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local non=Duel.SelectMatchingCard(tp,c511000759.matfilter,tp,LOCATION_MZONE,0,1,1,nil,tc:GetLevel())
		rg:AddCard(e:GetHandler())
		non:Merge(rg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetOperation(c511000759.synop)
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		e1:SetLabelObject(non)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		Duel.SynchroSummon(tp,tc,nil)
	end
end
function c511000759.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local tun=e:GetLabelObject()
	c:SetMaterial(tun)
	Duel.SendtoGrave(tun,REASON_MATERIAL+REASON_SYNCHRO)
end
