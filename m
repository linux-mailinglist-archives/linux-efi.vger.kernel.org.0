Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347CB12DDA1
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 05:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAAExJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 23:53:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43909 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgAAExJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 23:53:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so15981642oth.10
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfNNEg4YWXmXqYR9H7tCNhq2xPlPNDmuq3DmGMJWmh8=;
        b=jlKqsdFtlMYUFLmF58ewBNrKwzaCKl+MmNrsw/WrE148uBmGVfUJNtM16hf2u3sdjJ
         osz95h41zYayoSkYD3C8mxIAhV//e16lOi+q6EgFBJTAgsC9XYvBJayFob8IMOJYpZHG
         ReiEfSmlxm0jHMSm9mIsyV2WKia//95oBq2N0Ww4UVbR+KVQHbW4cU/eDcpKYJ66jUzD
         6FHsyog+U1sIiDs2juKzZErwdyMJo1xM1r6XiYGgARdukPE2wAgVnWndtkeY9lJhkd1D
         e74iWa1WwMs3vHLuNXG86LgNbx1lWP0eZG11AmU3jDrdB8d5SlB141BNNl96NWzgphat
         6QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfNNEg4YWXmXqYR9H7tCNhq2xPlPNDmuq3DmGMJWmh8=;
        b=JEpzWmHBKULD8DMmRaSMmAZGIeXs95js4xEd9c8/cgTmRQaA+1jbvNlI+1V99r/A9c
         CoPTkNh3Bg5LcZXesSdET41PsibX5MlQe0lRgAOi1gQrjDRoNzPtg+p08ldz6+UpkHdy
         TrX0LU08sC6EK8zs4WueXT1Bm5qAiMArbvO+T7NRL4MetjmVANuIVT3ZX7TSP+QNKA7d
         mf+o99Eqd40g61FSgrPUVyybDIEaxdWcpKkfz633jzGlVk/OsqzcJRENPVySL4THE4k2
         VCI/S1gN4MqPujxcP4RljvPWgePde0rocMigje4CLQxdXjfy9h709VP6jQ4j8Xilcnzs
         UG1A==
X-Gm-Message-State: APjAAAUG7K23+bY/gv1brKKCaRaM7/X2Wdh9zkv8W3iXT/p9slvunNZR
        mssSfC1/bSOgMGraqo1xhyVKxXUCS/F/DMcP/nxSlg==
X-Google-Smtp-Source: APXvYqzv6e+DqoNRilibIFzUVaa/7v8Np7/jZeI2hLlLcZACEoPElkCWi4mxDCufsiBXdFI1s30kAhVPlUeSW2yIhpY=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr47412305oto.207.1577854388602;
 Tue, 31 Dec 2019 20:53:08 -0800 (PST)
MIME-Version: 1.0
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987346.367056.16932641815225610530.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200101033517.GB14346@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200101033517.GB14346@dhcp-128-65.nay.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 31 Dec 2019 20:52:57 -0800
Message-ID: <CAPcyv4hXJi6v57L=-n8H9F_5Zvonr1idyijW7MqPdyMoGCj=2A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi: Fix efi_memmap_alloc() leaks
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 7:35 PM Dave Young <dyoung@redhat.com> wrote:
>
> Hi Dan,
> On 12/31/19 at 02:04pm, Dan Williams wrote:
> > With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> > updated and replaced multiple times. When that happens a previous
> > dynamically allocated efi memory map can be garbage collected. Use the
> > new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> > allocated memory map is being replaced.
> >
> > Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/firmware/efi/memmap.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> > index 2b81ee6858a9..188ab3cd5c52 100644
> > --- a/drivers/firmware/efi/memmap.c
> > +++ b/drivers/firmware/efi/memmap.c
> > @@ -29,6 +29,28 @@ static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
> >       return PFN_PHYS(page_to_pfn(p));
> >  }
> >
> > +static void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > +{
> > +     if (WARN_ON(slab_is_available() && (flags & EFI_MEMMAP_MEMBLOCK)))
> > +             return;
> > +
> > +     if (flags & EFI_MEMMAP_MEMBLOCK) {
> > +             memblock_free(phys, size);
> > +     } else if (flags & EFI_MEMMAP_SLAB) {
> > +             struct page *p = pfn_to_page(PHYS_PFN(phys));
> > +             unsigned int order = get_order(size);
> > +
> > +             free_pages((unsigned long) page_address(p), order);
> > +     }
> > +}
> > +
> > +static void __init efi_memmap_free(void)
> > +{
> > +     __efi_memmap_free(efi.memmap.phys_map,
> > +                     efi.memmap.desc_size * efi.memmap.nr_map,
> > +                     efi.memmap.flags);
> > +}
> > +
> >  /**
> >   * efi_memmap_alloc - Allocate memory for the EFI memory map
> >   * @num_entries: Number of entries in the allocated map.
> > @@ -209,6 +231,8 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map,
> >       data.desc_size = efi.memmap.desc_size;
> >       flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
> >
> > +     efi_memmap_free();
> > +
> >       return __efi_memmap_init(&data, flags);
>
> Hmm, only free the memmap in case __efi_memmap_init succeeded..

Ah true, that is a hastily chosen placement. Probably better in
__efi_memmap_init() after we're committed to the new map.
