Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D703FCD49
	for <lists+linux-efi@lfdr.de>; Tue, 31 Aug 2021 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHaS7S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Aug 2021 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbhHaS7M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Aug 2021 14:59:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D5C0613D9
        for <linux-efi@vger.kernel.org>; Tue, 31 Aug 2021 11:58:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l3so185327pji.5
        for <linux-efi@vger.kernel.org>; Tue, 31 Aug 2021 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hja3k4ZIoHMyQ4VMtlG5szRRbScDh1UjpE02C2d4Keg=;
        b=kicsjtll2NsAKBfjPi48UpmCfWsb4FJEcTRGcrE5uks4vHLsX71gqk79m8Us/tamin
         XNurIf+3NS5RgfXBPJDOh5b+AFFP3+H7hsFSxfL9Vwb+FBInOrB3bUMzGzI4HG1pv0yo
         qByPbg69R4mh1iyiutn783XwUDEuViZZh+wWLzAxV8KNPAXLYMLnMQ7ZIC5dBF/jJ0Uf
         ATOJBlEbDfKr49CyoQE3NS/wdpgXRK43XqUolPGY7v+/2iaZWnEhp4NxfHpSzOq8tAFY
         KPm7dvp3HOyllOHPqJ3OaYwVF710GR7FGM2+FU87sCMEW7HnJZYMbvATrp2kicNQo/Lp
         wZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hja3k4ZIoHMyQ4VMtlG5szRRbScDh1UjpE02C2d4Keg=;
        b=VRfxI64PtD0ZPyutRF+9Cg6lveJlYv22UVPSKsCuF0qp32MZ06il8JQKR1NbzpU9BZ
         akoa98qKOHLYEek+OqbG3DK6K/qdAejyOhEEeuOdgzoefIUDAmbvVLxKQYO4c5+bhSHH
         OEdLBmtEGXOoxPuP3nSlk2Yv6oPU46Eqml/PwwLDYzYoP4oFR2vKFuwSs8s8G4qOsEK8
         K5svxWZhMwH1rE172N0cllDcQ4Aex9Q6CojCCo9J/3THw4uBrn7qz2mpzbD6uOWoiH28
         gsQlroHF2HEuB77LBmgwCp30jd9Uo59/T/r+B3PMdJe3Pqocxs0cG8dPENe5RTXZEfJf
         t14g==
X-Gm-Message-State: AOAM531hvaTdhkXnUBG+V73WvBmuQO/xWgpjF09VFt8MgNauRVcC2qud
        itL7lHCPf7ecTuANF8oCJe/soRUg4KMM7VkmcLwdMg==
X-Google-Smtp-Source: ABdhPJwoE2JSRabTcXsiA1AgYUTphGBwkKAbOMuVGJ2LSP+gzTcAsVPbn/x852sYGDfXxMDArhTShQzlDIpbLKeNN64=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr7220358pjk.13.1630436296443;
 Tue, 31 Aug 2021 11:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com> <CAPcyv4jvR8CT4rYODR5KUHNdiqMwQSwJZ+OkVf61kLT3JfjC_Q@mail.gmail.com>
 <CAFqZXNtuH0329Xvcb415Kar-=o6wwrkFuiP8BZ_2OQhHLqkkAg@mail.gmail.com> <CAHC9VhTGECM2p+Q8n48aSdfJzY6XrpXQ5tcFurjWc4A3n8Qxjg@mail.gmail.com>
In-Reply-To: <CAHC9VhTGECM2p+Q8n48aSdfJzY6XrpXQ5tcFurjWc4A3n8Qxjg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Aug 2021 11:58:05 -0700
Message-ID: <CAPcyv4i8YXo=xOL2vO67KLABQRDNAxzrzT=a1xtwtrts5pVPKw@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        X86 ML <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 31, 2021 at 6:53 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Aug 31, 2021 at 5:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Sat, Jun 19, 2021 at 12:18 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > On Wed, Jun 16, 2021 at 1:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...
>
> > > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > > index 2acc6173da36..c1747b6555c7 100644
> > > > --- a/drivers/cxl/mem.c
> > > > +++ b/drivers/cxl/mem.c
> > > > @@ -568,7 +568,7 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
> > > >         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
> > > >                 return false;
> > > >
> > > > -       if (security_locked_down(LOCKDOWN_NONE))
> > > > +       if (security_locked_down(current_cred(), LOCKDOWN_NONE))
> > >
> > > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > ...however that usage looks wrong. The expectation is that if kernel
> > > integrity protections are enabled then raw command access should be
> > > disabled. So I think that should be equivalent to LOCKDOWN_PCI_ACCESS
> > > in terms of the command capabilities to filter.
> >
> > Yes, the LOCKDOWN_NONE seems wrong here... but it's a pre-existing bug
> > and I didn't want to go down yet another rabbit hole trying to fix it.
> > I'll look at this again once this patch is settled - it may indeed be
> > as simple as replacing LOCKDOWN_NONE with LOCKDOWN_PCI_ACCESS.
>
> At this point you should be well aware of my distaste for merging
> patches that have known bugs in them.  Yes, this is a pre-existing
> condition, but it seems well within the scope of this work to address
> it as well.
>
> This isn't something that is going to get merged while the merge
> window is open, so at the very least you've got almost two weeks to
> sort this out - please do that.

Yes, apologies, I should have sent the fix shortly after noticing the
problem. I'll get the CXL bug fix out of the way so Ondrej can move
this along.
