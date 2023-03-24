Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F86C832C
	for <lists+linux-efi@lfdr.de>; Fri, 24 Mar 2023 18:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCXRRV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Mar 2023 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjCXRRC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Mar 2023 13:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4561AE
        for <linux-efi@vger.kernel.org>; Fri, 24 Mar 2023 10:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EBEA62C18
        for <linux-efi@vger.kernel.org>; Fri, 24 Mar 2023 17:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73349C433D2;
        Fri, 24 Mar 2023 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679678151;
        bh=gfYUq2k+1iMjsL73K4HLyc037lcVe380oTye0UGEB4A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gmvHCMzNWUeGaV5plECAm4q7i1K1y3cf7CoAD0SImfBl0/mC476fyauRw83t2iLMd
         v4Qg8MhF0Tdcg9b+nutrsnEOcjYEQFude4vRZn6LWi7tN5y7eUbCdfaWigwxGA+dYp
         WUeAzgdt1vh6PX+lQ+LDMF0316yRDJ2MraD6xLZf1PKQJp5b4W59biXsmpsJSu3bVk
         pdeSRQeVbyb37ig1SjzaZZ2S/v5rCKTUH747EeHZC0sIOcnoYnSuFexM4y0yaXf5Bx
         48l45FU95jNew/qMFcbw6iDrm3OyYnb0WMRsQUezSB8tfTBDnLalTzjmF0GGf+54LT
         PVVrrVbnyELvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58774E2A039;
        Fri, 24 Mar 2023 17:15:51 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.3 #1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230324163319.1664833-1-ardb@kernel.org>
References: <20230324163319.1664833-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230324163319.1664833-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.3-1
X-PR-Tracked-Commit-Id: 0b1d9debe30304f35c1211e6dcdca1935ce67240
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 877c20b1042535d79f9806095b03fdb082095532
Message-Id: <167967815135.905.7626662890493339332.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 17:15:51 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 17:33:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/877c20b1042535d79f9806095b03fdb082095532

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
