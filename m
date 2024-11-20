Return-Path: <linux-efi+bounces-2181-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E59D4437
	for <lists+linux-efi@lfdr.de>; Thu, 21 Nov 2024 00:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D292F1F22BEF
	for <lists+linux-efi@lfdr.de>; Wed, 20 Nov 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54721D07BB;
	Wed, 20 Nov 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQWlkPYt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B031CEAA7
	for <linux-efi@vger.kernel.org>; Wed, 20 Nov 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143381; cv=none; b=DWy6VGHsTla42DdNSCHHGGzNsP/VyRHaaPKC9LDcmxZ/emOL5CGBiWg6Q+WEoQnR8ACyXs89gn5xLTyIYMHmyQ0YKe27nsNT1rquJo2qj+QV0Of6fBmobI4eoAxeiYrE1jGAQ1Xlk0LYuEH3tBP7lwLWaPeyKAJM7UISYAoOddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143381; c=relaxed/simple;
	bh=pMkeBCfbBcpcl3zU+uIvFmtIjeYqaVfk528mZXNkOjY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m9IJBi0GchO7v29y+IG/9Ibg5fiNCny2wZaAFssfO90h5zpDR70FaqjPkhKoezGCY/fO5OqDpPACHAcrzaTEQoTWvNE60VHtunVCPiScmAG+Sk2Pz0NVXO2WhXjxCZ27Chx3cmnl3bzBsV2wYA0SyJ2eIs59ny3o32ZO0NLu0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQWlkPYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16B3C4CECD;
	Wed, 20 Nov 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732143381;
	bh=pMkeBCfbBcpcl3zU+uIvFmtIjeYqaVfk528mZXNkOjY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UQWlkPYtaFLid2qRULSEfMBYyLWnzjO0K4mppc3lM84jsqgqeSrYIADs/VzQHjNTO
	 c1Nk4+Tm6BU0QQGkaZpgm9HcBWBl8VEnMZcubLzuNy06O1brmnGZTVwd6uJOj2nrZc
	 v0Q7nj7oZQU0ggNhK/Vgm0ZpDLaEHHItGkjUTQTjakCBJHAh2BvMSlfAXAa4kyCgPF
	 sWdnesIrS4nTBX9lPaxVFwBco0wORAHKxTT+2YywXFTPORkkHc81udUUt06R4yMF7d
	 XyPK9qtGQYe95wqcKHSpn7rSnjJuBQ6ROnSOiH0/AwASUxiRFqqC/u1vMHgpMycY6w
	 jeFQP9cjR8Yyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC343809A80;
	Wed, 20 Nov 2024 22:56:34 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241119201142.1339434-2-ardb+git@google.com>
References: <20241119201142.1339434-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241119201142.1339434-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.13
X-PR-Tracked-Commit-Id: c5d91b16f525ea8c98b3fd8efc5105106d17fe9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18a411cc5d5ce57d483718b1341a3ca69079bee2
Message-Id: <173214339322.1377324.11107680463006861182.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 22:56:33 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 21:11:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18a411cc5d5ce57d483718b1341a3ca69079bee2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

