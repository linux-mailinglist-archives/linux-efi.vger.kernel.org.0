Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFAB4509
	for <lists+linux-efi@lfdr.de>; Tue, 17 Sep 2019 03:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfIQBAW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Sep 2019 21:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbfIQBAW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:22 -0400
Subject: Re: [GIT PULL] EFI changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682021;
        bh=xh7OMPh/XeA91mjrPGOfWB+Ju+MvKdz9jJIN7Zmaviw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e8XQbaYPNhI7P7p6W5fwo/0mRBnrxn2xL515q3gLq+4IMx7B+3jtqFV/aTQwJzxuT
         UuoTODEPSep5L+0YYKT6JP7GMzxYkxBbfEanLh8lrzJpe+/zg2OfDjjZgkdDLgPO8w
         J2ZX7hd2FwNmLjZcdTrCvT8g1OZ6MGqGB6D7tavE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916113549.GA76922@gmail.com>
References: <20190916113549.GA76922@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916113549.GA76922@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: d3dc0168e93233ba4d4ed9a2c506c9d2b8d8cd33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc9b499a1f71696054a2771aae504c53eecff31d
Message-Id: <156868202161.3683.5524767636770902438.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:35:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc9b499a1f71696054a2771aae504c53eecff31d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
