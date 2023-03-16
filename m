Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E996BCF50
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCPMVx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCPMVw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 08:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9895BEB;
        Thu, 16 Mar 2023 05:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05CD46200A;
        Thu, 16 Mar 2023 12:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A115C4339B;
        Thu, 16 Mar 2023 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678969309;
        bh=K5Rk9ovqv+TS5mCWo6uxnqGYsOXm088DuaN676zaTiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FIZTVvkJvQdNkmw3zwmPuNeK2usb0gG6Cv7XVerQrDpje4VBZp1mgHhOtTS9PD6nN
         QqmEJ0n7whir3HGI5C4j/okVbY2Iwzn+09TikgW91ZrrQElzQX2TjvzZVBy6Ki9DwV
         hgw7mz3OMjU6FB9J0dfD0hNUv98pnPBhxw2hNEv4UN7ksv/d/d+efDeRDkO25BRqwH
         frwrZufLoVeDzhQaBK9OGPztW84VDGlKt+ZDZ09VZDW2SOFAqRbf+qhpMC1oiN3+6b
         mifNnJWWFI+Gg2fXkBJ7CKiBRiv9/qR0OVKknJ2JMeEpnicdl7MK9mj/Elaf2O2Wrq
         MaKq4HAiHetrQ==
Received: by mail-lf1-f44.google.com with SMTP id x17so2105162lfu.5;
        Thu, 16 Mar 2023 05:21:49 -0700 (PDT)
X-Gm-Message-State: AO0yUKX4fLzYdB6sWgTBnk7TjH6ifONe4ZnXaLbR5Y+IvkZQwg8Nkuqb
        eLKmJbbx+zTgebJLOz2MCLM0y7L2KMYkATDPlus=
X-Google-Smtp-Source: AK7set8iKGPx9Rwr2YxHuREC4sLbwUatt35wR6nb0hls+Fk6mvn4hc36pjh0dcK1JjfT7ZQAS25wiXjEBLTQ73uTqhQ=
X-Received: by 2002:ac2:48b0:0:b0:4d5:ca32:6ae4 with SMTP id
 u16-20020ac248b0000000b004d5ca326ae4mr3169778lfg.4.1678969307357; Thu, 16 Mar
 2023 05:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390> <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390> <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390> <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
 <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
In-Reply-To: <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Mar 2023 13:21:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
Message-ID: <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
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

On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > (cc Darren)
> > > >
> > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > Hello Andrea,
> > > > > >
> > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > >
> > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > [   72.082595] Call trace:
> > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > >
> > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > >
> > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > this one:
> > > > > > >
> > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > >
> > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > these arm64 boxes or something else.
> > > > > > >
> > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > >
> > > > > >
> > > > > > Thanks for the report.
> > > > > >
> > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > weeds and never returning.
> > > > > >
> > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > different types of hardware?
> > > > >
> > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > >
> > > > > >
> > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > >
> > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > ^C^C^C^C
> > > > >
> > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > >
> > > >
> > > > Could you please share the output of
> > > >
> > > > dmidecode -s bios
> > > > dmidecode -s system-family
> > >
> > > $ sudo dmidecode -s bios-vendor
> > > LENOVO
> > > $ sudo dmidecode -s bios-version
> > > hve104r-1.15
> > > $ sudo dmidecode -s bios-release-date
> > > 02/26/2021
> > > $ sudo dmidecode -s bios-revision
> > > 1.15
> > > $ sudo dmidecode -s system-family
> > > Lenovo ThinkSystem HR330A/HR350A
> > >
> >
> > Thanks
> >
> > Mind checking if this patch fixes your issue as well?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
>
> Unfortunately this doesn't seem to be enough, I'm still getting the same
> problem also with this patch applied.
>

Thanks for trying.

How about the last 3 patches on this branch?

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
