--Stairway to the Underworld
function c511000921.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000921.con)
	e1:SetTarget(c511000921.tg)
	e1:SetOperation(c511000921.act)
	c:RegisterEffect(e1)
end
function c511000921.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511000921.tfilter(c,e,tp)
	return c:IsCode(44330098) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000921.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c511000921.tfilter,tp,LOCATION_DECK,0,1,nil,e,tp) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,44330099,0,0x4011,-2,-2,7,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	e:SetLabel(ev)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000921.act(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511000921.tfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp) 
	Duel.SpecialSummonStep(sg:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,44330099,0,0x4011,-2,-2,7,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	local val1=e:GetLabel()
	local val2=e:GetLabel()
	if 2500>val1 then
		val1=2500
		val2=2700
	end
	local token=Duel.CreateToken(tp,44330099)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(val1)
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	e2:SetValue(val2)
	e2:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e2)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	Duel.SpecialSummonComplete()		
end
