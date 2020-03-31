Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498541988E0
	for <lists+linux-efi@lfdr.de>; Tue, 31 Mar 2020 02:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgCaAZM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 20:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbgCaAZM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:12 -0400
Subject: Re: [GIT PULL] EFI changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614311;
        bh=qmjVMTALva3Ty3VJ3cqURWmfUwLLZvsliMgSCgXM4Bo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ap1UVwaKfsld0SYLLnqWURL/smWrQAIn79nr6XoGMzW6Rqpr5/Qvd71tHwMv0g1GV
         6LsRvjgagjlfrqrwmbPpUzi+IGqzCQ1ZHnRSdxZX7Vd/ZPQGpAY3CtVQV97mJJMbHu
         NA9dRjU/m5boIhBorVWNsZvjRmZ8kI+uphW4LOmU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330134803.GA45544@gmail.com>
References: <20200330134803.GA45544@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330134803.GA45544@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: 594e576d4b93b8cda3247542366b47e1b2ddc4dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a776c270a0b2fad6715cb714187e4290cadb9237
Message-Id: <158561431155.380.2255359141342403392.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 15:48:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a776c270a0b2fad6715cb714187e4290cadb9237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
