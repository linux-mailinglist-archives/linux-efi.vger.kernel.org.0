Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453C5B1D02
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIHMbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiIHMay (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 08:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D138113650
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 05:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7055561CE2
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 12:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7A50C433C1;
        Thu,  8 Sep 2022 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662640251;
        bh=RD03O3NTLULGda+SMzmdALfRb7bsve7wcNF0KXusaUw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LluPKC8tnEidq/y3A+h7ywUoWjpqI+ZBWEEINpy4l7AaLyH+IAGDhrE9cB9yAcPEG
         QSOXSkoPLGw3nQGLjNhSLA7G8Wom19xxzBYOQ0Cvq+g7hYOXoEBewTJosa5QfqvpK1
         C8Vp4+Qt/gvgrq7eJt0CjagTHwLCaDvqdwv+SkknI0p7M+gXcC+zP3z9/FTDTDhqxI
         wURYjH6EDvaxueEQo78cYW9Nt00w05D7dghnNoH6CKGHn2H3v9yQdJgx4p3NsMNPry
         WR5j4iFrYWcZh1o1yeQJ3Wmg0G3s7rkZdV0dMPV2UhWDNHtQ64njEmKsvULLMeMXiW
         BmtsMsPx5aaGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF772C4166F;
        Thu,  8 Sep 2022 12:30:51 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.0 #1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220908104359.1416858-1-ardb@kernel.org>
References: <20220908104359.1416858-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220908104359.1416858-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-1
X-PR-Tracked-Commit-Id: 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f280b9872af1f58760b7731e973de57ffccfb0a4
Message-Id: <166264025178.22641.5492555327107927492.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Sep 2022 12:30:51 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        gregkh@linuxfoundation.org, Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Thu,  8 Sep 2022 12:43:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f280b9872af1f58760b7731e973de57ffccfb0a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
