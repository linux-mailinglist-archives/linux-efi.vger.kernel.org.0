Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E36EC8E6
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2019 20:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKATKF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Nov 2019 15:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfKATKF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Nov 2019 15:10:05 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572635404;
        bh=LZMtYNx+7eyqin0/yeV/hoXlKA1+gz2jHT4i56tlWfs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JA8thxWu/SDpKoMS2OPD9M0E4YOAiTPFzdwXp3pLoZ8fGNMqghuXkcp1AD9MpmLLV
         IRh31HOraMaI1LCHrT5RklClbIgunNBHv+2UB9yH949+C1ac4vM4xbIFjNTIN1Wnsw
         2x+3MegqPByGLYDL3jX4q3IcvEGHuU/N6UR/p0jE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191101174300.GA33878@gmail.com>
References: <20191101174300.GA33878@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191101174300.GA33878@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: 359efcc2c910117d2faf704ce154e91fc976d37f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2a18c25c73f30316eb356e915f4c9cc58ec42fc
Message-Id: <157263540467.17460.14925099456453241443.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 19:10:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 18:43:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2a18c25c73f30316eb356e915f4c9cc58ec42fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
