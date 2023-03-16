Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE856BD24B
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 15:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCPOZ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCPOZ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 10:25:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D69B79E1
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 07:25:24 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 34CDE445A2
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678976722;
        bh=92i4qrEhaaWULAWrFn5b6EQzymw7+aSf9ULAswrYqXc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=r7r+ganDTv7p0J4zec8GydLYJ1M+QVBdOp2jQykaHXByTG/tP3I2pCuVedAy9xEa9
         WZPzF+wkv/Qy6I8nuv4P8XSP723gEHDuBtA7hAlS6qvsVMiP2UkgTwqHMRNhMR/QWk
         aye9D9bKlUqACzPIam74eQiap31LoiWG5B8Tfkgq/xLWzr1LIPVpTJ6vHEKaAZttru
         UUUXVLu5St02Jmnq8gw7kXEKwD6W2m1O1DzM/NRQ3XSeaMqomOMnpvC+8SlgUaLAME
         dLoxdk5yNURBieGXewcBTNsx9i8jckMx/j1DF0bPOuRXjXYtDZI+nlxhoGcjM3iiRO
         3dCDJkhULThKQ==
Received: by mail-ed1-f71.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso3257408edu.17
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 07:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92i4qrEhaaWULAWrFn5b6EQzymw7+aSf9ULAswrYqXc=;
        b=p5zsfQZUlohvGbnk9lU54c0FX3lcM3GGAKgLuKlvhSoGfYj3P8XdLbEKDxsJZKiO25
         AQkXpVaAnPBP0Ws91FO/ojleARNedIs3xR+MS/JmqstrGQ285I7wXFF+hgvdMMZgTUZ1
         486gDrnnCH4gFXe/ty4DEArTx5doMm05PU4TKMVvWpmnsROyyTecx0U5rX7mDz90E7jL
         bq5YyVgSEe+UpSbaDmCJGGSImEDyqvCby4cz4AYtPvys6RbPIbOYzbL96d/aV2YBYNNk
         wZhk7x84HowNMY/JdvrJZ4Tv9ed4SX7WGUlOAMlvbTTe6C+dlFLhU7WNolyl8PW4LVPd
         tNlA==
X-Gm-Message-State: AO0yUKVlfXD2Wq58uindnKF29P0ipU1ujQDB4rgVG72iNxyP9BszJsMA
        vhecIz6vOtevZdE1W0FqQ9K6G01Ofrni1DJu7yaS3AX1vc/LcaCljJjBjUMnxUcYNAjFDwBfWbt
        WvlDbVws+yYy3jPqfj9IAjMt1tKLo+io/WjBMgw==
X-Received: by 2002:a17:906:a450:b0:88d:9cf8:2dbb with SMTP id cb16-20020a170906a45000b0088d9cf82dbbmr11090870ejb.12.1678976721833;
        Thu, 16 Mar 2023 07:25:21 -0700 (PDT)
X-Google-Smtp-Source: AK7set+agi1nKXx1jIWlNITv4H5MH/5KPqUouCuESwMucLcXHcirnZDPgg6dGpBI+OhNPpDle5P0tw==
X-Received: by 2002:a17:906:a450:b0:88d:9cf8:2dbb with SMTP id cb16-20020a170906a45000b0088d9cf82dbbmr11090849ejb.12.1678976721479;
        Thu, 16 Mar 2023 07:25:21 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id oy12-20020a170907104c00b00931024e96c5sm351777ejb.99.2023.03.16.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:25:21 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:25:20 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBMm0D97gWcxzY3B@righiandr-XPS-13-7390>
References: <CAMj1kXF3pkxvDX6ZMpnRd3wQX2_T6CYmz7ML-h+PXeo+hM_ZdA@mail.gmail.com>
 <ZBMOitWwCDj3XiRw@righiandr-XPS-13-7390>
 <CAMj1kXF=8KoCnRmUyLCZmbfPTeOFQZBeudZuTeA0uHOv-1drFg@mail.gmail.com>
 <ZBMQdgPepwa+VyAH@righiandr-XPS-13-7390>
 <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 03:08:53PM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 15:06, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 16 Mar 2023 at 14:59, Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > On Thu, Mar 16, 2023 at 02:53:24PM +0100, Ard Biesheuvel wrote:
> > > > On Thu, 16 Mar 2023 at 14:50, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > >
> > > > > On Thu, Mar 16, 2023 at 02:45:49PM +0100, Ard Biesheuvel wrote:
> > > > > > On Thu, 16 Mar 2023 at 13:50, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 16, 2023 at 01:43:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Thu, 16 Mar 2023 at 13:41, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Mar 16, 2023 at 01:38:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > On Thu, 16 Mar 2023 at 13:21, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, 16 Mar 2023 at 12:34, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > > > (cc Darren)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > > > > > > > > > > > > > Hello Andrea,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hello,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > > > > > > > > > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > > > > > > > > > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > > > > > > > > > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > > > > > > > > > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > > > > > > > > > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > > > > > > > > > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > > > > > > > > > > > > > [   72.082595] Call trace:
> > > > > > > > > > > > > > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > > > > > > > > > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > > > > > > > > > > > > > this one:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > > > > > > > > > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > > > > > > > > > > > > > these arm64 boxes or something else.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Thanks for the report.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > > > > > > > > > > > > > weeds and never returning.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > > > > > > > > > > > > > different types of hardware?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > > > > > > > > > > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > > > > > > > > > > > > > ^C^C^C^C
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Could you please share the output of
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > dmidecode -s bios
> > > > > > > > > > > > > > > dmidecode -s system-family
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > $ sudo dmidecode -s bios-vendor
> > > > > > > > > > > > > > LENOVO
> > > > > > > > > > > > > > $ sudo dmidecode -s bios-version
> > > > > > > > > > > > > > hve104r-1.15
> > > > > > > > > > > > > > $ sudo dmidecode -s bios-release-date
> > > > > > > > > > > > > > 02/26/2021
> > > > > > > > > > > > > > $ sudo dmidecode -s bios-revision
> > > > > > > > > > > > > > 1.15
> > > > > > > > > > > > > > $ sudo dmidecode -s system-family
> > > > > > > > > > > > > > Lenovo ThinkSystem HR330A/HR350A
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks
> > > > > > > > > > > > >
> > > > > > > > > > > > > Mind checking if this patch fixes your issue as well?
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately this doesn't seem to be enough, I'm still getting the same
> > > > > > > > > > > > problem also with this patch applied.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks for trying.
> > > > > > > > > > >
> > > > > > > > > > > How about the last 3 patches on this branch?
> > > > > > > > > > >
> > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-smbios-altra-fix
> > > > > > > > > >
> > > > > > > > > > Actually, that may not match your hardware.
> > > > > > > > > >
> > > > > > > > > > Does your kernel log have a line like
> > > > > > > > > >
> > > > > > > > > > SMCCC: SOC_ID: ID = jep106:036b:0019 Revision = 0x00000102
> > > > > > > > > >
> > > > > > > > > > ?
> > > > > > > > >
> > > > > > > > > $ sudo dmesg | grep "SMCCC: SOC_ID"
> > > > > > > > > [    5.320782] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks. Could you share the entire dmidecode output somewhere? Or at
> > > > > > > > least the type 4 record(s)?
> > > > > > >
> > > > > > > Sure, here's the full output of dmidecode:
> > > > > > > https://pastebin.ubuntu.com/p/4ZmKmP2xTm/
> > > > > > >
> > > > > >
> > > > > > Thanks. I have updated my SMBIOS patches to take the processor version
> > > > > > 'eMAG' into account, which appears to be what these boxes are using.
> > > > > >
> > > > > > I have updated the efi/urgent branch here with the latest versions.
> > > > > > Mind giving them a spin?
> > > > > >
> > > > > >
> > > > > > In the mean time, just for the record - could you please run this as well?
> > > > > >
> > > > > > hexdump -C /sys/firmware/dmi/entries/4-0/raw
> > > > > >
> > > > > > (as root)
> > > > >
> > > > > hm.. I don't have that in /sys/firmware/, this is what I have:
> > > > >
> > > > > # ls -l /sys/firmware/dmi/
> > > > > total 0
> > > > > drwxr-xr-x 2 root root 0 Mar 16 13:26 tables
> > > > > # ls -l /sys/firmware/dmi/tables/
> > > > > total 0
> > > > > -r-------- 1 root root 5004 Mar 16 13:26 DMI
> > > > > -r-------- 1 root root   24 Mar 16 13:26 smbios_entry_point
> > > > >
> > > >
> > > > You'll need to load the dmi_sysfs module for that. But no big deal
> > > > otherwise, I'm pretty sure the word order is the correct on on your
> > > > system in any case (it decodes the value correctly in the next line)
> > >
> > > ok, much better after modprobe dmi_sysfs. :)
> > >
> >
> > Yeah better, thanks.
> >
> > > $ sudo hexdump -C /sys/firmware/dmi/entries/4-0/raw
> > > 00000000  04 30 04 00 01 03 fe 02  02 00 3f 50 00 00 00 00  |.0........?P....|
> > > 00000010  03 89 b8 0b e4 0c b8 0b  41 06 05 00 06 00 07 00  |........A.......|
> > > 00000020  04 00 00 20 20 20 7c 00  01 01 00 00 00 00 00 00  |...   |.........|
> > > 00000030  43 50 55 20 31 00 41 6d  70 65 72 65 28 54 4d 29  |CPU 1.Ampere(TM)|
> > > 00000040  00 65 4d 41 47 20 00 30  30 30 30 30 30 30 30 30  |.eMAG .000000000|
> >
> > Darn, this means we have to match for "eMAG " (with the trailing
> > space) so the branch i just pushed needs to be updated for this.
> >
> 
> I.e.,
> 
> --- a/drivers/firmware/efi/libstub/arm64.c
> +++ b/drivers/firmware/efi/libstub/arm64.c
> @@ -36,7 +36,7 @@ static bool system_needs_vamap(void)
>         default:
>                 version = efi_get_smbios_string(&record->header, 4,
>                                                 processor_version);
> -               if (!version || strcmp(version, "eMAG"))
> +               if (!version || strncmp(version, "eMAG", 4))
>                         break;
> 
>                 fallthrough;

OK, I can add that and test it.

-Andrea
