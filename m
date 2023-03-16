Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144576BCFE0
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCPMuM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPMuK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 08:50:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC7C97DD
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 05:50:05 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F3EF3F04C
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678970999;
        bh=RTE1+/kyJT3ysYPqhg0Rdy0OJWOhaJ6nlSBBfgWtRzU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=UwWorSUMDynjjm2osInyHGLZc/zMydeVdAUXAhjmoirTaYRbMD63o/79sl57x8tHw
         iX+aW/ApbGLQrg+4GOBMhqyzSUZNbK58pjhNIRHHUA4NCXwHJYpXvoIeEEehXj9vMO
         xRfko5nTMk3SAnDT6r2sKYNuILtNQTyqfqTP0Do0Vwbw/G4Qp8YHiWhqU4Cim6VSji
         CJVU6lP2M61o36oC3gXdSSoHweR4raRWCNUK7kzsqPUN9QW+yYOoxTc65qH1/JX2h5
         JjtQA0XSABS7kdDss+n2u8vZZ1jw18ies/H6CTQ6u2GJh0+MJ3g6VkoJc92q0ADTbw
         374GpOmFJ4AYA==
Received: by mail-ed1-f70.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so2894694edh.14
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 05:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678970999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTE1+/kyJT3ysYPqhg0Rdy0OJWOhaJ6nlSBBfgWtRzU=;
        b=iyUCheh81fOlKAIAXUFpWizuoRm0gr7MVmoKJ6+RKfzQvVxMjZclncg/A6Q2awsB2X
         SaBIpu0LM/s9YJQk9oH/1U/0Komf7hk9c+qFQa8Zbuv3vcb0X3VyT4Xd2vknG3g57AaC
         JIMhvji5Aw1/3TZysduaOf3lDyRAwxmC77bfZa0SCKCNznsK3trvg4XEHmEi4fXui+45
         CTjkNSvoUUbgV3DNoPyIzO+PtFdDNNf38KOzkkd40SSFS77iAcCoBw+6z3VZEs4vZdXc
         Pp6b+oldDPOvAJZF4QeaAbp5fViCDjKTXBEYSAfWPfl+K0816YRpolHF4ehy+HoIzuUZ
         rE+g==
X-Gm-Message-State: AO0yUKW1jjuZqFJFTkJAcJEuOT4gB5oSqkF4FUS9F/dXiCo+bMClzKwS
        7wZlAB4aDUHUjO98aMP0V8zQTZ35b4zAy0iROIWfRcyRyEQFlDKiAjUbBqYMfgdFmpnHpEMC8nv
        VFYXZDL+aDnNXlE94vwCDWfQh7JVaekyD+cvqiQ==
X-Received: by 2002:a17:906:c047:b0:927:34f1:f284 with SMTP id bm7-20020a170906c04700b0092734f1f284mr11269975ejb.16.1678970999164;
        Thu, 16 Mar 2023 05:49:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set+4nDRbEGPF33UNX3MNrcdNYJbfk3Tgfgbr7luYB5IGcwuWkd4KNzMj8QVhHTRRVAy6nAsdsw==
X-Received: by 2002:a17:906:c047:b0:927:34f1:f284 with SMTP id bm7-20020a170906c04700b0092734f1f284mr11269947ejb.16.1678970998857;
        Thu, 16 Mar 2023 05:49:58 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id qh21-20020a170906ecb500b0092b422c9d37sm3776276ejb.110.2023.03.16.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:49:58 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:49:58 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390>
References: <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
 <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
 <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
 <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
 <CAMj1kXEtj_jEZeT6YNh9xB=8o=0LVKiPYucHU08s34xBgy1yDA@mail.gmail.com>
 <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com>
 <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
 <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 01:43:32PM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 13:41, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > > > (cc Darren)
> > > > > > > >
> > > > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > Hello Andrea,
> > > > > > > > > >
> > > > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello,
> > > > > > > > > > >
> > > > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > > > >
> > > > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > > > >
> > > > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > > > >
> > > > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > > > this one:
> > > > > > > > > > >
> > > > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > > > >
> > > > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > > > these arm64 boxes or something else.
> > > > > > > > > > >
> > > > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks for the report.
> > > > > > > > > >
> > > > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > > > weeds and never returning.
> > > > > > > > > >
> > > > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > > > different types of hardware?
> > > > > > > > >
> > > > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > > > >
> > > > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > > > ^C^C^C^C
> > > > > > > > >
> > > > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Could you please share the output of
> > > > > > > >
> > > > > > > > dmidecode -s bios
> > > > > > > > dmidecode -s system-family
> > > > > > >
> > > > > > > $ sudo dmidecode -s bios-vendor
> > > > > > > LENOVO
> > > > > > > $ sudo dmidecode -s bios-version
> > > > > > > hve104r-1.15
> > > > > > > $ sudo dmidecode -s bios-release-date
> > > > > > > 02/26/2021
> > > > > > > $ sudo dmidecode -s bios-revision
> > > > > > > 1.15
> > > > > > > $ sudo dmidecode -s system-family
> > > > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Mind checking if this patch fixes your issue as well?
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > > > >
> > > > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > > > problem also with this patch applied.
> > > > >
> > > >
> > > > Thanks for trying.
> > > >
> > > > How about the last 3 patches on this branch?
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> > >
> > > Actually, that may not match your hardware.
> > >
> > > Does your kernel log have a line like
> > >
> > > SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> > >
> > > ?
> >
> > $ sudo dmesg | grep "SMCCC: SOC_ID"
> > [    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> >
> 
> Thanks. Could you share the entire dmidecode output somewhere? Or at
> least the type 4 record(s)?

Sure, here's the full output of dmidecode:
https://pastebin.ubuntu.com/p/4ZmKmP2xTm/

-Andrea
