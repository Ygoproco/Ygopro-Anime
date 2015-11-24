--Infernity Zero
function c511000145.initial_effect(c)
	c:EnableReviveLimit()
	c:SetCounterLimit(0x97,3)
	--Survival
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c511000145.cost)
	e1:SetCondition(c511000145.condition)
	e1:SetTarget(c511000145.target)
	e1:SetOperation(c511000145.operation)
	c:RegisterEffect(e1)
	--cannot lose (damage)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(c511000145.surcon1)
	e2:SetOperation(c511000145.surop1)
	c:RegisterEffect(e2)
	--cannot destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000145.ncon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--lp check
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c511000145.surop2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)	
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_CHAIN_SOLVED)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c511000145.surop2)
	c:RegisterEffect(e5)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetCondition(c511000145.sdcon)
	c:RegisterEffect(e6)
	--counter
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EVENT_DAMAGE)
	e7:SetOperation(c511000145.ctop)
	c:RegisterEffect(e7)
	--lose
	local e9=Effect.CreateEffect(c)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_CHANGE_POS)
	e9:SetOperation(c511000145.flipop)
	c:RegisterEffect(e9)
	--lose (leave)
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_LEAVE_FIELD)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DAMAGE_STEP)
	e10:SetOperation(c511000145.leaveop)
	c:RegisterEffect(e10)
end
function c511000145.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	g:RemoveCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	e:SetLabel(g:GetCount())
end
function c511000145.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or Duel.GetLP(tp)>2000 then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	if not ex then return false end
	if cp~=PLAYER_ALL then return Duel.IsPlayerAffectedByEffect(cp,EFFECT_REVERSE_RECOVER)
	else return Duel.IsPlayerAffectedByEffect(0,EFFECT_REVERSE_RECOVER)
		or Duel.IsPlayerAffectedByEffect(1,EFFECT_REVERSE_RECOVER)
	end
end
function c511000145.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000145.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	end
end
function c511000145.surcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetLP(tp)<=0
end
function c511000145.surop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,1)
end
function c511000145.surop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLP(tp)<=0 and not c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(tp,1)
	end
	if Duel.GetLP(tp)==1 and c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(tp,0)
	end
end
function c511000145.ncon(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
function c511000145.sdcon(e)
	return e:GetHandler():GetCounter(0x97)>=3
end
function c511000145.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ep~=tp then return end
	if c:GetCounter(0x97)<3 then
		c:AddCounter(0x97,1)
	end
end
function c511000145.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() and Duel.GetLP(tp)==1 then
		Duel.SetLP(tp,0)
	end
end
function c511000145.leaveop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)==1 then
		Duel.SetLP(tp,0)
	end
end
