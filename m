Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC47446AC
	for <lists+linux-efi@lfdr.de>; Sat,  1 Jul 2023 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGAFFX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 1 Jul 2023 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGAFFV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 1 Jul 2023 01:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1DE65
        for <linux-efi@vger.kernel.org>; Fri, 30 Jun 2023 22:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0F860F05
        for <linux-efi@vger.kernel.org>; Sat,  1 Jul 2023 05:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2F6EC433C8;
        Sat,  1 Jul 2023 05:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688187919;
        bh=N3CWONQtLfZbnS9E7mH7aXcuyLY2q/pSPzREe79c258=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P/3SFPsy4My5Wa15+Tq12417VXJBOu3E7t9Lvxit7BBEnK3d81Cq/ZIN0d0+PmHZO
         22fj1XqOw28qkaqnebQPb4Jax35uY7rkBnqXTmTcmO1fD4jkGsIdWxAJqC+PCDMLEI
         g0EF9x/O+n+2v75tBhcfIfIqnhTIXDvxx0vCU1CMwfxFHLWf6SUTltsS914nydQHAx
         tE9PSSHf2oCkZxNV11QYdMhIC52gbx/pIbAjsFSXQJtTNTdq8XtEpLI2e5Dlwn/oNB
         I9Nppxe5NxlWHihuPq5hjzBIX0x23A0ItWRR/vQ5viXYTbI/F3q3T5Bdo895Gdjc7u
         pfT5GyhPzUsHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A64A0C0C40E;
        Sat,  1 Jul 2023 05:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230629232730.1484117-1-ardb@kernel.org>
References: <20230629232730.1484117-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230629232730.1484117-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.5
X-PR-Tracked-Commit-Id: 2e28a798c3092ea42b968fa16ac835969d124898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 937d96d2d567fe0d86a2f39a7f988bf31c66d3e6
Message-Id: <168818791967.30776.13028682858978455444.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 05:05:19 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 01:27:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/937d96d2d567fe0d86a2f39a7f988bf31c66d3e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
