Return-Path: <linux-efi+bounces-1496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EE193C9B6
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541BD1C22056
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8496339A0;
	Thu, 25 Jul 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTLfyVvv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1813C812
	for <linux-efi@vger.kernel.org>; Thu, 25 Jul 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939845; cv=none; b=IRo9YM2zNDX3TQSKUSSJgdjHSpMO0tZY1bfAUVYy8c3rCQAvmggD1X/NaI50YyCZzGgHD7fBkNgvsr4u6eX7qsoOmIKt9lbPoOv4LVMGs70SmUGhBSYqaGGj8iOpOqU0zsbN8a24r/iv4saQ8U5u736yeR/HCXrviz8QBbDMQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939845; c=relaxed/simple;
	bh=m2rGW9NDD+4P11d/1Ix0AfQWw7gz6/FrOqW7K9HuxmQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JhiZ4O97UT1Md3LQgm5So0ohRzC1QP3AqaaCChzS9hw8cMq+DqpRp2QIubH0qUiM877naGzg5JyTlYWiEWkoNKCmN7NlFD3nIbMJ7rVglGJNGZ6wk1E11AsDj28pNag9nh5RBqLAWK6npPFoBK0xuIAHoSdXM+9gcIzPfRCqa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTLfyVvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B3C6C116B1;
	Thu, 25 Jul 2024 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939845;
	bh=m2rGW9NDD+4P11d/1Ix0AfQWw7gz6/FrOqW7K9HuxmQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QTLfyVvv1s1WRkm8Bh3qC9UIQk4SbI27oQK1YH8joSS+qUMyWO0H8iFYt4zAa7pad
	 p6Z9sYAJKkiIQty59Tj+Y9jFuZhbc4cD/npZpTk26UhSKVnfEslhSRg3bYJAhF01vJ
	 2FCrhCLnasTypTo3yzCWqQUjFgue0n0zKYHvXq4ASlAxwlNmCvgN3naGiFamhueMtG
	 nDSivSN6zPQmIr7yFmFm5rIjNz1WahPaZ7fP/qtEzt5IZ3A2sOcpnTwFVHEM01Bizz
	 wKIiUBrJ1EkKpdYb9bB7aPueVuYjBpdL1KQh11QEuC+JVhxUePcLAtB27UjBpGahs/
	 rde1f4elc7odg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E64DC43445;
	Thu, 25 Jul 2024 20:37:25 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.11 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240724200734.1114800-2-ardb+git@google.com>
References: <20240724200734.1114800-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240724200734.1114800-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.11-1
X-PR-Tracked-Commit-Id: ae835a96d72cd025421910edb0e8faf706998727
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bba959f477f2f4a48ab72eda2902db706bbc3793
Message-Id: <172193984524.17931.10897479676073431920.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:25 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 22:07:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bba959f477f2f4a48ab72eda2902db706bbc3793

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

