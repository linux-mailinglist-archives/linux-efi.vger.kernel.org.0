Return-Path: <linux-efi+bounces-5225-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8EC1BB0D
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CC66614CF
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D32258ECC;
	Wed, 29 Oct 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJjMxP6I"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3A2561D1
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747372; cv=none; b=D2fVcGLpDPAxYKnpd11gVUr2PwBDJSmokjC2l1VoBdjiOkVxQA7UQVXoxXcM6PYB9zwdqq8x8J9lveN0sHScjV7hIysYEn/EdMisPt6H3RQTitW8ynWN4BQFFyT81RRzz0cnxWTKEC2Z6dV04/R9PDLq+geczvAi1yrGpSTiqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747372; c=relaxed/simple;
	bh=8p5qzn5lsjro6ecyrajsLYnqkz4JpIKQTGIKLB0bxno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWsu4eXvL8xGGDu76qgkmS86a8X8x9JYdVRc83OG75YwDkwLhL/yvggxUF4WrIdz4NobTzAFrbgVOnxJshzSZanTyrhzvVOVKiM8o5Uzj/5dgFlBXWOuX9OapuUS2rZoI9EsCAXNqKFN9St78gYWsO152PBQtUFG1KTMgvKXQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJjMxP6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50569C4CEFD
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747372;
	bh=8p5qzn5lsjro6ecyrajsLYnqkz4JpIKQTGIKLB0bxno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OJjMxP6IwoKCGacSgRL4QW2fdPx5GViCAibFG1eB4z0jhcV6B1aC7o0RtzfSDLeBh
	 TX82KVkgDRpsJdUM1tBUkYZGznNwBxIoJe9zgWqYjbLFrdYZP2MOpQqINGllnvUsMB
	 aMdxJoGaDM7SU1H4/cekAaZtxXv9wsKmm2SzaLChIuu1J9zAxx72B8BBD+29ypnWoe
	 inH443ETBqX+uBW/KhdROcbY/dGwOywYFt6MaxM8GxaRQ/mXVE27Rr7aphwJxMXp35
	 UY+Mdhwl5OVhQ1LXuAGOfJb+lrgphfIVKt0bHXC8rJTkAiqMzx1kUoqnaaDDsqbsvh
	 HLk03LeXC/dzQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592f1988a2dso1139792e87.0
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 07:16:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvkjqxXO/g8J2V+5ygw8392ZiHnMle+oTLegwV+Z1JZJZnS1GLm0Czy+/e4V/8w+S+48BroH+0+0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICvhePufNnSVJ8Vb2Y3dCn7rWdTakwcTX5/k8uisjUOujaySp
	fw4+tZXgOxETtRjfYkQNrHcaOi/k5ymn7+3KhO1o0ARI3KDXiLuznw7Q6tyS0+8OBr3+8GPr36e
	xDnl+gscF+J/TOE/ZSiUD0oJp3yRu/2o=
X-Google-Smtp-Source: AGHT+IEzWgdNj4Bs2eCcMWiSr9KjTK5w+8iRiC5xWh9ohGIX6Rk16IJVlTtZlJ9iC+OCfdlfG1EIrEfOnjygVEO23AI=
X-Received: by 2002:a05:6512:110e:b0:592:f098:f38a with SMTP id
 2adb3069b0e04-59412cb34a6mr1099049e87.20.1761747370603; Wed, 29 Oct 2025
 07:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082129.75612-1-maqianga@uniontech.com>
 <CAMj1kXHs3vC4TEWg1ogG=N8Dd5L0rkQ=qAFLWKiAA5yi_He3GA@mail.gmail.com>
 <10D9A93B0633E6BE+75720e07-b39d-452c-952e-41f8ab6aad94@uniontech.com>
 <CAMj1kXHQ6WQWfbkMP4JUk=nKwSt7CovY25RC4JA0ZM7vRWu6dA@mail.gmail.com> <9F7F632B7963434F+abad2548-a90d-4448-ae79-dd4bf637ee6e@uniontech.com>
In-Reply-To: <9F7F632B7963434F+abad2548-a90d-4448-ae79-dd4bf637ee6e@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 29 Oct 2025 15:15:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHu5ABgxKsc_gg1j=pWMz6DbWoqv=qAAjx-5CiSF2PAiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkPBgz5qsoTj4IvJC_wLSrwQLJE6QkYE7qxmwFvIEBZJRA3qMEx45Je13s
Message-ID: <CAMj1kXHu5ABgxKsc_gg1j=pWMz6DbWoqv=qAAjx-5CiSF2PAiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM/efi: Remove duplicate permission settings
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux@armlinux.org.uk, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Oct 2025 at 10:55, Qiang Ma <maqianga@uniontech.com> wrote:
>
>
> =E5=9C=A8 2025/10/28 21:42, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Mon, 27 Oct 2025 at 04:46, Qiang Ma <maqianga@uniontech.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/23 16:30, Ard Biesheuvel =E5=86=99=E9=81=93:
> >>> On Thu, 23 Oct 2025 at 10:22, Qiang Ma <maqianga@uniontech.com> wrote=
:
> >>>> In the efi_virtmap_init(), permission settings have been applied:
> >>>>
> >>>> static bool __init efi_virtmap_init(void)
> >>>> {
> >>>>           ...
> >>>>           for_each_efi_memory_desc(md)
> >>>>                   ...
> >>>>                   efi_create_mapping(&efi_mm, md);
> >>>>           ...
> >>>>           efi_memattr_apply_permissions(&efi_mm, efi_set_mapping_per=
missions);
> >>>>           ...
> >>>> }
> >>>>
> >>>> Therefore, there is no need to apply it again in the efi_create_mapp=
ing().
> >>>>
> >>>> Fixes: 9fc68b717c24 ("ARM/efi: Apply strict permissions for UEFI Run=
time Services regions")
> >>>>
> >>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> >>> No, efi_memattr_apply_permissions() uses the /optional/ memory
> >>> attributes table, whereas efi_create_mapping() uses the permission
> >>> attributes in the EFI memory map. The memory attributes table is
> >>> optional, in which case any RO/XP attributes from the memory map
> >>> should be used.
> >>>
> >> I see.
> >>
> >> Then, can it be modified like this?
> > No
> >
> >> --- a/arch/arm/kernel/efi.c
> >> +++ b/arch/arm/kernel/efi.c
> >> @@ -65,16 +65,13 @@ int __init efi_create_mapping(struct mm_struct *mm=
,
> >> efi_memory_desc_t *md)
> >>                   desc.type =3D MT_MEMORY_RWX_NONCACHED;
> >>           else if (md->attribute & EFI_MEMORY_WC)
> >>                   desc.type =3D MT_DEVICE_WC;
> >> +       else if (md->attribute & (EFI_MEMORY_RO | EFI_MEMORY_XP))
> > This will be true for RO, XP or RO+XP.
> >
> >> +               desc.type =3D MT_MEMORY_RO;
> > This will apply RO permissions even to XP regions, which need to be wri=
table.
> >
> Thanks for your review.
> I see.
>
> I can introduce a new type MT_MEMORY_RO_XP, to describe RO+XP,
> and then we can use the RO+XP attribute to implement memory mapping.
>

Why? The current code is working fine, no?

