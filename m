Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B004F4423C2
	for <lists+linux-efi@lfdr.de>; Tue,  2 Nov 2021 00:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhKAXNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhKAXNa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8420860EE5;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808256;
        bh=9C0wTVSJ7NMBI80NS5DZ9QjEat1Vfe5bIHIn17RMU0g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cdSrFwb5TAppZUS4G3NfU5Yqe0iG2kxtAGGVxT+wUGSsRtoxK1u5N25r4B9fpDwdQ
         YTNMppVsm4RSAUpPTPoQd4K655MisDyL2k6RihTa4u8kwAZVOl56xckALCIc0HBc7A
         DOnHnco8yITs2ga9UkN0FeJlHuhr1MfCEgfQzWadvcUFU5Br1yvkznUT0+dCiCx0vM
         47B92PdK8XfCghs9qGD/cmFUdw22gCkDyWkyqEUC/7IYe043WtktjPCvuuGZyA+rgb
         cYjmBF7A9minuzglUnGZTpe5XGvcCycj9s2Yjpoel7EAfOHs262yM5HIgktR7H8HUp
         kZl+Jgzl7D7fA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 762E4609EF;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX+xIaS0R2F9HJwr@zn.tnic>
References: <YX+xIaS0R2F9HJwr@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX+xIaS0R2F9HJwr@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-next-for-v5.16
X-PR-Tracked-Commit-Id: 720dff78de360ad9742d5f438101cedcdb5dad84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93351d2cc99643960f3931bcd1fe21ae7e5c6ae5
Message-Id: <163580825647.31036.2631945165217193139.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-efi <linux-efi@vger.kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:19:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-next-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93351d2cc99643960f3931bcd1fe21ae7e5c6ae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
