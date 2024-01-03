Return-Path: <linux-efi+bounces-314-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EFA8237A1
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B13B21B59
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48F1EB27;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6vRcghJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192B1EB20
	for <linux-efi@vger.kernel.org>; Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E00CC433C9;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320345;
	bh=yMVECcaANjwiOB3bxR7oiJn2MsNg6gES6HZGYEbF0v0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j6vRcghJuHlkKDWGMLcTlcbPJd3nlNQhawDXw+PsjKuxBkRPwzKmIbgVQAa9E7d/T
	 NjfaNXr2DwN0HmSqx6AgZs2oPvEydpiDTkZcNLKssfXLnA89qBX3hoYr6DIMRdyJO+
	 D4VgTmYJnl8bPGx2mwYNFKh2amGVKBC6NkbicKewpDojAOmgC2YA/HRb9b61cE+VDO
	 J74xfCguKWYjCgvmc3EQHAJACKWjnLzfywV0rLAXd+1M6IuIpCBgayxCy/O8gbZzH5
	 uMNmrtCrq2h3/7M7b6N7+aavHexvKbHIOFZsymEPDE21TEaETOwnTCbyV0eLBGrrDq
	 ZQdv5kZVJW5FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C6E2C43168;
	Wed,  3 Jan 2024 22:19:05 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v6.7 #3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240103141120.1646106-2-ardb+git@google.com>
References: <20240103141120.1646106-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240103141120.1646106-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-3
X-PR-Tracked-Commit-Id: 01638431c465741e071ab34acf3bef3c2570f878
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94a502eb59775e13c9089de38c601f9f85b25750
Message-Id: <170432034504.19489.5290935034162040477.pr-tracker-bot@kernel.org>
Date: Wed, 03 Jan 2024 22:19:05 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  3 Jan 2024 15:11:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94a502eb59775e13c9089de38c601f9f85b25750

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

