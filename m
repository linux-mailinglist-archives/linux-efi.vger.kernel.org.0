Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294585F2582
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 23:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJBVng (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 17:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJBVnf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 17:43:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F3337F89
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 14:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC34B80DD4
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 21:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E322C43142
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664747011;
        bh=IAPSgTIJ2zWHmsG/r3356fUhr6dadqjrzGJLMrSOPZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3PVkcW1VFO5tHecQ62YmtGJqa/Trl+xbSnKgdsr9BeaI3b1FRi3piTdyidsrbemE
         7JVAEt2WCtsGYZeGhQivdX0sY8pz2/7F6A95sTpUAiR99th5Q2TFtdO2X8kBVSMtFb
         H/NBbWLQf4Bq0pu1E+nA1WOkWjWvafgbpo/vh+Dch9jz3KhH7Ouqxyh3bpb0Ifp2u4
         BV5LQzrYohl/NMmrOhbRsoOj8agJmKzK4QE2EeALzgqFgW2Wwzc/Pupem0XUUZ9eUd
         yoY6hyv2OKCfIiVoaekI7Rjrf5fJ8zszXqj4vSgpIiH8i1lBWdmg703WrjDpuQjCdG
         osqwUex8gaPOQ==
Received: by mail-lf1-f46.google.com with SMTP id o7so6870423lfk.7
        for <linux-efi@vger.kernel.org>; Sun, 02 Oct 2022 14:43:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf1r1zp5cAFSP+4vdFKeiqGKk6ElgKzxnlMoVl6BLw3W9FQvISzF
        ZWnrXPIwVNOLcVR3OaW52CFSGWXYtrBVM79HfkM=
X-Google-Smtp-Source: AMsMyM585Xujcy26w6Ya5o+jV4sDOXs2w1GklBdKzIVYftuz6Q4NJYiDHea6a2mBWjS3AxbZTV8fZ2FoQ/xS1ntA6VE=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr393347lfc.228.1664747009153; Sun, 02
 Oct 2022 14:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221002095626.484279-1-ardb@kernel.org> <20221002095626.484279-6-ardb@kernel.org>
 <Yzm8HIccvuxyicYx@itl-email>
In-Reply-To: <Yzm8HIccvuxyicYx@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 2 Oct 2022 23:43:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG-0Bpc5B08EAJTGsNKan4S4628Wwz7wPh-EAY9p4zg1Q@mail.gmail.com>
Message-ID: <CAMj1kXG-0Bpc5B08EAJTGsNKan4S4628Wwz7wPh-EAY9p4zg1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] efi: esrt: Omit region sanity check when no
 memory map is available
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2 Oct 2022 at 18:28, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Sun, Oct 02, 2022 at 11:56:26AM +0200, Ard Biesheuvel wrote:
> > In order to permit the ESRT to be used when doing pseudo-EFI boot
> > without a EFI memory map, e.g., when booting inside a Xen dom0 on x86,
> > make the sanity checks optional based on whether the memory map is
> > available.
> >
> > If additional validation is needed, it is up to the Xen EFI glue code t=
o
> > implement this in its xen_efi_config_table_is_valid() helper, or provid=
e
> > a EFI memory map like it does on other architectures.
>
> I don=E2=80=99t like this.  It is easy to use a hypercall to get the end =
of the
> memory region containing the config table, which is what my one of my
> previous patches actually does.  Skipping all of the validation could
> easily lead to a regression.

I don't like putting Xen specific hacks left and right because Xen on
x86 cannot be bothered to provide an EFI memory map. And as for
regressions, ESRT does not work at all under Xen (given the lack of a
memory map) and so I fail to see how this could break a currently
working case.

>  I understand wanting to get Xen-specific
> code out of esrt.c, but this isn=E2=80=99t the answer.  Some sort of abst=
raction
> over both cases would be a much better solution.
>

We have such an abstraction already, it is called the EFI memory map.

So there are two options here:
- expose a EFI memory map
- add a ESRT specific check to xen_efi_config_table_is_valid() so that
the ESRT is withheld from dom0 if there is something wrong with it.

And frankly, the validation itself could use some attention as well:

"""
rc =3D efi_mem_desc_lookup(efi.esrt, &md);
...
max =3D efi_mem_desc_end(&md);
if (max < efi.esrt) {
"""

Unless I am missing something, this can never occur so the check is
pointless and the pr_err() that follows is unreachable.

Then we have

"""
size =3D sizeof(*esrt);
max -=3D efi.esrt;

if (max < size) {
"""

'size' is 16 bytes here, so the only way this can become true is if
the memory descriptor describes a region of 0 pages in length, which
is explicitly forbidden by the EFI spec. If such a descriptor exists
in spite of that, this is a memory map problem not a ESRT problem.

So actually, instead of making these checks conditional on EFI_MEMMAP
being set, I might just rip them out entirely and be done with it.



> > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/platform/efi/quirks.c |  3 +
> >  drivers/firmware/efi/esrt.c    | 61 +++++++++++---------
> >  2 files changed, 37 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/qui=
rks.c
> > index b0b848d6933a..9307be2f4afa 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -250,6 +250,9 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, =
u64 size)
> >       int num_entries;
> >       void *new;
> >
> > +     if (!efi_enabled(EFI_MEMMAP))
> > +             return;
> > +
>
> This function does not actually work under Xen, even if EFI_MEMMAP is
> set.  When running under Xen, either this function must never be
> called (in which case there should be at least a WARN()), or it should
> return an error that callers must check for.
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
