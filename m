Return-Path: <linux-efi+bounces-381-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC29829230
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 02:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F2A2842C6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657D3F8D4;
	Wed, 10 Jan 2024 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7iOCMZA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDF3F8D3
	for <linux-efi@vger.kernel.org>; Wed, 10 Jan 2024 01:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46757C433C7;
	Wed, 10 Jan 2024 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850270;
	bh=3nlHGpKKKcrj9L6Q1sQfIiYWPyDwY2mIEUsk2Vc93rs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q7iOCMZAY9apg2eym2PmhBFK5m7EvP+vnliABMBQe6Yh9cAg0tnyTatA1mYkEwn61
	 09q5ZaxJaxkvedMZneppy9quLCZKoMLWE0L2vbZmjnAAv2arSuc4iCYTr3wS5gBHlF
	 +iif3c2ZRX7qYsoJrLBlECyH6y3kFPyuLa6ogPW0SjQ2SssTqFsuZnKevi/3gHDkpy
	 m8/j29V+cIDQHgN9lF/4x9i9psuUMpzyoTf6OlOmI+YBvb9IwRZTpic2WxfD3UO7Ry
	 tH7yI2LGOHWCQy96c2Lbk1983Y0E4A5hkr/65pCBircfTWWopGr6/lQCRG5Y+yP6I3
	 zBcK1qB/tnrSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36E13C4166F;
	Wed, 10 Jan 2024 01:31:10 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240107114345.3415677-2-ardb+git@google.com>
References: <20240107114345.3415677-2-ardb+git@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240107114345.3415677-2-ardb+git@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.8
X-PR-Tracked-Commit-Id: 4afa688d7141ae7a166d32224abbfd536acccfca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7e4c6cf5bbbd8fea2be1cef0540e5cf107c43c2
Message-Id: <170485027022.7649.4715678466607364959.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:31:10 +0000
To: Ard Biesheuvel <ardb+git@google.com>
Cc: torvalds@linux-foundation.org, linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  7 Jan 2024 12:43:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7e4c6cf5bbbd8fea2be1cef0540e5cf107c43c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

