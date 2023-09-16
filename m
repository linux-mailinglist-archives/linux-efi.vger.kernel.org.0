Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF047A321E
	for <lists+linux-efi@lfdr.de>; Sat, 16 Sep 2023 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIPTOz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 Sep 2023 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjIPTOy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 Sep 2023 15:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D3CE8;
        Sat, 16 Sep 2023 12:14:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F4C433CD;
        Sat, 16 Sep 2023 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694891688;
        bh=GhEPs001caUtxwRsE4CgbQic7rBW6RkecWPBoHLDshg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B6EpN3T7NeJLqmpijC2ABe3zkhN7Mky/SKq3Wy46erS33iNYDHo7ePdb5NvptwhFH
         ZNfNeWEo+sda6PO1R1CRfd0MP7I/mQpofgcocUqbtTA67QvdCiouPO6SLpdwHR1NBh
         jiu+Qvj8LtBdpdg72StJjUpp7l7Mv0IaM6co40P+VNwlC4q/Voj9opKgn7iavZOv8e
         HzATNC1jVbdXapmA9prWf3+2NI8LUO/XpZtg3s1NZHsQhDOVtAmBzBa2ui376mBqMn
         jV4DLhWB7iSfG54I5vJOL33l/0wB6x2WEcRefcGRFsQUptvp19JvE/D37xpBfDjMuf
         6T+naGWoHW3bA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b962c226ceso51990651fa.3;
        Sat, 16 Sep 2023 12:14:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwtsSuuk7ntRLQuFwz5nc1ivw4B7EPwH3hQ/0WfJ0BdeUGdx9V
        64iuqp2fHZH82bwBnluNgIcaxlOGB3pAC2MCwxM=
X-Google-Smtp-Source: AGHT+IFFfllFzyDKsE+GvRpJHheHwfGf/pRlgEDGGKEVgxkT9+rKubZ/wvd926AEUbG6IJatdHLJbJlkSf+hRxAbKoc=
X-Received: by 2002:a2e:680c:0:b0:2bd:133c:58ff with SMTP id
 c12-20020a2e680c000000b002bd133c58ffmr3852284lja.48.1694891686814; Sat, 16
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZQQiUxh5vmeZnp7s@gmail.com>
 <ZQRAckHVxQZRNEGA@gmail.com> <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
 <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com> <ZQVxIIh1byq65lK/@gmail.com>
In-Reply-To: <ZQVxIIh1byq65lK/@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 16 Sep 2023 21:14:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH7b+TRajewcY0hzh_j0qMV+X9Nm2PNFftWTTEBp9xr5g@mail.gmail.com>
Message-ID: <CAMj1kXH7b+TRajewcY0hzh_j0qMV+X9Nm2PNFftWTTEBp9xr5g@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 16 Sept 2023 at 11:11, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > > So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage bootup,
> > > > due to the 8th patch:
> > > >
> > > >   988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
> > > >   commit 988b52b207a9fe74c3699bda8c2256714926b94b
> > > >   Author: Ard Biesheuvel <ardb@kernel.org>
> > > >   Date:   Tue Sep 12 09:01:01 2023 +0000
> > > >
> > > >       x86/boot: Define setup size in linker script
> > > >
> > > > I've removed it for now - but this side effect was not expected.
> > > >
> > >
> > > No, definitely not expected. I tested various combinations of i386 /
> > > x86_64 built with GCC / Clang doing EFI or BIOS boot.
> > >
> > > I'll rebase the remaining stuff onto -tip and see if I can reproduce this.
> >
> > This is actually quite bizarre. x86_64_defconfig has
> > CONFIG_EFI_MIXED=y and i tested that this change produces the exact
> > same bzImage binary in that case.
> >
> > Could you send me the .config and the QEMU command line perhaps?
>
> So the patch below is the delta between v2 and v3 - that is expected
> to fix the bzImage boot crash, right?
>

Yes.

ld.bfd does something unexpected [to me] here, and the resulting value
turns out not to be a multiple of 512 at all.

With this tweak, my claim that this patch does not affect the binary
bzImage at all actually holds for ld.bfd as well (provided that
CONFIG_EFI_MIXED=y and CONFIG_LOCAL_VERSION_AUTO is disabled)

So if this still does not work in your test, could you please disable
CONFIG_LOCAL_VERSION_AUTO and compare the md5sums of the two builds?

Thanks,


> --- tip.orig/arch/x86/boot/setup.ld
> +++ tip/arch/x86/boot/setup.ld
> @@ -41,7 +41,7 @@ SECTIONS
>                 LONG(0x5a5aaa55)
>
>                 /* Reserve some extra space for the reloc and compat sections */
> -               setup_size = ABSOLUTE(ALIGN(. + 64, 512));
> +               setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
>                 setup_sects = ABSOLUTE(setup_size / 512);
>         }
>
>
