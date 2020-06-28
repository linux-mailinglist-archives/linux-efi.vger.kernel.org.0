Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91720CADB
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 00:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgF1WFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Jun 2020 18:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgF1WFN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:13 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381913;
        bh=iqhRGEiW9ARDnsPMCySIHAspKXou38uBnThGjdeAoNA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M4uZ5DILBsxxF3RBEnfWy65zZTzqfHg7evVl1LAcY4bDgpok9Y8mtaV3Wc+c23eJG
         WiZqZqF3xTzZXGD14abnEZG/k3SqVAJKsHZKBvMOUNfW5a3PA+uMVdWzr0p6DoZWeZ
         hE4yTRv1atd9l3hAsvwUuIohwi4E0OlbZJfuBQqU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628182601.GA84577@gmail.com>
References: <20200628182601.GA84577@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628182601.GA84577@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-06-28
X-PR-Tracked-Commit-Id: 2a55280a3675203496d302463b941834228b9875
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc53f67d247a38d43e081faa7e63690a1279f5c7
Message-Id: <159338191320.4690.3507772829588857989.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi@vger.kernel.org
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 20:26:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc53f67d247a38d43e081faa7e63690a1279f5c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
