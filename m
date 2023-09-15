Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8157A275E
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjIOTrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbjIOTrW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 15:47:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0E1FD7
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 12:47:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B560AC433CA;
        Fri, 15 Sep 2023 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694807237;
        bh=m6QWimw7acVK6qtQydtGi4nI7hf7Ldj8uir4QJl4WRs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aJhVkjO4ee4KGHwzp/+4NT8pxQErHnROHrKn/1Wa0xzF6UggG+MjAqj0XDbR6OZe0
         jjwutGR6gSe7ZE+rI9yMw5/CEcbyhFeHgBtm2MI61ZQFVhgsFwMsZ/zBG4hdQ10GOJ
         njZ0IOwAdEKnaUtwYChhgrWCDVbV2aa24yJGjAkOaD2iuqgj18R7srA4fBK/5aEhts
         cIYhlqY/kx/e3aggll5rAWAH1g0Q7D9cRmiqz7x4nAVakREK80S5wvl7mQ7uK4IhCT
         A80kVerYlKrsy6XI/RlGnI22qoIjW0uEC5DcLxpOifvWu00FmbGeEnATEC2jaam6hn
         jF8L/3ce6bpPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A20D6E22AEE;
        Fri, 15 Sep 2023 19:47:17 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.6 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230914200126.266849-2-ardb@google.com>
References: <20230914200126.266849-2-ardb@google.com>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230914200126.266849-2-ardb@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-1
X-PR-Tracked-Commit-Id: 79b83606abc778aa3cbee535b362ce905d0b9448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e42bebf6db296d7fbfb3dd6782977d626e94031e
Message-Id: <169480723766.21547.9204467441406280201.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 19:47:17 +0000
To:     Ard Biesheuvel <ardb@google.com>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Thu, 14 Sep 2023 20:01:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e42bebf6db296d7fbfb3dd6782977d626e94031e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
