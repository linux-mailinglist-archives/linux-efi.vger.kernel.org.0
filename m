Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C349770BB50
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjEVLOC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjEVLNd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 07:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE119BD;
        Mon, 22 May 2023 04:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67EA8614C6;
        Mon, 22 May 2023 11:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47E7C43329;
        Mon, 22 May 2023 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684753721;
        bh=dZzOa+0jKFOy2FXi+DrUaKGjHvbyRLYaSwG19Q0u4E0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJD6jDN8N1fH8Sk1+KZCuXl3R0FNqMWXA5rHFwAwOa3B/Q9xfgsF1UeqY4zMbF87f
         A7dQB5Sj/pzo/ViW4bdXtBoHFIk28+YJIIf78BJ6rYoRR81UkTP/Y21elu87Z8AKSV
         Nd0jXFnBNo9Kvu+TpAN3l4C+15+ONqQkRT3KjB1BodGx/qmg7lXZmd6wEi3x4XmVw5
         lpvGOOcYZC1Xr9Gg7d7OLx2ndfwzfOD8lGMzjE7qyBUOh2RiO2zycUcGt3tJFOdxlT
         e/PrvebA7SBHmiRm7PxdHUC52vP2hka4ThQKuwKDdZ1Fc4wCM27eolycrdAUv8kRz1
         +ZQsvz7c31Atg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so1826570e87.3;
        Mon, 22 May 2023 04:08:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDxo3jxqZ/Nz2yGmL/wi88r+Ph/adWlgl00yrnO8HmJBYk5lBPlh
        6eZrxrPL/iH2HFV34W9pCVgYeq7eviHGEWkzg88=
X-Google-Smtp-Source: ACHHUZ7D/8RmGeXbWZYE5PXfgu2Db2fE1tbZ/Ty+qOnQj3Ao3ximTAhEb612qg9Af/a0JF3TKL3wl1dNXZZ8F20Vq10=
X-Received: by 2002:ac2:47ee:0:b0:4f3:ab4b:9015 with SMTP id
 b14-20020ac247ee000000b004f3ab4b9015mr3442452lfp.18.1684753719455; Mon, 22
 May 2023 04:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-5-kirill.shutemov@linux.intel.com> <20230519101641.nka7ty3fttntymci@box.shutemov.name>
 <20230522110116.675nqxrztxbtmdl7@box.shutemov.name>
In-Reply-To: <20230522110116.675nqxrztxbtmdl7@box.shutemov.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 13:08:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF1ugZ9fZaLccvi86jnJFM6OSiYrc1_6d6LP=ApcBr7Gg@mail.gmail.com>
Message-ID: <CAMj1kXF1ugZ9fZaLccvi86jnJFM6OSiYrc1_6d6LP=ApcBr7Gg@mail.gmail.com>
Subject: Re: [PATCHv12 4/9] x86/boot/compressed: Handle unaccepted memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 22 May 2023 at 13:01, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, May 19, 2023 at 01:16:41PM +0300, Kirill A. Shutemov wrote:
> > On Fri, May 19, 2023 at 02:14:29AM +0300, Kirill A. Shutemov wrote:
> > > diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> > > index 67594fcb11d9..87372b96d613 100644
> > > --- a/arch/x86/boot/compressed/mem.c
> > > +++ b/arch/x86/boot/compressed/mem.c
> > > @@ -1,9 +1,32 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >
> > >  #include "error.h"
> > > +#include "misc.h"
> > >
> > >  void arch_accept_memory(phys_addr_t start, phys_addr_t end)
> > >  {
> > >     /* Platform-specific memory-acceptance call goes here */
> > >     error("Cannot accept memory");
> > >  }
> > > +
> > > +void init_unaccepted_memory(void)
> > > +{
> > > +   guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> > > +   struct efi_unaccepted_memory *unaccepted_table;
> > > +   unsigned long cfg_table_pa;
> > > +   unsigned int cfg_table_len;
> > > +   int ret;
> > > +
> > > +   ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> > > +   if (ret)
> > > +           error("EFI config table not found.");
> > > +
> > > +   unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> > > +                                                    cfg_table_pa,
> > > +                                                    cfg_table_len,
> > > +                                                    guid);
> > > +   if (unaccepted_table->version != 1)
> > > +           error("Unknown version of unaccepted memory table\n");
> > > +
> > > +   set_unaccepted_table(unaccepted_table);
> > > +}
> >
> > 0-day reported boot failure outdise TDX guest with CONFIG_INTEL_TDX_GUEST=y.
>
> 0-day folks reported one more issue: booting on non-EFI system fail.
>
> Updated fixup:
>
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index 0108c97399a5..e7f7ef31e581 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -46,8 +46,13 @@ void init_unaccepted_memory(void)
>         struct efi_unaccepted_memory *unaccepted_table;
>         unsigned long cfg_table_pa;
>         unsigned int cfg_table_len;
> +       enum efi_type et;
>         int ret;
>
> +       et = efi_get_type(boot_params);
> +       if (et == EFI_TYPE_NONE)
> +               return;
> +
>         ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
>         if (ret)
>                 error("EFI config table not found.");
> @@ -56,6 +61,9 @@ void init_unaccepted_memory(void)
>                                                          cfg_table_pa,
>                                                          cfg_table_len,
>                                                          guid);
> +       if (!unaccepted_table)
> +               return;
> +
>         if (unaccepted_table->version != 1)
>                 error("Unknown version of unaccepted memory table\n");
>

With these changes applied,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
