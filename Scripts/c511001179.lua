--Depth Gardna
function c511001179.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetCondition(c511001179.condition)
	e1:SetTarget(c511001179.target)
	e1:SetOperation(c511001179.activate)
	c:RegisterEffect(e1)
end
function c511001179.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetAttackTarget()==nil
end
function c511001179.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001179,0,0x21,-2,-2,5,RACE_FISH,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001179.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001179,0,0x21,-2,-2,5,RACE_FISH,ATTRIBUTE_WATER) then return end
	c:AddTrapMonsterAttribute(TYPE_EFFECT,ATTRIBUTE_WATER,RACE_FISH,5,-2,-2)
	Duel.SpecialSummon(c,1,tp,tp,true,false,POS_FACEUP)
	c:TrapMonsterBlock()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENCE)
	c:RegisterEffect(e2)
end
