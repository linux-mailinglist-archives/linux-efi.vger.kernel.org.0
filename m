Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F454AE5B
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355359AbiFNK1n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 06:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNK1l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 06:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25DA2C657;
        Tue, 14 Jun 2022 03:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB8F60DF3;
        Tue, 14 Jun 2022 10:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7C2C3411B;
        Tue, 14 Jun 2022 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202458;
        bh=pLY/c1iB3KXXw2JkAgjQjqCgz0rlmIBHN5Fh/dw9rf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=azg81Ege00O8E7x7v7HQ9vUx4hboeEJbaHMhUrs8SErWepT7gFN6ogKeEtTJU3Az9
         UHGseD8HacKj7iGzHlCjJZK7V8KZJ2iDSHVKrm0ousyhFHQxvYsnVonc1kqxFqNiCW
         v5YlOdTT5m7xwGLfBGUVQ2MaNqnHbt1KXXDopo6tdEJZt1uMmrJqxy36OlhBrz+Dx/
         WouzetWQ9PPjJ3ICesIELajnDuWTrG/kPhfz/e8qMkrN4IIPARPjJF9e/bOSjnFBqR
         o9vFN5QyLUCl1psgzV+xxgVxbYvlO1c36pdF7UEveyDN8Jl8uT8itXQopI7806SJXy
         oGgdcxxgZ3F5A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-fe539f9afbso11903702fac.5;
        Tue, 14 Jun 2022 03:27:38 -0700 (PDT)
X-Gm-Message-State: AJIora8J7Zq1vOPvKOp71sWP1XQKuZg5VghY6TyO8wld6C8uDNl8Lqca
        cXeFEioOdRj2PqPRE0HMG6vKMg8d5pi1PWstXcA=
X-Google-Smtp-Source: ABdhPJwqvTBoi/hdOV5yBa6AZkvlop+ZjXzRzSSCX4iDQR2/4mlYcKmmyvZh/nsuqJlyiGM+W/g1OGM3mBXbHXv9T6k=
X-Received: by 2002:aca:aad5:0:b0:32f:3b9b:e0f with SMTP id
 t204-20020acaaad5000000b0032f3b9b0e0fmr1738156oie.228.1655202447146; Tue, 14
 Jun 2022 03:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
 <20220614092156.1972846-6-mawupeng1@huawei.com> <Yqhg6abZDGZSpJ7+@MiWiFi-R3L-srv>
In-Reply-To: <Yqhg6abZDGZSpJ7+@MiWiFi-R3L-srv>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Jun 2022 12:27:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGXvjrnY=Hzd4c3CYZsNT6OiqTcMmKT0tdnk=jFOiVpWA@mail.gmail.com>
Message-ID: <CAMj1kXGXvjrnY=Hzd4c3CYZsNT6OiqTcMmKT0tdnk=jFOiVpWA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] memblock: Disable mirror feature if kernelcore is
 not specified
To:     Baoquan He <bhe@redhat.com>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
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
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>, songmuchun@bytedance.com,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com,
        Stephen Boyd <swboyd@chromium.org>,
        Wei Liu <wei.liu@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, gpiccoli@igalia.com,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        vijayb@linux.microsoft.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

On Tue, 14 Jun 2022 at 12:20, Baoquan He <bhe@redhat.com> wrote:
>
> On 06/14/22 at 05:21pm, Wupeng Ma wrote:
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
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
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
>
> memblock_mark_mirror() is just a wrapper, maybe we should check this in
> efi_find_mirror(). Otherwise, how do we explain the message printed out
> at below in boot log if we don't mark mirror memory at all?
>
> void __init efi_find_mirror(void)
> {
> ......
>         if (mirror_size)
>                 pr_info("Memory: %lldM/%lldM mirrored memory\n",
>                         mirror_size>>20, total_size>>20);
> }
>

EFI does not care about *how* mirrored memory is being used or not, it
just reports what the firmware provided. So EFI is not the appropriate
level to take kernelcore=mirror into account.

I already mentioned that memblock_mark_mirror() is also the wrong
place IMO, but Kefeng explained that doing it elsewhere is
problematic.
