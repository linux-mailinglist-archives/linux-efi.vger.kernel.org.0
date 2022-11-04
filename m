Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84961A4D6
	for <lists+linux-efi@lfdr.de>; Fri,  4 Nov 2022 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiKDWvs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiKDWvg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 18:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C0554D9
        for <linux-efi@vger.kernel.org>; Fri,  4 Nov 2022 15:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43C46236F
        for <linux-efi@vger.kernel.org>; Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 334F6C433D6;
        Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667601996;
        bh=Ck25/hk4jXhCO+s3VQKD81TyRjyG7/8d5myL6bf4wJo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sHZ3S22OWyey8yn7lt5V9tsmvbul3Q7mznDKeOg9ndRktD+1XqLfcKPBgaiisGmiE
         3LYoBb3EQp3jxte0foKglboAkPFqjFfxFmi++oTOXvKACHnWkdyRPqz8J0E7UZSqOw
         cRe5h6UP3oNzr+kx/ZYhsRWMQnwxus5RSWbTqDJiig2lwDAki5YHswSvB56DTzlBI5
         P4R0fpCt0YipaeTD4U+csoEA5tCFo/6PvkVSlwVtNaU0X5YXzi3lnJP5k3ylLkbHrW
         7Ll3MZVoLxLg/gHBvEcRgnyi+gfG/8pH2jxusjejQUx3effxCeecixZ3bpV1tqyJkm
         WDks8ecmRYfFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11A91E270FB;
        Fri,  4 Nov 2022 22:46:36 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.1 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221104165149.2397431-1-ardb@kernel.org>
References: <20221104165149.2397431-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221104165149.2397431-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-2
X-PR-Tracked-Commit-Id: 23715a26c8d812912a70c6ac1ce67af649b95914
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1caa2f182afb59de9d6d5ba64b340df011a0b653
Message-Id: <166760199606.25569.3238482132922105154.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Nov 2022 22:46:36 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri,  4 Nov 2022 17:51:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1caa2f182afb59de9d6d5ba64b340df011a0b653

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
