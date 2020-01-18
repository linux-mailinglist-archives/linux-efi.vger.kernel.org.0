Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB31419C7
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 22:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgARVFf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 16:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgARVFE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:04 -0500
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381504;
        bh=osQUPtdZ2mbiAICI5lFxqdp7H2BusgDFxZzwmxSSWt8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=addUXvQxmRIpRpP1PEoxdSbhPxoenhJrVBfjYO7oalw6b+dNrAFgbw589kVlMqn3O
         6J3Sem3wrpQKVm+NuRbX8pZMEMRjYmhrxohcIOc3rjwBtvQ8h5M2lyc0PePe/5hZT+
         6TVH1nc1yz1CEK8ufaVHeunEKw4B90TldG41cH2g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118171633.GA28490@gmail.com>
References: <20200118171633.GA28490@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118171633.GA28490@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: 4911ee401b7ceff8f38e0ac597cbf503d71e690c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2f73d1e52a5b3c53f11861f31d726168ca92ce6
Message-Id: <157938150426.20598.17098019340095864469.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 18:16:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2f73d1e52a5b3c53f11861f31d726168ca92ce6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
