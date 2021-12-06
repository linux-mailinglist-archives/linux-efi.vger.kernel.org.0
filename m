Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63946A5B9
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbhLFTfv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 14:35:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49554 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348576AbhLFTfu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 14:35:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7393B81208
        for <linux-efi@vger.kernel.org>; Mon,  6 Dec 2021 19:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77779C341C1;
        Mon,  6 Dec 2021 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638819139;
        bh=tPASgz6UQlNmY+Qjrp3lVnQSutvaFp45m593zX/pooQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Znx3sWzJiOFSsnxvmYNoFSk0aD6WDqNVckVU9OMFk51KezAkWq5VTtrCVALctyBDS
         a3pyOWpITSxOatucqME0kcKqSyEzi/4cszEhmdFvLxutlerx7vYmXw6KfpNbCbxL+X
         tMLbtKBhGUkIxV6BbCEfr9yENQnKn7CSWeRbFKcHu4sHfRqGf33XoLD0yiLXC9n88h
         Y9bZ7PPzk6YqSp1a7JMUgzVleahQByVMgToSW5kmskcYsy8elJfL95nvYVY4pSEgDl
         7XyPoBCKOv0C1kuDN5NNZTfbrot20XuUqvTlgURwyq+6yFFs1yZhAiSNKSAyNUQbJK
         nS0bNqAU7wS7A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5ED6260A39;
        Mon,  6 Dec 2021 19:32:19 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211206114510.561270-1-ardb@kernel.org>
References: <20211206114510.561270-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211206114510.561270-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16
X-PR-Tracked-Commit-Id: 1ff2fc02862d52e18fd3daabcfe840ec27e920a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55a677b256c363a0cdcd00781d392abeb6e1c0d1
Message-Id: <163881913938.10155.877576933372879101.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Dec 2021 19:32:19 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon,  6 Dec 2021 12:45:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55a677b256c363a0cdcd00781d392abeb6e1c0d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
