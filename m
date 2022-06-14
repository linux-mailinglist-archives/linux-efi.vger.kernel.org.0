Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58BD54AED1
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jun 2022 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiFNKuV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jun 2022 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiFNKuT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jun 2022 06:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0026948E4E
        for <linux-efi@vger.kernel.org>; Tue, 14 Jun 2022 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655203818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IiQIaQMhxL76RBZHsmcLreZUSDHLka20T5mMLLN/xgk=;
        b=KFPUGzJngy/uxVYG/DSP+/UlAjL4FykIZSEbF6oCb/jMPE0y3ChjM0LTegn0XQiR+Vtcgz
        o654KetXZPgD2IeyhReUnacl02BNjECErC3hoIBSkJL5VAhvM63brglm/awzIORo8mzZma
        oEtd6ja6NVzuGUQNCs7j/Emm+9WisLI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-DhirNWZtMFiMrb8YeOnp2g-1; Tue, 14 Jun 2022 06:50:15 -0400
X-MC-Unique: DhirNWZtMFiMrb8YeOnp2g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78950299E755;
        Tue, 14 Jun 2022 10:50:14 +0000 (UTC)
Received: from localhost (ovpn-12-211.pek2.redhat.com [10.72.12.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2A5416164;
        Tue, 14 Jun 2022 10:50:12 +0000 (UTC)
Date:   Tue, 14 Jun 2022 18:50:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v5 5/5] memblock: Disable mirror feature if kernelcore is
 not specified
Message-ID: <Yqhn4Qs1bzPY9J4s@MiWiFi-R3L-srv>
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
 <20220614092156.1972846-6-mawupeng1@huawei.com>
 <Yqhg6abZDGZSpJ7+@MiWiFi-R3L-srv>
 <CAMj1kXGXvjrnY=Hzd4c3CYZsNT6OiqTcMmKT0tdnk=jFOiVpWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGXvjrnY=Hzd4c3CYZsNT6OiqTcMmKT0tdnk=jFOiVpWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 06/14/22 at 12:27pm, Ard Biesheuvel wrote:
> On Tue, 14 Jun 2022 at 12:20, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 06/14/22 at 05:21pm, Wupeng Ma wrote:
> > > From: Ma Wupeng <mawupeng1@huawei.com>
> > >
> > > If system have some mirrored memory and mirrored feature is not specified
> > > in boot parameter, the basic mirrored feature will be enabled and this will
> > > lead to the following situations:
> > >
> > > - memblock memory allocation prefers mirrored region. This may have some
> > >   unexpected influence on numa affinity.
> > >
> > > - contiguous memory will be split into several parts if parts of them
> > >   is mirrored memory via memblock_mark_mirror().
> > >
> > > To fix this, variable mirrored_kernelcore will be checked in
> > > memblock_mark_mirror(). Mark mirrored memory with flag MEMBLOCK_MIRROR iff
> > > kernelcore=mirror is added in the kernel parameters.
> > >
> > > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  mm/internal.h   | 2 ++
> > >  mm/memblock.c   | 3 +++
> > >  mm/page_alloc.c | 2 +-
> > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index c0f8fbe0445b..ddd2d6a46f1b 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -861,4 +861,6 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
> > >
> > >  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
> > >
> > > +extern bool mirrored_kernelcore;
> > > +
> > >  #endif       /* __MM_INTERNAL_H */
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index b1d2a0009733..a9f18b988b7f 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -924,6 +924,9 @@ int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
> > >   */
> > >  int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
> > >  {
> > > +     if (!mirrored_kernelcore)
> > > +             return 0;
> >
> > memblock_mark_mirror() is just a wrapper, maybe we should check this in
> > efi_find_mirror(). Otherwise, how do we explain the message printed out
> > at below in boot log if we don't mark mirror memory at all?
> >
> > void __init efi_find_mirror(void)
> > {
> > ......
> >         if (mirror_size)
> >                 pr_info("Memory: %lldM/%lldM mirrored memory\n",
> >                         mirror_size>>20, total_size>>20);
> > }
> >
> 
> EFI does not care about *how* mirrored memory is being used or not, it
> just reports what the firmware provided. So EFI is not the appropriate
> level to take kernelcore=mirror into account.
> 
> I already mentioned that memblock_mark_mirror() is also the wrong
> place IMO, but Kefeng explained that doing it elsewhere is
> problematic.

OK, seems we have no better choice other than these two. 

> 

