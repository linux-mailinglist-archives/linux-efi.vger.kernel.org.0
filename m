Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3273480292
	for <lists+linux-efi@lfdr.de>; Mon, 27 Dec 2021 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhL0RFe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 27 Dec 2021 12:05:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0RFd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 27 Dec 2021 12:05:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 675A4B80E71
        for <linux-efi@vger.kernel.org>; Mon, 27 Dec 2021 17:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AA3C36AE7;
        Mon, 27 Dec 2021 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640624730;
        bh=ylRq0swBur/Dy1P0Rnh1zjW4EulaW/g0bBXpy/BjEqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZMRaOjFekNw/bcdIP+eV+htoRVIMjqN6WNozuf4M8piE2hz55eWf3tr5B5vC+5pF0
         aVS4+x/JQqaAX0cxj6ORhiuQPfvj1PhT6eaBu0sv75dHSwQOeLZcAmd9+XMTd85cWJ
         Wp6BfgfkzovXrdsXRtewTgb9/Z5WOPL0iuG2OJD20g6OPv5uSpwEdN2WOqxHfmq8Zv
         /m/X0OR7jsIQ6H4fkaNoITD2hAsNzKshYzyl/aQcLOHr0BSm+cetJBEmWfHKwt5zko
         kd0hNHxG/SJeHvctua4xQSBifl8FSV8kxMtewN1+INiGc0LNjTb3ItY7ULTAY1mJfm
         kQu9FVXqL1l2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25532C395DD;
        Mon, 27 Dec 2021 17:05:30 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for 5.16 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211227122333.2425727-1-ardb@kernel.org>
References: <20211227122333.2425727-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211227122333.2425727-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16-2
X-PR-Tracked-Commit-Id: 4bc5e64e6cf37007e436970024e5998ee0935651
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8ad9a2434dc7967ab285437f443cae633b6fc1c
Message-Id: <164062473014.24398.1321631667885165605.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Dec 2021 17:05:30 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 27 Dec 2021 13:23:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8ad9a2434dc7967ab285437f443cae633b6fc1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
