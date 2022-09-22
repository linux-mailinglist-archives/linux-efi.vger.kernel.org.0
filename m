Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337575E6A7C
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiIVSPX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiIVSPM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 14:15:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FF54BD36
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 11:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 970F3CE231C
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 18:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A09EC433D6;
        Thu, 22 Sep 2022 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663870507;
        bh=j85EQ7maXFaeWPqUlp+BRcFH1WdV6/aM7lT/IOoBdwg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S13BWnUtK+MDFWyEZpLeYztlZiR9R/iPfZCbwAixzoqK5FkKic69Vr46DMaM0LlrS
         H3VJNRs3Wx7KCm7SOrbEXUUwDnu6oH72nJj0hwwz8S5C6FkOCrAR57i4GyZgUftkRI
         /brMjjmuW/M/E33Z64V9BapuLjCcXQ1dHwIAudVAumkplsYa8y09HdzIEfRjXuZ3Eg
         NnvmzFWj0wjuB7g0shg1H8d/iPjIIApbGMBBgU6QVvaTUG1+dV6ZNtJ6pl8p4+dMkI
         rmsfY4EnQbgOdPznpX8JFURqgf6xK0Jh+Cs+NkR5Y6LVTMYg6aGbJavopR/vjdGFAm
         WBnojUYxGDEWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54836E21ED1;
        Thu, 22 Sep 2022 18:15:07 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.0 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220922142122.1208186-1-ardb@kernel.org>
References: <20220922142122.1208186-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220922142122.1208186-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-2
X-PR-Tracked-Commit-Id: 5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 129e7152184b0224f9ca3f91b870acc14c64e1fa
Message-Id: <166387050734.24554.12716031222486948695.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Sep 2022 18:15:07 +0000
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

The pull request you sent on Thu, 22 Sep 2022 16:21:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/129e7152184b0224f9ca3f91b870acc14c64e1fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
