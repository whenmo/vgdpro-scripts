--正确的音程 克拉莉萨
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
    -- 【永】【V】：你的回合中，你没有后防者的话，这个单位的力量+5000。
	vgd.EffectTypeContinuousChangeAttack(c,EFFECT_TYPE_SINGLE,5000,cm.con1)
    --【自】：通过在「认真的挑战者 克拉莉萨」上RIDE的方式将这个单位登场到V时，通过【费用】[灵魂爆发1]，查看你的牌堆顶的7张卡，选择至多1张等级2以下的含有「诚意真心」的卡，公开后加入手牌，将其余的卡洗切后放置到牌堆底。
    vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_SPSUMMON_SUCCESS,cm.operation,VgF.OverlayCost(1),cm.con2)
end
function cm.con1(e)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	return vgf.VMonsterCondition(e) and not Duel.IsExistingMatchingCard(vgf.RMonsterFilter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetTurnPlayer()==tp
end
function cm.con2(e)
    local c=e:GetHandler()
    local g=c:GetMaterial()
	return (c:IsSummonType(SUMMON_TYPE_RIDE) or c:IsSummonType(SUMMON_TYPE_SELFRIDE)) and g:IsExists(Card.IsCode,1,nil,10501090)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetDecktopGroup(tp,7)
    Duel.ConfirmCards(tp,g)
	Duel.DisableShuffleCheck()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:FilterSelect(tp,cm.filter,0,1,nil)
	if #sg > 0 then
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		g:RemoveCard(vgf.ReturnCard(sg))
	end
	for i=1,#g do
		local dg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(dg:GetFirst(),SEQ_DECKBOTTOM)
	end	
end
function cm.filter(c)
	return c:IsSetCard(0xb6) and c:IsLevelBelow(3) and c:IsAbleToHand()
end


