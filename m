Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA5627058
	for <lists+linux-efi@lfdr.de>; Sun, 13 Nov 2022 17:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKMQBq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Nov 2022 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiKMQBp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Nov 2022 11:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E0E0D5
        for <linux-efi@vger.kernel.org>; Sun, 13 Nov 2022 08:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2A060C13
        for <linux-efi@vger.kernel.org>; Sun, 13 Nov 2022 16:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BF05C433D7;
        Sun, 13 Nov 2022 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668355303;
        bh=sJ/Qi5UXNXDB4jik7xUDVILcInO4IlqCw94CBhaawWE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d0A6FNxJGmPam6OdG9M7KwZodYk8HaPOc5Jctjj2ncoVtsqEbKtsQIPgn99Ej6gKp
         Vh0J/Be4677YRP2PPr7PmE9sW1jZub+YXfkiCN+NE21c7dlvchdtBrIpFPd2+VhNZp
         +/mkVJbnGWvFJbqQ7G+pxo3XNWUBn8F9vIuliqSQgxkJGM1a2/xydkjqDexy/gNwNt
         Q6H139rMQSEtdVXIQ2STTGa8jIsE5EidjiWfD4FegZ/VJoI1sLjn9lQ8XZfAKGOS9D
         KhHX0+vI+Wyb8i80y1viHbFQrNpVFQjxHKL5DYL4CjEPenfpcFl3xDBu7670xhT8Yx
         MVAzX1wcBCx5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80AE4C395FF;
        Sun, 13 Nov 2022 16:01:43 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.1 (#3)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221112230030.3248-1-ardb@kernel.org>
References: <20221112230030.3248-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221112230030.3248-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-3
X-PR-Tracked-Commit-Id: 9b9eaee9828fe98b030cf43ac50065a54a2f5d52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab57bc6f027c761d5411fae9492756b5fbb91108
Message-Id: <166835530352.20823.3432929360957448878.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Nov 2022 16:01:43 +0000
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

The pull request you sent on Sun, 13 Nov 2022 00:00:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab57bc6f027c761d5411fae9492756b5fbb91108

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
