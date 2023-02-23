Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2000C6A139E
	for <lists+linux-efi@lfdr.de>; Fri, 24 Feb 2023 00:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBWXQt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Feb 2023 18:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBWXQs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Feb 2023 18:16:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5C5DCEC
        for <linux-efi@vger.kernel.org>; Thu, 23 Feb 2023 15:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880B5617C7
        for <linux-efi@vger.kernel.org>; Thu, 23 Feb 2023 23:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74964C433EF;
        Thu, 23 Feb 2023 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194206;
        bh=HR1CJOjJAV61F56SOXJt4rSrKhGl4pY4WJipLBWjF50=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dlLzkJoXqTgFeeKfzQg8iO51NrBBmPUkjuAMfvGftGJvoyefveqonkcvlOBj04CD3
         ez2mml9FKbUnI2skmqWYylPpZ4FxQc3QWgYSGK1RANu83LIp+EJPra/qbeUYYUNR6N
         7iN/v9bQFrYD9UIK0/FjqW4EjeW0M8uiNWnrmxXA8ZlYUqqbMtTgnwThXF3dCGqrWZ
         TNL22Lho106QsBGQ5YcXkXpZtRZRvKK42mqL6lGqKwm1ziX8KOFomF3FVVFgXk38d8
         OH4PCCn6577lWMp6+u98QGzoN0tE6LNc1tu//33FZIhPWYOVYEXXP5kY1Sb8DH5rL4
         EC2pSwT7XbzMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CCDBC43157;
        Thu, 23 Feb 2023 23:16:46 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220184729.344373-1-ardb@kernel.org>
References: <20230220184729.344373-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220184729.344373-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.3
X-PR-Tracked-Commit-Id: e1d447157f232c650e6f32c9fb89ff3d0207c69a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06e1a81c4806d0b7f75f9d742ebf410718244e03
Message-Id: <167719420637.30381.15017664549482755399.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 23:16:46 +0000
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

The pull request you sent on Mon, 20 Feb 2023 19:47:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06e1a81c4806d0b7f75f9d742ebf410718244e03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
