Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA71531625
	for <lists+linux-efi@lfdr.de>; Mon, 23 May 2022 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiEWTe3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 May 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiEWTeX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 May 2022 15:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E314030
        for <linux-efi@vger.kernel.org>; Mon, 23 May 2022 12:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C7A4B81262
        for <linux-efi@vger.kernel.org>; Mon, 23 May 2022 19:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F36A5C385AA;
        Mon, 23 May 2022 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653333607;
        bh=C8eF1/10TLX/B3hLzzd98rzbNbIzg+7gt4DqWVqc76M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a0ouo1ehzrA1IR3m/rLptT4dBJfMLBBuNlGSjgLqsV50y0TB5Z0aAkg1jHoOp8hcM
         UiJnwQ3D/T9W8cP+kYyIzPpw6Ngo5kq+tW4wZHpeWQrsjAIqiiaKrydHNDA8BDcjp3
         ADLRlmoqYfQdVS4KBoU2JGURaGT++IN7tEYzpaSdTIfnAWAHIMl6UUA67dAJCfphbQ
         0bKejJevzKeCo1LjUzpJwf1+P9j8m9F68KB57cYhRw0oBl1l7K5MvZDkZMieE5C4jQ
         T55x2XZfyJ2F6Rm36v9yuYw6kqnwjj+Hq9RXzGFPMqRrnc6W8CsQHY5VkdNtHQySP3
         lB3duNFaeh0Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFD91F03935;
        Mon, 23 May 2022 19:20:06 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520083946.549534-1-ardb@kernel.org>
References: <20220520083946.549534-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520083946.549534-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19
X-PR-Tracked-Commit-Id: 3f68e69520d3d52d66a6ad872a75b7d8f2ea7665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf2431021c8cfe52c866d7bf640ced03a35ebe91
Message-Id: <165333360690.1924.5881232796237315482.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 19:20:06 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, torvalds@linux-foundation.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 10:39:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf2431021c8cfe52c866d7bf640ced03a35ebe91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
