Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465DF48BBAF
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 01:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbiALAOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 19:14:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50098 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347346AbiALAN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 19:13:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 746A0CE1BC0
        for <linux-efi@vger.kernel.org>; Wed, 12 Jan 2022 00:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A198BC36AE3;
        Wed, 12 Jan 2022 00:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946433;
        bh=zGP8j5iMHWZntHiJ6uFCabgmy/y7czHt1KqauJFiDto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W5br9OKZb0iaBhjx0cCorvwfU8q0b5bCQ2rtSOpAjFjmrJpqLV/eliCWEu1UCM+ZU
         UJ2RNCyDkVt736pls6urtegCQYpab3HCIiEy6BiDzy5SX6IhPZYybZk3XU51iwYBa5
         LcJmJgfxM/uhXpIQUpoDyWcvuMRVFiN+bvsJ+d+LuktR224ZumVF1l+/oCrDq5LRXt
         HxLV1X3DPZRujr06CKMVH7jlbV0faBXEehUele2ru6Lq3dWf9+kFVTNV0Hr0/+rn3C
         3+meD4AEaOKZP8DHfE7OXt9w7fvNqhOO8/QVg8JMcy2+p3SpsO0FOePjX1rDLxG6LF
         1lN5Il+Hk7NFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F684F60793;
        Wed, 12 Jan 2022 00:13:53 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110210307.918857-1-ardb@kernel.org>
References: <20220110210307.918857-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110210307.918857-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.17
X-PR-Tracked-Commit-Id: 42f4046bc4ba56c6e4d2af7a9d7f70eaa563daec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f12fc75ef7db44d71d5a509e2f1bec6966b73776
Message-Id: <164194643358.21161.16146573769477354289.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:53 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 22:03:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f12fc75ef7db44d71d5a509e2f1bec6966b73776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
