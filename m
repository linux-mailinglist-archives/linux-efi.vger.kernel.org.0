Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031006786F5
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 20:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjAWT66 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjAWT6z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 14:58:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC530B11
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 11:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFEA6102C
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 19:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD60C433D2;
        Mon, 23 Jan 2023 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674503928;
        bh=S+3WIxfLe8wxqU/sUyMCoccZytd+5qr2xX/NIQhoHfY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PdHBT5ert8tyQsQVabkuWsGU7A/6XksA6je0OFBoIFRyzGRj7jBMtXIxbxOSchRTp
         7DcA0QCGBNDY/Rs1wvpHYJkF/R10839i09AK+Y4EOUncWTW5kc0pu7zuksMlxvbVnp
         i8w7UKVVMNc/LrKJhGEDROdmXqcluaScvVl4sA1aLV2MT7X2mc14nzeHZudjXkGyqM
         dTjNfNlnpbNRIjmsTwr/SxIqfCIQfhXL3HJRCEq2IVQDVWV0KtynozGWa7oyTQ7IG1
         9zXvFMEO2TOT+O6RPF+jcRY7dJf7rNvkQ6lUhCRTspGWV53S9UhrHXnQPUJCZwx7Gb
         44zmEDhYOCkJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D15C04E34;
        Mon, 23 Jan 2023 19:58:47 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fixes for v6.2 #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230123164518.557152-1-ardb@kernel.org>
References: <20230123164518.557152-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230123164518.557152-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-2
X-PR-Tracked-Commit-Id: e1fabbc83cb1dd4ba63932faa86c9cacb8bf791e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9946f0981ff8698848ee79d739f432a2a3e68eed
Message-Id: <167450392793.2179.4839049207884318478.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Jan 2023 19:58:47 +0000
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

The pull request you sent on Mon, 23 Jan 2023 17:45:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9946f0981ff8698848ee79d739f432a2a3e68eed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
