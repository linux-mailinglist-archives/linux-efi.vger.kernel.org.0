Return-Path: <linux-efi+bounces-1440-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FC93323F
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F63E1F21B99
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jul 2024 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F31A0714;
	Tue, 16 Jul 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqN4iPnn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309519E7F7
	for <linux-efi@vger.kernel.org>; Tue, 16 Jul 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158660; cv=none; b=dM6IqJi4246Ji/p44BbsmpCgpsjCFr9HgmlH+9WlsK2KUNK9z/6SFFxjyT+takJTppY92vulQdAOZW3Osu0DTMAEQuLNBUUCqsL+uT6cZOOxqjRqK0Cl4NwR/pjpQtiZmNu0PY2spdnhiHJyXDlb6tCUEXlWPYuS2y1JvuL52wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158660; c=relaxed/simple;
	bh=Ua+BXjHu4QIcYKQP9T0UdPO9y7SaDIAoOP/Z2mVYtyw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y9Mokgs99lH0HH/pWpOG9CaFKIQA6UPVRBAXVq2l0wIEyHQ4lgURN/eZo8jBhOSrhkQ0aultgDGXblxRceo8EbuTGFRq2R9fsTNYJSL/dQENrBxnzGg/D987gv7cXy/Xh+ZE9cPOxmFSz8sdhckPsd//iIifA2II2V2FpviqBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqN4iPnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F910C4AF0B;
	Tue, 16 Jul 2024 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721158659;
	bh=Ua+BXjHu4QIcYKQP9T0UdPO9y7SaDIAoOP/Z2mVYtyw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JqN4iPnnxV6rNNx6UobaiMmOFVJPxFsl+xPh/YeP/bfp69SzOWJR3bMbAHBXEEh0v
	 PTi/DKHfHdzwaUPKq8YkY1RI5BQEYNADCX4UwRfKZvCHuZgW1sx6Y7J/teIOxujCkE
	 a2TPGDGHGWDOQOfEwupexxSopQ5JftNSTje5+vQhKWcqK0fFAmW3PMXAhPwbJIyyie
	 0Ru/jQc7gEaNe2Mb776bEl2NPtkDXfEZyWm3tGEkKBlmMSdvJGuUfRm2isfufxInlK
	 xEi3K84LSqPBPO8aQaugRt0+/6F6JdpPJHq21d6tO93ASZqWejA5PmWdPH0SYQQRLG
	 F0BZ0dq5rfJNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25112C43443;
	Tue, 16 Jul 2024 19:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716144401.1742972-2-ardb+git@google.com>
References: <20240716144401.1742972-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716144401.1742972-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.11
X-PR-Tracked-Commit-Id: 4a2ebb082297f41803742729642961532e54079e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e55037c879a087a57d775e848a58430ab3380fc1
Message-Id: <172115865914.21341.8661548477709206583.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:37:39 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 16:44:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e55037c879a087a57d775e848a58430ab3380fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

