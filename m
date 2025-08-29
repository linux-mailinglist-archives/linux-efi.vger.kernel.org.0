Return-Path: <linux-efi+bounces-4653-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A003B3C107
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39789A0704F
	for <lists+linux-efi@lfdr.de>; Fri, 29 Aug 2025 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B133439D;
	Fri, 29 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AemNGQk5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C88F3314AB
	for <linux-efi@vger.kernel.org>; Fri, 29 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485601; cv=none; b=ZRXbedfJLUbx7DE/3vLkKr5utSLKhSL9CgHqMXW9Ph9ALDRYdm6PPYT7WxfLwH6HREy5p18gpI8VKOjtaTr5qDg9M6PU9IVcu6CyQJPcP56OefhO9TCom4IOvumRNAUv5nWaXLpnxS9f0ttCPEWMWqL/m9C6Uq58oZ9UJRReqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485601; c=relaxed/simple;
	bh=Mpr0au4E0BGf+QWb4T/Hs5os470z/N9ItCSFpXKyyx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ThXoCU/5WhjgqlQF+LefooEJfJd6IceS3LooN97kmP95i8/3fz8mkSqfwSLr4xAKtmlj00AJyu5czurVDRvlkI21Ktn6xXWZGdntMz1dTiIfYVPDGCP1lNjpGC0O/i3iwK0mRlkgZ7Wi5BtiMB5ytT3azjPqiVthv1sR2l3zJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AemNGQk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32515C4CEF0;
	Fri, 29 Aug 2025 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485601;
	bh=Mpr0au4E0BGf+QWb4T/Hs5os470z/N9ItCSFpXKyyx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AemNGQk5jrarEiBph7TvoqUsrqFD+3jS3nLxdt0LWTuCtAXSobgB9tKgYq5KuMK/1
	 Ax3d1GVqp3CcXNkNM/m9vkMRojqvZBtpR/T5B1Q5jZkEj6kiriFTqHZKDF7KtKfzK9
	 yUwkZVTQ2synodFUgh0HOl4Eo5WYhK6ENDqaWEkLv+FoyJ4rGuUdBik1zgfJyErmEG
	 hxyWxW+hupM/qyDna35fT7H6oI0vhTcWu5HmavvQyR9W2e07OhtK4omTOiaSV2CHf7
	 kSTNEKSCQ2uYyED648SxKVqSmSIhiMraQfHyeVogNJzwUAt9SuiBADbrOQTLh1Y1+g
	 Wb7iHlROCdcIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36606383C24E;
	Fri, 29 Aug 2025 16:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.17 #1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250829151849.2602707-2-ardb+git@google.com>
References: <20250829151849.2602707-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250829151849.2602707-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.17-1
X-PR-Tracked-Commit-Id: a6358f8cf64850f3f27857b8ed8c1b08cfc4685c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb679c832b6497f19fffb8274c419783909c0912
Message-Id: <175648560759.2275621.12213569265237113393.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:40:07 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linuxfoundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Aug 2025 17:18:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb679c832b6497f19fffb8274c419783909c0912

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

