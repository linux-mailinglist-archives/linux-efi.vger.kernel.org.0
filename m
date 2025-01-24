Return-Path: <linux-efi+bounces-2728-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA21A1BF1D
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jan 2025 00:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C0816D4D8
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jan 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA51EEA34;
	Fri, 24 Jan 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTEunqzu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6E1EEA2F
	for <linux-efi@vger.kernel.org>; Fri, 24 Jan 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762432; cv=none; b=tjNp8acIxdtsgUuVGSNY/wSSF8IpZPsxcE8i1S0akvMAnp7UjZ6WIxqnQFss37Kz3Tr0KgO2/Mgs71mA8eYYXJuuLyKNGrMZX9Ep5KMDeStmUDBCiosUOVfzOS1OaGGm0VAGR5h8+owqjg3Ufk+EdBPqN3bmqx/Zt0vjHkbRwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762432; c=relaxed/simple;
	bh=bAH7uh1kHpeq5LbItET3zXoTTqGmTiysQ9Dhcb3RZK4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s0eQwMd24oBylPZ8In4QPx5Tgb3ekY8ksSGgSMOV3R6egRy7nehWi1IaMsV+UP/B62CKP54y1dC3Gq1m38dI2h25j+xqomDEy+zP8zRHgMjQHUPYT2QdEMMM6NSrWPYvTpFBW26LG3ko3M4RpA47ZLvchbHih0TwOCreRuoWe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTEunqzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C6C4CED2;
	Fri, 24 Jan 2025 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762431;
	bh=bAH7uh1kHpeq5LbItET3zXoTTqGmTiysQ9Dhcb3RZK4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sTEunqzud7Xu/Uysye3jVwTGFkBRcG/3zLoW4PYju8GAj/53S8Yq7Gb9rFcTjMCzO
	 7YJ9eCqaY7crpimClm0TU1/hZL5SHOoBfiUKluDhZqNbH/uIr7EJnQHNedUpbqRPVU
	 yPIJjJ8P/1eXT0oaZtpJ5H9IaN/6OieqAnvFAwz9EgRyvRwTeF5hgE/mqsGH8W0R+i
	 mdS0gumvS83wBo/gEzU3VRJdEVGNVNoyoMj2f5DNGWT3xlseKLNRVWcV+eCGoDAT8h
	 A8xP20PgzLs73nflieQrsROKRW+sbnnx9bLgMs9GP3SQJLVbeHnwBtJ1DIh0McrTx5
	 TSd+wBn0T7L7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB033380AA79;
	Fri, 24 Jan 2025 23:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250124222510.3849262-2-ardb+git@google.com>
References: <20250124222510.3849262-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250124222510.3849262-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.14
X-PR-Tracked-Commit-Id: 64b45dd46e154ee7641d7e0457f3fa266e57179f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae8b53aac3273d876170437197631bcb5e16c932
Message-Id: <173776245644.2209747.11729218703066226265.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jan 2025 23:47:36 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jan 2025 23:25:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae8b53aac3273d876170437197631bcb5e16c932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

