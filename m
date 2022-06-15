Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F154C55B
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiFOKEQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 06:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiFOKEP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 06:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E843B56C;
        Wed, 15 Jun 2022 03:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C9460B78;
        Wed, 15 Jun 2022 10:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A604C341C8;
        Wed, 15 Jun 2022 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655287453;
        bh=qMHUliC6OQhBo7q9WDQGe2cH8qdN+43JlMt46VgcPdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tyzse1Cd3fjLm/gl7wC+IqzAGy+1IriofM5pf4qKXRRr+RD7XMP6qeeCQczv87bOW
         lZPIqlVimG2aFN3LhJn2n9oH4HTkX3+GvyG0SWWgmmT8xQPBpLRT80gpZdFAlNle8H
         0O/u+rQnIii6/pajDxyLuKVErE0YfU+qgZWcitjONsgOd5TvvCqnxNlZxtrUwFuqH2
         nhFUDabN0Ird/c6wpMi9ZCw6hqP4C5crCW9iL7yXFbg9ADs12XsVMtqCPAErkkbbkg
         1ifFJoC3paloF+AckRbYJBKxrGGp/nOUMPTPZxYthiK0A4pVA/hJZHReLEMhVQtSvs
         9Mg1PK0on1RmQ==
Received: by mail-oi1-f177.google.com with SMTP id v143so14792296oie.13;
        Wed, 15 Jun 2022 03:04:13 -0700 (PDT)
X-Gm-Message-State: AOAM530VZmAKtKNjC/RwhRyrpu/kjQOTYl3hVYJJ1R7pITpwXA7I+chp
        XJnDZ+BE+hHzlN4eKrmltl0ZMa3Px6aUhsLm4Wg=
X-Google-Smtp-Source: AGRyM1uoryGCjOCIvlwgWz7+peQb+MFbP9xnQEX5bRMY6ahyU4equv8ziGQaSK27jXjDURN9dcuDuanaZNr23KVfwtM=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr5078024oao.228.1655287441873; Wed, 15
 Jun 2022 03:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
 <20220614092156.1972846-2-mawupeng1@huawei.com> <YqmuQIpkY7TJHAh6@arm.com>
In-Reply-To: <YqmuQIpkY7TJHAh6@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jun 2022 12:03:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+UgWeAVyh8CD5S0M4n2SKFGcP0ayOn41bKmyoVb8QXQ@mail.gmail.com>
Message-ID: <CAMj1kXG+UgWeAVyh8CD5S0M4n2SKFGcP0ayOn41bKmyoVb8QXQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] efi: arm64: Introduce ability to find mirrored
 memory ranges
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Wupeng Ma <mawupeng1@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
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

On Wed, 15 Jun 2022 at 12:02, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jun 14, 2022 at 05:21:52PM +0800, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> >
> > Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory
> > ranges") introduce the efi_find_mirror() function on x86. In order to reuse
> > the API we make it public.
> >
> > Arm64 can support mirrored memory too, so function efi_find_mirror() is added to
> > efi_init() to this support for arm64.
> >
> > Since efi_init() is shared by ARM, arm64 and riscv, this patch will bring
> > mirror memory support for these architectures, but this support is only tested
> > in arm64.
> >
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >  arch/x86/include/asm/efi.h      |  4 ----
> >  arch/x86/platform/efi/efi.c     | 23 -----------------------
> >  drivers/firmware/efi/efi-init.c |  1 +
> >  drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
> >  include/linux/efi.h             |  3 +++
>
> The subject prefix says "efi: arm64: " but it looks like x86 diffstat
> here. You may want to get an ack from the x86 maintainers.
>

This just moves efi code around, and this is going through the EFI
tree, so that should be fine. I'll fix the subject in any case,
though.
