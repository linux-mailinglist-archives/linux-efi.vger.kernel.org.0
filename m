Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280BA64BF70
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiLMWfv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 17:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiLMWfp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 17:35:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15418B05
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 14:35:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEC1E61755
        for <linux-efi@vger.kernel.org>; Tue, 13 Dec 2022 22:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52B2DC433D2;
        Tue, 13 Dec 2022 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970943;
        bh=zYNfoHWWQBoATDZMaWPYDcX2PXGlXJThl47soa8jBJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ap0BlyfiTxmp33oOZEHYjTtlkbSJ1N5EpI9fKzz7atn1fAKkslAh4LQ5tmTzjilBF
         3PqQKIUqbqcxIY0tQIGsWsecA8OrXlFZWVeH/bbkU52Fofb+/UQwakF1D5Jai/PIex
         yfuaGJw4Aivstce6hJXXGcAFYzaLOpj9dOKOq4J/aaP9WIlOHlfFDSByhk3z+DI3yd
         oC5VDxFZhuQF816j5srFXAKOGk+PcmxB9POfb2y/5RMBSKchIkCk5bNBMS1Dd/s2CX
         ecAVnGrFq+bwgWitsnA1DfPrvDv8OeU/0KqtrSxK7ih9QqyXxr9SVOTlRzX6ly5AIf
         /VXkLBiTIcvwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3798AC00445;
        Tue, 13 Dec 2022 22:35:43 +0000 (UTC)
Subject: Re: [GIT PULL] EFI updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213164622.2213946-1-ardb@kernel.org>
References: <20221213164622.2213946-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213164622.2213946-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.2
X-PR-Tracked-Commit-Id: e8dfdf3162eb549d064b8c10b1564f7e8ee82591
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc4c9f450493daef1c996c9d4b3c647ec3121509
Message-Id: <167097094322.5412.1446156285018903978.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 22:35:43 +0000
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

The pull request you sent on Tue, 13 Dec 2022 17:46:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next-for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc4c9f450493daef1c996c9d4b3c647ec3121509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
