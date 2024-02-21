Return-Path: <linux-efi+bounces-625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBDD85ECDA
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4DB21744
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA51272B2;
	Wed, 21 Feb 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo6j9C+3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCD56456;
	Wed, 21 Feb 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557862; cv=none; b=bXgU2jiPSdcUFeC6nq9/Qpw2zdwS/FJLxKrx6uuLARE4b7tPNzu1ossHia/rDzsD18Jq6KEDdKh2vMt4d7gmi9YN2f6ObCB66XPOC/TuHQovLxS/0uqnXl0ayOAsGAefgaBWGa5XVT5IO91FgQEbCm5wa1LCn+AjhZYSWuWVDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557862; c=relaxed/simple;
	bh=o0pBvdU+JHgT39C/oZ43v61yIgxOBybqfEpddDffT+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4BOlSGoxPIU5l4AobN6VjfgXmiDgDv5hqQvSGx3xa3c65QB7eMHJtTkcYLfRLU51C8OKtl7CQoXmQWytOTZ3lGDbADrRJzBu7a6z7cWLzXSoKu22yv7Bsh+EH3sgF8XDOLY9T0PUdCXrIhdLSdej4i1LBDBLcf2RFXmQBwyGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo6j9C+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A2C433B2;
	Wed, 21 Feb 2024 23:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557862;
	bh=o0pBvdU+JHgT39C/oZ43v61yIgxOBybqfEpddDffT+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uo6j9C+3yRULLuhfUameeJdnFArY/DJQDmDNfb1NtvgSUoJu5xf4jfx3Gzy+QWSD9
	 /Ki6xXWWXFKWco2i+oBjemS298yxFH2zmONSAJcVKpgnn5ASa+vrnmQIpFxASzABp+
	 xoSQLSGYl7MTRjNIb7yQfurBY6V9FXK8ivBg1ovDs85Q1KUONIJVWj5xmY8Ur8JYYU
	 fZHc/w3kaVNWAkptQF2laAOVKKd9frUPsRF+EkoYYE7i6AHxoYzxa8iLUf660a9KUD
	 GjhfnDzRtt2+7CtEkm91mWF+v2OU9tMK+ATcehpGg8SBuGV4NPe2dcC3yYgKO2TTcg
	 nGOx4pK29xnCA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2531294faso19792401fa.2;
        Wed, 21 Feb 2024 15:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyNDcEzKTTQSv5DNDzm/PrucU88RphNZGanUIZpAW4RGjDQJRoA7FJlrzpZTt4kpx2CrcO1ZAs3P9e/iVNqF1VhthsobAG+dhfnKTe7wSsSdjrnEPK160TbQEifnJ6cxMni/EG6Kb7xGz3/xfbB6BHeSGx4yzb7N1MvOkq+WCmOCrewD+AbEAMPqmnF+BWfUgQNA48h1Km3vftmz4GB/6o3gILoVIaorvMToST92829DTGtVOhqZFyPaf6tC0X4XMJ
X-Gm-Message-State: AOJu0YxaIvoxLHyGYb7bxG007v0Gnu3PS5YuKWr7ng7EE0b9ZPf+wHTt
	YQ0yIU0PViUTWaBbYJ1dhHKJnMQTD7DbPx79iV/ma/Dee8P1mLaifevw0t3hppN3dAzc3eNCzkT
	vnyRwpFbEarFUMmBRf6EbMcc5eYc=
X-Google-Smtp-Source: AGHT+IEFjS3UH7erXEZ4kbkF96yuQm9TlfZ1AWhPucU81wH0eazr9XKjePangSR6zBzRuAu+rhDmfGqI9zl7A6Q+3YI=
X-Received: by 2002:a2e:b8c8:0:b0:2d0:c77c:b1ca with SMTP id
 s8-20020a2eb8c8000000b002d0c77cb1camr14950388ljp.49.1708557860236; Wed, 21
 Feb 2024 15:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-16-ross.philipson@oracle.com> <CAMj1kXF3k_c4Wn9GU+NC_+_aYfDpAzAUnfR=A4L_T+re1H3G=w@mail.gmail.com>
 <dc53f100-062b-47ae-abc8-5414ce8d041c@oracle.com> <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
In-Reply-To: <C98F883A-31D5-4F67-97FF-4AEFAADDDC74@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Feb 2024 00:24:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFYVbCd3EaweseNndhmOwdbzEmvB1vjWk2rmTBxAoPCxg@mail.gmail.com>
Message-ID: <CAMj1kXFYVbCd3EaweseNndhmOwdbzEmvB1vjWk2rmTBxAoPCxg@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] x86: EFI stub DRTM launch support for Secure Launch
To: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Cc: ross.philipson@oracle.com, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 21:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On February 21, 2024 12:17:30 PM PST, ross.philipson@oracle.com wrote:
> >On 2/15/24 1:01 AM, Ard Biesheuvel wrote:
> >> On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.co=
m> wrote:
> >>>
> >>> This support allows the DRTM launch to be initiated after an EFI stub
> >>> launch of the Linux kernel is done. This is accomplished by providing
> >>> a handler to jump to when a Secure Launch is in progress. This has to=
 be
> >>> called after the EFI stub does Exit Boot Services.
> >>>
> >>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>> ---
> >>>   drivers/firmware/efi/libstub/x86-stub.c | 55 ++++++++++++++++++++++=
+++
> >>>   1 file changed, 55 insertions(+)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmwa=
re/efi/libstub/x86-stub.c
> >>> index 0d510c9a06a4..4df2cf539194 100644
> >>> --- a/drivers/firmware/efi/libstub/x86-stub.c
> >>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> >>> @@ -9,6 +9,7 @@
> >>>   #include <linux/efi.h>
> >>>   #include <linux/pci.h>
> >>>   #include <linux/stddef.h>
> >>> +#include <linux/slr_table.h>
> >>>
> >>>   #include <asm/efi.h>
> >>>   #include <asm/e820/types.h>
> >>> @@ -810,6 +811,57 @@ static efi_status_t efi_decompress_kernel(unsign=
ed long *kernel_entry)
> >>>          return EFI_SUCCESS;
> >>>   }
> >>>
> >>> +static void efi_secure_launch(struct boot_params *boot_params)
> >>> +{
> >>> +       struct slr_entry_uefi_config *uefi_config;
> >>> +       struct slr_uefi_cfg_entry *uefi_entry;
> >>> +       struct slr_entry_dl_info *dlinfo;
> >>> +       efi_guid_t guid =3D SLR_TABLE_GUID;
> >>> +       struct slr_table *slrt;
> >>> +       u64 memmap_hi;
> >>> +       void *table;
> >>> +       u8 buf[64] =3D {0};
> >>> +
> >>
> >> If you add a flex array to slr_entry_uefi_config as I suggested in
> >> response to the other patch, we could simplify this substantially
> >
> >I feel like there is some reason why we did not use flex arrays. We were=
 talking and we seem to remember we used to use them and someone asked us t=
o remove them. We are still looking into it. But if we can go back to them,=
 I will take all the changes you recommended here.
> >
>
> Linux kernel code doesn't use VLAs because of the limited stack size, and=
 VLAs or alloca() makes stack size tracking impossible. Although this techn=
ically speaking runs in a different environment, it is easier to enforce th=
e constraint globally.

Flex array !=3D VLA

VLAs were phased out because of this reason (and VLAISs [VLAs in
structs] were phased out before that because they are a GNU extension
and not supported by Clang)

Today, VLAs are not supported anywhere in the kernel.

Flex arrays are widely used in the kernel. A flex array is a trailing
array of unspecified size in a struct that makes the entire *type*
have a variable size. But that does not make them VLAs (or VLAISs) - a
VLA is a stack allocated *variable* whose size is based on a function
parameter.

Instances of types containing flex arrays can be allocated statically,
or dynamically on the heap. This is common practice in the kernel, and
even supported by instrumentation to help the compiler track the
runtime size and flag overruns. We are even in the process of adding
compiler support to annotate struct members as carrying the number of
elements in an associated flex arrays, to improve the coverage of the
instrumentation.

I am not asking for a VLA here, only a flex array.

