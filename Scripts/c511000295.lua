--Numeron Chaos Ritual
function c511000295.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000295.condition)
	e1:SetTarget(c511000295.target)
	e1:SetOperation(c511000295.activate)
	c:RegisterEffect(e1)
end
function c511000295.matfilter(c)
	return c:IsSetCard(0x48)
end
function c511000295.confilter(c)
	return c:IsCode(511000275)
end
function c511000295.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511000295.matfilter,c:GetControler(),LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	return Duel.IsExistingTarget(c511000295.filter1,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,tp,Duel.GetTurnCount()) and ct>=4 and
	Duel.IsExistingTarget(c511000295.confilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
end
function c511000295.filter1(c,tp,turn)
	return c:GetCode()==511000277 and c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and (c:GetTurnID()==turn or c:GetTurnID()==turn-1)
end
function c511000295.filter2(c,e,tp)
	return c:GetCode()==511000294 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000295.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511000295.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=Duel.SelectTarget(tp,c511000295.confilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectTarget(tp,c511000295.matfilter,tp,LOCATION_GRAVE,0,4,4,nil)
	g1:Merge(g2)
end
function c511000295.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()~=5 or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	tc=g:GetFirst()
	local spg=Duel.SelectMatchingCard(tp,c511000295.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if Duel.SpecialSummonStep(spg:GetFirst(),SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP) then
		while tc do
			Duel.Overlay(spg:GetFirst(),tc)
			tc=g:GetNext()
		end
		spg:GetFirst():CompleteProcedure()
	end
	Duel.SpecialSummonComplete()
end
