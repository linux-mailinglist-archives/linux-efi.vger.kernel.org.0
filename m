Return-Path: <linux-efi+bounces-5250-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D1C1F6E3
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BC3AAC92
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BE3043CB;
	Thu, 30 Oct 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIcPugs3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A370809
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818569; cv=none; b=fRShesPc8ugjaO8yLyGNvuBERPHCTBqsp+IQ2qAyG4WUq3wYQwpsRk4Tph1sLC/7YVYyislF5Xcm0U+OmIkitCljx20IcWRguBRC/pUN30I75kxvZQVjlmotvPLYVzwfJQ9DJuzAM/AesLhuxQ0W2f2sJagte7gRNAUYG7HwHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818569; c=relaxed/simple;
	bh=r5xiql/CWLoKOljyLg2/QtrdaB9yqJsCMTZbhNIakUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frYvVoGZ2OOo0BuT1mzYGgDn4LvnT1JsxakSnyhLYBw44aukFopZPphPGGvaD1rESsgyKO1xY/RoOdbfthhDunhKxH7UCzl0gNZ+NPDIBZbOk661tQbTCfLLsX2qK0N6ChoJDPb+8gyXikltjvA62HuYDiienBaORjamiEOhkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIcPugs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7009C113D0
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818568;
	bh=r5xiql/CWLoKOljyLg2/QtrdaB9yqJsCMTZbhNIakUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EIcPugs30KHp2oN6mGnWO5R5GzlIB6xW5eoCAJ4MOPlPLrSXwaLhXrJblMRprR9aE
	 QdVaoLFBWMtbOfqcgqdvWKf714XGEVo52AwmfsAF/XLBJRU1X0qCcgQLyB741xpYst
	 Bvb0sp/uiUa2FyqNtgKl+1uM/aw66NPNI7tTLaVi6UCZMGnqsqcqYKZfG//A479eCx
	 xWiWqbzK3qhlm1MghWY9R1/rlr6NwA0tOvxWWfqRQQ1hVhNWo+xtiT0HWLXUqvR2zd
	 BSTrIsQzM84Wior5sP8wqfA9xR4THb9jhUAzjW40ierljUBJaeh5lqS+llpF+9VwgS
	 VcDUrTyhMoS8Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3652d7800a8so6115031fa.0
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 03:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaBI3AB+MA+gKxu3fgtM0ucrW8Q4yLjFxMcj3ursxBrtYFcU42qbczb4sv/oe/2U+9mV8EpSj2u60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVzjt1ygDttWjIgtMHQwfejbQ47gTXBPnmHoHb2Sxl5ge/KUS
	WP75VAXXO2sJW/jjpeUYV76MwgKDoLzIhLX1/yivxtYH7eMivOxV5yoBlmjyW5EPjuwEsedgsUS
	GN6aCEMOzJOQIjRMXCffWJo78HjpUGac=
X-Google-Smtp-Source: AGHT+IEWtHRJgfzesZIicoiwBsGNiijy1Cz9bSwYEQl6Xwgwlj+lutUH1oxJWo6qzPvnRFAwdMfybG0k46nq2737U4E=
X-Received: by 2002:a05:651c:12c8:b0:372:9505:7256 with SMTP id
 38308e7fff4ca-37a05316e43mr17170601fa.30.1761818567165; Thu, 30 Oct 2025
 03:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082129.75612-1-maqianga@uniontech.com>
 <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
 <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
 <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com>
 <9F7F632B7963434F+abad2548-a90d-4448-ae79-dd4bf637ee6e@uniontech.com>
 <CAMj1kXHu5ABgxKsc_gg1j=pWMz6DbWoqv=qAAjx-5CiSF2PAiQ@mail.gmail.com> <BD93A8DBE27154B0+22bf4a83-a850-4f78-8e0d-84cc93fe2715@uniontech.com>
In-Reply-To: <BD93A8DBE27154B0+22bf4a83-a850-4f78-8e0d-84cc93fe2715@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Oct 2025 11:02:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFUUCoE=gZ0kTMKx87qnJMU9J9skT75STTKjjakXb8kmw@mail.gmail.com>
X-Gm-Features: AWmQ_bmbipMpTfTSvyFPuGPK5qsmoZKz2m5xvqfsOsmZI7s9lak8SdW6KJRsPRA
Message-ID: <CAMj1kXFUUCoE=gZ0kTMKx87qnJMU9J9skT75STTKjjakXb8kmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 08:37, Qiang Ma <maqianga@uniontech.com> wrote:
>
>
> =E5=9C=A8 2025/10/29 22:15, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Wed, 29 Oct 2025 at 10:55, Qiang Ma <maqianga@uniontech.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/28 21:42, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>> On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote=
:
> >>>> =E5=9C=A8 2025/10/23 16:30, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>>>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wro=
te:
> >>>>>> In the efi_virtmap_init(), permission settings have been applied:
> >>>>>>
> >>>>>> static bool __init efi_virtmap_init(void)
> >>>>>> {
> >>>>>>            ...
> >>>>>>            for_each_efi_memory_desc(md)
> >>>>>>                    ...
> >>>>>>                    efi_create_mapping(&efi_mm, md);
> >>>>>>            ...
> >>>>>>            efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_=
permissions);
> >>>>>>            ...
> >>>>>> }
> >>>>>>
> >>>>>> Therefore, there is no need to apply it again in the efi_create_ma=
pping().
> >>>>>>
> >>>>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI R=
untime Services regions")
> >>>>>>
> >>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> >>>>> No, efi_memattr_apply_permissions() uses the /optional/ memory
> >>>>> attributes table, whereas efi_create_mapping() uses the permission
> >>>>> attributes in the EFI memory map. The memory attributes table is
> >>>>> optional, in which case any RO/XP attributes from the memory map
> >>>>> should be used.
> >>>>>
> >>>> I see.
> >>>>
> >>>> Then, can it be modified like this?
> >>> No
> >>>
> >>>> --- a/arch/arm/kernel/efi.c
> >>>> +++ b/arch/arm/kernel/efi.c
> >>>> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *=
mm,
> >>>> efi_memory_desc_t *md)
> >>>>                    desc.type =3D MT_MEMORY_RWX_NONCACHED;
> >>>>            else if (md->attribute & EFI_MEMORY_WC)
> >>>>                    desc.type =3D MT_DEVICE_WC;
> >>>> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
> >>> This will be true for RO, XP or RO+XP.
> >>>
> >>>> +               desc.type =3D MT_MEMORY_RO;
> >>> This will apply RO permissions even to XP regions, which need to be w=
ritable.
> >>>
> >> Thanks for your review.
> >> I see.
> >>
> >> I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
> >> and then we can use the RO+XP attribute to implement memory mapping.
> >>
> > Why? The current code is working fine, no?
> >
> Yes, the current code is running normally.
>
> The reasons for the modification are as follows:
> I noticed that the arm64/RISC-V efi_create_mapping() always return 0,
> but in the code where efi_virtmap_init() calls it, it is as follows:
>
> ret =3D efi_create_mapping(&efi_mm, md);
> if (ret) {
>      pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
>          &phys, ret);
>      return false;
> }
>
> This return error print is unnecessary, so I want to remove it.

So what is preventing you from removing this from the RISC-V version?

