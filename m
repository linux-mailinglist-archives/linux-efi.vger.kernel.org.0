Return-Path: <linux-efi+bounces-1243-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686E90D715
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0781F249B2
	for <lists+linux-efi@lfdr.de>; Tue, 18 Jun 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C14643A;
	Tue, 18 Jun 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLzwplw2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0A381BD
	for <linux-efi@vger.kernel.org>; Tue, 18 Jun 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724033; cv=none; b=Ze2LGW0ATkuRVP/l0EcJ7vHlDB/eck6mG7qmsYCB1hD4MBrFiZ2zImFBVdx8HMczwOzV/tj6itaNJvp7x7VI3U1I20AcMGBKcwFZx4tjMKaUFMj8vWmxUAOWy0ey7MBMkIC/Zg9zAmj/BsjSy9u69/Gb2TUhicP51fHAfZkBN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724033; c=relaxed/simple;
	bh=DAhg7ynR8iVSCpZ+KQgacwnQ9XwknkCXJaWQfpO8lzU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cwXCT9QXY8XWATgfppXDZh2gTa81No6y6kUaaOJ4JmJnqriEJ3QWEp2Q8/gdTb6+acIi32Hyl6iZsfdq7ZiqrzMpC+yNDFysIwVfS4o9LUUANwZ1ZnWFjjC9yIQQ3p/9VKu4s5Q1Z9vSibzb+MJEHBqK03ZehNHs8SLKg0YfaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLzwplw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF550C3277B;
	Tue, 18 Jun 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724032;
	bh=DAhg7ynR8iVSCpZ+KQgacwnQ9XwknkCXJaWQfpO8lzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TLzwplw2Csy0ofKx7L7TMiAcdlNIjix3OOF1+vzkVwWg/GakQYwUiRSLt0ClrkC4z
	 1MAM2e9SLeLppmca0V7w4WsmgUM2AKd/2rf5ZvL20dqsgTutvzX5tFM/KEQPNbmOYa
	 /95yE0NLocHKJjghLqCi1YpGX2C1aEWu4nvOjqt6hPPeeEnTWuYmd56X4keuoJuOyn
	 8uMUZnhD6sseEGn4Tt5LdjTFhxu7jiZv3okpZRoQJ5Acs7WRT1aagAm2y42tV5yO7X
	 Btj+q4fAVxUgS9njZr9FwjqtOZ23yjnz2rq7lVZYqFs66OpBBTKz5/RLdh9CPj3oyJ
	 g2auyzmQYkehQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0B2FCF3BA3;
	Tue, 18 Jun 2024 15:20:32 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.10 #3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240618144547.365311-2-ardb+git@google.com>
References: <20240618144547.365311-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240618144547.365311-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-3
X-PR-Tracked-Commit-Id: 46e27b9961d8712bc89234444ede314cec0e8bae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46d1907d1caaaaa422ae814c52065f243caa010a
Message-Id: <171872403284.6241.3433006547070158460.pr-tracker-bot@kernel.org>
Date: Tue, 18 Jun 2024 15:20:32 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Jun 2024 16:45:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46d1907d1caaaaa422ae814c52065f243caa010a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

