Return-Path: <linux-efi+bounces-1561-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A8957AA2
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2024 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C08B22EF3
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2024 00:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8CE541;
	Tue, 20 Aug 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax39Rzc2"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD262BA4D
	for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115500; cv=none; b=Mx2utXtT1myMyJMKipuNVIKBumrgtKnoABepiWW8UrzMA7GiRhzd8vibz6WhV/26TERtaIvimujmV+LbtYkdnzMBxVb9u4KGPYvfSOzuchucL0MLd6O8nM41fuF6nzodA/w0M1sJBMwYxpE0CabSnAihh/b1ei3LewawzCralVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115500; c=relaxed/simple;
	bh=0VoB3F+f1M56dPnDJTyh/ZvXxKagqoILbksn7eR9ay8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eldkq1mWTB/ZuOcj5TaSsY3Us9EstAiMA19UQ3at4dQTJKzVB7Fu6dMxsoaoTQKx9McAaWJcRygggWI4IEgoIxeq9idcxa8QFMyJCe7IV3olY+TKOAdzxR2r6KBi2GCFC4x/K2J5L7u1fKoAzvNP3dFd689VTqng1V+Z0pbcVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ax39Rzc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724115497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
	b=Ax39Rzc2dpgZ5vpZA+qwAUTy+M0g0cB+mHS/c6pCELrsQ1lnlAsKJU+8CmkPMux5WUiSgo
	phzZrKDJvAPo3bZKq3uaQRq5x0ZYgcbtnKLmuEMD5WJ7sc/eIZWI0ZJIUNTVbDwOqPyjRr
	IrJVOto2gAXZ/WX+8B3G1GZdY54P4sk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-UyKQDEdGPlKfHPYatIrqHQ-1; Mon, 19 Aug 2024 20:58:13 -0400
X-MC-Unique: UyKQDEdGPlKfHPYatIrqHQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf88568489so31842586d6.0
        for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115493; x=1724720293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
        b=mpjOg06I9ujAZW5lFLqmsJjR4x0fS4opoJJ3VwqK0xvgHkiaFTD3jXNea2PURYAvG3
         gn5b4GfzNeGgvsNKKTFXdNApdq8RSwcl98l9K2ntB0xjoa88mdMn0adi6Pa/l41h4/r9
         QZNp3NONxc+RUzQgFjJ1ydJcoWqCA5jkDsb7nzol65KiHwtvErxgFZO5WvB9UWCKFCGy
         w+pyMPJYsLwgrrfOag7AjcCZbyVdAbGk/lVmXix0gqofCJy6dVi7xibDSfBHnrmf11X2
         7CZwM8W9b+OKBoiolOqTF7V5XWBz/7f4XisosbFKW5sk544l7bQLk/27ARRhclX733kP
         zYXw==
X-Gm-Message-State: AOJu0YzW2J+Bf0t6iQQIxNqi8ES+Cl7SNXVLwQDWeHrFV3Inu/PQPFxe
	tCIIrbrWjWGDQqXjWlqD3dH8atoxylJOubV0G3tM6SiE45k7DJWUS08P2ew8p1SWsqrqOOZ330z
	wdrG91fY+lLG5yIviBrSM6v2uy/5K73iINXRVn5RfizTCpm1xfN6hk4rZyKp23bOpa8y0nFD753
	w8wyIBRSjC8892r+YRXeXIXVLpMrIXN0Kc
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id 6a1803df08f44-6bf7ce06a55mr152730916d6.32.1724115493013;
        Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0xEAdTPZqQ0R37bhm+bI8tZ08r0K84Li3rZ/xKsFzl+U1c+/gTnEWiG6hFEZE3WA3cmHWfdPmI8H8H/7457I=
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id
 6a1803df08f44-6bf7ce06a55mr152730866d6.32.1724115492656; Mon, 19 Aug 2024
 17:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <20240819145417.23367-2-piliu@redhat.com>
 <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
In-Reply-To: <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 20 Aug 2024 08:58:01 +0800
Message-ID: <CAF+s44TK1RZ6m=b3RX_KTsptRQ06XZO_knn3=39eWXLv64AxoA@mail.gmail.com>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:00=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon Aug 19, 2024 at 5:53 PM EEST, Pingfan Liu wrote:
> > efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> > but the current implement can not ensure the selected target locates
> > inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> > EFI_RUNTIME_SERVICES_* etc.
> >
> > Fix the issue by checking md->type.
>
> If it is a fix shouldn't this have a fixes tag?
>
Yes, I will supplement the following in the next version
Fixes: 2ddbfc81eac8 ("efi: stub: add implementation of efi_random_alloc()")

> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > To: linux-efi@vger.kernel.org
> > ---
> >  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmw=
are/efi/libstub/randomalloc.c
> > index c41e7b2091cdd..7304e767688f2 100644
> > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> >               unsigned long slots;
> >
>
> I'd add this inline comment:
>
> /* Skip "unconventional" memory: */
>

Adopt.

Thanks for your kind review.

Best Regards,

Pingfan

> > +             if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTE=
NT_MEMORY)))
> > +                     continue;
> >               slots =3D get_entry_num_slots(md, size, ilog2(align), all=
oc_min,
> >                                           alloc_max);
> >               MD_NUM_SLOTS(md) =3D slots;
> > @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               efi_physical_addr_t target;
> >               unsigned long pages;
> >
> > +             if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTE=
NT_MEMORY)))
> > +                     continue;
> > +
> >               if (total_mirrored_slots > 0 &&
> >                   !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
> >                       continue;
>
> BR, Jarkko
>


