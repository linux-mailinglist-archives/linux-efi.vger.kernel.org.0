Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C663B6C3
	for <lists+linux-efi@lfdr.de>; Tue, 29 Nov 2022 01:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiK2AuS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Nov 2022 19:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiK2AuR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Nov 2022 19:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F51010B79;
        Mon, 28 Nov 2022 16:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33BA61356;
        Tue, 29 Nov 2022 00:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D32C433D6;
        Tue, 29 Nov 2022 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669683015;
        bh=gVh2g0Vi1FSHpyi0QX/3SGHx2knvHC+vTGRbDJ9Tg/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=A2y0HV0WBuZHEV0GYJ/MZJ3NGO8o6Yo+3jHKTQJduA2LKrukDPICEN/IK/nEtp+E3
         rQ0LRQ9BRTGh07oqSgpxIyhPOez6/vFgqBWtMz1oZWLbqnqHdOiR0wnNlb8fEZV8YN
         2sHZrOKhxgO3/tfzRcAcJZz94WssYuB56mO9EL1E0IG0a/OEdGpeHY0ywmi9EG5XwT
         HYsohvw0FVHddZgPMEu0hcrKIi+uQBvHOJqiTdfjnz/wDvLzsV+lEKkalWZId7PcGx
         roLKVhT9cvYXs5klK94Quac1gzo1azLgffLlCFtAoT98CyZH0NP3euvHwK1DEqsYsb
         uHREn/H7qO4zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0128AE21EF6;
        Tue, 29 Nov 2022 00:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before switching
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166968301500.7047.6174959001069239033.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Nov 2022 00:50:15 +0000
References: <20221121133303.1782246-1-alexghiti@rivosinc.com>
In-Reply-To: <20221121133303.1782246-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, ardb@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, heinrich.schuchardt@canonical.com,
        emil.renner.berthing@canonical.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 21 Nov 2022 14:33:03 +0100 you wrote:
> The EFI page table is initially created as a copy of the kernel page table.
> With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
> if the stack is allocated in a new PGD (one that was not present at the
> moment of the efi page table creation or not synced in a previous vmalloc
> fault), the kernel will take a trap when switching to the efi page table
> when the vmalloc kernel stack is accessed, resulting in a kernel panic.
> 
> [...]

Here is the summary with links:
  - riscv: Sync efi page table's kernel mappings before switching
    https://git.kernel.org/riscv/c/3f105a742725

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


