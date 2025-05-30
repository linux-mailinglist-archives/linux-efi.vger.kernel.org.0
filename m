Return-Path: <linux-efi+bounces-3806-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D6AC980F
	for <lists+linux-efi@lfdr.de>; Sat, 31 May 2025 01:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C401884CBE
	for <lists+linux-efi@lfdr.de>; Fri, 30 May 2025 23:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6E28C86F;
	Fri, 30 May 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YccYeRGR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C228C85D
	for <linux-efi@vger.kernel.org>; Fri, 30 May 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646998; cv=none; b=j0ja6JkcNn/MKDc/ZwfPc81g2mj04g0REWF3fWxt1Jc3RKTJyXIRUrDBM22wr5ZnLO+wY6VMSXQTeVZwNxuw75Q4pBFCZFCQXuyA6UEN/nsqgY2vU8X9qef/WEyKc3AAR6pNKkKFydDK9o44SRSM36xkREXBee4tMDDqLNymH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646998; c=relaxed/simple;
	bh=p0qxDFECSe3IeKb/B6l9xyq5J0iHqUcHjGCycQis/50=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r6baoXkNZWwCbS8bPPT8Vtoy8yhkQuWFpxEOudmujTGzIUflB/OCy3wbFyPfFqp43LheArVZd7LEKuube7xrQZVhHqoGZvgrYrAQPDsN+CMAOVSgMI+Em1B+aHUW+266gTFeTh9FV0SeqTQLQV/6lfg8XvjyKurnN/0P4omP1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YccYeRGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164B6C4CEE9;
	Fri, 30 May 2025 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748646998;
	bh=p0qxDFECSe3IeKb/B6l9xyq5J0iHqUcHjGCycQis/50=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YccYeRGRUu4atKWtoHPXF7C1/OwjsNffzPvkms+R9dMAE5dPuD7B2I+HTSTBMrzfK
	 7PKBELLJOOdQOADlPeUVGv9lfXjgBxau1apVA8CXrFSUmMWbPeW5dORzcQXhQiRCbr
	 cerZzxljSsUUdVBn4/BZa0kQXc+oUDnxKBC50ckudr/5AZslN4PRwZW5p0Qsvwz2s/
	 mggmczvYO/hgV2dkNj2WonPKMXxJm1OHZmAt0sqdEsFiMg0pPe+nfEoAFVT3yD1mIr
	 qrEX/G9M7hp+6LRvkL1zC2sowtjYUQNIL1tKk3s4VNLkgeQLmR8iquqrjK2YCL08RH
	 5JqZP9vd6kwEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFC39F1DF2;
	Fri, 30 May 2025 23:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250530183449.3558067-2-ardb+git@google.com>
References: <20250530183449.3558067-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250530183449.3558067-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.16
X-PR-Tracked-Commit-Id: 46550e2b878d60923c72f0526a7aac02e8eda3d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 724b03ee96b8d45310d89c9c3b0aa5ee0dbb72f7
Message-Id: <174864703136.4165071.2838009849533292770.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 23:17:11 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 20:34:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/724b03ee96b8d45310d89c9c3b0aa5ee0dbb72f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

