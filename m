Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAC430E83
	for <lists+linux-efi@lfdr.de>; Mon, 18 Oct 2021 06:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhJREKk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Oct 2021 00:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhJREKi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3A18D610A3;
        Mon, 18 Oct 2021 04:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530108;
        bh=eFIIfXUMZ151X4HKeWezU8m2rG7vkphhPY7AbLCKouc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ruFqEkW7GpvVjJSUkSAOXBHhv1kfXreT/MZI30fWXfLHJXFtpwTdQs0EzTK4JUtcE
         X43GZaq0kJ2QU25m7YGPgQ3rq2Ac8C7mqyByBaQnwYUB67PcMbIwwV6GlF1XM3vZPz
         itnFKpJKvrOZP55nE41d6GEYRIB3lbHdCFDo0igaVFGWcAxw3ialpNCIktgGkyZ3gt
         N0pXqOyFqSKyCdLwRACgdKukjxfNFFeOOhbW0kf/a4LUDZRGVLZRQZIcmBi1hubqan
         eCe4WmUWclIXURzhH64BzGMjRvqYHxCCByRwHHF1RCX+juHukc8d/JGm+SrBeRCcrQ
         mTz1kZrLkHmsg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 33A77609AD;
        Mon, 18 Oct 2021 04:08:28 +0000 (UTC)
Subject: Re: [GIT PULL] efi/urgent for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv0fTagC0e4D0Jy@zn.tnic>
References: <YWv0fTagC0e4D0Jy@zn.tnic>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv0fTagC0e4D0Jy@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.15
X-PR-Tracked-Commit-Id: 38fa3206bf441911258e5001ac8b6738693f8d82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 424e7d878cb7a51f446514826a0b9ddbc78ff1d0
Message-Id: <163453010820.24310.15007129835621206171.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:28 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:01:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/424e7d878cb7a51f446514826a0b9ddbc78ff1d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
