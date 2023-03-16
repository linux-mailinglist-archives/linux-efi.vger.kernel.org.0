Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3CA6BCFAC
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 13:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCPMlx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCPMlw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 08:41:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F21B0B96
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 05:41:50 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 997DB41B67
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678970508;
        bh=0pyT45jGFslmx3X3EIC6TC1Ls4szNKSRMgbKXJ/ytIk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=HPzPo9DuU+0teu/rhIR9t59N0iGpxKFJTawAy8H8jWtkI54LSNz/Db9a4DAXlXp+3
         M7cquTYxxDLMpc1xex0fKv/NLrUEaCPiyWXlE4Wo6alHaIxLs1z+nmemDIpjVM68Xx
         Xe0RtKH+Uy1DyzwPSeXz7nU7bQhG2myn7F1uPjlExwQG3DJqgFHOVyicsyYlfS4Yzj
         EdCzmCGwv0wOAEZdpZ+BWvflHrfPPQV14ag+lySZeDopwrdlTq1Q19/8SZt8Fdb2Ap
         c0C8q5FKXtqo+ClJQ1VkFifVtRo71UikBiwkHqd4ZUQw4ozfA1OaJNbupBY4/pBN+2
         062E1gW4bqISA==
Received: by mail-ed1-f70.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso2906914edh.15
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 05:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678970508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pyT45jGFslmx3X3EIC6TC1Ls4szNKSRMgbKXJ/ytIk=;
        b=CwSjYIUYTwy1NrQdKzQQF5jptx8jj5REK59vUknJLL7IRfrPWrcSdSP1MZi+2ZQF4d
         b+CEoL6TZX11dWlBUGJ9wrHxsFSQEwyal4vjbJDj2cBj+EBmGglN6rAjT0MyZtnxjR+t
         lop3yfRucOe/Opl8Io3oUlYPpW7aLzbzkHH/Ld0iiWKs9xsbq4nuq/jru2ceFDyGWojJ
         1ewAJK9HyEiSTKDuLUsUBjBWb7MxV91npfug6UX1/D9QMVg2buySodRoWeTe8GYbKlbF
         MM44Ip7pPKTojaKvOQBp2Psy6+50wgqNmzglwFcpkcYnB515pkEoaTS5R/qgFcLNoKA2
         nM1g==
X-Gm-Message-State: AO0yUKW3rNPJWvvqw53u/a88epHLQYfqgzSoT8b45vVUBUuq8E2PZxCr
        wTM3xUg4xJBmrsvYrPZiYFLPlCW4swL3JQryeVyQmuetJ/e287gNvxezQD8YHk6RCHNAjwLGbLB
        O1TQeLnbo7SK7NumxaiJo6LzeRBeIVWXiK7rf2A==
X-Received: by 2002:a17:906:5945:b0:888:9bd6:34d2 with SMTP id g5-20020a170906594500b008889bd634d2mr8643997ejr.63.1678970508193;
        Thu, 16 Mar 2023 05:41:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set/EWxsZt3eyGkFD5QDfqRBo8DD51mYYArCgq0v7oDskDMs+nKK5dd92m3qcERtsr+vgh0Ujeg==
X-Received: by 2002:a17:906:5945:b0:888:9bd6:34d2 with SMTP id g5-20020a170906594500b008889bd634d2mr8643978ejr.63.1678970507894;
        Thu, 16 Mar 2023 05:41:47 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id jz26-20020a17090775fa00b008e309da3253sm3791482ejc.202.2023.03.16.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:41:47 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:41:46 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
 <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
 <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
 <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
 <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
 <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
 <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > (cc Darren)
> > > > > >
> > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > Hello Andrea,
> > > > > > > >
> > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > >
> > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > >
> > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > >
> > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > this one:
> > > > > > > > >
> > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > >
> > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > these arm64 boxes or something else.
> > > > > > > > >
> > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks for the report.
> > > > > > > >
> > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > weeds and never returning.
> > > > > > > >
> > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > different types of hardware?
> > > > > > >
> > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > >
> > > > > > > >
> > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > >
> > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > ^C^C^C^C
> > > > > > >
> > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > >
> > > > > >
> > > > > > Could you please share the output of
> > > > > >
> > > > > > dmidecode -s bios
> > > > > > dmidecode -s system-family
> > > > >
> > > > > $ sudo dmidecode -s bios-vendor
> > > > > LENOVO
> > > > > $ sudo dmidecode -s bios-version
> > > > > hve104r-1.15
> > > > > $ sudo dmidecode -s bios-release-date
> > > > > 02/26/2021
> > > > > $ sudo dmidecode -s bios-revision
> > > > > 1.15
> > > > > $ sudo dmidecode -s system-family
> > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > >
> > > >
> > > > Thanks
> > > >
> > > > Mind checking if this patch fixes your issue as well?
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > >
> > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > problem also with this patch applied.
> > >
> >
> > Thanks for trying.
> >
> > How about the last 3 patches on this branch?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> 
> Actually, that may not match your hardware.
> 
> Does your kernel log have a line like
> 
> SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> 
> ?

$ sudo dmesg | grep "SMCCC: SOC_ID"
[    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....

-Andrea
