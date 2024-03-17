Return-Path: <linux-efi+bounces-828-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C918A87DFA9
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BC5B20C43
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24671F94C;
	Sun, 17 Mar 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5i98Q/N"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80F1F947
	for <linux-efi@vger.kernel.org>; Sun, 17 Mar 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704046; cv=none; b=TaKrxWXgRpRQrsKM0dmdwQSiEzjyKoF2jMMbEgyhBtFKnUBlla1Z3AGDlnPMZs5ODFdiFUzuo7Rgf1QtOjmfey4KEkF2j7Zaxwtu3O6zyKpWamjN9Gx40nW22O3oAg7Dhi2/05jxh5dzvO3bWp5zfXunj5zA4+zXK7Fe9o+YKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704046; c=relaxed/simple;
	bh=ojQdPKuk/ABa2yhcbbSQeFXU3PUNlPKRFTY/6iaUdQo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NO8fHnAsRmldPzaEHq6Zx4sRoge1QTePJQRZJX3FILmzuI6gy4o6RVqaCfCQ2Ul8CpMmIys2lpt5FFMJQ8Ej1PFVoerLwzR4bSWi4P5R9lFUQLtpqBnzrZt2sdQToMonpX1Qzl9qk2I7O+nrLfwEXe6N5Bg+QYdhBUFYkwRURbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5i98Q/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71556C433F1;
	Sun, 17 Mar 2024 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704046;
	bh=ojQdPKuk/ABa2yhcbbSQeFXU3PUNlPKRFTY/6iaUdQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S5i98Q/N8gyycOh91BC9/6LFzzR2/NDA5zloUlmGbZHWFnyKLXP7f93g6oizfE57V
	 OhJnzNeSFS59F8swW4ix2NEtB+hH+4fNT8cjBFWuZXtKHXqXxKMWpFOP+1KnPjigNK
	 wfXoNLnsfcF4dyxgbPY++QOVR+S+Ym5CuINO4uF4HwFmHne4A4PxG/xs0HJUCRubAv
	 v47dr3WgEr2fELJJfslFrcKkr563BXqXb9c9o/kylfP3R2Og+MQKVM/bnKKedbuv7t
	 sB3EZht+FSmjGlUYFsux6gLsRHmhbjF6FdN5DHX9cJKD9ylg/YRzvHq7RZo47mjxdD
	 U1TkDRA/IUR6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68E77D95060;
	Sun, 17 Mar 2024 19:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.9 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240317135804.4092430-2-ardb+git@google.com>
References: <20240317135804.4092430-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240317135804.4092430-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-1
X-PR-Tracked-Commit-Id: b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 906a93befec826475ab3d4facacc57a0b0a002a5
Message-Id: <171070404642.21222.2907036416407168093.pr-tracker-bot@kernel.org>
Date: Sun, 17 Mar 2024 19:34:06 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Mar 2024 14:58:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/906a93befec826475ab3d4facacc57a0b0a002a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

