Return-Path: <linux-efi+bounces-2866-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE80A4A0C6
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B7188F036
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2025 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB47B15ECDF;
	Fri, 28 Feb 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTYa8WQ1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670A1F4CBE
	for <linux-efi@vger.kernel.org>; Fri, 28 Feb 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764908; cv=none; b=g5ofID2WKq9A8ikECpTcP7w1z7pdqbJqiIyfJdPmvsaAPM2V5L9+bs/DT9MEe6iRRt2i7SH3IvgW1UM6bdEA5GPyIFzYvVY/v2Bz1J9nVkiDh38WsZAXeL0xOG7Rb8F6c9ym3XYnhU4mghc+LD0la0e29xwVRUQ30RaAMnjxZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764908; c=relaxed/simple;
	bh=xPC+PqksQMJjzL7yt0eSv4bV70fHPreLj1lCHpkysM0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jvMAmESq6/6L8i6qhxeCH3EiA01/ZCC6v7pGMu8VBN8AB2/BRY48ditb6PULo8MLu/GZjjvSq5pq5Xtla6N2W27vLVZqpXJ/Qdji3Utl1A0+cyzAj2dJzjYXXbX4v9XczivHrx79cQvzLnMTnldu3CHMZhYiCFmf+hchRCiwks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTYa8WQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46005C4CED6;
	Fri, 28 Feb 2025 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740764908;
	bh=xPC+PqksQMJjzL7yt0eSv4bV70fHPreLj1lCHpkysM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iTYa8WQ1qNiqt4B4jrEIcnLClkQQIFEKKhCAhotLE5DwnhGPpRMsiyrg0/HdwZ1+n
	 8oZVIhbdmODqhZMBlmcOd1o2lFf11zHijct+Rh4UP8GbA2FJcM3lOw+buXuA7AkYvy
	 ZyFYXDA9mZA6Df0K1HlyktQYM0xERFwIqlH92wiZ1utjKg3Ju+wCev3IBHR8bjqEAu
	 UtTQ14Pk//kK6gYoRDU3IavmxtNvCyUfGTEND9kja8Iws2u6XWzJxRYIFtBCCT8I81
	 rox1/KzgdZ3EHC4GcZOsbT3rB22Ifzu5yfrZwxiX5iZqCEFl+YHJrsbYmnmTtY4f3M
	 JErA1dR/kujRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B8380CFF1;
	Fri, 28 Feb 2025 17:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.14 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250228140020.3558244-2-ardb+git@google.com>
References: <20250228140020.3558244-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250228140020.3558244-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-2
X-PR-Tracked-Commit-Id: e3cf2d91d0583cae70aeb512da87e3ade25ea912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea185bdedb738b9ace114dd6806e95ccd53c6c52
Message-Id: <174076494024.2226632.7065526750616150390.pr-tracker-bot@kernel.org>
Date: Fri, 28 Feb 2025 17:49:00 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Richard Hughes <richard@hughsie.com>, James Bottomley <James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 15:00:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea185bdedb738b9ace114dd6806e95ccd53c6c52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

