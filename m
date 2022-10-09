Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F45F8EE6
	for <lists+linux-efi@lfdr.de>; Sun,  9 Oct 2022 23:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJIVRv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 9 Oct 2022 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJIVRd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 9 Oct 2022 17:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C17BE2B
        for <linux-efi@vger.kernel.org>; Sun,  9 Oct 2022 14:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF5860C6F
        for <linux-efi@vger.kernel.org>; Sun,  9 Oct 2022 21:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4711C433C1;
        Sun,  9 Oct 2022 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350234;
        bh=pR/O0dCj7v8fkfKebRyDvYIUcNtdT55p0ZkF4wD09ro=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p+jedHGxy819G5lCXp+seAIpkQzqtRjtNMBGtxFpdff98YgtTzc6g84uNjtUE/C+5
         LCvBaSxb5qA5/ZLKLP4JE/S22/6M1Qm6P9gghzY324OTjGmHKio/sxLByHetKB4K5d
         nF7hS8DXwDyweouDzGnHtBCXbGaPmS9FQmpeAteZyNQ1p+8jEkAhiQSwfOmoArbk6s
         SoD31C39/Fzmx6ZwT6JJcnVarPyOEClx1c/cvUcaW2IIYPCTws0quS4wvKR67K/Iaa
         kIAnhgrwScVeR8pcDWieI3wOT4zGTcYd9Jp+2L0muzqgWg4HL4h7lyrshrBKMZtiLB
         T0ystQ4S6e/uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EC6DE21EC5;
        Sun,  9 Oct 2022 21:17:14 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003115910.973547-1-ardb@kernel.org>
References: <20221003115910.973547-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003115910.973547-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.1
X-PR-Tracked-Commit-Id: d3549a938b73f203ef522562ae9f2d38aa43d234
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e470763d84dcad27284067647dfb4b1a94dfce0
Message-Id: <166535023464.11566.712449809935957380.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 21:17:14 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon,  3 Oct 2022 13:59:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e470763d84dcad27284067647dfb4b1a94dfce0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
