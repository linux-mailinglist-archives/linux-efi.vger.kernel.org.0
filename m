Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4F52E55C
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbiETGwW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiETGwV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 02:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75792562F9;
        Thu, 19 May 2022 23:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1987961DAD;
        Fri, 20 May 2022 06:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A1BC3411B;
        Fri, 20 May 2022 06:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653029539;
        bh=sgNd0vtqp83N2s1CaS4qcYCZ1Em1yEUBxHGWRZy2GF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJBTW/RwnaTwqYXJN8e7engo5uBawXCQTvmCdGvUS74l9X8TDS1QOyLsWI5uKXyLl
         z4mcTAEHIllWYWzAWLvEqFQSVWA32pMZOO5rV0hQ76pRqnCkjg+uHjPRlQhFvoL3pk
         S/APCr1bAALi9XnsrfiRcp5eTRBKjNuEkQjPgzSmc4cr82m2Yn2166lyMu8gdFNv+V
         9OQycaz9hf0jXTvYhYsi7Fap6X1mFAoahOANs7pZPkc4DkbDp15FLM1CMmm+YQalNU
         pIhNUBmoXl8vZ5ih7RzVCxqVn9MrEkNHQcn0ctt+y/zyJkvn1B8ldM3OjofP7BiqGf
         PPytbnwyBdBzA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f1d2ea701dso9333010fac.10;
        Thu, 19 May 2022 23:52:19 -0700 (PDT)
X-Gm-Message-State: AOAM533X3U4X/Fhw25PbbXfwFzto6i+qGsW8RxrTfTPiqX6yA2792NVz
        ga7asyjjoMNMeHEZ1KKb5h/eNHRt80EwpBmRW1Y=
X-Google-Smtp-Source: ABdhPJyUGKjChdSOGekyhnWuYeiWn9PaC4+0BZipYBFb+HJq3aKZ3nWX3el0jnXK/bPQXUK7A1ce3Km9EF5ppdRDfgo=
X-Received: by 2002:a05:6870:f112:b0:f1:f1e9:e8f1 with SMTP id
 k18-20020a056870f11200b000f1f1e9e8f1mr3897703oac.126.1653029538554; Thu, 19
 May 2022 23:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <20220419070150.254377-1-mawupeng1@huawei.com> <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
 <c65d22b4-f654-21aa-bd5f-d4f8b0939a25@huawei.com> <7058b8d8-c0cb-108e-0db9-2fdf5fb154cf@huawei.com>
In-Reply-To: <7058b8d8-c0cb-108e-0db9-2fdf5fb154cf@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 May 2022 08:52:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
Message-ID: <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support to relocate kernel image to mirrored region
To:     mawupeng <mawupeng1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, songmuchun@bytedance.com,
        macro@orcam.me.uk, Frederic Weisbecker <frederic@kernel.org>,
        W_Armin@gmx.de, John Garry <john.garry@huawei.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        chenhuacai@kernel.org, David Hildenbrand <david@redhat.com>,
        gpiccoli@igalia.com, Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-ia64@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 19 May 2022 at 13:09, mawupeng <mawupeng1@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/5/7 17:28, mawupeng =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2022/5/3 17:58, Ard Biesheuvel =E5=86=99=E9=81=93:
> >> On Tue, 19 Apr 2022 at 08:43, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >>>
> >>> From: Ma Wupeng <mawupeng1@huawei.com>
> >>>
> >>> Now system image will perfer to be located to mirrored regions both K=
ASLR
> >>> on and off.
> >>>
> >>
> >> Hello Ma Wupeng,
> >>
> >> I wonder if we could simplify this as follows:
> >> - ignore the non-KASLR case for now, and rely on the bootloader  > loa=
d the image into mirrored memory if it exists;
> >
> > In grub, memory for static image is allocated via the following path:
> >
> > grub_cmd_linux
> >    kernel =3D grub_malloc(filelen)
> >    kernel_alloc_addr =3D grub_efi_allocate_any_pages (kernel_alloc_page=
s)
> >    grub_memcpy (kernel_addr, kernel, grub_min(filelen, kernel_size))
> >     grub_loader_set (grub_linux_boot, grub_linux_unload, 0)
> >
> > Can we get memory from mirrored region by the following steps:
> > 1. get memory map by calling grub_efi_get_memory_map()
> > 2. iter all memory map to find a suitable mirrored memory area
> > 3. locate kernel image to this area
> >
> > So, if kaslr is not enabled
> >   - grub will load kernel into mirrored region
> > else
> >   - arm64-stub.c will relocate kernel image to mirrored region
> >
> > Is this feasible?
>
> Is this a feasible proposal to relocate the static kernel image itself
> into more reliable memory?
>

I'm not sure, it all depends on the firmware.

When GRUB calls LoadImage(), the firmware will reallocate the image
and unpack it there. So it is really the firmware's job to ensure that
the image is loaded into a suitable location.

I have some code here that implements a EFI based decompressor, and
which loads the kernel image into mirrored memory if it exists,
without the need to move it again. It could trivially be modified to
deal with non-randomized loads as well.

But the bottom line is that UEFI should expose the ability to target
mirrored memory, hacking around it like this is not a sustainable
approach.
