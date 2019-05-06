Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC3A15679
	for <lists+linux-efi@lfdr.de>; Tue,  7 May 2019 01:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfEFXkH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 May 2019 19:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfEFXkH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 May 2019 19:40:07 -0400
Subject: Re: [GIT PULL] EFI changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186006;
        bh=V4ixEGbonExk2RLE1nQcGlQFE1f0NK/exeq9Pp+mjAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E0ZtzNJkUHgLHznRrL2ZrTTlwJROiMl9pybANJJwNEDywkTKdLUfXD5jVy0R8/BoD
         CvoinwuST5A0oe0ALOWv1xIKJby3GsRVqQT1TQSV/KDB9IyXm/fHhoQ96+geZOQUXX
         1CoGzvEa8oQg0j5DomDCKJLjbFdjVIxdoUa54qcE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506081759.GA30024@gmail.com>
References: <20190506081759.GA30024@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506081759.GA30024@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: 02562d0ca1084a688ac5c92e0e92947f62f13093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d90dcc1f14555c62a32bc15c86c66d1d5444b5cb
Message-Id: <155718600656.9113.10517083269940973115.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:17:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d90dcc1f14555c62a32bc15c86c66d1d5444b5cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
