Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30635C9C6
	for <lists+linux-efi@lfdr.de>; Mon, 12 Apr 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242632AbhDLPY5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Apr 2021 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbhDLPY4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Apr 2021 11:24:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A3C06138C
        for <linux-efi@vger.kernel.org>; Mon, 12 Apr 2021 08:24:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w23so5117352ejb.9
        for <linux-efi@vger.kernel.org>; Mon, 12 Apr 2021 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G2tox/5m4T/HeFq4NSDfjHHOjATezp74lQScw7HLYNk=;
        b=qCXFxOYALI8moZOeo7qPmtuOU21OMQ00k0JLMLt6mfN5O1G8oP7HqGgx6ug6md4tWA
         /lJ5RkZQ3khy3AOEw1s0PIye1kwTnhV5IBTXgR2yvOb4M5V1T4RXTKD+DGhIfW91PE24
         ys3Xt5zQYN7fJPDvtnohuHy1fgkP6yHG/H63wtYVmSRqyb+pm+cpolEroSMxsYid7yrZ
         E3NLPYTSK3NLp3P7SwzNczwxfUzzdluk7wxhSZlJGVNHayzg4wZTDEXUw53O1IuxgaIM
         WEKw9qNA3yNOvt/g4wzLvY9hWfpdHV7/s7orqLKped5Vh52XclKirenwJa/cFl2Dn16w
         KfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G2tox/5m4T/HeFq4NSDfjHHOjATezp74lQScw7HLYNk=;
        b=GiIldZuwB+UwRpeJOSLuIbhit7MSQXkQ/GMnDlbKxtuqPAyK8l8YwTJcn0ZcoOoMhD
         hceV4bmTduSMsoCv9Xo0tnChfmzvkEetKMANBoOLRaHjdAboBE0lIAHAGBW4jg+xlK/y
         poxkuTbiAFA5C5KhVyYDGDeIto+Eu9FTZ07u8pLtuh6z6P2Kdp/5owK/3jQSyuf9zE/p
         1SvJPrkSOJX1S5PzLLETVMGLPEHExiMmOrWqQxpEZsdzG38FJ52FCp5r/yplS4kLSzpA
         arUBFcnMTMUdHTyj+LaXi5ohYAdvMRz5baOTPHVxsFDxijqnpuf2DrZQau3j6GIAM48d
         UcnA==
X-Gm-Message-State: AOAM531VwYqJlEtAgqsoHfoybvQrGviLjBKgdDJot7V6nKYSUUkxbm26
        s5I1Z2mGm8hNaJ+SGSlZ/FCytk+FagN55HMUDAJ5yg==
X-Google-Smtp-Source: ABdhPJwLnf3+Eim3NF91XxF3HcZvWvxbSm8si58lnBSwbyAw56oxGWqpmmmlQ69EAC9KkLz4vfsxjoRe2QhBBSci0Cs=
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr19241777ejb.253.1618241076976;
 Mon, 12 Apr 2021 08:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210412011347.GA4282@MiWiFi-R3L-srv> <8FAA2A0E-0A09-4308-B936-CDD2C0568BAE@amacapital.net>
 <20210412095231.GC4282@MiWiFi-R3L-srv>
In-Reply-To: <20210412095231.GC4282@MiWiFi-R3L-srv>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 12 Apr 2021 08:24:25 -0700
Message-ID: <CALCETrV0dgn1=7CoB+BSHdDuzqtfpKGOPvjJg+sNo74VrcJE=A@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
To:     Baoquan He <bhe@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 12, 2021 at 2:52 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/11/21 at 06:49pm, Andy Lutomirski wrote:
> >
> >
> > > On Apr 11, 2021, at 6:14 PM, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > =EF=BB=BFOn 04/09/21 at 07:59pm, H. Peter Anvin wrote:
> > >> Why don't we do this unconditionally? At the very best we gain half =
a megabyte of memory (except the trampoline, which has to live there, but i=
t is only a few kilobytes.)
> > >
> > > This is a great suggestion, thanks. I think we can fix it in this way=
 to
> > > make code simpler. Then the specific caring of real mode in
> > > efi_free_boot_services() can be removed too.
> > >
> >
> > This whole situation makes me think that the code is buggy before and b=
uggy after.
> >
> > The issue here (I think) is that various pieces of code want to reserve=
 specific pieces of otherwise-available low memory for their own nefarious =
uses. I don=E2=80=99t know *why* crash kernel needs this, but that doesn=E2=
=80=99t matter too much.
>
> Kdump kernel also need go through real mode code path during bootup. It
> is not different than normal kernel except that it skips the firmware
> resetting. So kdump kernel needs low 1M as system RAM just as normal
> kernel does. Here we reserve the whole low 1M with memblock_reserve()
> to avoid any later kernel or driver data reside in this area. Otherwise,
> we need dump the content of this area to vmcore. As we know, when crash
> happened, the old memory of 1st kernel should be untouched until vmcore
> dumping read out its content. Meanwhile, kdump kernel need reuse low 1M.
> In the past, we used a back up region to copy out the low 1M area, and
> map the back up region into the low 1M area in vmcore elf file. In
> 6f599d84231fd27 ("x86/kdump: Always reserve the low 1M when the crashkern=
el
> option is specified"), we changed to lock the whole low 1M to avoid
> writting any kernel data into, like this we can skip this area when
> dumping vmcore.
>
> Above is why we try to memblock reserve the whole low 1M. We don't want
> to use it, just don't want anyone to use it in 1st kernel.
>
> >
> > I propose that the right solution is to give low-memory-reserving code =
paths two chances to do what they need: once at the very beginning and once=
 after EFI boot services are freed.
> >
> > Alternatively, just reserve *all* otherwise unused sub 1M memory up fro=
nt, then release it right after releasing boot services, and then invoke th=
e special cases exactly once.
>
> I am not sure if I got both suggested ways clearly. They look a little
> complicated in our case. As I explained at above, we want the whole low
> 1M locked up, not one piece or some pieces of it.

My second suggestion is probably the better one.  Here it is, concretely:

The early (pre-free_efi_boot_services) code just reserves all
available sub-1M memory unconditionally, but it specially marks it as
reserved-but-available-later.  We stop allocating the trampoline page
at this stage.

In free_efi_boot_services, instead of *freeing* the sub-1M memory, we
stick it in the pile of reserved memory created in the early step.
This may involve splitting a block, kind of like the current
trampoline late allocation works.

Then, *after* free_efi_boot_services(), we run a single block of code
that lets everything that wants sub-1M code claim some.  This means
that the trampoline gets allocated and, if crashkernel wants to claim
everything else, it can.  After that, everything still unclaimed gets
freed.

Does that make sense?

--Andy
