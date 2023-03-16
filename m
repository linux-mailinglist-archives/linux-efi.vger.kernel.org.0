Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E86BCE45
	for <lists+linux-efi@lfdr.de>; Thu, 16 Mar 2023 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCPLeO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Mar 2023 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCPLeB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Mar 2023 07:34:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB9D30B
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 04:34:00 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E23BD41BA8
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678966437;
        bh=Mpm31NliFgs0ydzc6S3DaZ/Zls4Qi0OVxpRYVFsfdKk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=kNDknlVwlPTVzd9EnRsjfdQCZXmU7d0TX5ky2GUpVCBqh3DOdQdLNn1czW0XYElHH
         mx/G6q/HjCXqLLyW2YVT2K2GZswRH9RPHCZQwBjgYtVbM5K2yqyeygbaDn0thTgOGE
         HST5Eq86nDynu3K9TiPdEPmroAjv06mlrwubltEOnX/XpOhJdU6ZWPXZRNvFq4zJ9f
         DyknjycBi+U6lAIW7W17j4wXqEYo/f7E274aWgtFn9pccFoC+EWys/6XRjRNqbNZza
         2i1oJ5jbEQMgaxzuZNLJ3i1r9Hk7FeMAW6QaMFBk2VBbKJJmogoqUnDpGZW8/MNinO
         bodqQdbjMPM8g==
Received: by mail-ed1-f69.google.com with SMTP id w6-20020a05640234c600b004fc0e5b4433so2565224edc.18
        for <linux-efi@vger.kernel.org>; Thu, 16 Mar 2023 04:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mpm31NliFgs0ydzc6S3DaZ/Zls4Qi0OVxpRYVFsfdKk=;
        b=kMQLZJd9T1+4bMgvw/2ral1/f2jCkbDzeGBof1Y//Oyijvkb/gZ+LYP/5IRkSCOg3P
         bwHOaSal5tHhlTxvRD/+ZovAfN+87LA3aemR0/rJN0h/wbrJp5iHVHH2ItR2guR9t9VJ
         mL77fVQkTO8p7xA7v+xJcha+ARc81dyHkrXXIWuspCs+CWACPys1yDNoFJR+bZ+Q/I97
         81r1gh69SMPeOwgfwyYtn/gIYC0z0g+LUoIUOsmk0EzykoAphURCdQUR8qSOSinWMHBS
         EP2O8wWaV1gUCXzzIS9boTueXwckwzMybEuNmx5LmcSvko7ylk2B4lmi+fsoCPO400Z/
         cBWg==
X-Gm-Message-State: AO0yUKWS4h9+qISOpCLM1VHOKkgtgcc0xpqLz6tmwLTO9DcwAD8q25jS
        Um1r0cFMtsKX+JKWt0q87+dkr1h9q3Nn5dH+U7McIGHqvLPpjzId7FzWu1UMH6mdGlcueM5W3Np
        1bl/X+GJYWpjU+Si1N5HSOpqAEe8uCjv5ZRn046Pob4yK21sg
X-Received: by 2002:a17:906:4d53:b0:926:e917:133c with SMTP id b19-20020a1709064d5300b00926e917133cmr10258743ejv.47.1678966436961;
        Thu, 16 Mar 2023 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: AK7set+PgHth3qWZf6VcyjKGp4GUyLDJ6SCZCRIWk0t0BEGs5o7U+BS0eITXVTXOby5ZEIb4RFWivA==
X-Received: by 2002:a17:906:4d53:b0:926:e917:133c with SMTP id b19-20020a1709064d5300b00926e917133cmr10258725ejv.47.1678966436678;
        Thu, 16 Mar 2023 04:33:56 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b00930c7b642d0sm413338ejb.166.2023.03.16.04.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:33:56 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:33:55 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBL+o7ydLk2iBCCr@righiandr-XPS-13-7390>
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
 <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
 <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
 <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
 <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF_f4QFtaDYBaSJwO0B97TJHWr6uRQdeYeD=Gv7DrVicg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 16, 2023 at 11:18:21AM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 11:03, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> > > (cc Darren)
> > >
> > > On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > > > Hello Andrea,
> > > > >
> > > > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > > > gets stuck and never completes the boot. On the console I see this:
> > > > > >
> > > > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > > > [   72.064949] Task dump for CPU 22:
> > > > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > > > [   72.082595] Call trace:
> > > > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > > > [   72.088508]  0xffff80000fe83d4c
> > > > > >
> > > > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > > > >
> > > > > > I tried to bisect the problem and I found that the offending commit is
> > > > > > this one:
> > > > > >
> > > > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > > > >
> > > > > > I've reverted this commit for now and everything works just fine, but I
> > > > > > was wondering if the problem could be caused by a lack of entropy on
> > > > > > these arm64 boxes or something else.
> > > > > >
> > > > > > Any suggestion? Let me know if you want me to do any specific test.
> > > > > >
> > > > >
> > > > > Thanks for the report.
> > > > >
> > > > > This is most likely the EFI SetVariable() call going off into the
> > > > > weeds and never returning.
> > > > >
> > > > > Is this an Ampere Altra system by any chance? Do you see it on
> > > > > different types of hardware?
> > > >
> > > > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> > > >
> > > > >
> > > > > Could you check whether SetVariable works on this system? E.g. by
> > > > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> > > >
> > > > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > > > ^C^C^C^C
> > > >
> > > > ^ Stuck there, so it really looks like SetVariable is the problem.
> > > >
> > >
> > > Could you please share the output of
> > >
> > > dmidecode -s bios
> > > dmidecode -s system-family
> >
> > $ sudo dmidecode -s bios-vendor
> > LENOVO
> > $ sudo dmidecode -s bios-version
> > hve104r-1.15
> > $ sudo dmidecode -s bios-release-date
> > 02/26/2021
> > $ sudo dmidecode -s bios-revision
> > 1.15
> > $ sudo dmidecode -s system-family
> > Lenovo ThinkSystem HR330A/HR350A
> >
> 
> Thanks
> 
> Mind checking if this patch fixes your issue as well?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=altra-fix&id=77fa99dd4741456da85049c13ec31a148f5f5ac0

Unfortunately this doesn't seem to be enough, I'm still getting the same
problem also with this patch applied.

-Andrea
