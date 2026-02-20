Return-Path: <linux-efi+bounces-6195-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFqJArLJmGl7MQMAu9opvQ
	(envelope-from <linux-efi+bounces-6195-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 21:53:06 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2016ACAF
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB1C3035D43
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499E309EFC;
	Fri, 20 Feb 2026 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwLkywAE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA62FFFA5
	for <linux-efi@vger.kernel.org>; Fri, 20 Feb 2026 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620702; cv=none; b=Lbsefk/j8uFjh/1lOMaN9+Xb9rf3FlqBwXK3lywQPS4EVDvXSkMRhl5YTBg2RbITgKQ2+FQAIu+mxDPSBR7EWLUl1w+atgLHnrZGcanKD78cGBgovQDpSrUPxekrV1EYXO1C+xSAHPJ8NjOPEwR+D9y3/Rb+g/fdtnal4dYOp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620702; c=relaxed/simple;
	bh=pADU2vnUWuE9OPE0CnwU1aqRkxT3gr9TaLu7lKcsO5o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rVLmjpKrjSdY0thY8HhtRGBg1I3BMLu7R/imbP46DC62g4bAiBaTCqHj0QL4gX/kIrWQXIscz6X7/+uiwx88mk5tiBHT7ZpNbnWFsGg24658gqpTtWZ43Re4elMgCL5D61GYcyW5f2NES7OHD7n9YZI14ChSwobHrlXDIC+jaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwLkywAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857D4C116C6;
	Fri, 20 Feb 2026 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771620702;
	bh=pADU2vnUWuE9OPE0CnwU1aqRkxT3gr9TaLu7lKcsO5o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pwLkywAEU0xi3JS85ZR3wZi8hrnTpteAlwTAB2McexsK+2CchPLorvd7DxgZfiWvw
	 drfsJW70LXZ8CPziETkFw2agzX6EFDICmaIXkBRMC1lBKrn2qoOALptKSBz1V3bKqR
	 C8oODAEWG9yfbfSXusfjO3dPJHuFW5pGWNiXx+khGDae+oMgqsvC9eyX4Mz2jIjpYA
	 PwxqHzoF+rEepdCDGW3bM8KGSztLXyhz375IalrhbeLbkSWkl4OxfddPJUZyX1pH58
	 6a6K6DljWAEFXMeU66Q0T7iyk7UBiJWc9vADSvi2j12aVZFP5U5bg8l7m7oze8pUrm
	 cIAVpbHT92ibw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA4533808200;
	Fri, 20 Feb 2026 20:51:51 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v7.0 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260220083531.1254723-2-ardb+git@google.com>
References: <20260220083531.1254723-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260220083531.1254723-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-1
X-PR-Tracked-Commit-Id: 948a013a54c47d5eba06e644b99d4927a8bc62f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f283371efd6a0ec1713349cd8c12fa5ffb19c60a
Message-Id: <177162071038.904298.17420767262339032277.pr-tracker-bot@kernel.org>
Date: Fri, 20 Feb 2026 20:51:50 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6195-lists,linux-efi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-efi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,git];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CA2016ACAF
X-Rspamd-Action: no action

The pull request you sent on Fri, 20 Feb 2026 09:35:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v7.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f283371efd6a0ec1713349cd8c12fa5ffb19c60a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

