Return-Path: <linux-efi+bounces-4425-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B829B0B2C7
	for <lists+linux-efi@lfdr.de>; Sun, 20 Jul 2025 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9273A988B
	for <lists+linux-efi@lfdr.de>; Sat, 19 Jul 2025 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D627223702;
	Sat, 19 Jul 2025 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWp/yEkm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787221D5A9
	for <linux-efi@vger.kernel.org>; Sat, 19 Jul 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752968082; cv=none; b=lj3xFGEFi4U+DRTGPjVg9ypb5z4NwsLkKIbGAKvZ93SVZr3gmPH9Q3WvRrlxbZBc84rYovFnojeBvkNo+/llBpbxRKECsVj+m1lPcmK0IkHMOMbaWMAS43uo+wMg8LWAc6oz1jZ5ashOu0zYiXZuSs0uwADGPkPjZ5LQInfV2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752968082; c=relaxed/simple;
	bh=6PZD2KhbqTq7+Z0XWBBcxJ2ieNFAnnFD88XfPzPS+84=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NixkhRIp+cztquY/CjjxolsaZurmmGrZGJyzNDParK/g3Q4zfZP+MLZZI2sz23+EfvIB6xaT/VVE6AHMj2DpGt7yb7xBcOn8UhQc8eeQvEhXY8Ysky7UheoEL3FZL1fOPchyKV2VRcsuKxcPqNFWso9eeKcLRIPufR1xaW7RBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWp/yEkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD5C4CEE3;
	Sat, 19 Jul 2025 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752968081;
	bh=6PZD2KhbqTq7+Z0XWBBcxJ2ieNFAnnFD88XfPzPS+84=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GWp/yEkmkskOlZh7mNllynx8ahaE5TKuLaL+5kJb0mvLe4x3XqSrNy1NVDyvy1Ae1
	 Oce+gaj+7ytC7dPCMn7R+gRIG1C8Lsi6HONkzOLyULlB64U+Wjf8ClnmuttsOkspc9
	 pjH7J7vVmutvajH1MZ6AsIA5rvuL3i54C0UW2gekSm+OHKwzCZ5AO3au/Z95GBEsEK
	 V8BIgXduij5qEFBvh4a16J66KmXlYmHd75YR2dp751YjCuWjQEnREhI8ObrFvCNdD3
	 lmZ3CqSI6wGdSSWOaX4ApcwYvwfe3hduceDSMWKwTeNERZ6BwavRUCBVLalttZJCKD
	 75DvoNAAVcAKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCB383BF51;
	Sat, 19 Jul 2025 23:35:02 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.16 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250719222008.760814-2-ardb+git@google.com>
References: <20250719222008.760814-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250719222008.760814-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-2
X-PR-Tracked-Commit-Id: 64e135f1eaba0bbb0cdee859af3328c68d5b9789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4a40a4282f467ec99745c6ba62cb84346e42139
Message-Id: <175296810064.3075058.3962960522270019309.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 23:35:00 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 00:20:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4a40a4282f467ec99745c6ba62cb84346e42139

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

