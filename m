Return-Path: <linux-efi+bounces-1715-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA6976E19
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C6AB21A3D
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DA1A0BCB;
	Thu, 12 Sep 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDJccmdj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B778C9D;
	Thu, 12 Sep 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155947; cv=none; b=tht9l2quOuxKpbtY2f+upLUDhdFLk9BtP885Bi0WjkjeCoSLG10TiFakxDzDCqLgQEWBKCsBdbCbIZGqEtupDVPrhWnJihGRn3g3uiXcwboSsYWxdBJxnrt8ELMC8haxzMeW6zopcSbATdgfHDp1wcw1rLJsMLeg4dDD8gZGP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155947; c=relaxed/simple;
	bh=ywFiwczqxaKbUkWxJ47iW1M5pbc7iwd6Xn9eBevRoDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddpwDVSkla8O1gn3FXh5yh5NZX14Ihdg/cODBtM/Fsk9UBfycm3UMUFfjrRYHTbXqJFD6JORPkk/v12kAvkMY87bzS9ia3p/MtzObBwMszs/VAQsV5xjxGOtoYcytI4PJwjoGQTP2ugn0oAk8FLWuDSC0gg4XVOtBdhLzOcET/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDJccmdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ACCC4AF09;
	Thu, 12 Sep 2024 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155947;
	bh=ywFiwczqxaKbUkWxJ47iW1M5pbc7iwd6Xn9eBevRoDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pDJccmdjI03IMJtcb83SC1z9FrOAtChHORsadr4dL473qvY49Ojw7AzIH/kZ+qyJd
	 HdcYp8vaTNdIVBy3FJem7f5uyj3kAnsETgKuzcOHLCbE+IxOw5YSXS+/Kzs5eluwU0
	 3PoA7LbnUgooH0Pqso3eGEXTFkYGqemxQHiH51pqx+ESnn4vrtk8IkWi1WXCUpK5Fm
	 ryACS4yQiuwt0XKNpDWBFaDILYe/2fEWSMHxM2ERC+2Tnxnnd8e62t3w8ETrKSYvOR
	 N/rKI0p4+c3TyEROfXjyKUIBb9RXT/FOZDVxLkvY9UdvMLWtJ3BSv+x+15AX8ZA6Bp
	 Z64PIgHlKm35A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53654dbde59so2132046e87.1;
        Thu, 12 Sep 2024 08:45:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe5feESTzueMXtTFfeaN6seBwovgKVhcvfBMcC9NJ99KUE2WytLl9GXUoUnxVy1VZaY3hpr5F4fbU=@vger.kernel.org, AJvYcCXjNjDS/hyWWt+NU6ieiwU+S5dfwWfGmhhCsPS8cqrgQUFs7SNIsc0V8hJOZ8+pdCvWkGh5Ym5vQURls+mw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hijUiNJk6i5pneCufqOrkWeRVsvIHMHiM/NTL4w+c7crNm45
	k64Bv+ubSCKLY2UCJSpFXGLz46YmOc23vrffMFCiR2ajmHxQHtmdPYfZHDpXdIP6ydm+KQ2LC/y
	ywHkFINujCS94On6p32KjFchlAU0=
X-Google-Smtp-Source: AGHT+IF+PZ6Sc/dPixZyy1JWDp50kq/OHT7HLXcUA13lJnelsHoZIUZ2S9NCa6y/9M2NhXv+XVcTtIqT2lLSeM+wrVE=
X-Received: by 2002:a05:6512:308f:b0:52e:9425:3cc8 with SMTP id
 2adb3069b0e04-5367909dc4fmr1135158e87.19.1726155945412; Thu, 12 Sep 2024
 08:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <20240912-sapphire-koala-of-focus-918cff@leitao> <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
 <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
In-Reply-To: <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 17:45:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGqnVSoWUf1u6kx5zDHYhZHk_GjjUuV8TVZhXpgjaJDqg@mail.gmail.com>
Message-ID: <CAMj1kXGqnVSoWUf1u6kx5zDHYhZHk_GjjUuV8TVZhXpgjaJDqg@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 17:35, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 12/09/2024 16:21, Ard Biesheuvel wrote:
> > On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
> >>
> >> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
> >>> On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
> >>>> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> >>>>> I don't see how this could be an EFI bug, given that it does not deal
> >>>>> with E820 tables at all.
> >>>>
> >>>> I want to back up a little bit and make sure I am following the
> >>>> discussion.
> >>>>
> >>>> From what I understand from previous discussion, we have an EFI bug as
> >>>> the root cause of this issue.
> >>>>
> >>>> This happens because the EFI does NOT mark the EFI TPM event log memory
> >>>> region as reserved (EFI_RESERVED_TYPE).
> >>>
> >>> Why do you think EFI should use EFI_RESERVED_TYPE in this case?
> >>>
> >>> The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
> >>> used for anything by EFI itself. It is quite common for EFI
> >>> configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
> >>> EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
> >>>
> >>> Reserved memory is mostly for memory that even the firmware does not
> >>> know what it is for, i.e., particular platform specific uses.
> >>>
> >>> In general, it is up to the OS to ensure that EFI configuration tables
> >>> that it cares about should be reserved in the correct way.
> >>
> >> Thanks for the explanation.
> >>
> >> So, if I understand what you meant here, the TPM event log memory range
> >> shouldn't be listed as a memory region in EFI memory map (as passed by
> >> the firmware to the OS).
> >>
> >> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
> >>
> >> Am I correct with the statements above?
> >>
> >
> > No, not entirely. But I also missed the face that this table is
> > actually created by the EFI stub in Linux, not the firmware. It is
> > *not* the same memory region that the TPM2 ACPI table describes, and
> > so what the various specs say about that is entirely irrelevant.
> >
> > The TPM event log configuration table is created by the EFI stub,
> > which uses the TCG2::GetEventLog () protocol method to obtain it. This
> > must be done by the EFI stub because these protocols will no longer be
> > available once the OS boots. But the data is not used by the EFI stub,
> > only by the OS, which is why it is passed in memory like this.
> >
> > The memory in question is allocated as EFI_LOADER_DATA, and so we are
> > relying on the OS to know that this memory is special, and needs to be
> > preserved.
> >
> > I think the solution here is to use a different memory type:
> >
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
> > efi_physical_addr_t log_loca
> >         }
> >
> >         /* Allocate space for the logs and copy them. */
> > -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> >                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> >
> >         if (status != EFI_SUCCESS) {
> >
> > which will be treated appropriately by the existing EFI-to-E820
> > conversion logic.
>
> I have tested above diff, and it works! No memory corruption.
>
> The region comes up as ACPI data:
> [    0.000000] BIOS-e820: [mem 0x000000007fb6d000-0x000000007fb7efff] ACPI data
>
> and kexec doesnt interfere with it.
>

Thanks, I'll take that as a tested-by

