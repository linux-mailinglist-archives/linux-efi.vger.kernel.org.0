Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9356BD15D
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 14:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCPNuy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCPNux (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 09:50:53 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32AB0483
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 06:50:47 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 881BF3F1F2
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678974645;
        bh=pGYSqv8yaZjHwdWIWY499NZFPJpTqI2+kvxO3gPkHlQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=BtKq5q3wvvtdF86vyMcEOTFU8J4DPGdstxvWryjI2MzreeuGFP6Id/vHIWD9G732D
         D14AJufhRbJ5E80IMsh5PFQnDGu43SPE+39Oeg7a3IzPEh1Y6UmzVWH4IFRmla23pM
         7a3phyAAAvlWvnof6hqo4QixSfQrz+JRTzsewQq0KnQtfRPiZLdI7J/jXGaH+Z7EiJ
         Je9jjga0VfihQAfCXpSc8npiRZmcWWswJhS0ayNDFlg0QyYtLO/qdU5h4XsWy2VTd/
         0TN+Dakci9+SYXyMwGG1SH8isKHHIKpE1btvorsFeKA0CXArxqzVZDIb9goYgJhukZ
         RtOC7jeeMd3aw==
Received: by mail-ed1-f71.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so3151107edb.21
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 06:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGYSqv8yaZjHwdWIWY499NZFPJpTqI2+kvxO3gPkHlQ=;
        b=uoG9Eig29HrO1UMdJI74Ng5UglQrjjOxDNpMn7bcmRKYZ/ckcxVMu2ET9rRYcfawgY
         oaG78ax1f6BSONoWOTWLx3xBhDZhKc+xQEZguCrlRdwQfszTCPk6m82No1X1axwUEb5v
         bVOIj5hCN6d7h3r3oFU3FZ4bHjlJSxeQ8fiQ0pX1LX6gxkDDsDV3sMp9eG/EB7q21fLj
         SYKliCzWjFCF1KyqPuwoTg48GKmsOLgoSl3o8tyfYrkke3QxHXdyY9+S2AIMWXrZIutj
         xyk+ixA7QelbwcON4VKqlIVMnoZhUrj3GlOgQDTe22uLcZz1noHEnqTBgmTeKUSdvvV6
         2ZVA==
X-Gm-Message-State: AO0yUKVEpRyJMdwqUpemftaCTalGNyi6d8/N2/PGYv0LfX3sy8625lYO
        MOCAJoK7uy+eHZvua49fpc8CgVAUcM/SxGZboHdZIuMUzM8QeHo65wzWcbz6n1qKguLsTflm+o9
        qkZCYfPnqlgX1lsmIMXMPVnWfwGEiWEqe3RKgWg==
X-Received: by 2002:a17:906:1cc9:b0:8b1:78b6:bbd7 with SMTP id i9-20020a1709061cc900b008b178b6bbd7mr10468121ejh.10.1678974645289;
        Thu, 16 Mar 2023 06:50:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set8rFj9CLfYMtKX4xu8yZAFbvxkkKoyzadeV3sP5cC/9RNyysGcLx9qP04sgCB1N4DVtpzc+Dw==
X-Received: by 2002:a17:906:1cc9:b0:8b1:78b6:bbd7 with SMTP id i9-20020a1709061cc900b008b178b6bbd7mr10468099ejh.10.1678974645012;
        Thu, 16 Mar 2023 06:50:45 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b0093034e71b94sm993133ejb.65.2023.03.16.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:50:44 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:50:43 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
References: <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
 <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
 <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
 <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
 <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com>
 <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
 <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
 <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390>
 <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 02:45:49PM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 13:50, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 01:43:32PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Mar 2023 at 13:41, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> > > > > On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > (cc Darren)
> > > > > > > > > >
> > > > > > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > Hello Andrea,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hello,
> > > > > > > > > > > > >
> > > > > > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > > > > > >
> > > > > > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > > > > > >
> > > > > > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > > > > > this one:
> > > > > > > > > > > > >
> > > > > > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > > > > > >
> > > > > > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > > > > > these arm64 boxes or something else.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for the report.
> > > > > > > > > > > >
> > > > > > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > > > > > weeds and never returning.
> > > > > > > > > > > >
> > > > > > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > > > > > different types of hardware?
> > > > > > > > > > >
> > > > > > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > > > > > >
> > > > > > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > > > > > ^C^C^C^C
> > > > > > > > > > >
> > > > > > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Could you please share the output of
> > > > > > > > > >
> > > > > > > > > > dmidecode -s bios
> > > > > > > > > > dmidecode -s system-family
> > > > > > > > >
> > > > > > > > > $ sudo dmidecode -s bios-vendor
> > > > > > > > > LENOVO
> > > > > > > > > $ sudo dmidecode -s bios-version
> > > > > > > > > hve104r-1.15
> > > > > > > > > $ sudo dmidecode -s bios-release-date
> > > > > > > > > 02/26/2021
> > > > > > > > > $ sudo dmidecode -s bios-revision
> > > > > > > > > 1.15
> > > > > > > > > $ sudo dmidecode -s system-family
> > > > > > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > Mind checking if this patch fixes your issue as well?
> > > > > > > >
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > > > > > >
> > > > > > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > > > > > problem also with this patch applied.
> > > > > > >
> > > > > >
> > > > > > Thanks for trying.
> > > > > >
> > > > > > How about the last 3 patches on this branch?
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> > > > >
> > > > > Actually, that may not match your hardware.
> > > > >
> > > > > Does your kernel log have a line like
> > > > >
> > > > > SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> > > > >
> > > > > ?
> > > >
> > > > $ sudo dmesg | grep "SMCCC: SOC_ID"
> > > > [    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > >
> > >
> > > Thanks. Could you share the entire dmidecode output somewhere? Or at
> > > least the type 4 record(s)?
> >
> > Sure, here's the full output of dmidecode:
> > https://pastebin.ubuntu.com/p/4ZmKmP2xTm/
> >
> 
> Thanks. I have updated my SMBIOS patches to take the processor version
> 'eMAG' into account, which appears to be what these boxes are using.
> 
> I have updated the efi/urgent branch here with the latest versions.
> Mind giving them a spin?
> 
> 
> In the mean time, just for the record - could you please run this as well?
> 
> hexdump -C /sys/firmware/dmi/entries/4-0/raw
> 
> (as root)

hm.. I don't have that in /sys/firmware/, this is what I have:

# ls -l /sys/firmware/dmi/
total 0
drwxr-xr-x 2 root root 0 Mar 16 13:26 tables
# ls -l /sys/firmware/dmi/tables/
total 0
-r-------- 1 root root 5004 Mar 16 13:26 DMI
-r-------- 1 root root   24 Mar 16 13:26 smbios_entry_point

-Andrea
