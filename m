Return-Path: <linux-efi+bounces-1180-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9618FF352
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451251C2619E
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D211990B2;
	Thu,  6 Jun 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMdL57Vo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE71990A5
	for <linux-efi@vger.kernel.org>; Thu,  6 Jun 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693625; cv=none; b=DAkuB4pnGnrlQhCYpO3mTpVdSJwLQPrUUTeDox0vO35vznyi2ZUig7ML6ar+v5EuJLrZSAluorB6l/ytPSLLfv4NxJRPKXgara61myAh9acA83g8UdYRVBAg1J13VTqoQmfhEjnw5xrDPfwvLB23WpGfy8BQ8BRZhj+Oi9J3eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693625; c=relaxed/simple;
	bh=Iuy+eCru+7irbwy8CWrJZKC90yrjW7LvgpF7LMjJWCA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kOaiYUO37hE5NqG5N5UFXy8pCIYarY3Y0Zv6AZn0qCWskEfvrV0zXq0uSeuAEqMeoYtgjUpAtpNT5SDaGB1O6O/jDEq+tkXWfp6CElOwH2OJF14lw0atY6CB9PyZop/kNROoZuMC72SGfXwWNWC0sMhjZOEN82mn8sMbvEVLFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMdL57Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51F11C2BD10;
	Thu,  6 Jun 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693625;
	bh=Iuy+eCru+7irbwy8CWrJZKC90yrjW7LvgpF7LMjJWCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mMdL57VosGMWcWQLKEkLgZx2T+9jHvbmiSOIoET+mCJ34hBczhTa3Iq7z17Sav9R/
	 adK3nAz35NSMS4SEnm3y8Mn1tIa9i64BX947Z/0MWNjtZrmFAuoYolxvePrktUXsdz
	 s8/spB5OJjVHIhT/hKKTaeAxYhtwl/Z88duMCcXEl9X8BdzvkWBij/DrwS7XOEAnMJ
	 D7LMXRRocWyJFVXM3Zt6YR9Pofwph+t3jbM3PY44skpCRoBslPHlBddc/gmsFwyMRL
	 o/NFJCvRmxVOywKhBJGLHc6SYk/imGLXYUXDyoEXquitnZhu/KHVSPmyCIfcglnLFt
	 gJwopb1F7xM5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49882D2039C;
	Thu,  6 Jun 2024 17:07:05 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.10 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240606124550.3584379-2-ardb+git@google.com>
References: <20240606124550.3584379-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240606124550.3584379-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-2
X-PR-Tracked-Commit-Id: 99280413a5b785f22d91e8a8a66dc38f4a214495
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a34adf6010d723abc26c9f50ac2b326bf5ae0b9e
Message-Id: <171769362529.23076.15682238553953482131.pr-tracker-bot@kernel.org>
Date: Thu, 06 Jun 2024 17:07:05 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Jun 2024 14:45:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a34adf6010d723abc26c9f50ac2b326bf5ae0b9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

