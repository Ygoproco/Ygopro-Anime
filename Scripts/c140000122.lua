--Maytr Curse
function c140000122.initial_effect(c)
        local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c140000122.bacon)
	e1:SetTarget(c140000122.batg)
	e1:SetOperation(c140000122.baop)
	c:RegisterEffect(e1)
end
function c140000122.bacon(e,tp,eg,ep,ev,re,r,rp)
        local ph=Duel.GetCurrentPhase()
	return eg:IsExists(c140000122.cfilter,1,nil) and Duel.GetTurnPlayer()~=tp
            and (ph==PHASE_BATTLE or ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
end
function c140000122.cfilter(c)
	return (c:IsReason(REASON_DESTROY) or c:IsReason(REASON_BATTLE)) and c:IsControler(tp)
end
function c140000122.batg(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEUP_ATTACK)
            and Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP_ATTACK) end
        local a=Duel.SelectTarget(tp,Card.IsPosition,tp,LOCATION_MZONE,0,1,1,nil,POS_FACEUP_ATTACK)
        local d=Duel.SelectTarget(tp,Card.IsPosition,tp,0,LOCATION_MZONE,1,1,nil,POS_FACEUP_ATTACK)
        c140000122[0]=a:GetFirst()
        c140000122[1]=d:GetFirst()
end
function c140000122.baop(e,tp,eg,ep,ev,re,r,rp)
        local a=c140000122[0]
        local d=c140000122[1]
        if a:IsAttackPos() and d:IsAttackPos() then
            Duel.CalculateDamage(a,d)
        end
end