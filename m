Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125B4123582
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2019 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLQTUN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Dec 2019 14:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQTUN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:13 -0500
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610412;
        bh=YC2mwblfonfwCfIN4f23jCrobWP1I2pR9UzwrZsnwlE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FrRcT6Su0VG39Lx1Fu0GVLr0uyDZWsZ88brFn12nZ1XBGiF0PCEgMbYnv9YVT978X
         DzxkmB2bhuLxaVQkCMmgVsx9VGjY5fxKdOn2uWjpNxkZg3lZHCkLC59gJw05qr3LLB
         kJpDyoVWpVBNf6merXt0u7zR1upwJNpBHiwdiE1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217110942.GA55641@gmail.com>
References: <20191217110942.GA55641@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217110942.GA55641@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: a470552ee8965da0fe6fd4df0aa39c4cda652c7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a114a18c7dbc2b7ac5a1379a8dcced6095c52ead
Message-Id: <157661041253.14288.12273251815906584485.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:09:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a114a18c7dbc2b7ac5a1379a8dcced6095c52ead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
