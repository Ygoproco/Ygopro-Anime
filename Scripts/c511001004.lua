--Deuce
function c511001004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001004.condition)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c511001004.atkcon)
	e2:SetTarget(c511001004.atktg)
	c:RegisterEffect(e2)
	--check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511001004.checkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CHANGE_DAMAGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetTargetRange(1,0)
	e4:SetValue(c511001004.damval1)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CHANGE_DAMAGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetTargetRange(0,1)
	e5:SetValue(c511001004.damval2)
	c:RegisterEffect(e5)
	--win
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_ADJUST)
	e6:SetRange(LOCATION_SZONE)	
	e6:SetOperation(c511001004.winop)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EVENT_CHAIN_SOLVED)
	c:RegisterEffect(e7)
	local e8=e6:Clone()
	e8:SetCode(EVENT_DAMAGE_STEP_END)
	c:RegisterEffect(e8)
	--lp check
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e9:SetCode(EVENT_ADJUST)
	e9:SetRange(LOCATION_SZONE)
	e9:SetOperation(c511001004.surop2)
	c:RegisterEffect(e9)
	local e10=Effect.CreateEffect(c)	
	e10:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e10:SetCode(EVENT_CHAIN_SOLVED)
	e10:SetRange(LOCATION_SZONE)
	e10:SetOperation(c511001004.surop2)
	c:RegisterEffect(e10)
	--lose
	local e11=Effect.CreateEffect(c)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_CHANGE_POS)
	e11:SetOperation(c511001004.flipop)
	c:RegisterEffect(e11)
	--lose (leave)
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_LEAVE_FIELD)
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DAMAGE_STEP)
	e12:SetOperation(c511001004.leaveop)
	c:RegisterEffect(e12)
end
function c511001004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)==1000 and Duel.GetLP(1-tp)==1000
end
function c511001004.atkcon(e)
	return e:GetHandler():GetFlagEffect(30606547)~=0
end
function c511001004.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c511001004.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(30606547)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(30606547,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c511001004.damval1(e,re,val,r,rp,rc)
	local tp=e:GetHandler():GetControler()
	if val~=0 then
		Duel.RegisterFlagEffect(1-tp,511001004,RESET_PHASE+PHASE_END,0,1)
		return 0
	else return val end
end
function c511001004.damval2(e,re,val,r,rp,rc)
	local tp=e:GetHandler():GetControler()
	if val~=0 then
		Duel.RegisterFlagEffect(tp,511001004,RESET_PHASE+PHASE_END,0,1)
		return 0
	else return val end
end
function c511001004.winop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,511001004)>1 and Duel.GetFlagEffect(1-tp,511001004)>1 then
		Duel.Win(PLAYER_NONE,0x54)
	elseif Duel.GetFlagEffect(tp,511001004)>1 then
		Duel.Win(tp,0x54)
	elseif Duel.GetFlagEffect(1-tp,511001004)>1 then
		Duel.Win(1-tp,0x54)
	end
end
function c511001004.surop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLP(tp)<=0 and not c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(tp,1)
	end
	if Duel.GetLP(1-tp)<=0 and not c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(1-tp,1)
	end
	if Duel.GetLP(tp)==1 and c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(tp,0)
	end
	if Duel.GetLP(1-tp)==1 and c:IsStatus(STATUS_DISABLED) then
		Duel.SetLP(1-tp,0)
	end
end
function c511001004.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() and Duel.GetLP(tp)==1 then
		Duel.SetLP(tp,0)
	end
	if c:IsFacedown() and Duel.GetLP(1-tp)==1 then
		Duel.SetLP(1-tp,0)
	end
end
function c511001004.leaveop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)==1 then
		Duel.SetLP(tp,0)
	end
	if Duel.GetLP(1-tp)==1 then
		Duel.SetLP(1-tp,0)
	end
end
