--バトル・スタン・ソニック
function c511001025.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001025.condition)
	e1:SetTarget(c511001025.target)
	e1:SetOperation(c511001025.activate)
	c:RegisterEffect(e1)
end
function c511001025.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001025.filter(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511001025.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511001025.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsFaceup() and tc:IsAttackable() and Duel.NegateAttack() then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511001025.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()==0 then return end
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
