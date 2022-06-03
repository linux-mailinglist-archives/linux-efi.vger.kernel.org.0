Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4253D354
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jun 2022 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349490AbiFCVtp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jun 2022 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349676AbiFCVtj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jun 2022 17:49:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB00583B1
        for <linux-efi@vger.kernel.org>; Fri,  3 Jun 2022 14:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E0DB824CE
        for <linux-efi@vger.kernel.org>; Fri,  3 Jun 2022 21:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF199C3411C;
        Fri,  3 Jun 2022 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292972;
        bh=TJ/nYzTQixZKqcqFAU2ATq7VK50okAP5ZIURWT3pI8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b99SmQVR1kEC4Jmhj8J8l3U2d0tUDNfvbdt3D+b7mm4OMdmLjarkuuTTnN1Pm0MQK
         cUOYY0pjjrrQViPmU99XKo0RL8n29YH1sJ4VH7UH9KZ4TWC/1dHS4fuCbV9u2z4kG5
         hW/3Y4O5JOmu/yIEDOtYeEIFxFmqsmToq4rsujy2MFjupCBpgKegLW5zk/e8nr6Z20
         QgamOU68wcPWgTYj6804ZyLBXupDfV3jVP62PMYydYaSU7kYVIEgcGISFrZqkUi09a
         UuKzINYcoGbXh7YHexu3NHfgFe/ezw6vB1sZ9ZvIjPWZUA9rWMGON1kxfXjsGKq8Dq
         K0baMBV/7+cIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB66F0394E;
        Fri,  3 Jun 2022 21:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v5.19 #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220603084910.130410-1-ardb@kernel.org>
References: <20220603084910.130410-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220603084910.130410-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19-2
X-PR-Tracked-Commit-Id: 75ed63d919400b803691a0c757ee23c6f767a625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93ce7948e38ffe6f9b4fd403c94c098bd892a5ff
Message-Id: <165429297269.7657.5019480201845294928.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:32 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri,  3 Jun 2022 10:49:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93ce7948e38ffe6f9b4fd403c94c098bd892a5ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
