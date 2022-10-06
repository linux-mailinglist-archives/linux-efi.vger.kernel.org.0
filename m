Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA55F653A
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiJFLaN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 07:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJFLaM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 07:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66225C75;
        Thu,  6 Oct 2022 04:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1251B82064;
        Thu,  6 Oct 2022 11:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F4C433C1;
        Thu,  6 Oct 2022 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665055808;
        bh=5LgFNtqy92bY4lq9P95C4sy291naVE3GnG0i/RMkzbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P6NQcbHXdPZp8W9Pw42UETn4EjjGM5QpEZsRP7CRLrGxZlztZP+2G7F6x0Q28ksl3
         C1vHQ5+LqNVj1yx+pedKx6UbWMCm0gPos9VnPv63d43XlZY24vcPObo/IMdMB3BDfT
         uMOyAWtwFzp//ycCsakb80xlgBMHo7nw3yyI5ZGxezfI2XO8pOYj4sin2ylHeXmD/I
         TFubWaiiKYNWHQ03jfdTNdontrLcESSZJgIE+UPhZGzfbAM3Hr1JAYgLI/XU/GDsMv
         SMOpmx9utBZsdXSp2gB4g60XI5s0ByfUs5aUVAdYXVcYHrdae94PNjp4SW/ZKiE2dA
         UpAwNxwY5W/Rw==
Received: by mail-lf1-f42.google.com with SMTP id y5so2255414lfl.4;
        Thu, 06 Oct 2022 04:30:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Reskrj73XOjt3KPGoArbBMph/AKxjfV9v4Fk4Sufe/PmjoZxC
        HugZ7Q/aVONPe9O0L215h7iwLRRetCGbxpD/UMI=
X-Google-Smtp-Source: AMsMyM66STFwycI1XvAGvGAEuWxPj9W08DY3UOKK0pq6bPj+0Iew3OYSo3gmiYwpiBHSgw/LqoRkYZxrISlEynaahTo=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr1628632lfc.228.1665055806638; Thu, 06
 Oct 2022 04:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145422.437618-1-ardb@kernel.org> <20220921145422.437618-4-ardb@kernel.org>
 <Yz615Qc1K284jlH9@zn.tnic>
In-Reply-To: <Yz615Qc1K284jlH9@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 13:29:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGfMp_nquvL2ECchof_BMZ54tZK5JwrXno4VO6nGCJVAA@mail.gmail.com>
Message-ID: <CAMj1kXGfMp_nquvL2ECchof_BMZ54tZK5JwrXno4VO6nGCJVAA@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] x86/compressed: efi-mixed: move bootargs parsing
 out of 32-bit startup code
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Oct 2022 at 13:03, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 21, 2022 at 04:54:09PM +0200, Ard Biesheuvel wrote:
> > Move the logic that chooses between the different EFI entrypoints out of
> > the 32-bit boot path, and into a 64-bit helper that can perform the same
> > task much more cleanly. While at it, document the mixed mode boot flow
> > in a code comment.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/efi_mixed.S | 43 ++++++++++++++++++++
> >  arch/x86/boot/compressed/head_64.S   | 24 ++---------
> >  2 files changed, 47 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> > index 67e7edcdfea8..77e77c3ea393 100644
> > --- a/arch/x86/boot/compressed/efi_mixed.S
> > +++ b/arch/x86/boot/compressed/efi_mixed.S
> > @@ -22,6 +22,49 @@
> >
> >       .code64
> >       .text
> > +/*
> > + * When booting in 64-bit mode on 32-bit EFI firmware, startup_64_mixedmode()
> > + * is the first thing that runs after switching to long mode. Depending on
> > + * whether the EFI handover protocol or the compat entry point was used to
> > + * enter the kernel, it will either branch to the 64-bit EFI handover
> > + * entrypoint at offset 0x390 in the image, or to the 64-bit EFI PE/COFF
> > + * entrypoint efi_pe_entry(). In the former case, the bootloader must provide a
> > + * struct bootparams pointer as the third argument, so the presence of such a
> > + * pointer is used to disambiguate.
> > + *
> > + *                                                             +--------------+
> > + *  +------------------+     +------------+            +------>| efi_pe_entry |
> > + *  | efi32_pe_entry   |---->|            |            |       +-----------+--+
> > + *  +------------------+     |            |     +------+---------------+   |
> > + *                           | startup_32 |---->| startup_64_mixedmode |   |
> > + *  +------------------+     |            |     +------+---------------+   V
> > + *  | efi32_stub_entry |---->|            |            |     +------------------+
> > + *  +------------------+     +------------+            +---->| efi64_stub_entry |
> > + *                                                           +-------------+----+
> > + *                           +------------+     +----------+               |
> > + *                           | startup_64 |<----| efi_main |<--------------+
> > + *                           +------------+     +----------+
> > + */
>
> That is much appreciated.
>
> Questions:
>
> - is this whole handover ABI documented somewhere?
>

Documentation/x86/boot.rst has a section on this (at the end), but we
should really stop using it. It is only implemented by out-of-tree
GRUB at the moment (last time I checked) and leaking all those struct
bootparams specific details into every bootloader is not great,
especially the ones that intend to be generic and boot any EFI OS on
any EFI arch.


> - efi32_pe_entry() is the 32-bit PE/COFF entry point? I.e., that is
> called by a 32-bit EFI fw when the kernel is a PE/COFF executable?
>

Yes. But I should note that this is actually something that goes
outside of the EFI spec as well: 32-bit firmware can /load/ 64-bit
PE/COFF binaries but not *start* them.

Commit 97aa276579b28b86f4a3e235b50762c0191c2ac3 has some more
background. This is currently implement by 32-bit OVMF, and
systemd-boot.

> But then Documentation/admin-guide/efi-stub.rst talks about the EFI stub
> and exactly that. Hmm, so what is efi32_pe_entry() then?
>

That is the same thing. The EFI stub is what enables the kernel (or
decompressor) to masquerade as a PE/COFF executable.

In short, every EFI stub kernel on every architecture has a native
PE/COFF entry point that calls the EFI stub, and the EFi stub does the
arch-specific bootloader work and boots it.

In addition, the x86_64 EFI stub kernel has an extra, non-native
PE/COFF entry point, which is exposed in a way that is not covered by
the EFI spec, but which allows Linux specific loaders such as
systemd-boot to boot such kernels on 32-bit firmware without having to
do the whole struct bootparams dance in the bootloader.
