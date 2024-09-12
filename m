Return-Path: <linux-efi+bounces-1708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1301976A15
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E39284D7B
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573B1AB6E2;
	Thu, 12 Sep 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1wmVC6j"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A71AAE07;
	Thu, 12 Sep 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146656; cv=none; b=efXaI2jddITFzYINvU7794dxEUp/iih0lbwEQUKuhdLd9IZTU5GwTJFsnNbXKE8+pZNGpC09BHCP2DsqjmyQ+J2rAJFR3Vt98+ZSFoGbHyxyTuZ8Wm3vo2tKtKVBwfHFnOo/dK4K1Ro252H4BeQ2QpgXB9RCVr7kKYBftYTz4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146656; c=relaxed/simple;
	bh=pVjkE8pzjkEOi/MpgQecc17AU7Z6dbtmsPZ9CjjhpkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVH5LrYhJeFNxVBR93v67M6eAD7cPvArgFL89TzUeAFkRgk3j5GlgbZ4RGGRJaGIMlBG/aaSRk14Crs2XrFoN6BliWuB8p1CquUrkvRrbGiRhSpYK1rDm84PCgPRq38YfZHQIfThFfWMSZbWalZhcZpzRIuJdI8SUT8RUYrm/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1wmVC6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2459BC4CEC3;
	Thu, 12 Sep 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146656;
	bh=pVjkE8pzjkEOi/MpgQecc17AU7Z6dbtmsPZ9CjjhpkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1wmVC6jMy5HidYKYX6gkDHOqJ04g/LVF2H3SLEIhiACcIpUo02s8Stx5av0ebRH4
	 P4pQagK4Wgu0ayR5fZVPd++gajPVzEJGk3B0ATpPmcFqbtQgnQX/XAu3F3qngJFxXI
	 fY0bxlmW5M3oClhrQ+3Z1r24YK6gbifjo34TvnzA48MeEQguQFbQwYXmzsOGbVnEtJ
	 ZjkIVO2vILSt/C6yndXP47Zy22Cj3z1ZaOw+IutJf7mkydD8VEz3LEWoRLCgOSNWfy
	 waCP9EjTTltyLSIF9clSJKt9BvvWKuS6vqHbNyV/O1YfyS98ls+vAVtu0z1yPgILfD
	 TS17Px8oFJ4IA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f74b6e1810so8656011fa.2;
        Thu, 12 Sep 2024 06:10:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVikOBwkAQHQBmDN9YOqvN7KhbdvuQwSahF8GASIYj80cw7B8zsT4Ize67Bezk3wzCwV3PTaEeq0dw=@vger.kernel.org, AJvYcCVmNTJNRksu+P921d+w1Wgu1ZRKPSlz0nthSmtqQopccU4NM5GTPLEo+LjSXOdvbou75T8Tw1JajESvE4HJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUyyN2cq6DygkBTbnvbo8gahfA92vb63hhmpQQcqZtpxUulEJ
	8q2yn68uoY3cq9ICyiUBTRYY88AvRGN4UYnbEyX9dw9i2ltCpNldWustUYziQMUQfqEUpd0Xn/V
	ecJvLjCsn5BqC62xAZJwaoxv1zqk=
X-Google-Smtp-Source: AGHT+IGjrOuPsLEXIxWof6GVdoN8GI0LIbmwDbSCBJpeeh/ccOJ3roKoI1IcDk5B73JTTHAPFOWlD8x3NCpNNbmbuWw=
X-Received: by 2002:a2e:bc1d:0:b0:2f7:708f:d1c3 with SMTP id
 38308e7fff4ca-2f787ddf3b1mr17068111fa.21.1726146654494; Thu, 12 Sep 2024
 06:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
In-Reply-To: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 15:10:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Message-ID: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > I don't see how this could be an EFI bug, given that it does not deal
> > with E820 tables at all.
>
> I want to back up a little bit and make sure I am following the
> discussion.
>
> From what I understand from previous discussion, we have an EFI bug as
> the root cause of this issue.
>
> This happens because the EFI does NOT mark the EFI TPM event log memory
> region as reserved (EFI_RESERVED_TYPE).

Why do you think EFI should use EFI_RESERVED_TYPE in this case?

The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
used for anything by EFI itself. It is quite common for EFI
configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).

Reserved memory is mostly for memory that even the firmware does not
know what it is for, i.e., particular platform specific uses.

In general, it is up to the OS to ensure that EFI configuration tables
that it cares about should be reserved in the correct way.

> Not having an entry for the
> event table memory in EFI memory mapped, then libstub will ignore it
> completely (the TPM event log memory range) and not populate e820 table
> with it.
>
> Once the e820 table does not have the memory range for TPM event log,
> then the kernel is free to overwrite that memory region, causing
> corruptions all across the board.
>

We shouldn't be relying on the E820 table for this.

> From what I understand from the thread discussion, there are three ways
> to "solve" it:
>
> 1) Fix the EFI to pass the TPM event log memory as reserved.
>
> 2) Workaround it in libstub, and considering the TPM event log memory
> range when populating the e820 table. (As proposed in
> https://lore.kernel.org/all/2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com/)
>
> 3) Workaround in later in the kernel, as proposed in
> https://lore.kernel.org/all/20240911104109.1831501-1-usamaarif642@gmail.com/
>

Does the below help at all?

--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
        }

        tbl_size = sizeof(*log_tbl) + log_tbl->size;
-       memblock_reserve(efi.tpm_log, tbl_size);
+       efi_mem_reserve(efi.tpm_log, tbl_size);

        if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
                pr_info("TPM Final Events table not present\n");

