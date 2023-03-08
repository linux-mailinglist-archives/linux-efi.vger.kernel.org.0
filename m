Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE326AFD65
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 04:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCHDa0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Mar 2023 22:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCHDaX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Mar 2023 22:30:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B096086;
        Tue,  7 Mar 2023 19:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5448661647;
        Wed,  8 Mar 2023 03:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A45A2C4339B;
        Wed,  8 Mar 2023 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678246220;
        bh=5OPrOB1Zlr48DWUViK6j0Fy6jpixegIvZul/S1eMV1A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P0OewE6KImVyn+o1ovvGPT4UVpVJjaly2jOe8KkD6n/Ar8IvHlclmm9K4Li2g3IHm
         ViY+R95z4+y9dv+k0OYHjtAPBE6F1dlPwhsrKn/lG5bRfgHeDKvO7DCkbqTUvfXNJI
         3sPLXXlb0lomrJN2IExcW1tqHV1XpbGoIaBK+3oq8GzvapDs9EP/OrqEZOcOaYYxij
         VaTUboPQL02V5olqVLIuq/xKEyOztzvyOW3fgXImUkGRcxMGeDGdxtjGTpYVi9RyOw
         x8jFenZDCuIPK86kzOJq7lTYRFPuH320CqlYYQ5Xw2LBpRctAuVE8bgGOa9K7YmoaJ
         3OuYuTAiM/edQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 862FDC39563;
        Wed,  8 Mar 2023 03:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/6] RISC-V kasan rework
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167824622054.6983.17538269821612408608.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Mar 2023 03:30:20 +0000
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, ardb@kernel.org, conor@kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  3 Feb 2023 08:52:26 +0100 you wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.
> 
> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
> 
> [...]

Here is the summary with links:
  - [v4,1/6] riscv: Split early and final KASAN population functions
    https://git.kernel.org/riscv/c/70a3bb1e1fd9
  - [v4,2/6] riscv: Rework kasan population functions
    https://git.kernel.org/riscv/c/fec8e4f66e4d
  - [v4,3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
    https://git.kernel.org/riscv/c/1cdf594686a3
  - [v4,4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
    https://git.kernel.org/riscv/c/415e9a115124
  - [v4,5/6] riscv: Fix ptdump when KASAN is enabled
    https://git.kernel.org/riscv/c/fe0c8624d20d
  - [v4,6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
    https://git.kernel.org/riscv/c/4cdc06c5c741

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


