Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5191560831E
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJVB2k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJVB2j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 21:28:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670662A568A
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 18:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 174D8B82AD9
        for <linux-efi@vger.kernel.org>; Sat, 22 Oct 2022 01:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C85EAC43470;
        Sat, 22 Oct 2022 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666402115;
        bh=h3TA+D2CfnPM2YsnFDJipVUrleeZT7lEGE1W1i3Dq8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JxYOHgU2wx0eUa3m7lA9cvpHDbQtFlm0/LKYe1ICxuVg2LAVFDLSL1dbY5t/FtoUR
         aktajvqN3tYOTBHRSe9UG9z6lPD/RWSKa0+2xSPbGo3lWnU1hkOm5fMDXuIFVHiKz8
         7mrdgcnWNGqAFej/G6HJr3feB8hKMIB4z7BKaETcGCJvV/onW2MlGhcrcyqfTHhFxj
         4KZOMXgGTNWdHys2YtZebnbRqTSP+2eWEZh9vtzXruTypkQxzrQoWwTUvs79egr6eb
         BzV7IeTOKOMWVuyz88dSGA8pZxgwQh8js3ekcN4RHP3u5oIerNBvzul5LVcU+ZbUHz
         DMJzYeaO9BMwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD980E270E0;
        Sat, 22 Oct 2022 01:28:35 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.1 #1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221021154045.2848205-1-ardb@kernel.org>
References: <20221021154045.2848205-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221021154045.2848205-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-1
X-PR-Tracked-Commit-Id: 37926f96302d8b6c2bc97990d33e316a3ed6d67f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec4cf5dbb1887adadba2f7cbe8131facbd27a5d5
Message-Id: <166640211570.11783.8688934449144396570.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Oct 2022 01:28:35 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 21 Oct 2022 17:40:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec4cf5dbb1887adadba2f7cbe8131facbd27a5d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
