Return-Path: <linux-efi+bounces-902-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CEF89242F
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BBA1C21DD5
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75413AA38;
	Fri, 29 Mar 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXPneDJZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75F13AA24
	for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740451; cv=none; b=mST8r34964EHP3Kj2RR8/hLhvdmhqlTuUOvnvpZlSdaSeY/L5CNCcbfPOytqp6oL3feTKy0vk6AskpjgxCyUJXI3ZHB3P9+Buf2IDJDkwr91TqOjr2j+l3ZV9vPdktGLZWCKMFxx1usy+AqqPTcvkjpyixZqQs7YRY6ifrskbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740451; c=relaxed/simple;
	bh=6deH9kHMl+GuNthYjq3PL1plPnLnEGonHYXkPFeTzv0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iYZA8ueH7LMf6wHwxixxe0XRLLw7hlMBqvG8GcGHQpM3T3sPG65oFxGXOND1LRjqIRVrmibBdJDjzM+3tJWkIN/1hu8JVV+STq13+SAxbIATrkvboapIOnhgt1gMQfidVrfYkJh6ImX3I0Bo/xZsBKS0jrHBowt2C0thLXVUOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXPneDJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF647C43390;
	Fri, 29 Mar 2024 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740450;
	bh=6deH9kHMl+GuNthYjq3PL1plPnLnEGonHYXkPFeTzv0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UXPneDJZxd6lBSR9dr/2zUy1WGDM6A5R4A8wMh1VW9fIgTVWasiDYtuWh+QC6sSBt
	 xSua1oMZHfdVXIBbe4FPcqUOhJWHZuLiwy1aT8UTPL4tiJ+38xA3LIV2QT0MkgUzGb
	 I3CkP2+fSPzeycqRJ+A3lCizEXorE/HlsyTRMg0/cTzsS+BbVSmXhbcAhuieqz8MLb
	 AqvkjFfdwQ/uOShgURLS9aczTnOgFldq8hcAx8MsSASLGG/L6LKO7zFgHoLtkDZZx9
	 SPrWmZuW7ZgsLbKnOmnzAph6f2ttAlHxF5KfSyxJJtoNb1kiqbR1bdLsmtPDj9Hqjq
	 k+3zmLL3P/kQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5EC3D84BAF;
	Fri, 29 Mar 2024 19:27:30 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.9 #3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240329161712.596062-2-ardb+git@google.com>
References: <20240329161712.596062-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240329161712.596062-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-3
X-PR-Tracked-Commit-Id: decd347c2a75d32984beb8807d470b763a53b542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eee99d9eb5a617f7f779c890f955eec6fbbe647
Message-Id: <171174045087.16736.2858957315422712114.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:30 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 17:17:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eee99d9eb5a617f7f779c890f955eec6fbbe647

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

