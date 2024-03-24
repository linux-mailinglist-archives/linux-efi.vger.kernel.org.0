Return-Path: <linux-efi+bounces-874-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BD8887EF4
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 22:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E99C1F20F27
	for <lists+linux-efi@lfdr.de>; Sun, 24 Mar 2024 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3855182DD;
	Sun, 24 Mar 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekY8gdzY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEB14A8B
	for <linux-efi@vger.kernel.org>; Sun, 24 Mar 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314123; cv=none; b=MWeQ8qrfUWwKvMkwuetCfDGaezGcB22SMR+pcPA7hThd+uLiNAD9vZm0jot3MccjwJTpV18AOTtksJLJqi8x17rRl5J3pOYMwIPclU21p+vJQQhZG1ttP6ZD79k7U17KGOd2gWNWwOiD5fev7H6eGCNjVzXPMvXiiZllUY3NC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314123; c=relaxed/simple;
	bh=vCCo9ofT6yyPNjlMHjfGjuWD0jHNhBbSNPomlDX/Ynw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PywEoY6sT2zO8H3rzpDSCsfqlAA7pOj91cwbKqhhxUgaNd8ipKjRFE5MIchJeN5dfi3z3pIlF1jlR8C963Wvx/aSpeaqhSqSAc6nndZKoN6HfHe8a8z2VznuIIkG3MVyl+nynyS7ydoIMwZLfwwLFf7plyoVLAw6eGP/hHxc9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekY8gdzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC45C433C7;
	Sun, 24 Mar 2024 21:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711314123;
	bh=vCCo9ofT6yyPNjlMHjfGjuWD0jHNhBbSNPomlDX/Ynw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ekY8gdzYcREXv29NuNLjemNUGOIcA1wbrYBGvPjduJ/NEH0GD5r4chLdPWKtP6ye2
	 KMv/TRUgsuOdUH7Co5R/BynXAPGhACrwzrSSh5SCRsgnjN8AWd7VOki6l6LJBRJmya
	 hK3xTgcIDdmIZvWoIWhb/E5sFWgKo23TrdqnK8jNJXYQ5DURZ1TViXKmZE+6Ae4QMW
	 idt8LKCwydJ332AalzRLmvKJacQKtwVN6uHnMFowcB+IvciSOdCarSVk950CLIQlzE
	 UOP83Y6hpR6tBrCN3jvAJRTYIr4KBXyR7e/NO/dCjGPnM7/9K1TZ6EeVEMwjv58qFq
	 LhwddMPcHUqKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87F8AD8BCE2;
	Sun, 24 Mar 2024 21:02:03 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.9 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240324205235.3988845-2-ardb+git@google.com>
References: <20240324205235.3988845-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240324205235.3988845-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-2
X-PR-Tracked-Commit-Id: 62b71cd73d41ddac6b1760402bbe8c4932e23531
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab8de2dbfc9ec912f2762f3b813437a4c4f56251
Message-Id: <171131412354.24577.15936525722639201567.pr-tracker-bot@kernel.org>
Date: Sun, 24 Mar 2024 21:02:03 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Mar 2024 21:52:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab8de2dbfc9ec912f2762f3b813437a4c4f56251

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

