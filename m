Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12525F32FF
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJCP6K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJCP5z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 11:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B331DCB
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 08:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE1A61137
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 15:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A655AC433C1
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664812669;
        bh=HK0PyG2JOynGOGBkEbuAK3OGKXVMbzzRaU3W5vyNt+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AQMIy+gZU0FZvbsFZaA/iufqEOae9NC0wo+dRflAhYnC6jnM8qSAMMBMY+3W28QKZ
         kRwJYifri5QB9yfwmbwltmeQRWrijo0neN4OzKpExGNS60zUst3JDaOz9Nkjln/KTo
         SoYQcATvD+6B3JC7uJA5ZWuFhPXPGwjdlWyFmV7TdIprBNkBfsC21GZ50M9btExCZa
         TCJV52bpxRJTRoU/N+YlX8Lo02hgoxge/+vYcEnQo7jAUcPJr407xs5RjvWJoAtIT2
         dZseqkmkGvasBrxYV6hUGHAj2Vgo+N6nhSFfen709qiFlb9Gxs3jCwjNIyibuhvO34
         IXEA13xKVue3A==
Received: by mail-lf1-f45.google.com with SMTP id 25so6964371lft.9
        for <linux-efi@vger.kernel.org>; Mon, 03 Oct 2022 08:57:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf0g2Fba5NOKF398W3dO5sQ42ypqssb+Xecys17gZlDoxPC2dJL2
        wbNX4wUmWQi+fSGFphhuFBr2budk3THIF6oWQDA=
X-Google-Smtp-Source: AMsMyM5zBei2ibLZSe5zBohqN76AF5p5VnNKqtesYDF5KeePFuwB202Vk4nYzh88dwPErgPxMR/ChrhAsD0uBYHKM5o=
X-Received: by 2002:a05:6512:261b:b0:4a1:abd7:3129 with SMTP id
 bt27-20020a056512261b00b004a1abd73129mr7960216lfb.637.1664812667660; Mon, 03
 Oct 2022 08:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221003112625.972646-1-ardb@kernel.org> <20221003112625.972646-5-ardb@kernel.org>
 <Yzr9R2ziBAJgzAqR@itl-email>
In-Reply-To: <Yzr9R2ziBAJgzAqR@itl-email>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 3 Oct 2022 17:57:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHjZRdhNdBjCJkmY16a005+wSemceWWLStDWEBywUp7uA@mail.gmail.com>
Message-ID: <CAMj1kXHjZRdhNdBjCJkmY16a005+wSemceWWLStDWEBywUp7uA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efi: memmap: Disregard bogus entries instead of
 returning them
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
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

On Mon, 3 Oct 2022 at 17:18, Demi Marie Obenour
<demi@invisiblethingslab.com> wrote:
>
> On Mon, Oct 03, 2022 at 01:26:23PM +0200, Ard Biesheuvel wrote:
> > The ESRT code currently contains some sanity checks on the memory
> > descriptor it obtains, but these can only trigger when the descriptor is
> > invalid (if at all).
> >
> > So let's drop these checks, and instead, disregard descriptors entirely
> > if the start address is misaligned, or the number of pages reaches
> > beyond the end of the address space. Note that the memory map as a whole
> > could still be inconsistent, i.e., multiple entries might cover the same
> > area, or the address could be outside of the addressable VA space, but
> > validating that goes beyond the scope of these helpers.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/firmware/efi/efi.c  | 13 +++++++------
> >  drivers/firmware/efi/esrt.c | 18 +-----------------
> >  2 files changed, 8 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 11857af72859..55bd3f4aab28 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -461,19 +461,20 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> >       efi_memory_desc_t *md;
> >
> >       if (!efi_enabled(EFI_MEMMAP)) {
> > -             pr_err_once("EFI_MEMMAP is not enabled.\n");
> > +             pr_warn_once("EFI_MEMMAP is not enabled.\n");
> >               return -EINVAL;
> >       }
> >
> > -     if (!out_md) {
> > -             pr_err_once("out_md is null.\n");
> > -             return -EINVAL;
> > -        }
> > -
>
> Nit: this seems unrelated.
>
> >       for_each_efi_memory_desc(md) {
> >               u64 size;
> >               u64 end;
> >
> > +             /* skip bogus entries */
> > +             if ((md->phys_addr & (EFI_PAGE_SIZE - 1)) ||
> > +                 (md->phys_addr > 0 &&
> > +                  (md->num_pages > (U64_MAX - md->phys_addr + 1) >> EFI_PAGE_SHIFT)))
> > +                     continue;
>
> Should this also check if md->num_pages is 0?

Yes, probably.

>  Also, should this check
> be part of for_each_efi_memory_desc()?
>

No, I don't think so. The for_each_xxx() helpers we have throughout
the kernel usually don't incorporate such checks, and I'd prefer to
adhere to the principle of least surprise here.

> > +
> >               size = md->num_pages << EFI_PAGE_SHIFT;
> >               end = md->phys_addr + size;
> >               if (phys_addr >= md->phys_addr && phys_addr < end) {
> > diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> > index 2a2f52b017e7..8f86f2b0734b 100644
> > --- a/drivers/firmware/efi/esrt.c
> > +++ b/drivers/firmware/efi/esrt.c
> > @@ -247,9 +247,6 @@ void __init efi_esrt_init(void)
> >       int rc;
> >       phys_addr_t end;
> >
> > -     if (!efi_enabled(EFI_MEMMAP))
> > -             return;
> > -
> >       pr_debug("esrt-init: loading.\n");
> >       if (!esrt_table_exists())
> >               return;
> > @@ -263,21 +260,8 @@ void __init efi_esrt_init(void)
> >               return;
> >       }
> >
> > -     max = efi_mem_desc_end(&md);
> > -     if (max < efi.esrt) {
> > -             pr_err("EFI memory descriptor is invalid. (esrt: %p max: %p)\n",
> > -                    (void *)efi.esrt, (void *)max);
> > -             return;
> > -     }
> > -
> > +     max = efi_mem_desc_end(&md) - efi.esrt;
> >       size = sizeof(*esrt);
> > -     max -= efi.esrt;
> > -
> > -     if (max < size) {
> > -             pr_err("ESRT header doesn't fit on single memory map entry. (size: %zu max: %zu)\n",
> > -                    size, max);
> > -             return;
> > -     }
>
> This can still happen if the ESRT pointer is very very close to the end
> of a memory map entry, unless there is another check that handles
> such cases.

You're right - I missed that.
