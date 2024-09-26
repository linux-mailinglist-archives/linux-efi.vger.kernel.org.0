Return-Path: <linux-efi+bounces-1845-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6C987984
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2024 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5946286E48
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2024 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C015C14D;
	Thu, 26 Sep 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2yIDx9s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8215D5C7
	for <linux-efi@vger.kernel.org>; Thu, 26 Sep 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377753; cv=none; b=neggPwr/fL91TuDVN6JKEkzebra9a4Vv+e/+ECHZr0QK4YHzGeogAJ69dtZj54PCdfZsr1DoqYxb5ti5asEv6gdfJb/tbtk006Gd6QiwdOqeZ3yLzGxdJOSppEA5yj9WH9ddO1xFX5PBSdT65Pr4zwL9V1KudHn5F4XGHTSFekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377753; c=relaxed/simple;
	bh=WfV1qzIiyrvTFzJdVMSnleMtAoD9AW9P27OWzNV8GYU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qggPwoXdWeuSDcEG16NsGtocnrKHx8y/KH29mXJjYEHH9tTvuQJA+pIJbcXUGEOYT8qSjSnYYbGTe0GeuBfq83+3C+PkgSLK7YKy1njRGgnaH+lhIzJ+pFvBx7Ah13DnShj8dlX+wdphIeWgFklBfaLNC5yypCBhv4007jCN5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2yIDx9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283E6C4CEC5;
	Thu, 26 Sep 2024 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727377753;
	bh=WfV1qzIiyrvTFzJdVMSnleMtAoD9AW9P27OWzNV8GYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r2yIDx9spTmL4GKacZ+DGYP4wg38Ev5IkUvZ2TbaGFulRl7rzMIRFSiemix1BXkt2
	 QFkSG/h55kG0NDhwiURHyc0TiMv44+bbxVRvHCD/nxj20gmT6dl+MB7Sh5J34ABzb5
	 tbUUA3MB7PR8u+reNMN+VAzFsBy78XvF/EuU1Xuy69i2xOs9mEZL2Y7RYOZmPHLRBg
	 eySpUKMCfVTf8Hi5rWAc87QoXBvRQ5vZip7J+UBRQnAq01fV34mS3iEw2lml28OIRk
	 F8OH1EUJBNSYQm2IYhuM0x2SRAV3UsWFMBQkqfuXS/NGnt8WV1gHWA3B+47j+XDEKz
	 OwxYfLEqa+mqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC33809A8F;
	Thu, 26 Sep 2024 19:09:16 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240926154206.1041064-2-ardb+git@google.com>
References: <20240926154206.1041064-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240926154206.1041064-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.12
X-PR-Tracked-Commit-Id: 04736f7d1945722117def1462fd3602c72c02272
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1abcb8c9934cc3bd51f1bdc8916fa749b2e82cab
Message-Id: <172737775552.1364780.18169750232780494793.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 19:09:15 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 17:42:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1abcb8c9934cc3bd51f1bdc8916fa749b2e82cab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

