Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E595181D7
	for <lists+linux-efi@lfdr.de>; Tue,  3 May 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiECKCh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 May 2022 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiECKCg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 May 2022 06:02:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4436144;
        Tue,  3 May 2022 02:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7B1EB81A99;
        Tue,  3 May 2022 09:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1BDC385B3;
        Tue,  3 May 2022 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651571941;
        bh=WVwFOkcs0sk/AMUmXJiSEkXOMbWN6ztZIQQGzqt52AM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XtQoNbbEFZdYp4LpIJJEhHEAGMGZu00Cp2IQTv9OCYdBCz3V9yn9A9suUqlU8clee
         +U/x/KqJZsWZVtekrVzB9pop5aKtxswiuVdNBaQpCVckVhZOBu+YAq02mF/8snLy4K
         m3HHKSR8WDrFbBPJTsxZ2VaNNhrxQoep1GrSC4Iuz4TImEnKdtnUQcxSiYDiYygORo
         pZxuUnaH/0ZIRXpxCcEPxw/3XfGSj9cWfIYa6PInV/dRQdpYY+fnSBFcp/E3XajZM8
         lu2MnJ3uOkmXZVulO8s50sDVOQsyabzAhLticAB6tVfKshVxfAbHvwyzJfL5uSBOzQ
         UZPswvkYpDIjA==
Received: by mail-oi1-f173.google.com with SMTP id s131so17689713oie.1;
        Tue, 03 May 2022 02:59:01 -0700 (PDT)
X-Gm-Message-State: AOAM531E11NE06SxipYM2vbCPHKHdZsVnKjQrQedyi0aAM0TiYR/7rWo
        ywmtrbUmd7xtSW9L+MY9bpBrD7eXEb04hK6/MpU=
X-Google-Smtp-Source: ABdhPJzZLw8ilzQbV1pL4k8nZiRUjWAyZqXRQGFBAJdJypcgmo+eQk7OAOpjcIo6rkTWfD85Nr8vlqeh1Vobo6YGtI4=
X-Received: by 2002:a05:6808:1141:b0:325:cd92:ef8d with SMTP id
 u1-20020a056808114100b00325cd92ef8dmr1465875oiu.228.1651571940719; Tue, 03
 May 2022 02:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
 <20220419070150.254377-1-mawupeng1@huawei.com>
In-Reply-To: <20220419070150.254377-1-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 May 2022 11:58:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
Message-ID: <CAMj1kXHr2RdYSPor1st1ZnL=O42c8N6e=bNG+eFhatfefWLUrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support to relocate kernel image to mirrored region
To:     Wupeng Ma <mawupeng1@huawei.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Apr 2022 at 08:43, Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> Now system image will perfer to be located to mirrored regions both KASLR
> on and off.
>

Hello Ma Wupeng,

I wonder if we could simplify this as follows:
- ignore the non-KASLR case for now, and rely on the bootloader to
load the image into mirrored memory if it exists;
- simplify the KASLR case to the below.

I think this is reasonable, because it means we take mirrored memory
into account when we decide to move the image anyway, but expect the
boot chain to take care of this if there is no need to move the image.

-------------8<------------------
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -56,6 +56,7 @@ efi_status_t efi_random_alloc(unsigned long size,
                              unsigned long random_seed)
 {
        unsigned long map_size, desc_size, total_slots = 0, target_slot;
+       unsigned long total_mirrored_slots = 0;
        unsigned long buff_size;
        efi_status_t status;
        efi_memory_desc_t *memory_map;
@@ -86,8 +87,14 @@ efi_status_t efi_random_alloc(unsigned long size,
                slots = get_entry_num_slots(md, size, ilog2(align));
                MD_NUM_SLOTS(md) = slots;
                total_slots += slots;
+               if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
+                       total_mirrored_slots += slots;
        }

+       /* only consider mirrored slots for randomization if any exist */
+       if (total_mirrored_slots > 0)
+               total_slots = total_mirrored_slots;
+
        /* find a random number between 0 and total_slots */
        target_slot = (total_slots * (u64)(random_seed & U32_MAX)) >> 32;

@@ -107,6 +114,10 @@ efi_status_t efi_random_alloc(unsigned long size,
                efi_physical_addr_t target;
                unsigned long pages;

+               if (total_mirrored_slots > 0 &&
+                   !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
+                       continue;
+
                if (target_slot >= MD_NUM_SLOTS(md)) {
                        target_slot -= MD_NUM_SLOTS(md);
                        continue;
