Return-Path: <linux-efi+bounces-497-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9884FC44
	for <lists+linux-efi@lfdr.de>; Fri,  9 Feb 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C312B2D3DD
	for <lists+linux-efi@lfdr.de>; Fri,  9 Feb 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A4128370;
	Fri,  9 Feb 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttpzvqA8"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6E128364
	for <linux-efi@vger.kernel.org>; Fri,  9 Feb 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504388; cv=none; b=pO5e7qUGpuP13mpGeAopafB7myGrtfeGsTN9+JP0TWJ0QjmAUWYmjGhSjEUhRrGWfkgAbYcv9DVQkrvRmg0FQ4jbecEYDa7AHu2VL3A8UNvD+VgkOd1vuq1e7GstOsASwT+wfpz2tI5dr9XWJ3PBW0gVBHsZ/oLPPxS0zg+7Re8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504388; c=relaxed/simple;
	bh=xfciaF5mt+GTwhLuX+KL5C2nllD6spOWXMnRD3tBULM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uZBLi2uWerEJiXIPY8sOKfpl9c3lgRQoL21pcvQmorsF1Br0flzehYN/jX7q9dZOWrVM85eGUpvniRLVLyVQqZGu7Oyq4IwqhKxWSqThz/h7OVbgh9sDHa+OTcL5pG2j0ra1p65gSsIV+fBuoOoNOixCt06InTZcW+H7klIOAnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttpzvqA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A6E2C433C7;
	Fri,  9 Feb 2024 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707504388;
	bh=xfciaF5mt+GTwhLuX+KL5C2nllD6spOWXMnRD3tBULM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ttpzvqA8cEHX1cn01lagMoSJWYd0p18jeeera71R8xMz4+ELhZcMryE2LfWmcG7Lx
	 HM7qkOeoWTWagcKxPNPPuoG1qmQ8ZroBiy0rIIemz88ARXjfzasclKRZsxBnZ2q/Xt
	 gaLFVJi3KhRxn0dsLDT8u6EylfOnsTu+VfaAfCRnSLheoaEpfU+LF6K7mDLM6XBD3G
	 oyU3ymSOv2C4WIKgwuxNAQhDDjKefTHGqNJGq8nP09jXSaXIgFCvMDLIBMjTXpMwH5
	 g76xRxpth8q7sG2xnXVQ9ht+Ggdmp3Z5v5yHvYo2UT6LgBpjjX6pL0x6JX6kDYpHh0
	 0tMtK4wqAER9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4677DC41677;
	Fri,  9 Feb 2024 18:46:28 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.8 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240209121854.4043660-2-ardb+git@google.com>
References: <20240209121854.4043660-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240209121854.4043660-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-1
X-PR-Tracked-Commit-Id: 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6f39a90de9213693db19aeb2ddea54163f104d7
Message-Id: <170750438827.872.7108849009140604400.pr-tracker-bot@kernel.org>
Date: Fri, 09 Feb 2024 18:46:28 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Feb 2024 13:18:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6f39a90de9213693db19aeb2ddea54163f104d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

