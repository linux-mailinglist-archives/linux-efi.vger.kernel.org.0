Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1D6939AA
	for <lists+linux-efi@lfdr.de>; Sun, 12 Feb 2023 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBLTeq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Feb 2023 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLTep (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Feb 2023 14:34:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3DFF24
        for <linux-efi@vger.kernel.org>; Sun, 12 Feb 2023 11:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C4CCB80D3B
        for <linux-efi@vger.kernel.org>; Sun, 12 Feb 2023 19:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDCA7C433D2;
        Sun, 12 Feb 2023 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676230481;
        bh=nGx2SomgGsvHBT+8PBisgPd3Yn8qev8o/yN55p18LPA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oTaY1emIDT24bfOlWTOdJ6Dwfrrx5AYxHdJQYy5Pz+sswDZlY+KDs1MfV1X2IQY5y
         yGmVMrLVB1LxpOzL5JwPOGb7yyaaUFZORbtqn+ZvOIBKpqeYUAXjcuJqrvsOBF5I3U
         rIJjPF/SyzYYsUzkzYt29wxWO6FgrxKLRwTmvMyJRdRKe4K0qpIQJNI85s8qd2C+H8
         seUGsUD5RW3WDIKOu5rypNw2E2uOD+0XADm8eahz2Gba803ae7gBnCpYhJOrFppHeV
         z88DNEpjsSJoaBfgFthiZtkPSWcUwHwv0UF3dOW6PuXYwnAp5uiRFsLoL08QtYFgb8
         7E+dILIrKfSug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B55A9E21EC5;
        Sun, 12 Feb 2023 19:34:41 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.2 #4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230212121933.2030597-1-ardb@kernel.org>
References: <20230212121933.2030597-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230212121933.2030597-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-4
X-PR-Tracked-Commit-Id: 190233164cd77115f8dea718cbac561f557092c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd78af9fde7aeae427adf4bac6cf62ed84e8f898
Message-Id: <167623048173.930.985079784388858660.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Feb 2023 19:34:41 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        darren@os.amperecomputing.com, Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Sun, 12 Feb 2023 13:19:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd78af9fde7aeae427adf4bac6cf62ed84e8f898

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
