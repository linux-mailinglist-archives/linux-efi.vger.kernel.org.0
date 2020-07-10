Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD63921B654
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGJN1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jul 2020 09:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJN1g (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Jul 2020 09:27:36 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05664207DD;
        Fri, 10 Jul 2020 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387655;
        bh=mNW++VsEqP3S7PL2ngGMIOCMSfxmahBdnZ67NyJxUvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y29NVJdkXAxsgk2xI3t1jiVzttBFvTNx8HCPIKiN8ZM7ftE9wB6zTnP1BMb0MkiHU
         QendZh5SWBTBNOnp2LBOwt7y9i89bCxloiL/H5BpHgUTMz/HsVGIVwSr+QGFlWIjcr
         y7jk4l2N4ARxgyR+SRTlUkcRkdfqRggSEE0L6X1I=
Received: by mail-oi1-f175.google.com with SMTP id t198so4762957oie.7;
        Fri, 10 Jul 2020 06:27:34 -0700 (PDT)
X-Gm-Message-State: AOAM531oTa+ZKHY9CAQK4I0qWrIdUppC1hfP9Ye+iAuVjSnAUrNMehWS
        h44bL5h6EJO0eO+rZ1aya4clxYvtCYLJnytP0NI=
X-Google-Smtp-Source: ABdhPJx27k85cRD5Br4iASr1hfkX2ZBE1Hh91r9eyyCurmoSEz5t5x80h7mauiVvJR80iRujQZjgdIQ5i6DKyNJJWKM=
X-Received: by 2002:aca:d643:: with SMTP id n64mr4195802oig.33.1594387654399;
 Fri, 10 Jul 2020 06:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200610141052.13258-1-jgross@suse.com> <094be567-2c82-7d5b-e432-288286c6c3fb@suse.com>
 <CGME20200709091750eucas1p18003b0c8127600369485c62c1e587c22@eucas1p1.samsung.com>
 <ec21b883-dc5c-f3fe-e989-7fa13875a4c4@suse.com> <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
In-Reply-To: <170e01b1-220d-5cb7-03b2-c70ed3ae58e4@samsung.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Jul 2020 16:27:23 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGE52Y6QQhGLU6r_9x6TVftZqfS7zyLCiDusZhV4tbhjg@mail.gmail.com>
Message-ID: <CAMj1kXGE52Y6QQhGLU6r_9x6TVftZqfS7zyLCiDusZhV4tbhjg@mail.gmail.com>
Subject: Re: [PATCH] efi: avoid error message when booting under Xen
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 10 Jul 2020 at 13:17, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> [ added EFI Maintainer & ML to Cc: ]
>
> Hi,
>
> On 7/9/20 11:17 AM, J=C3=BCrgen Gro=C3=9F wrote:
> > On 28.06.20 10:50, J=C3=BCrgen Gro=C3=9F wrote:
> >> Ping?
> >>
> >> On 10.06.20 16:10, Juergen Gross wrote:
> >>> efifb_probe() will issue an error message in case the kernel is boote=
d
> >>> as Xen dom0 from UEFI as EFI_MEMMAP won't be set in this case. Avoid
> >>> that message by calling efi_mem_desc_lookup() only if EFI_PARAVIRT
> >>> isn't set.
> >>>

Why not test for EFI_MEMMAP instead of EFI_BOOT?


> >>> Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes =
when mapping the FB")
> >>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>> ---
> >>>   drivers/video/fbdev/efifb.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.=
c
> >>> index 65491ae74808..f5eccd1373e9 100644
> >>> --- a/drivers/video/fbdev/efifb.c
> >>> +++ b/drivers/video/fbdev/efifb.c
> >>> @@ -453,7 +453,7 @@ static int efifb_probe(struct platform_device *de=
v)
> >>>       info->apertures->ranges[0].base =3D efifb_fix.smem_start;
> >>>       info->apertures->ranges[0].size =3D size_remap;
> >>> -    if (efi_enabled(EFI_BOOT) &&
> >>> +    if (efi_enabled(EFI_BOOT) && !efi_enabled(EFI_PARAVIRT) &&
> >>>           !efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
> >>>           if ((efifb_fix.smem_start + efifb_fix.smem_len) >
> >>>               (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
> >>>
> >>
> >
> > In case I see no reaction from the maintainer for another week I'll tak=
e
> > this patch through the Xen tree.
>
> From fbdev POV this change looks fine to me and I'm OK with merging it
> through Xen or EFI tree:
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
