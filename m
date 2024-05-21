Return-Path: <linux-efi+bounces-1054-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835A8CB3E6
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2024 20:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2237B1C2198F
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4176142916;
	Tue, 21 May 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBeTeNrb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076326AF5
	for <linux-efi@vger.kernel.org>; Tue, 21 May 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317603; cv=none; b=tpdmiV+Zqr0d11UnjQV/QToq+aQmkIU9l2pv3RvccJU5IVi3QdrH9SqdQRoSrHwX3Ls162WUaly6+4Go5jtrpl0MuDBt/hT+OQachD3/lSAtnew5RiTBWbMv3quFtWPqARxGCdKgcLkv9bPTKq4uD9PPClHk18FRsScqS5/iz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317603; c=relaxed/simple;
	bh=dTrEUEcKEAC/IvM5wlCyNZy/zdOWAhPEYqr2geM4jV0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PKg+VbMXgWDymScDTbNni9+kB3yf+TAndFZdnJtN1+Oz/JAIR77qwvdrKkHWtz5fuMDeVwPFZm90NUjz+Ed4ggkGJE6SL79f4McYJhB1I5jl5fOtY/PebEpJTrV8E8upJNYwINmTP3rNOfIpAzbki/3Y4/GAsoShss7pZGPQjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBeTeNrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B3E5C2BD11;
	Tue, 21 May 2024 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317603;
	bh=dTrEUEcKEAC/IvM5wlCyNZy/zdOWAhPEYqr2geM4jV0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MBeTeNrbXFMfS5shuCCw/1W0BnL+630HBRRMS6upkBYgJ0NBTtHsumMAFagmvQ+cs
	 HEhs+JiwljbnxFYX78tzEcrtXPXcULGRWASzIAg333VpbpTyiB+t9KgM3CacNuOfOP
	 dt1f1VjQaUwb4HuhH+XZxvHJsE6WRjSlM2cSsuVSREb2Qltwru717i2RYq+yEjlfl6
	 XbtnN6J0Gshei7iVDl8mwvXH8YJLexwpJY85Zc3hzScXGvHqu94TFeH9eKY5HoRWKA
	 ZiaFKtGTpv7d7H8Ryo8uo9r2hzez+RSVt1JkF7toN9aIK6/6wbT78iScJbW85Xgq1D
	 PD0/6im6JBzOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 624BCC4936D;
	Tue, 21 May 2024 18:53:23 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.10 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521171303.3822496-2-ardb+git@google.com>
References: <20240521171303.3822496-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521171303.3822496-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-1
X-PR-Tracked-Commit-Id: 15aa8fb852f995dd234a57f12dfb989044968bb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5499315668dae0e0935489075aadac4a91ff04ff
Message-Id: <171631760339.16717.14452191390383340888.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:53:23 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 19:13:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5499315668dae0e0935489075aadac4a91ff04ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

