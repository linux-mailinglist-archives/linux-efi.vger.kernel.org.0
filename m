Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A316BC7FA
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 08:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCPH6v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCPH6q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 03:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2503136C7;
        Thu, 16 Mar 2023 00:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F14161F5F;
        Thu, 16 Mar 2023 07:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3B4C433EF;
        Thu, 16 Mar 2023 07:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678953513;
        bh=tGrF8FN40I9NDQVodLp3N/ltZWrhiNCUoyB/iQXBDA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VroVw6g++624JIm7pyOH3YQuUqRkPWDykMnHgtJMV3APU7t+1MSOLcv1ggdhKjDrr
         dmgtaFuYed6kxr/vmeXV+JmqFYvrO0uQA8fUbESjuRBPHG9KpAT55cUR21HmJPoGJt
         mEG0IdkKsp3iqrg0LqclLekheOlrgJZCL/AoRGNrCpWgOxLBpjarN9eidVsmKV6AQD
         QWeB4sR1NMPQqDd5dXdrP+BoiJxh4BqPjMSq/FW5v6Xgdn9gc7MvHcia9Fi+CD57NO
         QfJMx7bSFimKSR/6KGPTOZ+vXsjaZIJAGHzZkxRh1jmkCLq5FeNEPHYdrK+qRxJa8a
         szzQMp0MW5Aag==
Received: by mail-lj1-f178.google.com with SMTP id h3so705993lja.12;
        Thu, 16 Mar 2023 00:58:33 -0700 (PDT)
X-Gm-Message-State: AO0yUKXWQIicKFyNQpnE/WR9qGcPHu059kc/fHErETvQfj0vvABM2Zzl
        UbAx2V9hdNPU7X7jb60geLjQM2tgeKx5thyQyms=
X-Google-Smtp-Source: AK7set9HWnRC13hh7svP3IEx3yg4RQpwib6E3L6bEt3NtBvlvXa9G1Kmu3LQBzHb8Yb5SGYyKGG0EL+yWakKHCnRPfM=
X-Received: by 2002:a05:651c:337:b0:295:d460:5a2d with SMTP id
 b23-20020a05651c033700b00295d4605a2dmr1748275ljp.2.1678953511817; Thu, 16 Mar
 2023 00:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
In-Reply-To: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Mar 2023 08:58:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
Message-ID: <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Andrea,

On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> Hello,
>
> the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> gets stuck and never completes the boot. On the console I see this:
>
> [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> [   72.064949] Task dump for CPU 22:
> [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> [   72.082595] Call trace:
> [   72.085029]  __switch_to+0xbc/0x100
> [   72.088508]  0xffff80000fe83d4c
>
> After that, as a consequence, I start to get a lot of hung task timeout traces.
>
> I tried to bisect the problem and I found that the offending commit is
> this one:
>
>  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
>
> I've reverted this commit for now and everything works just fine, but I
> was wondering if the problem could be caused by a lack of entropy on
> these arm64 boxes or something else.
>
> Any suggestion? Let me know if you want me to do any specific test.
>

Thanks for the report.

This is most likely the EFI SetVariable() call going off into the
weeds and never returning.

Is this an Ampere Altra system by any chance? Do you see it on
different types of hardware?

Could you check whether SetVariable works on this system? E.g. by
updating the EFI boot timeout (sudo efibootmgr -t <n>)?
