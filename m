Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E257566E8
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjGQO4x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGQO4w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 10:56:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09A10C0;
        Mon, 17 Jul 2023 07:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17FAD610FB;
        Mon, 17 Jul 2023 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F949C433C9;
        Mon, 17 Jul 2023 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689605810;
        bh=fMVMLDyaT91QMS4Y0JqnqMsVXKFXNflrRoMtl9SJR0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4fmjA4IrIiL5blX9/bh3cQWJdD7r2RrzlJ5sQWbdRx+emBJ9qnfSPhzsIfp4fARl
         KUMfdReB5CkdxvD93jRzR+sHsQF7ZRUJeCEflWspo+xG53qDP6PhOkCqFRD3fuBUsc
         oiY76T1DxZ52Eh1AW/4ZRnOFYr4vyvZcN/bbXNKmccEJdFF10Ql07jUYm1/yyEHtS0
         zPGezh34UnfoN9pwTypMk9DhBQD4feVL6h/pKyzAYu4xMLisuudukbivDZm7p/F7YY
         Rm+NH3q2h+UE5DHILPyUUrweFs+gaEziQVyf8LqfGQJ9Dpub7mzTdZI6WEgI60C6Bv
         OCZzddguyylUQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso70294721fa.1;
        Mon, 17 Jul 2023 07:56:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLaQ3ijffJgCvCjS1efISVHewFdNe2eaYx6r08wjQw1u4OzFXyT9
        wtY/ZzwS2oQYMeFqbGX/nfrVvknorOn1047WI7c=
X-Google-Smtp-Source: APBJJlGS2j/onhT+8KrLFfXCBR/cBjItbdLyFrBpTCKJFO4b8DuZWgzwV9I8vi2Psd5cnH5hGrGW+wehNKIRyuc0EvU=
X-Received: by 2002:a2e:700b:0:b0:2b6:cff1:cd1c with SMTP id
 l11-20020a2e700b000000b002b6cff1cd1cmr8535527ljc.34.1689605808535; Mon, 17
 Jul 2023 07:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
In-Reply-To: <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Jul 2023 16:56:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
Message-ID: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Tao Liu <ltao@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 17 Jul 2023 at 15:53, Tao Liu <ltao@redhat.com> wrote:
>
> Hi Borislav,
>
> On Thu, Jul 13, 2023 at 6:05=E2=80=AFPM Borislav Petkov <bp@alien8.de> wr=
ote:
> >
> > On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++--=
--
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > Ok, pls try this totally untested thing.
> >
> > Thx.
> >
> > ---
> > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/=
sev.c
> > index 09dc8c187b3c..fefe27b2af85 100644
> > --- a/arch/x86/boot/compressed/sev.c
> > +++ b/arch/x86/boot/compressed/sev.c
> > @@ -404,13 +404,20 @@ void sev_enable(struct boot_params *bp)
> >         if (bp)
> >                 bp->cc_blob_address =3D 0;
> >
> > +       /* Check for the SME/SEV support leaf */
> > +       eax =3D 0x80000000;
> > +       ecx =3D 0;
> > +       native_cpuid(&eax, &ebx, &ecx, &edx);
> > +       if (eax < 0x8000001f)
> > +               return;
> > +
> >         /*
> >          * Setup/preliminary detection of SNP. This will be sanity-chec=
ked
> >          * against CPUID/MSR values later.
> >          */
> >         snp =3D snp_init(bp);
> >
> > -       /* Check for the SME/SEV support leaf */
> > +       /* Recheck the SME/SEV support leaf */
> >         eax =3D 0x80000000;
> >         ecx =3D 0;
> >         native_cpuid(&eax, &ebx, &ecx, &edx);
> >
> Thanks a lot for the patch above! Sorry for the late response. I have
> compiled and tested it locally against 6.5.0-rc1, though it can pass
> the early stage of kexec kernel bootup,

OK, so that proves that the cc_blob table access is the culprit here.
That still means that kexec on SEV is likely to explode in the exact
same way should anyone attempt that.


> however the kernel will panic
> occasionally later. The test machine is the one with Intel Atom
> x6425RE cpu which encountered the page fault issue of missing efi
> config table.
>

Agree with Boris that this seems entirely unrelated.

> ...snip...
> [   21.360763]  nvme0n1: p1 p2 p3
> [   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
> [   21.421097] pps pps1: new PPS source ptp1
> [   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized): PHC=
 added
> [   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
> (5.0 GT/s PCIe x1 link)
> [   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
> [   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
> [   21.479446] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [   21.486405] #PF: supervisor read access in kernel mode
> [   21.491519] mmc1: Failed to initialize a non-removable card
> [   21.491538] #PF: error_code(0x0000) - not-present page
> [   21.502229] PGD 0 P4D 0
> [   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-rc1+=
 #1
> [   21.515905] Hardware name: ...snip...


Why are you snipping the hardware name?
