Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F744DCF81
	for <lists+linux-efi@lfdr.de>; Thu, 17 Mar 2022 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiCQUmb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Mar 2022 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCQUm2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Mar 2022 16:42:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5ACC531
        for <linux-efi@vger.kernel.org>; Thu, 17 Mar 2022 13:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E55B82007
        for <linux-efi@vger.kernel.org>; Thu, 17 Mar 2022 20:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11F33C340E9;
        Thu, 17 Mar 2022 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647549661;
        bh=blzAIg62jJh1mju2/CpzKe5RZjitFSKzxMsaGM4Ev84=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tfNyR3EGrjRj48E3OzYpgc9QoZWPF7E62jOd2KtdVf1+RXPs5tyQHG/x2QWXrOc3/
         aUTzVfRBCTEMce9CI6z3fszEi+y2+K/yBUxuoI37GkLjOWiaudyrEi4khnW+P8y8qS
         tURGFAxRcA1OeE9a419iNI9x9eMHCczPLv4A+nZtbv3VxXYpXvDSScbaHXEaTwBMAT
         4DfvhLB85oWXeszEDZglg4vAxcwcj36wlN0biQmFGXU7L8AMeqN7OJ6uJv5yX897Re
         RhDTqgc8YR56+dkyCCJY5b03X315tnvHYxKcMdslQHJQ3mOudjIdSBKVFK08bms90/
         93iMOTL63qNgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1A1FE8DD5B;
        Thu, 17 Mar 2022 20:41:00 +0000 (UTC)
Subject: Re: [GIT PULL] EFI fix for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220316070051.3489932-1-ardb@kernel.org>
References: <20220316070051.3489932-1-ardb@kernel.org>
X-PR-Tracked-List-Id: <linux-efi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220316070051.3489932-1-ardb@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-3
X-PR-Tracked-Commit-Id: 9feaf8b387ee0ece9c1d7add308776b502a35d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a46310bfae94cfadf3d28a4d97b71e3e4dcc954c
Message-Id: <164754966098.20112.16975819044609892402.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Mar 2022 20:41:00 +0000
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The pull request you sent on Wed, 16 Mar 2022 08:00:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a46310bfae94cfadf3d28a4d97b71e3e4dcc954c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
