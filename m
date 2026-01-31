Return-Path: <linux-efi+bounces-6073-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLk2McBvfmnEYwIAu9opvQ
	(envelope-from <linux-efi+bounces-6073-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 22:10:24 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50362C3F32
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 22:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D511D300D169
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jan 2026 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2A36C0A7;
	Sat, 31 Jan 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bqm944ad"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4D366825
	for <linux-efi@vger.kernel.org>; Sat, 31 Jan 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893802; cv=none; b=ti4+vT32tH/+QJPUK4d5y0u1FAam3/pOWjbyTgcT9+0l2CnPQc3BOTw97zIgTrSqHIwvf47nMF5ZZo3/Ghq30fK9gZS9T2Ixk+YTi91IT0663x1/qaNEZQbCncN+7Ygi/AJG9kstMxtae+EEwGtCAahtJfxQsYXAGso1BnZRKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893802; c=relaxed/simple;
	bh=31A0ma0cJv0beQzPpZ0gLKepoOZ2A0IdA64QldvETxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JPgwO8c1+uL64ok9TYwrmvlZfMjxgiO7uMKxi1BNyXjLK7Ytm/FkEPgNy5GlqDqJrvfhNopVXOqgIPZttcyJ2JWmIotF9cAkf/VLJaQtbNKYFAdjPA0HQ9K16OkXfA48yjh8xjGCqdHTUZXbKf5J6yYOfAsLjfGaffOBwzweVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bqm944ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E03C4CEF1;
	Sat, 31 Jan 2026 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769893801;
	bh=31A0ma0cJv0beQzPpZ0gLKepoOZ2A0IdA64QldvETxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bqm944adLpJ2iaNpc9T5kcSYqn+59Ol+RjURkrdfwHrkAqeAIHPPoML7ghLeWloOt
	 qDMLxJoIAKl04GvWPCuXBzRd0nki43jeSxL9c77eiVamgOcHgWhRexKuNueeAF62YZ
	 fyWiefk4UtYyTpSOm3t7oWYqKOcikhT75G6Z4bhDlc6qMkBEuHlz/Xsv9dXM36zvFc
	 xuYsZX3at3foBfsENnhwZ4nXgy3glS5cbhIct3ls/byVl8choGAXcYq/JY42Uc1l22
	 YBT21cWUPeY2CDtegUSw9T0P5jrou88Uewy23ql6BQnvmjeaQDqpnxWD7f1x3qHUTD
	 gXAmF/jua4UKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8E69380DBD4;
	Sat, 31 Jan 2026 21:09:54 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.19 #3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260131160642.3480429-2-ardb+git@google.com>
References: <20260131160642.3480429-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260131160642.3480429-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-3
X-PR-Tracked-Commit-Id: 4b22ec1685ce1fc0d862dcda3225d852fb107995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d097a0783102a9e966ed0a70f54def4a1d091b6a
Message-Id: <176989379350.4190632.14075990334804646601.pr-tracker-bot@kernel.org>
Date: Sat, 31 Jan 2026 21:09:53 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6073-lists,linux-efi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,git];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50362C3F32
X-Rspamd-Action: no action

The pull request you sent on Sat, 31 Jan 2026 17:06:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d097a0783102a9e966ed0a70f54def4a1d091b6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

