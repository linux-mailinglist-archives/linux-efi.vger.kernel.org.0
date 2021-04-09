Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745963595ED
	for <lists+linux-efi@lfdr.de>; Fri,  9 Apr 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhDIG7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Apr 2021 02:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhDIG7G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 9 Apr 2021 02:59:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48B1761165
        for <linux-efi@vger.kernel.org>; Fri,  9 Apr 2021 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617951534;
        bh=xCeA8QMY+cxjdoG5vh1ZVFnQ3ZcMHgwKgWB0gy/oY/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljT83JPh/cPVtz668Pu9VMOqmeswpHrSBsoR/KEuUOoTf9IeZdjjD12el2yYXM5iy
         a0kAnwKIWClq5wbvTBLLIO0emZEK+8Fp4uOoUNa9MpdI4ed0sg9bIB/aci8WMkXdXq
         ZuDFYd5KzPldgECvYOV512k66YKqv6/SmNUXktdKrNo6V3qwU4QIuO2N0oiF7ZrEOv
         4RLcBCnZXUxiMM9ZeW+WV+glmA486wHo0bzwgJ+tcrAbZOe1CYGQjDpgCT/OCmBc/m
         W1GupbaimgAzoc8oneuWYau1KfZ/CiTTJXPWKDI2ceKKXEXAzERD+NKSdTv9154D2g
         9GcPJKwqUiJ7A==
Received: by mail-ot1-f43.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so4782484otr.4
        for <linux-efi@vger.kernel.org>; Thu, 08 Apr 2021 23:58:54 -0700 (PDT)
X-Gm-Message-State: AOAM530FIilogVxgf74Zfg/dkR4lb6/+bq0VQzMoqBtzEEMMjELzOJND
        XsY5Y/U7XzAdh62gO+3tA+6bbatYAwQNHDdMfcQ=
X-Google-Smtp-Source: ABdhPJzMoKfMNqxgd/oe2BEUzc5fLt8c1ZFQzXgx1TiYFCLQI8pKQCs70hiottlOef207R0GTYLJrjC1zl9bfmwu9xc=
X-Received: by 2002:a9d:7ccf:: with SMTP id r15mr10729108otn.108.1617951533642;
 Thu, 08 Apr 2021 23:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201025134941.4805-1-ard.biesheuvel@arm.com> <20201025134941.4805-6-ard.biesheuvel@arm.com>
 <70b3f147-b6d6-013e-fc65-e7228486d911@gmx.de> <CAMj1kXFC6OvBD2tDeKWbSWugurvheZdr9vw_F-r6WRwnpLsG2w@mail.gmail.com>
 <371cd2a9-1302-8e8c-9c2e-3fffb1be6a1e@gmx.de>
In-Reply-To: <371cd2a9-1302-8e8c-9c2e-3fffb1be6a1e@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Apr 2021 08:58:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHb=0nGF_KPxuvLwZW1AK526jOE+rpmwX1G5BUtWcNTMg@mail.gmail.com>
Message-ID: <CAMj1kXHb=0nGF_KPxuvLwZW1AK526jOE+rpmwX1G5BUtWcNTMg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] linux/arm: account for COFF headers appearing at
 unexpected offsets
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 9 Apr 2021 at 08:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/9/21 8:12 AM, Ard Biesheuvel wrote:
> > On Thu, 8 Apr 2021 at 20:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 10/25/20 2:49 PM, Ard Biesheuvel wrote:
> >>> The way we load the Linux and PE/COFF image headers depends on a fixed
> >>> placement of the COFF header at offset 0x40 into the file. This is a
> >>> reasonable default, given that this is where Linux emits it today.
> >>> However, in order to comply with the PE/COFF spec, which permits this
> >>> header to appear anywhere in the file, let's ensure that we read the
> >>> header from where it actually appears in the file if it is not located
> >>> at offset 0x40.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> >>> ---
> >>>    grub-core/loader/arm64/linux.c | 15 +++++++++++++++
> >>>    1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> >>> index 915b6ad7292d..28ff8584a3b5 100644
> >>> --- a/grub-core/loader/arm64/linux.c
> >>> +++ b/grub-core/loader/arm64/linux.c
> >>> @@ -66,6 +66,21 @@ grub_arch_efi_linux_load_image_header (grub_file_t file,
> >>>      grub_dprintf ("linux", "UEFI stub kernel:\n");
> >>>      grub_dprintf ("linux", "PE/COFF header @ %08x\n", lh->hdr_offset);
> >>>
> >>> +  /*
> >>> +   * The PE/COFF spec permits the COFF header to appear anywhere in the file, so
> >>> +   * we need to double check whether it was where we expected it, and if not, we
> >>> +   * must load it from the correct offset into the coff_image_header field of
> >>> +   * struct linux_arch_kernel_header.
> >>> +   */
> >>> +  if ((grub_uint8_t *) lh + lh->hdr_offset != (grub_uint8_t *) &lh->coff_image_header)
> >>> +    {
> >>> +      grub_file_seek (file, lh->hdr_offset);
> >>
> >> Isn't this overly complicated? Why don't we first read the whole file
> >> into memory and then analyze it instead of using multiple accesses which
> >> only slows down the process?
> >>
> >
> > Given that the condition will never hold in practice, as the offset is
> > always going to be 0x40, this change is not expected to affect
> > performance at all.
>
> The PE COFF specification let's you specify any value. The linux command
> can be used to launch arbitrary EFI binaries if they have the Linux
> magic 'ARM\x64' in the right place.
>
> What I never understood is why the linux command is checking this Linux
> magic field at all instead of running any EFI binary thrown at it.
>

I don't disagree with you on that. The question is whether it should
be in scope for this change to fix all of that.
