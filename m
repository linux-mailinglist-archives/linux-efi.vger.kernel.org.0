Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F53B6929
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhF1Tgq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 15:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233400AbhF1Tgp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 28 Jun 2021 15:36:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C7E9061159;
        Mon, 28 Jun 2021 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624908859;
        bh=tuRK/zQbf/RypvBYyUyoaoWu0hUI2sQo6BeiG7kLDc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nQejKnbUlZufD08E4Lk9iyaGMVwITGJuFVFu5gV3DC4akvkXB+2JRpkG4/64V5rAU
         x+We5aULd67up2cUixUGat2oGjgDcS9x4R9gLvJPKXaMglj+b+eZ43vHljyprZDd7E
         PCbr4A6vie7WMTZO+UlfqaRA5IrEv6TO36MVf9KfN0loPFjcjyrwdc+lTNH4l4fEIf
         Ma73gt2F6ozzWeaDHYLSrdx9Gdxad8f7a2LITdm/2rXHsHMG24LQXUnJm1UKmvWMvc
         g42J6qos28DOZLPRsvg/wDsBBLq+uzjvDCwO31tBx1MeSzvfZwPaIwSzS2uWUBm0NH
         iyIH0Q/Ra8N5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B250960A71;
        Mon, 28 Jun 2021 19:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] EFI changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNlh7jolB04h6z0h@gmail.com>
References: <YNlh7jolB04h6z0h@gmail.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNlh7jolB04h6z0h@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-06-28
X-PR-Tracked-Commit-Id: 267be9dbacf4485f7842a3755eef4bb68dc85fc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6796355bc49b625a701389c954073c4e5dad4381
Message-Id: <162490885966.14456.18067682055462127960.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 19:34:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, peters@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-efi@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 07:45:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6796355bc49b625a701389c954073c4e5dad4381

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
