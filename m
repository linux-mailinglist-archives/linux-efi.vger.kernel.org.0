Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0368EF78
	for <lists+linux-efi@lfdr.de>; Wed,  8 Feb 2023 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBHNEE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Feb 2023 08:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHNEC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Feb 2023 08:04:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8EE4617D
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 05:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A333B81DE4
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 13:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5475C433A1
        for <linux-efi@vger.kernel.org>; Wed,  8 Feb 2023 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675861438;
        bh=j/uo4bq5W+jO+7HLkk36EoaAQy5TPjOlKItRIzp6H98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xmv3f8aLiQ7yhba9CTAnf6d/nsIhyOTfBnbo9qRxFNdXJkliQZlTl1rDiM1HYde55
         pQJWrb6FuBaivTIo+tm/tzKSEp7YHj48sJqc6lXsHFY1mmbLHjdmHh7bMHjfkxvWqF
         8Bm+PajDN5J6ncMucfyd/6/qVtN0/LhP5nJwMk+rA+KMC+oGW/a7UkUYADz2eMx6JR
         vCOzyvHYf3wsxPgXej5PgZs/TnXEFGC4XvXT2bY/Kn/VhAyDML73aXABMzp2PHE8SG
         jCiGoX3k6hTI5dbCOnCLgMQtjzGowDzYrqexvUl+00LO8DWmFO1EdBdH8NUXTfM7/N
         7UbBwXbUDTvcQ==
Received: by mail-lf1-f47.google.com with SMTP id j17so26999945lfr.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Feb 2023 05:03:58 -0800 (PST)
X-Gm-Message-State: AO0yUKXt56muCJ86dAN4vZpsS8WUCUPJnnsaxwJWqj4Gkmh8KI7PnCTD
        uHER0nrTaQiB+iyUzRYcZtkLCfEep5EK6qWKKJA=
X-Google-Smtp-Source: AK7set8FFuy9KfcTKogFJHtIWqW8wP5ltcQi1m5rJw9OJ/EXDXKEIPbniC1CtllqJ5oUzh7jQXIeEUseFwMt1RoZO4k=
X-Received: by 2002:a05:6512:218e:b0:4d7:2dc1:b7bc with SMTP id
 b14-20020a056512218e00b004d72dc1b7bcmr1237486lft.100.1675861436595; Wed, 08
 Feb 2023 05:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20230206124938.272988-1-ardb@kernel.org> <20230206124938.272988-3-ardb@kernel.org>
 <20230208130007.GA13529@willie-the-truck>
In-Reply-To: <20230208130007.GA13529@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Feb 2023 14:03:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
Message-ID: <CAMj1kXEReR30NYgHS67W2RH0z=0HdG4UrkBKuTXwFN9NrNE6wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: arm64: Wire up BTI annotation in memory
 attributes table
To:     Will Deacon <will@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 8 Feb 2023 at 14:00, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 01:49:37PM +0100, Ard Biesheuvel wrote:
> > UEFI v2.10 extends the EFI memory attributes table with a flag that
> > indicates whether or not all RuntimeServicesCode regions were
> > constructed with BTI landing pads, permitting the OS to map these
> > regions with BTI restrictions enabled.
> >
> > So let's take this into account on arm64.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/kernel/efi.c   | 14 ++++++++++++--
> >  arch/arm64/kernel/traps.c |  6 ++++++
> >  2 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 78ffd5aaddcbbaee..99971cd349f36310 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -96,15 +96,23 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
> >       return 0;
> >  }
> >
> > +struct set_perm_data {
> > +     const efi_memory_desc_t *md;
> > +     bool                    has_bti;
> > +};
> > +
> >  static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
> >  {
> > -     efi_memory_desc_t *md = data;
> > +     struct set_perm_data *spd = data;
> > +     const efi_memory_desc_t *md = spd->md;
> >       pte_t pte = READ_ONCE(*ptep);
> >
> >       if (md->attribute & EFI_MEMORY_RO)
> >               pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> >       if (md->attribute & EFI_MEMORY_XP)
> >               pte = set_pte_bit(pte, __pgprot(PTE_PXN));
> > +     else if (system_supports_bti() && spd->has_bti)
>
> system_supports_bti() seems to check CONFIG_ARM64_BTI rather than
> CONFIG_ARM64_BTI_KERNEL. In theory, I think this means we could have
> mismatched BTI support, so it might be slightly more robust to use the
> latter option here even thought the runtime services aren't kernel code.
>
> What do you think?
>

v1 checked for CONFIG_ARM64_BTI_KERNEL as well, but I dropped it
because we can do the enforcement even without it.

I'm not sure how mismatched BTI support factors into that, though,
given that CONFIG_ARM64_BTI_KERNEL is set at compile time. You mean
mismatched between cores, right?
