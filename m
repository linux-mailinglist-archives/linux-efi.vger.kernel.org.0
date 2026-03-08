Return-Path: <linux-efi+bounces-6269-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vfF8HNcMrmnA/AEAu9opvQ
	(envelope-from <linux-efi+bounces-6269-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 00:57:11 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E02232CE6
	for <lists+linux-efi@lfdr.de>; Mon, 09 Mar 2026 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21BC8300B9EC
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2026 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EE3563E8;
	Sun,  8 Mar 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTpIULuJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1346BF
	for <linux-efi@vger.kernel.org>; Sun,  8 Mar 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014228; cv=none; b=GKN+ZRN8Y2DkSt+E9VjlMn9E7hm3OM4EPqgSSek8wKZvfAovzCMMmua0yckLgunzYhig7VFNQO0b+6trNYAKDkKBbCEcKUtJHbzikKq34/UJYzaLLNaHlCg5r3BILvOl5L/bCHvusjmTsJfgc6I/VUHCnbD2LjMZ22CtcrAZ+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014228; c=relaxed/simple;
	bh=YsclmFUAR7MZoJHyMDS0EI0ltDWBUg/phYDwCqD65K4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fo9BLCMraHekWb8P253yQETipUHjj7DwWxNlJCvCpxgu7GOlJXG5EI+GDz94dIpOV2CdppGyQxyNHLDzxX2V7e3vH0kg7KFPTw7Dihxhm8qgcNekynNnwKYPW2coUb1kBlJierboietRAPbwmAQpUALpCpc/J6oSiAFPWsy8je4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTpIULuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A59C116C6;
	Sun,  8 Mar 2026 23:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773014228;
	bh=YsclmFUAR7MZoJHyMDS0EI0ltDWBUg/phYDwCqD65K4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NTpIULuJCDqOMIZIUb376NFuLacwUTCCqPGJgJh+kEs4EqZ6s9r7DOCKD5uj+NyZH
	 Zc0Fw8SmwLxIdUCvT0DZeC273Rkrn91LVJaFiLS7Yqgi+nVJtDDQJrwQ9aneX4AyaL
	 j7mFln5QOf8WziqD+M3Bxb2alK3JB/e1DEC76s0Ov8SUS2qrZvTVKxPhPc32dXcLV4
	 8zwRuuuVtJUN8Y85KtLJ+hpgHKiIOBPzGTYBhUF0Ue0YSJwpGMf/27yMuLzFcXcokJ
	 pVQdIUqkU6gcK4yUvIG10SXfMhn6F4qKfFOUxYa3kSLH1tw73bRNTybgUvny9lpRb2
	 ncUJMO8jRYMaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F6B3808200;
	Sun,  8 Mar 2026 23:57:07 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v7.0 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260308174552.104770-2-ardb@kernel.org>
References: <20260308174552.104770-2-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260308174552.104770-2-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-2
X-PR-Tracked-Commit-Id: a4b0bf6a40f3c107c67a24fbc614510ef5719980
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc9f248d8c591454e257edd54ac4085d84f11e6a
Message-Id: <177301422559.583975.150295011038761083.pr-tracker-bot@kernel.org>
Date: Sun, 08 Mar 2026 23:57:05 +0000
To: Ard Biesheuvel <ardb@kernel.org>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C3E02232CE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-6269-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Sun,  8 Mar 2026 18:45:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc9f248d8c591454e257edd54ac4085d84f11e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

