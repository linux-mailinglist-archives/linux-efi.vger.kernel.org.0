Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDD63F869
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiLAThX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiLAThW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 14:37:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DCB89
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 11:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180A362102
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 19:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C501C43470;
        Thu,  1 Dec 2022 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669923441;
        bh=qpS5cHuOBRIS5CZ8cOfSzQttoO9PhY9PijoSuUbyk4E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KcZ89aiaNZthTNaGx/jJqcvlTORxFt6kX5eRx1vB4ZFiqBi+jKzLV6Cn9DCWMSZMx
         4Cruv+1UlUZSrBmg1chaD7LHwZiTN1PEujfIl34WDdm/DW6m6ZmGB7z7ppUQb47EJ8
         +tMZ9y5WhaxEkiFLtKkFHahSTEILyxYNdMqTBRgaf6Itcma+tBOvJpcxtTbqu4GZsF
         i7bI3ExZwfUU9VvnaMPSR+4eCopS0YVo0wS1MumJVlLbZarwRrCfuGxUC+V00721pM
         rAy7LK7MKt8cFifuFhptunT4lr4syUhA4ruQPbpkS/oKBhSZcnm5e9HEgVE0F0xUnN
         iY+oufj6XLN2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AEDBE52537;
        Thu,  1 Dec 2022 19:37:21 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v6.1 (#4)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221201180725.3063485-1-ardb@kernel.org>
References: <20221201180725.3063485-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221201180725.3063485-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-4
X-PR-Tracked-Commit-Id: 7572ac3c979d4d0fb42d73a72d2608656516ff4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 355479c70a489415ef6e2624e514f8f15a40861b
Message-Id: <166992344136.6584.17945436284327484874.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Dec 2022 19:37:21 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Thu,  1 Dec 2022 19:07:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/355479c70a489415ef6e2624e514f8f15a40861b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
