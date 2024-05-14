Return-Path: <linux-efi+bounces-1036-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421A8C5D9F
	for <lists+linux-efi@lfdr.de>; Wed, 15 May 2024 00:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B451C20AB7
	for <lists+linux-efi@lfdr.de>; Tue, 14 May 2024 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD6181D09;
	Tue, 14 May 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL0d4l5T"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E68181D08
	for <linux-efi@vger.kernel.org>; Tue, 14 May 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715725353; cv=none; b=RPsB8C8mTlXi/9w9BSNHJnemNuIKSupWF6ObVco+HKpxXJlcgSiIfOXIJ8ORGNCtK4fgJga0qm4KCl8VktwRP+axjDVwfwmWaS1f8vWtPVPZGOVClMFpFjZWefg4QNNt4qtRxjvDF3Dm6EQ6AFMZ1Zz9Q+0iboCM7eNcZ6Kgqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715725353; c=relaxed/simple;
	bh=LkZx6HvdyCEoQG+3O/5sXe54mxmQUO+9VE20XW6teu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AMK1/yv0p6BPnzit5KcjohUMxXmp8qTB410jpyUdFsocc8TCJE9HwR2CorTk0F8JLAd590rAABJAF6XL1jKQmOcZV5nu75qnUdyQyQIcGxKF3UO6TgPqphGa9Mm3+5ZCnEyMgbdZFcwcyjXMgOp1kbwjmSb+6aVZNnY7PRl8Dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL0d4l5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB2A6C32786;
	Tue, 14 May 2024 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715725352;
	bh=LkZx6HvdyCEoQG+3O/5sXe54mxmQUO+9VE20XW6teu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CL0d4l5Tp8uQ4ftdssI0O2rcNOwR1MOHb+V5d6Xk4ipQixMA5B3BzEXg2hzN6RQZU
	 FN5gBKc/6hEF8NAQOlp1Gnd0MHjCnUqU39CKBSkwxJQmS+QVeGi/n7A5JSG3tdysXo
	 lM9Gu4aybWbgh7IUpYDfCt4ylK7TlAbqNpUBCYibmxvfyIiukHQfNf7V4JgHe5W+td
	 cSyffpcP0dvYvHUujzhOC9C3XBpUBIig15y0PcOJ3dXo6YgByqr4QfIpF5z22Yy2vR
	 Bb9zAJy0d74FarVV7yf/19yJ55wA1I4rpFoN/lCQJsZ1H7ds9Wk+7PEjhY2H4pDJRr
	 mJharmGH/KyTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF17AC1614E;
	Tue, 14 May 2024 22:22:32 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514072039.3346871-2-ardb+git@google.com>
References: <20240514072039.3346871-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240514072039.3346871-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.10
X-PR-Tracked-Commit-Id: 4b2543f7e1e6b91cfc8dd1696e3cdf01c3ac8974
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b10b390d945a19747d75b34a6e01035ac7b9155
Message-Id: <171572535270.9756.2141084857377456058.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 22:22:32 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 09:20:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b10b390d945a19747d75b34a6e01035ac7b9155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

