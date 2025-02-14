Return-Path: <linux-efi+bounces-2794-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3FA368B6
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2025 23:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E46B188E130
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2025 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ED41FC11C;
	Fri, 14 Feb 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llMjvk56"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D571DF98F
	for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2025 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573600; cv=none; b=fN/itgl3VJPRa3l12N6tpuc4e6/613iSBPYjVeKMfypd0gMdTY+7XC7wK3eUlO5Xwylrzh66OtVb6Dl4QpOK4KGEfPWKSSwnI0k16Jzf+UMStajoBG/fveVg1QTXwwvHCQlZRw1PPLJPochJATqLXdFi8o1kQX1trcrrer1wjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573600; c=relaxed/simple;
	bh=AkuPkr36/Qh3HsEx9hU8ZC5oSlNGaSZz0Af4w53TsgI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KnTeG3rWS2EH9y3OMoQk2fDHU1z4/Laxmx4sE1qNriibyseiYoOoEGXdj37K5OXIqLO1s1AFWKTa8DFjUn4YxtaTL63TBhIj6XPhARzPUziY31vCBadPXl/eRfKeg+jC55ezp0QaU0tYeyMTfaKybUugdOVbWvjeTgzVtL5NzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llMjvk56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6494C4CED1;
	Fri, 14 Feb 2025 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739573600;
	bh=AkuPkr36/Qh3HsEx9hU8ZC5oSlNGaSZz0Af4w53TsgI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=llMjvk56zx7MJVx1e+7ZuVAbbce09UCx0IWJMm+hgivx4RQe7nfUcej5gXZCSvNmI
	 3I9e+LZUhu3E/oPUh6ga3ferUY3eyaPhkE1C3jQiBhM10d1WC1bXHVpLTVEQRmhN8B
	 kMDTwUsuphThv9TGjM8tTam5ccKpa7iVWK7vIkREbanXSqcI1r8vcQ1lyftL1iLGFq
	 YGQ7iwCDRAJGPGNVgT7FYlsvBrDttuGPbsC38+YS+skTquDNYrHRI+7wnL8A72uIRL
	 hx8K5XMvC+4BnTB4T2FAaKNGZ59VzTo0WMy/u8hed4CS32+Ey1ekVnfzdCt7xClQOQ
	 Q5QtfYQffkZUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3B380CEE8;
	Fri, 14 Feb 2025 22:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.14 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250214175225.544273-2-ardb+git@google.com>
References: <20250214175225.544273-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250214175225.544273-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-1
X-PR-Tracked-Commit-Id: bbc4578537e350d5bf8a7a2c7d054d6b163b3c41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7ab7b2a18f386b37a289a00ff3d92f00bb16934
Message-Id: <173957362920.2130743.17027766547436660315.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 22:53:49 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 18:52:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7ab7b2a18f386b37a289a00ff3d92f00bb16934

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

