Return-Path: <linux-efi+bounces-5927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8006CDF2DF
	for <lists+linux-efi@lfdr.de>; Sat, 27 Dec 2025 01:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D812B300479F
	for <lists+linux-efi@lfdr.de>; Sat, 27 Dec 2025 00:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5F1FF7C5;
	Sat, 27 Dec 2025 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anF1KJeM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A51A3179
	for <linux-efi@vger.kernel.org>; Sat, 27 Dec 2025 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766795023; cv=none; b=Jlb85Qa2J5dYWg32yX60pr+LiGwbo8DShM4cNfnMtRH7q3H77uQEFEtEeVYUHZtcblfJnqbAY0MXMGb+eiT5hqvAQy7c6auyISkjpzHjYYLXW3t8Y0aHxa4piJjCC9ftGCCmcAbKwh7V3yJbey/ELZ93p4GGyCgY8N5kaNGqews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766795023; c=relaxed/simple;
	bh=ZbLLqTh8BNEmIF0cEjO550dhJuH5rDsJDyWToOPGWHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=No317NErLefiCUFpwsi+1YFyZ5Zv2bR+7MIKnvmA0fd/Ql+p6Znec9SvxlwtWOBZ4eNV7tA2wZh6g8U/4JwFmfYCTXUiNAf8NHesJjPM9ZemEOfkemOVqJxa+S75HleV7Xrc1OnywWOx6pgI+nnfo50Rqj6f5QiGxYB/wYBOncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anF1KJeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CECCC4CEF7;
	Sat, 27 Dec 2025 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766795023;
	bh=ZbLLqTh8BNEmIF0cEjO550dhJuH5rDsJDyWToOPGWHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=anF1KJeM4tlwvEn6atLtEpJfoDJ99vwZTeQTdV0asNKJi4tWnW41yOfjkEK+GPZxZ
	 moaKduolxMxz2S3mSU3m8t0uyk+SeH5eB7k0Neu+E39fduv/51ZdbPmPU6p8kgMtl6
	 P7ZITuarLgcWaQCG3VLlmvmKy9LRq+7MKYhX6sN0IyPQVoa9LLPfDeAnfEcIshkulY
	 MPh5Bw/q17RWQQjW0H1kEuri0yEO/HQLBX2pJOUppze1Tl+ol0fREzTmoehr2KuuR7
	 YjYNj4seN4T3ReqRsuQfYi8OWl/+gw9XXnrB+87OxdqsK2J4foWQzztVG7YFewoR0O
	 hKudEo3U2TJ0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2C813AAA6EF;
	Sat, 27 Dec 2025 00:20:28 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.19 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251226170040.2335976-2-ardb+git@google.com>
References: <20251226170040.2335976-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251226170040.2335976-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-1
X-PR-Tracked-Commit-Id: cfe54f4591e675cedf2c0d25287ff4c0a2e0cb9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b63f4a4e95d61bc7fc3db074f3689c849f27f046
Message-Id: <176679482848.2028187.3677529658236950746.pr-tracker-bot@kernel.org>
Date: Sat, 27 Dec 2025 00:20:28 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Dec 2025 18:00:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b63f4a4e95d61bc7fc3db074f3689c849f27f046

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

