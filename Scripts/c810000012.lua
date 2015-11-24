-- Narrow Tunnel
-- scripted by: UnknownGuest
function c810000012.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- disable summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c810000012.sumlimit)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e4)
	-- reg
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetRange(LOCATION_SZONE)
	e5:SetOperation(c810000012.spreg)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e7)
	--destroy monster
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e8:SetCode(EVENT_MSET)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c810000012.descon)
	e8:SetOperation(c810000012.desop)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e9)
	local e10=e8:Clone()
	e10:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e10)
	local e11=e8:Clone()
	e11:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e11)
	--adjust
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e12:SetCode(EVENT_ADJUST)
	e12:SetRange(LOCATION_SZONE)
	e12:SetCondition(c810000012.descon)
	e12:SetOperation(c810000012.desop)
	c:RegisterEffect(e12)
end
function c810000012.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return e:GetHandler():GetFlagEffect(810000012+sump)~=0
end
function c810000012.filter(c,tp)
	return c:GetSummonPlayer()==tp
end
function c810000012.spreg(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c810000012.filter,1,nil,tp) then
		e:GetHandler():RegisterFlagEffect(810000012+tp,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
	if eg:IsExists(c810000012.filter,1,nil,1-tp) then
		e:GetHandler():RegisterFlagEffect(810000012+1-tp,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c810000012.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>=2 or Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>=2
end
function c810000012.desop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)
	if ft>1 then
		local ct=ft-1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c810000012.desfilter,tp,LOCATION_MZONE,0,ct,ct,nil)
		local tc=g:GetFirst()
		while tc do
			Duel.Destroy(tc,REASON_EFFECT)
			tc=g:GetNext()
		end
	end
	ft=Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0,nil)
	if ft>1 then
		local ct=ft-1
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(1-tp,c810000012.desfilter,1-tp,LOCATION_MZONE,0,ct,ct,nil)
		local tc=g:GetFirst()
		while tc do
			Duel.Destroy(tc,REASON_EFFECT)
			tc=g:GetNext()
		end
	end
end
