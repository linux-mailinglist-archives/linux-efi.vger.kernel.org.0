Return-Path: <linux-efi+bounces-5806-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E10CA5DE3
	for <lists+linux-efi@lfdr.de>; Fri, 05 Dec 2025 03:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3183C3066DF4
	for <lists+linux-efi@lfdr.de>; Fri,  5 Dec 2025 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA62BF011;
	Fri,  5 Dec 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIR/OORp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCB274B39
	for <linux-efi@vger.kernel.org>; Fri,  5 Dec 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899774; cv=none; b=T5C3bnkjTANHCvymgKHtRwu0uFikBNuzl6BwwmWw+0kKnGwHdWpiEOjqaW5mRxdn6ufJS244ir85kEbyTh2MPN5gpZkbdti9TbwBeDkTn74OTTim4zC5CT44LKAt+zJA2e3ZoP4eKB8gHyfeWY3UdrbXcoZ2zSSj+XK7bwl2htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899774; c=relaxed/simple;
	bh=kWPZwYuHbZb1/1ufR+hZddwhthqnRIia6SuTI7Z86aM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZSb3HRxZBn6fIQuUWbLSzOeohdAYX/FTPBjvVSOztAQU/OsJW7B/u0B+obEheud3sAnV6580eyhMph/o4cnLv7EYpRp4paKP3X8l//Bj9JCPi8IA1ioQzg9bobCm6wmDq8AgrKPjFy+pwiSbhbEOWEbWUcWbf0PPnVpsl+b/Xik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIR/OORp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F344FC4CEFB;
	Fri,  5 Dec 2025 01:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764899772;
	bh=kWPZwYuHbZb1/1ufR+hZddwhthqnRIia6SuTI7Z86aM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IIR/OORpgtXhCE0O+vQlvXrbEhO3AuiMGzuyyulGvEFUU4JblgCo+1YNwilWrwk3X
	 LnBsCfJGdnljkPxoFn8j410VmoNxliTKZyTePQhHA+Lirmg9oR7WWec5Sv94HEwOuS
	 d/mgXiFGLYbWAzPKToCkmEVIN2tx986NyxVMLDCCt8ftcxThfc3laQHPgV1sHvwfZq
	 KY9GzVs3CwCsHqs5H8pjJfZIlSjk6GN/2dUbygWve7hNDHrzyWUZ5nSn6rEbNfOZuD
	 uEb+C38cVLfstqJpuv6GH56jtNiXzd6Zwp/Ji+V+84KfuvG7iREEyI+3iSk9SGFaNu
	 dnXNeWaAoY8sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9043AA9A85;
	Fri,  5 Dec 2025 01:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202095159.1183189-2-ardb+git@google.com>
References: <20251202095159.1183189-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251202095159.1183189-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.19
X-PR-Tracked-Commit-Id: 7a2ff00c3b5e3ca1bbeb13cda52efe870be8501b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1dd1e2f3e4ed970949ab4bb982bb0165f3e979d
Message-Id: <176489958916.1057018.3919215398282237847.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 01:53:09 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Dec 2025 10:52:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1dd1e2f3e4ed970949ab4bb982bb0165f3e979d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

