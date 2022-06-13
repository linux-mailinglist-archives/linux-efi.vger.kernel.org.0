Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2D548EE9
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbiFMNcx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378044AbiFMNas (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 09:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498C6EC62;
        Mon, 13 Jun 2022 04:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903B46101F;
        Mon, 13 Jun 2022 11:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC27C341C4;
        Mon, 13 Jun 2022 11:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655119527;
        bh=7W3RCHPt+tsv4dUVuAHZPUmYNjQsn6MQMQZiltiHPMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BYeZAMVPRmwlA54Ck5SoP5JNY1uzX1oKBuBKOEW0/18L/N7SH1Q6Pz9oeAFuPK1GE
         Ptzikw+GpSyVlczUN29YAhruuXdl1iBwdleFwXj61A8Bjm6Oap6QobCHLuR6IlGnrG
         a867EL6fHjHeZqJiTG32UY8WKmmCidwwJxDMWSPSUuFcrVt24whdpbUYvFaLs3dxYn
         AnpWvYOJmpWmr+DcDVSHh8dj91Y3P9JW0WcBwHlU2aG5hZNYY1rBi91fVlWG/958dW
         EgY1jhEIQqrZrlsm7hkIRXVSmVgXDCBEI8MnB+noz8cDuV9nyp8ck0qtHSevV3zFqO
         QMZCGqo3oQqRQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1014b2752c1so970922fac.11;
        Mon, 13 Jun 2022 04:25:26 -0700 (PDT)
X-Gm-Message-State: AOAM5300mjgZjXs5Ylm4yVobjPfl6gqUuHS6O99QC8FmhVsMdt5F9sV+
        Alj7Gda5QTfMQxDeM9Nq164nP9GylQFMkkUXLHM=
X-Google-Smtp-Source: ABdhPJwye+3Ce8gz8k+4lo9ehXOBU1aZPcGoJ+NlVwPSgSQ16T74tDI4+9Z8khhO9pTdsWAwon+Bdee0S9o3i5/Vjzs=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr7435011oan.126.1655119515578; Mon, 13
 Jun 2022 04:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220613082147.183145-1-mawupeng1@huawei.com> <20220613082147.183145-7-mawupeng1@huawei.com>
 <YqcZ4O3pwceVtKYm@kernel.org>
In-Reply-To: <YqcZ4O3pwceVtKYm@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 13:25:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGwOczo1bgftMX9xTf8fRkrVYq8BjXJ6=XPj_yarbDYrA@mail.gmail.com>
Message-ID: <CAMj1kXGwOczo1bgftMX9xTf8fRkrVYq8BjXJ6=XPj_yarbDYrA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] memblock: Disable mirror feature if kernelcore is
 not specified
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, corbet@lwn.net, will@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
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

On Mon, 13 Jun 2022 at 13:05, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:21:47PM +0800, Wupeng Ma wrote:
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
>
> Hmm, this changes the way x86 uses mirrored memory.
> This change makes sense for x86 as well, but we should get an Ack from x86 folks.
>

Also, on second thought, I don't think marking as mirror is what
should be affected by the policy. Instead, choose_memblock_flags()
should take this into account, in a way that we could refine later if
needed.
