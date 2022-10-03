Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9185F33AE
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJCQhg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJCQhf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 12:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7324BC9
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 09:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5AB61170
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 16:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07108C433D7
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664815053;
        bh=SwOOl/GQEKKR5VLMEWFYuNALBz3486Y2crgztQdS0M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aS+XHOSk78BoST/tF3yiLd11KWnxUQQV6gWJ2IgD1NJfd6mDeqA0FuKJADsrHfG61
         6WFwKYqevnjY8y4Q22XNQGz62LUdPGrgqEfbK2/F/0Nr6+XkFPLXOxSQXJ8RapvLqk
         c28+gJwTPc94HNDw5tOvSenb6RTtiSxG4WEoMJwG5usSs1eH/pvU2BVdKhYZoNo574
         hVZ6z8lOrmQwoZtbQkXbts3sGiwbr6R04NOKwkbvy7I7S3o1IW+OEMGlUHdt0Cg9RK
         14YN4faQPZ9NwIiuS+3mMRRm0M7yC+sGkvep6SF8e5sU7mR5SMQxIuWNphBpIIR6PF
         n3w1YKRL8jMug==
Received: by mail-lf1-f54.google.com with SMTP id 10so17426121lfy.5
        for <linux-efi@vger.kernel.org>; Mon, 03 Oct 2022 09:37:32 -0700 (PDT)
X-Gm-Message-State: ACrzQf2RioeRdw6dKZnLTSQV6pfkCWGJTLfV6ep+KWKenaR0ZjOXixyN
        L2Pok/eFaRRE0ujXXyKzZByrtx9j3Leo4kisCt0=
X-Google-Smtp-Source: AMsMyM4++k3liVITL0oeYHvbLXxUBDS6Zi3r5RUAZI8RvjR+zPLOB01pG6Tc5J6rPPOP61hBXJXtp2tt06wpwZ549bA=
X-Received: by 2002:a05:6512:261b:b0:4a1:abd7:3129 with SMTP id
 bt27-20020a056512261b00b004a1abd73129mr8018624lfb.637.1664815050992; Mon, 03
 Oct 2022 09:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221003112625.972646-1-ardb@kernel.org> <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email> <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
 <YzsMYfEwmjHwVheb@itl-email>
In-Reply-To: <YzsMYfEwmjHwVheb@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Oct 2022 18:37:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
Message-ID: <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
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

On Mon, 3 Oct 2022 at 18:23, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Mon, Oct 03, 2022 at 05:59:52PM +0200, Ard Biesheuvel wrote:
> > On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> > > > Xen on x86 boots dom0 in EFI mode but without providing a memory map.
> > > > This means that some sanity checks we would like to perform on
> > > > configuration tables or other data structures in memory are not
> > > > currently possible. Xen does, however, expose EFI memory descriptor info
> > > > via a Xen hypercall, so let's wire that up instead.
> > > >
> > > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  drivers/firmware/efi/efi.c |  5 ++-
> > > >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> > > >  include/linux/efi.h        |  1 +
> > > >  3 files changed, 39 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > index 55bd3f4aab28..2c12b1a06481 100644
> > > > --- a/drivers/firmware/efi/efi.c
> > > > +++ b/drivers/firmware/efi/efi.c
> > > > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> > > >   * and if so, populate the supplied memory descriptor with the appropriate
> > > >   * data.
> > > >   */
> > > > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > >  {
> > > >       efi_memory_desc_t *md;
> > > >
> > > > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > >       return -ENOENT;
> > > >  }
> > > >
> > > > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > > +      __weak __alias(__efi_mem_desc_lookup);
> > > > +
> > > >  /*
> > > >   * Calculate the highest address of an efi memory descriptor.
> > > >   */
> > > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > > > --- a/drivers/xen/efi.c
> > > > +++ b/drivers/xen/efi.c
> > > > @@ -26,6 +26,7 @@
> > > >
> > > >  #include <xen/interface/xen.h>
> > > >  #include <xen/interface/platform.h>
> > > > +#include <xen/page.h>
> > > >  #include <xen/xen.h>
> > > >  #include <xen/xen-ops.h>
> > > >
> > > > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> > > >       efi.get_next_high_mono_count    = xen_efi_get_next_high_mono_count;
> > > >       efi.reset_system                = xen_efi_reset_system;
> > > >  }
> > > > +
> > > > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > > +{
> > > > +     static_assert(XEN_PAGE_SHIFT == EFI_PAGE_SHIFT,
> > > > +                   "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> > > > +     struct xen_platform_op op = {
> > > > +             .cmd = XENPF_firmware_info,
> > > > +             .u.firmware_info = {
> > > > +                     .type = XEN_FW_EFI_INFO,
> > > > +                     .index = XEN_FW_EFI_MEM_INFO,
> > > > +                     .u.efi_info.mem.addr = phys_addr,
> > > > +                     .u.efi_info.mem.size = U64_MAX - phys_addr,
> > > > +             }
> > > > +     };
> > > > +     union xenpf_efi_info *info = &op.u.firmware_info.u.efi_info;
> > > > +     int rc;
> > > > +
> > > > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
> > > > +             return __efi_mem_desc_lookup(phys_addr, out_md);
> > > > +
> > > > +     rc = HYPERVISOR_platform_op(&op);
> > > > +     if (rc) {
> > > > +             pr_warn("Failed to lookup header 0x%llx in Xen memory map: error %d\n",
> > > > +                     phys_addr, rc);
> > > > +     }
> > > > +
> > > > +     out_md->phys_addr       = info->mem.addr;
> > >
> > > This will be equal to phys_addr, not the actual start of the memory
> > > region.
> > >
> > > > +     out_md->num_pages       = info->mem.size >> EFI_PAGE_SHIFT;
> > >
> > > Similarly, this will be the number of bytes in the memory region
> > > after phys_addr, not the total number of bytes in the region.  These two
> > > differences mean that this function is not strictly equivalent to the
> > > original efi_mem_desc_lookup().
> > >
> > > I am not sure if this matters in practice, but I thought you would want
> > > to be aware of it.
> >
> > This is a bit disappointing. Is there no way to obtain this
> > information via a Xen hypercall?
>
> It is possible, but doing so is very complex (it essentially requires a
> binary search).  This really should be fixed on the Xen side.
>
> > In any case, it means we'll need to round down phys_addr to page size
> > at the very least.
>
> That makes sense.  Are there any callers that will be broken even with
> this rounding?

As far as I can tell, it should work fine. The only thing to double
check is whether we are not creating spurious error messages from
efi_arch_mem_reserve() this way, but as far as I can tell, that should
be fine too.

Is there anyone at your end that can give this a spin on an actual
Xen/x86 system?
