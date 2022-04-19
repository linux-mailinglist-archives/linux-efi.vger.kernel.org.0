Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A0507938
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiDSSiY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357653AbiDSShy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 14:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE5FF1;
        Tue, 19 Apr 2022 11:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56FBB615A6;
        Tue, 19 Apr 2022 18:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B515BC385BB;
        Tue, 19 Apr 2022 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650393147;
        bh=md0tG2V1t23ZnRlqUCm/DSQwwQtpFcWbjxl5FLEoEv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0rDFyXH+Y4efoyOnsqNuYiJmzhCiI6h9S/IY7vLQ0uLcNiwyzet7N76wpqbRAm30
         1jqnComDoxuqmYOsfDjPA4y4IULg+iCVZd6KW8jGbhlptQQNieVGtdDsdx3dtc0XJ+
         B1JG/I0jTQuifGxjaRZf6PdX4JnyRSSZJ1n2xDnKk5h6zYs/gZUqPOMOes8O0riSGE
         yot+jdxfHO73G0eCf6jG7r1iYS0rlDQCyt3Z3ZLFBtWtXh5NY3R7Hs9IA/BzWOWoZd
         m7G8EcMmArocQBNTLWRV8SNi17Z1xQSxctb1aG558N+lBbXlBOuexVA3DS9aUbrA1o
         vBJGSQ2N4JB+Q==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e604f712ecso5168895fac.9;
        Tue, 19 Apr 2022 11:32:27 -0700 (PDT)
X-Gm-Message-State: AOAM532fwLQWwEhjvmr1BZUjS4aXo+gDWbesKCSAMLT7VBfFAnv9I7bA
        fChsNW8SbKknUuQ7wRiz1D81IZSlib3yQJmsLuc=
X-Google-Smtp-Source: ABdhPJy+tDK9eGCepkKXeOvvfKeb4HZc+BluW5/5YJu1JhLSn0xWy3QnFC8BRtKUY0f9PpybIp3EFNlsyXbWugc+Hn4=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr9290611oap.228.1650393146846; Tue, 19
 Apr 2022 11:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
 <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com> <6de859df-e1c3-e9aa-4530-3b61b9c69a28@huawei.com>
In-Reply-To: <6de859df-e1c3-e9aa-4530-3b61b9c69a28@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Apr 2022 20:32:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGyKQMeFWSK-s84pdL89qPTyTN_x3WHTgp_R7sH1+qOfA@mail.gmail.com>
Message-ID: <CAMj1kXGyKQMeFWSK-s84pdL89qPTyTN_x3WHTgp_R7sH1+qOfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] introduce mirrored memory support for arm64
To:     mawupeng <mawupeng1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, hpa@zyccr.com,
        Darren Hart <dvhart@infradead.org>,
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 16 Apr 2022 at 03:32, mawupeng <mawupeng1@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/4/14 18:22, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Thu, 14 Apr 2022 at 11:54, Wupeng Ma <mawupeng1@huawei.com> wrote:
> >>
> >> From: Ma Wupeng <mawupeng1@huawei.com>
> >>
> >> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory=
 ranges")
> >> introduced mirrored memory support for x86. This support rely on UEFI =
to
> >> report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-15=
8:
> >>
> >>    http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
> >>
> >> Memory mirroring is a technique used to separate memory into two separ=
ate
> >> channels, usually on a memory device, like a server. In memory mirrori=
ng,
> >> one channel is copied to another to create redundancy. This method mak=
es
> >> input/output (I/O) registers and memory appear with more than one addr=
ess
> >> range because the same physical byte is accessible at more than one
> >> address. Using memory mirroring, higher memory reliability and a highe=
r
> >> level of memory consolidation are possible.
> >>
> >> Arm64 can support this too. So mirrored memory support is added to sup=
port
> >> arm64.
> >>
> >> Efi_fake_mem is used for testing mirrored features and will not be use=
d in
> >> production environment. This test features can fake memory's attribute
> >> values.
> >>
> >> The reason why efi_fake_mem support is put first is that memory's attr=
ibute
> >> is reported by BIOS which is hard to simulate. With this support, any =
arm64
> >> machines with efi support can easily test mirrored features.
> >>
> >> The main purpose of this patchset is to introduce mirrored support for
> >> arm64 and we have already fixed the problems we had which is shown in
> >> patch #5 to patch #7 and try to bring total isolation in patch #8 whic=
h
> >> will disable mirror feature if kernelcore is not specified.
> >>
> >> In order to test this support in arm64:
> >> - patch this patchset
> >> - add efi_fake_mem=3D8G@0:0x10000 in kernel parameter to simulate mirr=
ored
> >>    memroy between phy addr 0-8G.
> >> - add kernelcore=3Dmirror in kernel parameter
> >> - start you kernel
> >>
> >
> > As I explained before:
> >
> > - NAK to EFI fake_mem support on arm64
>
> fake_mem support on arm64 will be removed in subsequent version.
>
> > - NAK to the whole series until you come up with a proposal on how to
> > locate the static kernel image itself into more reliable memory, as
> > there is really no point to any of this otherwise.
>
> Sorry I am not familiar with this, as you metioned before,
>
>  > you have to iterate over the memory map and look for regions with
>  > the desired attribute, and allocate those pages explicitly.
>
> Do you mean this is x86, commit c05cd79750fb
> ("x86/boot/KASLR: Prefer mirrored memory regions for the kernel physical =
address").
> I will do some research.
>
>  > I'd prefer to implement this in the bootloader, and only add minimal
>  > logic to the stub to respect the placement of the kernel by the loader
>  > if the loader signals it to do so.
>
> Does this bootloader refer to grub and then add minimal logic to arm64-st=
ub.c?
>

Any bootloader, yes.

> What is the loader signal?

A protocol installed onto the image handle, as I suggested before. I
even cc'ed you on a patch that implements this.

> System exists mirrored memory reported by uefi?
>

What on earth is the point of any of this if the only use case being
targeted is efi_fake_mem with arbitrary fake mirrored regions?

So yes, unless there are systems that need this, I don't see a point
in merging any of this.
