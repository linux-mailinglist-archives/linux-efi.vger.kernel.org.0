Return-Path: <linux-efi+bounces-3049-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E0A6ABA3
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 18:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4030B1886CAB
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130D19D074;
	Thu, 20 Mar 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWeyd6vq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BF42065
	for <linux-efi@vger.kernel.org>; Thu, 20 Mar 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490122; cv=none; b=KE4ssS9dWwFtZ7IwnSa/OcH2GSFyky21gZkloK2agxgd/caAnzG9nHVAJ4XTaIeKxMDYknsLKfHEJU8wSkxBqtaUJIqf2wV/WKSJA5NupoYyIRFyXANbbhDHUOmul+EFLjNJrcRNnSx28Xa/XabairbLHVHlL/rKtpHCS5VHTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490122; c=relaxed/simple;
	bh=YOqSqZRcvVWNRyy7HT283huhXa1isj7VIc/uRGPO33c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bG2oK3gbMCBMRswVyEUrpUrUP7R+QpqLldPccgnJCZE6a39t3PyBfp9VLuymGA9zTyu+8LBgPaN4sm9k+3zUyoSPWUXVwgAN2LbnJP9YTef7HXixRNQ0NEsccq4pexA38GXqE5K+JS+xLz3M7OzUF68W4qDngk1m0RpugBjBQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWeyd6vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B048C4CEDD;
	Thu, 20 Mar 2025 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490122;
	bh=YOqSqZRcvVWNRyy7HT283huhXa1isj7VIc/uRGPO33c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BWeyd6vqyr2A9xucWcEz2U0JQGWya1r5x4ULkHvavuzG/4ltn0XX6t0u7VLgDdKaD
	 OM4BDxb0Bg6gTW/vql0JXiwYXKmJtbzs689A5eXfvDDXfRqcAjHePYeif2eJGD+xUB
	 BeAF33tifwZstl+I2SGrnksNM0Pe97f6hZytfo2caXbdfR05Az6Pn7tT3f6ddEabsY
	 fkn3JM/h3RWej5SqqTugHI4IKApNVWg+M1l/bQ4OSIBVwx1NMFiPsD+Bhfngq/BiCx
	 tpEo4kgtXuTcKK0UrESf1J8XTSXJX3WbP/EnHoQonvnmhQtCNTDYqJg7TN9EjRXKTu
	 5ztdPA7Pmj1IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6C43806654;
	Thu, 20 Mar 2025 17:02:39 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.14 #3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320063746.4177561-2-ardb+git@google.com>
References: <20250320063746.4177561-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250320063746.4177561-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-3
X-PR-Tracked-Commit-Id: 11092db5b57377ac99e6339cfd16ca35ef011f3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4f586a9fc9b295ad1eb5c914ef48ff3c43bb8e5
Message-Id: <174249015818.1840953.12767693326409940623.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 17:02:38 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 07:37:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4f586a9fc9b295ad1eb5c914ef48ff3c43bb8e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

