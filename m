Return-Path: <linux-efi+bounces-5253-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CBEC1F980
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 11:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA752424A6E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84256351FB8;
	Thu, 30 Oct 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSGT/15K"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4634D936
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820586; cv=none; b=rTJZX1thvh5uV3sNTYjPCZQHRVsDvFsCoX3yGY5whWjUg61KGuFXcCgXZLlZMVaPKD90mp0sxmDKFroa+/VwNqP/ijzSvFuI2fkosJSFJADj4TePcpfaIxn0XQxFo6aAEOB4m96wBK1d9ugBKpRN79LAbxvB2PRBWaEJyR+FaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820586; c=relaxed/simple;
	bh=EWFesmgztVELijrKVyAIw58RaW5qiWVySUAVHUAu/+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uITXp5k3grki2qjYtMXqwo8SFcn+wNp5YibsHWKJHP17a4eSt6I+4oSJK9vHrbD2TyL3rXLn2GBWxbt60duFxfwejnQJeWEzhi1WXVYNRpkbYOLLkXv/0Xuy5lexj8aXpc1B77P0PWziKqPpw9kr9+pRQRlxR5Ps0p7GbT5th80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSGT/15K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B555C116B1
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761820586;
	bh=EWFesmgztVELijrKVyAIw58RaW5qiWVySUAVHUAu/+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dSGT/15Kfa4OjyCbAC3SF32XVKb7iNe5i2e4rxYDvK+/9ZzBSpT0ZAMJfDHB1bcP2
	 hp5kUsmaBwE0hUemzCE8xVONjhfFtAVrRoKKP13YBZa7NSi8axpICuho4I7H7pyOXn
	 jdM+sxNM2/bMtwb/8zTeW1KCgChee/4k78ddKWL5YKaucYtJvcIMlwzOhYUO7mPGey
	 9i/5Nf9FD59c14UP/zd1Kar2xylXV8dSZNyLvDNGacgpUNIjWv8EmRHggYRoep7d3a
	 cC2Z6yFL0DTwcMRBC0hqJqNbd74O1SUUL2lp4zC10zY5eFpCTEe1YISaoNMaN+mcRb
	 csZ/MUE3SsF4Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5930f751531so882750e87.3
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 03:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK5WK3W5qIBnaLfX/QWKMt3dj/sOb7/G3rfD1fRBTV8SFjc2Mmx4d5PXk1ZV2o87hfrZgtAvuQ6lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiwR5WohLl/fmda4D4T/I5ZOz7lypwad8OXWjSZfc7rrLLMXr
	IC/20iGU5jEJagPrRHevC081yFPLii6wdL/CzU4h42vbH0gY/Gp2PWWNHayqNDsxD0Z78FRbV1C
	CUoOfRfHKSRSNFdQNA87qFauhNxUd8Kw=
X-Google-Smtp-Source: AGHT+IHR/19RmctxNKLqKlIM6A9WMpVSviX3cRXYR7NP88oXpyxxA4MhRkufffXBTnPae5fME9y34v1H81TPMSh2mxo=
X-Received: by 2002:a05:6512:39c5:b0:592:fa97:e167 with SMTP id
 2adb3069b0e04-59412a07650mr2713264e87.51.1761820584347; Thu, 30 Oct 2025
 03:36:24 -0700 (PDT)
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
 <CAMj1kXHu5ABgxKsc_gg1j=pWMz6DbWoqv=qAAjx-5CiSF2PAiQ@mail.gmail.com>
 <BD93A8DBE27154B0+22bf4a83-a850-4f78-8e0d-84cc93fe2715@uniontech.com>
 <CAMj1kXFUUCoE=gZ0kTMKx87qnJMU9J9skT75STTKjjakXb8kmw@mail.gmail.com> <89364700AD0CD6E1+dd8d745f-5a72-4b0a-80db-eaa1d00c4e64@uniontech.com>
In-Reply-To: <89364700AD0CD6E1+dd8d745f-5a72-4b0a-80db-eaa1d00c4e64@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Oct 2025 11:36:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHpJ3gz=+Keswx0MZ8v6YQENR2pjeS_CE6g4cXML2LQhA@mail.gmail.com>
X-Gm-Features: AWmQ_bmO2T77I4AkXqTFCl7Na2UIDeYUBNoQV7BXje2VupPA54kyxqhBixnA39k
Message-ID: <CAMj1kXHpJ3gz=+Keswx0MZ8v6YQENR2pjeS_CE6g4cXML2LQhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 at 11:25, Qiang Ma <maqianga@uniontech.com> wrote:
>
>
> =E5=9C=A8 2025/10/30 18:02, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Thu, 30 Oct 2025 at 08:37, Qiang Ma <maqianga@uniontech.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/29 22:15, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>> On Wed, 29 Oct 2025 at 10:55, Qiang Ma <maqianga@uniontech.com> wrote=
:
> >>>> =E5=9C=A8 2025/10/28 21:42, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>>>> On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wro=
te:
> >>>>>> =E5=9C=A8 2025/10/23 16:30, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>>>>>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> w=
rote:
> >>>>>>>> In the efi_virtmap_init(), permission settings have been applied=
:
> >>>>>>>>
> >>>>>>>> static bool __init efi_virtmap_init(void)
> >>>>>>>> {
> >>>>>>>>             ...
> >>>>>>>>             for_each_efi_memory_desc(md)
> >>>>>>>>                     ...
> >>>>>>>>                     efi_create_mapping(&efi_mm, md);
> >>>>>>>>             ...
> >>>>>>>>             efi_memattr_apply_permissions(&efi_mm, efi_set_mappi=
ng_permissions);
> >>>>>>>>             ...
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> Therefore, there is no need to apply it again in the efi_create_=
mapping().
> >>>>>>>>
> >>>>>>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI=
 Runtime Services regions")
> >>>>>>>>
> >>>>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> >>>>>>> No, efi_memattr_apply_permissions() uses the /optional/ memory
> >>>>>>> attributes table, whereas efi_create_mapping() uses the permissio=
n
> >>>>>>> attributes in the EFI memory map. The memory attributes table is
> >>>>>>> optional, in which case any RO/XP attributes from the memory map
> >>>>>>> should be used.
> >>>>>>>
> >>>>>> I see.
> >>>>>>
> >>>>>> Then, can it be modified like this?
> >>>>> No
> >>>>>
> >>>>>> --- a/arch/arm/kernel/efi.c
> >>>>>> +++ b/arch/arm/kernel/efi.c
> >>>>>> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct=
 *mm,
> >>>>>> efi_memory_desc_t *md)
> >>>>>>                     desc.type =3D MT_MEMORY_RWX_NONCACHED;
> >>>>>>             else if (md->attribute & EFI_MEMORY_WC)
> >>>>>>                     desc.type =3D MT_DEVICE_WC;
> >>>>>> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
> >>>>> This will be true for RO, XP or RO+XP.
> >>>>>
> >>>>>> +               desc.type =3D MT_MEMORY_RO;
> >>>>> This will apply RO permissions even to XP regions, which need to be=
 writable.
> >>>>>
> >>>> Thanks for your review.
> >>>> I see.
> >>>>
> >>>> I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
> >>>> and then we can use the RO+XP attribute to implement memory mapping.
> >>>>
> >>> Why? The current code is working fine, no?
> >>>
> >> Yes, the current code is running normally.
> >>
> >> The reasons for the modification are as follows:
> >> I noticed that the arm64/RISC-V efi_create_mapping() always return 0,
> >> but in the code where efi_virtmap_init() calls it, it is as follows:
> >>
> >> ret =3D efi_create_mapping(&efi_mm, md);
> >> if (ret) {
> >>       pr_warn("  EFI remap %pa: failed to create mapping (%d)\n",
> >>           &phys, ret);
> >>       return false;
> >> }
> >>
> >> This return error print is unnecessary, so I want to remove it.
> > So what is preventing you from removing this from the RISC-V version?
> >
> The current idea is to first remove the unnecessary return print from
> arm/arm64,

Please leave the ARM code alone.

> and then remove RISC-V later, as this RISC-V code is also adapted based
> on arm64.
>

RISC-V copied the ARM code and used it as a starting point. That does
not mean it has to remain that way.

