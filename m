Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DB52E562
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiETGws (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbiETGwp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 02:52:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B65DBDE;
        Thu, 19 May 2022 23:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A5F6CE27A2;
        Fri, 20 May 2022 06:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE11FC36AEC;
        Fri, 20 May 2022 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653029558;
        bh=zCfFFCGe/AG+lzsCAng2qYtEBpCVx3Hvfd4T25qLHJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WURZpMvuRSprpYKhNklruvBIefHI85zzQkD5d63METtxWJZOcNUBsD8gmOWTCiD/r
         On+R+elW5y/dl4os9iiXTGjQqjvIyWop3RW9c0A8UoHt+65GRqd0IHR6j9XK5ngzlZ
         S2UHt7+9DEc5nz9e1JlgKFv7TRqge110TfdF1g9+r6AAOh2u0Tv34ynxBdZdBI00oj
         pCQTjZ46N/Rd40Q8bncUrGbMm+ktr7+h4q7s/AI6IXPcdV3l89da4c0Y6BkWrOl9FY
         M70p/HMOiq8e2qp1x8ix0w2nNuv1vj07LBKJw8T+XimTrImA0vmQSrDybzvelhzNz4
         96NYdg/9e2lEQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f1eafa567cso5939229fac.8;
        Thu, 19 May 2022 23:52:38 -0700 (PDT)
X-Gm-Message-State: AOAM532acDQN9Ht3Rv/8rP6qCbDTF7daGhOQq54StYfQc4Qv+lUk31De
        08vqyVJnD4V6NbFoO8D+LfzYxm+I4KTuyeKIdPg=
X-Google-Smtp-Source: ABdhPJz2W/7dvembodmCsWH351nKi/f5VpNYYyF6mV6O3gBLvZ7E0rPGjRInnvXyOVZQdqISea5dzKMcVurSNykdr58=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr5450734oap.228.1653029558029; Thu, 19
 May 2022 23:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <20220419070150.254377-1-mawupeng1@huawei.com> <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
 <c65d22b4-f654-21aa-bd5f-d4f8b0939a25@huawei.com> <7058b8d8-c0cb-108e-0db9-2fdf5fb154cf@huawei.com>
 <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
In-Reply-To: <CAMj1kXHnL12j6FPGtEeSQB2-kHzoVF+LJMUF9YBq43Yi1UntDg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 20 May 2022 08:52:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFP9kA_rJ8DfP1Ln=W++xL1Rvdojb8ZuNLoOJx2mLkysA@mail.gmail.com>
Message-ID: <CAMj1kXFP9kA_rJ8DfP1Ln=W++xL1Rvdojb8ZuNLoOJx2mLkysA@mail.gmail.com>
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

On Fri, 20 May 2022 at 08:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 19 May 2022 at 13:09, mawupeng <mawupeng1@huawei.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2022/5/7 17:28, mawupeng =E5=86=99=E9=81=93:
> > >
> > >
> > > =E5=9C=A8 2022/5/3 17:58, Ard Biesheuvel =E5=86=99=E9=81=93:
> > >> On Tue, 19 Apr 2022 at 08:43, Wupeng Ma <mawupeng1@huawei.com> wrote=
:
> > >>>
> > >>> From: Ma Wupeng <mawupeng1@huawei.com>
> > >>>
> > >>> Now system image will perfer to be located to mirrored regions both=
 KASLR
> > >>> on and off.
> > >>>
> > >>
> > >> Hello Ma Wupeng,
> > >>
> > >> I wonder if we could simplify this as follows:
> > >> - ignore the non-KASLR case for now, and rely on the bootloader  > l=
oad the image into mirrored memory if it exists;
> > >
> > > In grub, memory for static image is allocated via the following path:
> > >
> > > grub_cmd_linux
> > >    kernel =3D grub_malloc(filelen)
> > >    kernel_alloc_addr =3D grub_efi_allocate_any_pages (kernel_alloc_pa=
ges)
> > >    grub_memcpy (kernel_addr, kernel, grub_min(filelen, kernel_size))
> > >     grub_loader_set (grub_linux_boot, grub_linux_unload, 0)
> > >
> > > Can we get memory from mirrored region by the following steps:
> > > 1. get memory map by calling grub_efi_get_memory_map()
> > > 2. iter all memory map to find a suitable mirrored memory area
> > > 3. locate kernel image to this area
> > >
> > > So, if kaslr is not enabled
> > >   - grub will load kernel into mirrored region
> > > else
> > >   - arm64-stub.c will relocate kernel image to mirrored region
> > >
> > > Is this feasible?
> >
> > Is this a feasible proposal to relocate the static kernel image itself
> > into more reliable memory?
> >
>
> I'm not sure, it all depends on the firmware.
>
> When GRUB calls LoadImage(), the firmware will reallocate the image
> and unpack it there. So it is really the firmware's job to ensure that
> the image is loaded into a suitable location.
>
> I have some code here that implements a EFI based decompressor, and
> which loads the kernel image into mirrored memory if it exists,
> without the need to move it again. It could trivially be modified to
> deal with non-randomized loads as well.
>

Code is here
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=3Defi=
-decompressor-v2
