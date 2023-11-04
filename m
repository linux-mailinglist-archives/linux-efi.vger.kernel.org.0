Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54D7E10AA
	for <lists+linux-efi@lfdr.de>; Sat,  4 Nov 2023 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjKDTBh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Nov 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjKDTBg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Nov 2023 15:01:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B8184
        for <linux-efi@vger.kernel.org>; Sat,  4 Nov 2023 12:01:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26552C433C8;
        Sat,  4 Nov 2023 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699124493;
        bh=FzHwVwA4vRgqfUktqzK7Wbra3zxB+sWCMEx683ImGPQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P4hRWF6p9K4EuCiBra2ftRe8ct//FXd/Dh2TEhXAfytPimxo3Eby4On0BN0KAZTMA
         zcfnSLQvWF2dRAUgdN+PgUOHBaG+v4ef7zTHQBo+R6Dy+cfww2zsskP2j1JswXehCz
         86yy8RqVUVzxkXpjXgg/Q5D1b38WRvN0vC/hpOL3wm9s0yYwtNrSLYpDYhmOX/Me/b
         zMUr3rT4yl6mCgVvgrZ38OxawYFyOCkSiF7RYoXBlo3eCcLvS4n/rFGKgKnDyjps/g
         ZYerKr4uywTMfUfAbU1qg2jBImZK9OmAGhtQt+hyUi0H/47oWJGyvNYSk+3DADnlg8
         dojVOjNXQdCIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BF38C4316B;
        Sat,  4 Nov 2023 19:01:33 +0000 (UTC)
Subject: Re: [GIT PULL] EFI update for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231103225829.427073-1-ardb@kernel.org>
References: <20231103225829.427073-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231103225829.427073-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.7
X-PR-Tracked-Commit-Id: 5329aa5101f73c451bcd48deaf3f296685849d9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c975a43fa380676828321ebe5b662c743c14d9e
Message-Id: <169912449303.2096.3794161734218779054.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:01:33 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri,  3 Nov 2023 23:58:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c975a43fa380676828321ebe5b662c743c14d9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
