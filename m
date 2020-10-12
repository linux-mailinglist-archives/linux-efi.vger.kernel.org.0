Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55C28C3F5
	for <lists+linux-efi@lfdr.de>; Mon, 12 Oct 2020 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgJLVZC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Oct 2020 17:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgJLVZC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:02 -0400
Subject: Re: [GIT PULL] EFI changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537902;
        bh=v+9f3MPB8yW4vIYi4dycKGmdotoC4gZ0eWWxB2CM1eQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hrX1EYA19UIv9KBvsHIab2fYgpjpqSi8w/hQtAI6czwNu5lkIS2feFTm6XSVpYeUO
         KYkORhNAGZf8qmmd4dok6Qn0X+cykDdy6OWXaubSZXpdHdEUEOdk+nY5QWZVXVzFNb
         Og0JRQiCe6dPmVOD+5pTu6BMDFEDyd0KuouOhdys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012152119.GA3476595@gmail.com>
References: <20201012152119.GA3476595@gmail.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012152119.GA3476595@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-10-12
X-PR-Tracked-Commit-Id: 4d0a4388ccdd9482fef6b26f879d0f6099143f80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6412f9833db23740ee848ab3d6e7af18dff82a6
Message-Id: <160253790214.926.8020408319776197944.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:02 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 17:21:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6412f9833db23740ee848ab3d6e7af18dff82a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
