Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C396D5316
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2019 00:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfJLWfF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 12 Oct 2019 18:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJLWfF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:05 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919705;
        bh=/7o2qmc54YKDZd9/+fl9cBiJguaPlhmAXlQAccqkwlM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WGIhG9bkzaR+ZjH45oHcnnaYlxqgEhDBXshqH/27N6N5uoB4G4kyuerCUP8C3wlGe
         TGtbcz7fOPxFWmVzvxuyDpeBf6Imnx9K0u1N2J3Yczjq8XM70wLkJFM7H3Z26MjJOr
         S/12jmpu7j8x5h9LwOePSYbPaR6ggHqFA5Myfkak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012130139.GA10386@gmail.com>
References: <20191012130139.GA10386@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012130139.GA10386@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: be59d57f98065af0b8472f66a0a969207b168680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b4e40c8fe1e120fef93985de7ff6a97fe9e7dd3
Message-Id: <157091970525.17047.18085630474579119447.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 15:01:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b4e40c8fe1e120fef93985de7ff6a97fe9e7dd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
