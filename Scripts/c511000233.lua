--Number 4: Gate of Numeron - Catvari
function c511000233.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--Double ATK
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c511000233.cost)
	e1:SetTarget(c511000233.target)
	e1:SetOperation(c511000233.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCost(c511000233.cost)
	e2:SetTarget(c511000233.target)
	e2:SetOperation(c511000233.op)
	c:RegisterEffect(e2)
end
c511000233.xyz_number=4
function c511000233.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000233.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1FF)
end
function c511000233.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000233,0))
	if Duel.IsExistingMatchingCard(c511000233.filter,tp,LOCATION_MZONE,0,1,c) then
		op=Duel.SelectOption(tp,aux.Stringid(511000233,1),aux.Stringid(511000233,2))
	else
		Duel.SelectOption(tp,aux.Stringid(511000233,2))
		op=1
	end
	e:SetLabel(op)
end
function c511000233.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(511000233,0))
		e2:SetCategory(CATEGORY_ATKCHANGE)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e2:SetTarget(c511000233.atktg)
		e2:SetOperation(c511000233.atkop)
		c:RegisterEffect(e2)
	else
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(511000233,1))
		e2:SetCategory(CATEGORY_ATKCHANGE)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e2:SetOperation(c511000233.atkop2)
		c:RegisterEffect(e2)
	end
end
function c511000233.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000233.filter,tp,LOCATION_MZONE,0,1,c) end
end
function c511000233.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c511000233.filter,tp,LOCATION_MZONE,0,c)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
function c511000233.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c:GetAttack()*2)
		c:RegisterEffect(e1)
	end
end
