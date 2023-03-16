Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837486BCC5B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPKSh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCPKSg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 06:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007EA250;
        Thu, 16 Mar 2023 03:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5E661F18;
        Thu, 16 Mar 2023 10:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76832C4339E;
        Thu, 16 Mar 2023 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678961914;
        bh=G1AyxVAMGwImEABoxZJFpsEdcGxx6pT+ilsm+wxVkxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HKfMDGnaFZztl9W8R+EP+SvxdMlhv+myl+zDekWT/L1UdgLPf9oZFPo83UODyJ44r
         XvdTQraeV8qSEz789e+66mb5+sbdMgqKn6achNDH2WXzEt71motcIYw+uVPHQh43fJ
         1UNhkvZfIesa/lGoNrMkUwaDEKlC7LI3vN8Jyn9cEfQ4uzcY4KBgskzHo/YSJvD1PO
         ml5cddjgLgdDJTGHJzoWQjcR4bJh0SceF/uJhyNXD+c+QXTqiZaQ+elkl3ZS/iKfGf
         TAB2S8JOSMmzTy6zRGewnq0SNlFE78NqXkyF+sD70xzCzsj9ZiBIS6HR7d1NiAmRr0
         Fbdav67ILellg==
Received: by mail-lj1-f182.google.com with SMTP id a32so1088159ljq.1;
        Thu, 16 Mar 2023 03:18:34 -0700 (PDT)
X-Gm-Message-State: AO0yUKVNzBk/80PukCFaUsxrwtNXtgqlGy069rMdrvNXknnu3gW8hzl+
        C3/khtX+aY1130SdAeUp1ydm09pCMsHoCwhxgd0=
X-Google-Smtp-Source: AK7set80FKcbIS/K52OhFC3rDsvTzNAiC3217bkLL7bmSl/3Zgbu28L6PtaJS0XdVeTClYYFRLp5tb9TiJaw5ZvY4tA=
X-Received: by 2002:a2e:9f13:0:b0:299:9de5:2f05 with SMTP id
 u19-20020a2e9f13000000b002999de52f05mr610090ljk.2.1678961912470; Thu, 16 Mar
 2023 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390> <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390> <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
In-Reply-To: <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Mar 2023 11:18:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
Message-ID: <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > (cc Darren)
> >
> > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > Hello Andrea,
> > > >
> > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > gets stuck and never completes the boot. On the console I see this:
> > > > >
> > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > [   72.064949] Task dump for CPU 22:
> > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > [   72.082595] Call trace:
> > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > [   72.088508]  0xffff80000fe83d4c
> > > > >
> > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > >
> > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > this one:
> > > > >
> > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > >
> > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > these arm64 boxes or something else.
> > > > >
> > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > >
> > > >
> > > > Thanks for the report.
> > > >
> > > > This is most likely the EFI SetVariable() call going off into the
> > > > weeds and never returning.
> > > >
> > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > different types of hardware?
> > >
> > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > >
> > > >
> > > > Could you check whether SetVariable works on this system? E.g. by
> > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > >
> > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > ^C^C^C^C
> > >
> > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > >
> >
> > Could you please share the output of
> >
> > dmidecode -s bios
> > dmidecode -s system-family
>
> $ sudo dmidecode -s bios-vendor
> LENOVO
> $ sudo dmidecode -s bios-version
> hve104r-1.15
> $ sudo dmidecode -s bios-release-date
> 02/26/2021
> $ sudo dmidecode -s bios-revision
> 1.15
> $ sudo dmidecode -s system-family
> Lenovo ThinkSystem HR330A/HR350A
>

Thanks

Mind checking if this patch fixes your issue as well?

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
