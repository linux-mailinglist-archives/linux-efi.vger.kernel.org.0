Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D16F2744
	for <lists+linux-efi@lfdr.de>; Sun, 30 Apr 2023 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjD3Aw3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Apr 2023 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjD3Aw1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Apr 2023 20:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4B1BDC
        for <linux-efi@vger.kernel.org>; Sat, 29 Apr 2023 17:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BB66124E
        for <linux-efi@vger.kernel.org>; Sun, 30 Apr 2023 00:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF5D5C433EF;
        Sun, 30 Apr 2023 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682815945;
        bh=dv6WKyXWPrQ76SrDCpQyx1boQrLu64iqLdC+0n2qDCc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H0lQTD7GD21jklcPyhJfbc1tyGeCIuzBIa5TE5zjcv97hv0esdU0LWuSDOXdcIuGt
         KBIiJ9gLqH663OmGLcDSnZDLfhPwoEwJD8Y/Kgkss2meLdhZuGn6QF0madJignA+tP
         W57ZlZQ8khAtLiKWzsJoVbzc7FejMgmXmCtbdDW3gUZVyfrSpXBspOs5fxAYZKB6OB
         jyBQx8eov0fCQKPxyEOV74ezS7Iis72vr6YyI+iZ7h0RF7xVnSB50z0IXiurE7FnFm
         +n7/yy+3ybgRn7qGoYnSQcyMsYzXXJLdyQiE6LThjwylQJNonmer/aIvjbVxVmWHFy
         vsOKgAtPdl7fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCC69E5FFC8;
        Sun, 30 Apr 2023 00:52:25 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230428201741.2580061-1-ardb@kernel.org>
References: <20230428201741.2580061-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230428201741.2580061-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.4
X-PR-Tracked-Commit-Id: 026b85796ab4d52af56f8a1c60d2613983ecd845
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 825a0714d2b3883d4f8ff64f6933fb73ee3f1834
Message-Id: <168281594583.341.6047956163985083978.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 00:52:25 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 22:17:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/825a0714d2b3883d4f8ff64f6933fb73ee3f1834

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
