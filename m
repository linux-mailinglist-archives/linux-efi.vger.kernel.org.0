Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678F86BCBA7
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCPJ5N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCPJ4s (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 05:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131448FBF5;
        Thu, 16 Mar 2023 02:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35E761FAC;
        Thu, 16 Mar 2023 09:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29317C4339C;
        Thu, 16 Mar 2023 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678960571;
        bh=CVrasF+J91p1DtpL/FMvCfh8mw0L48i58u1GBp387l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jVWJXrikc0qcs/RL0vt95U6ALVDRyNCxfbecdpWXF08EdwU3weAdk0JeT5Gv8LHAs
         3wWpopLXdwQy2TpLJtRf1lIehNaI2H/6IflPG4iBAP81461URhNOA54ZzbreHBCEgq
         Gy8VlWEc/tMk2+vjTFudid7yPukjqulYVcrEr1osjHv1gg8Ia0E7oEmT8cdaGWQ0kF
         DtHwf3jZ0OqZwQBBvE+HEbnPSCNa010GAIVne5enpODWY4HMoSfJAfZD2TamE4IE4S
         2qLq/g/uyXnw8NSZtlx0POApKMzA/VjMWfLwFypn/X5ZuI9BOYU/VutYSKXEhAFGQb
         XzrhNYeCUN4lw==
Received: by mail-lj1-f181.google.com with SMTP id y14so1019512ljq.4;
        Thu, 16 Mar 2023 02:56:11 -0700 (PDT)
X-Gm-Message-State: AO0yUKVenfcCob9x2p+7a1k6TzU/TLd0GoCz1/Uv2ZrHAqyEb+QRsb6D
        tzWXwict8aknxpHAldu8sY5U1kw9RQWe2bbKXOw=
X-Google-Smtp-Source: AK7set8trH3yySusbI4k0SyM2eyWbNsRx4HZ30ADCBQBu/5NKsRuOary68HM6uI4zNU50CI6oPh8LjIJpFRwJ7dMwWI=
X-Received: by 2002:a05:651c:108:b0:299:ac5e:376e with SMTP id
 a8-20020a05651c010800b00299ac5e376emr153861ljb.2.1678960569149; Thu, 16 Mar
 2023 02:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390> <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
In-Reply-To: <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Mar 2023 10:55:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
Message-ID: <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Darren)

On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > Hello Andrea,
> >
> > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > Hello,
> > >
> > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > gets stuck and never completes the boot. On the console I see this:
> > >
> > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > [   72.064949] Task dump for CPU 22:
> > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > [   72.082595] Call trace:
> > > [   72.085029]  __switch_to+0xbc/0x100
> > > [   72.088508]  0xffff80000fe83d4c
> > >
> > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > >
> > > I tried to bisect the problem and I found that the offending commit is
> > > this one:
> > >
> > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > >
> > > I've reverted this commit for now and everything works just fine, but I
> > > was wondering if the problem could be caused by a lack of entropy on
> > > these arm64 boxes or something else.
> > >
> > > Any suggestion? Let me know if you want me to do any specific test.
> > >
> >
> > Thanks for the report.
> >
> > This is most likely the EFI SetVariable() call going off into the
> > weeds and never returning.
> >
> > Is this an Ampere Altra system by any chance? Do you see it on
> > different types of hardware?
>
> This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
>
> >
> > Could you check whether SetVariable works on this system? E.g. by
> > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
>
> ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> ^C^C^C^C
>
> ^ Stuck there, so it really looks like SetVariable is the problem.
>

Could you please share the output of

dmidecode -s bios
dmidecode -s system-family

Thanks,
Ard.
