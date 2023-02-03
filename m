Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DEE68A22E
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjBCSpi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 13:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjBCSpf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 13:45:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5DADBB2
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 10:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49B74B82B6D
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 18:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0777C433D2;
        Fri,  3 Feb 2023 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449925;
        bh=9B002VLv6sBJ23idoAXPw572kFS6NNPXafR2HHNhkHE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t45VzC7ZhkjheUPux9yeSCX9jc15QBBWaUStzmSzRaANftolX4zFfDVuTR8q5ldt6
         KJ6k4SzyD1IYCfppMF5MF4Em74gG6pNxHAo9ltVI+rzAiqjJ2D4L7vuyt8mN1Z+nvz
         RrzNk44iuq6sXmqHok7gLQESk3sC8XACacTab6dG7tznGd9x79X3ZW7hEb+iCJYX65
         QBQixec/jqYVhsmy2cgdRrJjc1HA+q+57OCn2AYI03tU6QflSfOoAOOQWGfJx5TT5u
         S211cBkdcqu2QAuQI2NwX4w5OdBQGMb1rLuD/JENH2c52rqbEX8d9L86XEUNaXOfR2
         5oBEX0JFNbl3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D844CE21ED0;
        Fri,  3 Feb 2023 18:45:24 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.2 batch #3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230203175537.2694499-1-ardb@kernel.org>
References: <20230203175537.2694499-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230203175537.2694499-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-3
X-PR-Tracked-Commit-Id: 966d47e1f27c45507c5df82b2a2157e5a4fd3909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0880c33794ba417687822482ffb0d3b797f0a04
Message-Id: <167544992487.32203.15964423216484430905.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 18:45:24 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri,  3 Feb 2023 18:55:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0880c33794ba417687822482ffb0d3b797f0a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
