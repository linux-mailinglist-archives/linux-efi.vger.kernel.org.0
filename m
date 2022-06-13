Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFEB5483B4
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbiFMJou (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiFMJos (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 05:44:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895612D2B;
        Mon, 13 Jun 2022 02:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BC73CE10FB;
        Mon, 13 Jun 2022 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2B4C3411E;
        Mon, 13 Jun 2022 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655113482;
        bh=xt5DGwjhYrIt2t4/I7WxcJsztFBJP3gm0q1s4WQ34ZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O6YeFxlyL68gdYVZZNmot4hKDu0cvDrL3n970VtnwqC9I7SfliUL5fhLeFQ4/9bin
         T8zI4SrdeG92yvm7oD0YAcVoiXTFDHh28yErHqdUpfGE3l8jWy59lCt44xoXqiVYSC
         I1Z18vioGAzwJOeFhgQIglmEv8c7kXJ8qrYOAjH7LtWOk4F+xLDBKV1LrBX0QY69Xf
         oYM20nOCGNvfXlNxhrShdrqtSJhvfFSnhgSL1r67+lRBEpFwCMaWrgIT+2uZ2a/pO3
         0vNnT4K97SF5CYxpWY0TAy70/MiMaYUqQUWDiiuRybC1LkGsmhR5stXESG+KOtcBee
         qam3B2J8kCg/w==
Received: by mail-oi1-f172.google.com with SMTP id h187so7109196oif.4;
        Mon, 13 Jun 2022 02:44:42 -0700 (PDT)
X-Gm-Message-State: AOAM530eFjOPm1KaCH46mFxQ7DfzQo8y3q5zAZK8ITXNn6eW43AAWWgh
        nqMk7elbFsfA40g/xGyGkxhsGzZjogvZHPBKx9M=
X-Google-Smtp-Source: ABdhPJxWL190gaOo8x+poLO9fIQXg4n82FrPAPLPqZ2Srb/3zr8FQ26NmuG4wz3v6gR8a+MZBf5hmYgVu3gibFw/syM=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr7281685oao.228.1655113471413; Mon, 13
 Jun 2022 02:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220613082147.183145-1-mawupeng1@huawei.com> <20220613082147.183145-7-mawupeng1@huawei.com>
 <590a1211-d316-d51d-6577-eb9983126dd0@huawei.com>
In-Reply-To: <590a1211-d316-d51d-6577-eb9983126dd0@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 11:44:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfmXMriLutNA1FyeNhNz=Zo2hHgO8FLkQ3_xT8kF6oeQ@mail.gmail.com>
Message-ID: <CAMj1kXFfmXMriLutNA1FyeNhNz=Zo2hHgO8FLkQ3_xT8kF6oeQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] memblock: Disable mirror feature if kernelcore is
 not specified
To:     mawupeng <mawupeng1@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        paulmck@kernel.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, swboyd@chromium.org,
        wei.liu@kernel.org, robin.murphy@arm.com, david@redhat.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Jun 2022 at 11:13, mawupeng <mawupeng1@huawei.com> wrote:
>
>
>
> On 6/13/2022 4:21 PM, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > If system have some mirrored memory and mirrored feature is not specified
> > in boot parameter, the basic mirrored feature will be enabled and this will
> > lead to the following situations:
> >
> > - memblock memory allocation prefers mirrored region. This may have some
> >   unexpected influence on numa affinity.
> >
> > - contiguous memory will be split into several parts if parts of them
> >   is mirrored memory via memblock_mark_mirror().
> >
> > To fix this, variable mirrored_kernelcore will be checked in
> > memblock_mark_mirror(). Mark mirrored memory with flag MEMBLOCK_MIRROR iff
> > kernelcore=mirror is added in the kernel parameters.
> >
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >  mm/internal.h   | 2 ++
> >  mm/memblock.c   | 3 +++
> >  mm/page_alloc.c | 2 +-
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c0f8fbe0445b..ddd2d6a46f1b 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -861,4 +861,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
> >
> >  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> >
> > +extern bool mirrored_kernelcore;
> > +
> >  #endif       /* __MM_INTERNAL_H */
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index b1d2a0009733..a9f18b988b7f 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -924,6 +924,9 @@ int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
> >   */
> >  int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
> >  {
> > +     if (!mirrored_kernelcore)
> > +             return 0;
> > +
> >       system_has_some_mirror = true;
> >
> >       return memblock_setclr_flag(base, size, 1, MEMBLOCK_MIRROR);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e008a3df0485..9b030aeb4983 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -356,7 +356,7 @@ static unsigned long required_kernelcore_percent __initdata;
> >  static unsigned long required_movablecore __initdata;
> >  static unsigned long required_movablecore_percent __initdata;
> >  static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
> > -static bool mirrored_kernelcore __meminitdata;
> > +bool mirrored_kernelcore __initdata;
>
> __initdata here is not suitable and will lead to compile warnings.
>
> In my test, __initdata_memblock and ro_after_init are both fine, but I am not
> sure which one to choose? Do you have any idea on this?
>

__initdata_memblock is fine if it works.

This looks to me like the right place to implement this policy, so

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> >
> >  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
> >  int movable_zone;
