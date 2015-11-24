--Synchro Call
function c511000765.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000765.target)
	e1:SetOperation(c511000765.activate)
	c:RegisterEffect(e1)
end
function c511000765.filter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) 
		and Duel.IsExistingMatchingCard(c511000765.tunfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,c:GetLevel())
end
function c511000765.tunfilter(c,lv)
	local loc=0
	if c:IsLocation(LOCATION_MZONE) then
		loc=LOCATION_MZONE
	else
		loc=LOCATION_GRAVE
	end
	return ((c:IsFaceup() and c:IsLocation(LOCATION_MZONE)) or c:IsLocation(LOCATION_GRAVE)) and c:GetLevel()<lv and c:IsType(TYPE_TUNER)
		and Duel.IsExistingMatchingCard(c511000765.nontunfilter,c:GetControler(),LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,c:GetLevel(),lv,loc)
end
function c511000765.nontunfilter(c,lv,synlv,loc)
	return ((c:IsLocation(LOCATION_MZONE) and loc~=LOCATION_MZONE) or (c:IsLocation(LOCATION_GRAVE) and loc~=LOCATION_GRAVE))
		and not c:IsType(TYPE_TUNER) and lv+c:GetLevel()==synlv
end
function c511000765.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511000765.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000765.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000765.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		local tune=Duel.SelectMatchingCard(tp,c511000765.tunfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,tc:GetLevel())
		local loc=0
		if tune:GetFirst():IsLocation(LOCATION_MZONE) then
			loc=LOCATION_MZONE
		else
			loc=LOCATION_GRAVE
		end
		local nontun=Duel.SelectMatchingCard(tp,c511000765.nontunfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,tune:GetFirst():GetLevel(),tc:GetLevel(),loc)
		tune:Merge(nontun)
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetOperation(c511000765.synop)
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		e1:SetLabelObject(tune)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		Duel.SynchroSummon(tp,tc,nil)
	end
end
function c511000765.synop(e,tp,eg,ep,ev,re,r,rp,c,tuner)
	local tun=e:GetLabelObject()
	c:SetMaterial(tun)
	Duel.SendtoGrave(tun,REASON_MATERIAL+REASON_SYNCHRO)
end
