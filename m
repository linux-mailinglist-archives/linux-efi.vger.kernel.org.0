Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF67D24D4
	for <lists+linux-efi@lfdr.de>; Sun, 22 Oct 2023 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJVROO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 22 Oct 2023 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjJVRON (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 22 Oct 2023 13:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC1B0
        for <linux-efi@vger.kernel.org>; Sun, 22 Oct 2023 10:14:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D799C433C7;
        Sun, 22 Oct 2023 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994851;
        bh=MkFgxAFuLdn1ad8iGm+YdDSskPyY10MykIsmn9c4QVA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JHpPaTkL/xxfYObMYkOaXJPOym6+Q5g/2k+NiB2CTzf9abZ+elNCd/5ycOTOc63LQ
         w3A9LMcqJk0HZp1SjQ1s1XJgplFq4nMELyuawRoefmHnA81ofm1tGBRK9bTkP63zgw
         6gDOStt1jH1iVoLBVflofZULmFjAf5ivLG662JwDCsyJJvBepBHKJx0ubm41ArsxkA
         EVGfdwCsJn/vL0sAgBQoLUtLGBhQHpbVlECiUM1jORHUWbUOmoKy/wn43joRCoXKRK
         EeVZ3GBbKZkjfyUBTOLwOv1jYwQT/WAGB9C1ZSp57sDbXgL86prkJ5fiIhVFAAjul6
         7hODlyCWUb6qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EF45C04DD9;
        Sun, 22 Oct 2023 17:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.6 #3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231022161846.28311-1-ardb@kernel.org>
References: <20231022161846.28311-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231022161846.28311-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-3
X-PR-Tracked-Commit-Id: c03d21f05e76b25f907684bdf874308dcefab385
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70e65afc23b7670b775f0f086b9acd59b7fc4343
Message-Id: <169799485111.21820.3350625425440640584.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Oct 2023 17:14:11 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sun, 22 Oct 2023 18:18:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70e65afc23b7670b775f0f086b9acd59b7fc4343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
