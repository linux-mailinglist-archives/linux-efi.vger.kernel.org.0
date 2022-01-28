Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C894B4A00B4
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350847AbiA1TOr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 14:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350850AbiA1TOq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jan 2022 14:14:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F5C061714
        for <linux-efi@vger.kernel.org>; Fri, 28 Jan 2022 11:14:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70605B826EA
        for <linux-efi@vger.kernel.org>; Fri, 28 Jan 2022 19:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C51FC340E7;
        Fri, 28 Jan 2022 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643397284;
        bh=URWBoG+H66aWj+DwAAjyMZrzlHWfCnpWhQHBwL2zhps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HXXx85AyN1t1yVZ+tDIddoWcVlw5P+j92KOlfW5KBi+rSwe4Z6byAbCiWnmo97iBC
         daUK3fPZ6xNfF8kHh+/Ow1AR9HQsxp7pTOzWRkImwIN2VCet2sxYNKyeriwqOWMPs2
         tzbHa/rZMC1ZcCes3+I5xb9w0j1NmtoyC0pi9LPzSgQ6kDQi/bZVpiKgGHyXzQW1oF
         XxMq3sPdtqfpFBN36rn0kkyJFYsO7lmLlwdF+JPezxeuyJ9MyBkD/Ux+w2WvHC04r5
         kQbjPPheLxB41+FT6wFyKiJmsFp8FUD1bA/DTvA503j3FpmHPYZOnB8RP7XitsjAEr
         xac/IKcNGvifQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A64DF6079F;
        Fri, 28 Jan 2022 19:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128143049.3630222-1-ardb@kernel.org>
References: <20220128143049.3630222-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128143049.3630222-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-1
X-PR-Tracked-Commit-Id: f5390cd0b43c2e54c7cf5506c7da4a37c5cef746
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 073819e0ff389ee94dadd2d5340bfdc108ccddff
Message-Id: <164339728409.30751.8496922695269941909.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 19:14:44 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 15:30:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/073819e0ff389ee94dadd2d5340bfdc108ccddff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
