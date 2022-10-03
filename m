Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792275F3308
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJCQAO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJCQAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 12:00:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9838A3
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 09:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C9CFB81180
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 16:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6913C43470
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 16:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664812805;
        bh=B3UehTQ0iZXIQsaNP2ErI1eh7d2NC3uBWlqaRsGMZ7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jd84JlaD0ra/QSLdyuz2phPuzZOwwIsx55YQvZAQyJaq9SzeCxjWRwzq8g2TEGN/R
         Mk1KZn2yXmrNAX3eO2A5qou7/tkXsQp7iFq/X1P9hS3v9ZN7XF+pR8LLqqBkxPTopf
         Syld5qp5reVIy7bBBpx0c3VkyCEXFTC3lJfTvl5G0Up3iTEitGhPksZB7qhwYQpXnN
         Fha7RQDtTSjv6VzcGLjFC+yFeC7j2AY5r10gawfYl8QL5evqsYkrtlyuZNoi4G5ZKk
         L3vyqT9JkKpCKdOlUfYd0oCZMJTirwQtAinUqR1lHdaURXDJGUZGq3qiBjvDpaUuf5
         JuWZAktos3JIA==
Received: by mail-lj1-f180.google.com with SMTP id u14so2336624ljk.4
        for <linux-efi@vger.kernel.org>; Mon, 03 Oct 2022 09:00:05 -0700 (PDT)
X-Gm-Message-State: ACrzQf3c9Acc3M/r9CGKOqNP4ARx3OUMcODVG/93Ny9a9QSbtts6GMFU
        qMyyJ2um4UPqu+CHZZHIJMhOOwZvW/QXlwttJtQ=
X-Google-Smtp-Source: AMsMyM76GdGG/AcxOxDqgV1MySSXcIQv5dlPIEhnRlae1lqaUkXnKMnbHbJddFJUo49QeKlaz0aBbFDJwBkdXRP+vlk=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mr5010050ljq.152.1664812803907; Mon, 03
 Oct 2022 09:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221003112625.972646-1-ardb@kernel.org> <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
In-Reply-To: <Yzr/1s9CbA0CClmt@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Oct 2022 17:59:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
Message-ID: <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup based
 on hypercall
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-efi@vger.kernel.org,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> > Xen on x86 boots dom0 in EFI mode but without providing a memory map.
> > This means that some sanity checks we would like to perform on
> > configuration tables or other data structures in memory are not
> > currently possible. Xen does, however, expose EFI memory descriptor info
> > via a Xen hypercall, so let's wire that up instead.
> >
> > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/efi.c |  5 ++-
> >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> >  include/linux/efi.h        |  1 +
> >  3 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 55bd3f4aab28..2c12b1a06481 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> >   * and if so, populate the supplied memory descriptor with the appropriate
> >   * data.
> >   */
> > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> >  {
> >       efi_memory_desc_t *md;
> >
> > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> >       return -ENOENT;
> >  }
> >
> > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > +      __weak __alias(__efi_mem_desc_lookup);
> > +
> >  /*
> >   * Calculate the highest address of an efi memory descriptor.
> >   */
> > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > --- a/drivers/xen/efi.c
> > +++ b/drivers/xen/efi.c
> > @@ -26,6 +26,7 @@
> >
> >  #include <xen/interface/xen.h>
> >  #include <xen/interface/platform.h>
> > +#include <xen/page.h>
> >  #include <xen/xen.h>
> >  #include <xen/xen-ops.h>
> >
> > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> >       efi.get_next_high_mono_count    = xen_efi_get_next_high_mono_count;
> >       efi.reset_system                = xen_efi_reset_system;
> >  }
> > +
> > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > +{
> > +     static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
> > +                   "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> > +     struct xen_platform_op op = {
> > +             .cmd = XENPF_firmware_info,
> > +             .u.firmware_info = {
> > +                     .type = XEN_FW_EFI_INFO,
> > +                     .index = XEN_FW_EFI_MEM_INFO,
> > +                     .u.efi_info.mem.addr = phys_addr,
> > +                     .u.efi_info.mem.size = U64_MAX - phys_addr,
> > +             }
> > +     };
> > +     union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
> > +     int rc;
> > +
> > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
> > +             return __efi_mem_desc_lookup(phys_addr, out_md);
> > +
> > +     rc = HYPERVISOR_platform_op(&op);
> > +     if (rc) {
> > +             pr_warn("Failed to lookup header 0x%llx in Xen memory map: error %d\n",
> > +                     phys_addr, rc);
> > +     }
> > +
> > +     out_md->phys_addr       = info->mem.addr;
>
> This will be equal to phys_addr, not the actual start of the memory
> region.
>
> > +     out_md->num_pages       = info->mem.size >> EFI_PAGE_SHIFT;
>
> Similarly, this will be the number of bytes in the memory region
> after phys_addr, not the total number of bytes in the region.  These two
> differences mean that this function is not strictly equivalent to the
> original efi_mem_desc_lookup().
>
> I am not sure if this matters in practice, but I thought you would want
> to be aware of it.

This is a bit disappointing. Is there no way to obtain this
information via a Xen hypercall?

In any case, it means we'll need to round down phys_addr to page size
at the very least.
