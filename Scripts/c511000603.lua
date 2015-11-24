--Defense Paralysis
function c511000603.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c511000603.condition)
	e1:SetTarget(c511000603.target)
	e1:SetOperation(c511000603.activate)
	c:RegisterEffect(e1)
end
function c511000603.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousPosition(POS_ATTACK) and c:IsPosition(POS_DEFENCE)
end
function c511000603.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000603.cfilter,1,nil,1-tp)
end
function c511000603.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000603.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDefencePos,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511000603.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDefencePos,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,0,0,POS_FACEUP_ATTACK,POS_FACEDOWN_ATTACK)
end
