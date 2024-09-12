Return-Path: <linux-efi+bounces-1713-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4471B976DA4
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0A1F27964
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB11B982B;
	Thu, 12 Sep 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB4Rzoob"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8A1B5EC6;
	Thu, 12 Sep 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154481; cv=none; b=MmaS1VZFHXhi47Nx+UA9ZrIDlowvpBTkMhVSTmddB2pmxzuGBLZbKtG2Hv3VQgYC3CE0sCZoK2amvBpG7E83vrjtislw7uKJUQOEyOg+gK1ftVZgFqvWCkeEyB+7AXPkh7Gl/+SgtW9cvTZITzidXKtr1WxQUAh79Je3BkBUe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154481; c=relaxed/simple;
	bh=XoAQWmOKdAGe2LxePsrGsTfGlOK7zWHOGSNbSW1eKAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m76p6WEVUJ1HVecawto4gNxIvQEPV7yr02jj+LBntNNCt9KbOP/BpUk52fIcju86WoWI1dZxP+XDp7lA0MMAn/7dyPUjLrtnGmiZL2JwancGQM5fB+P0WTgQyMja8MKqgKgayHG48MPq6+sBgf9LqWqdj1mCtyINZ1FcHEQm1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB4Rzoob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0C6C4CEC5;
	Thu, 12 Sep 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726154480;
	bh=XoAQWmOKdAGe2LxePsrGsTfGlOK7zWHOGSNbSW1eKAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iB4RzoobDJ2QP8gIiVB5vpjnOnZDlVGB7EKeqxbvLAc5+wcnN2Xzaxyg8xeRnHXuS
	 gCgauQvCaV6+IFQ1Yix3jIvb5q0hG6ad/rYoHR6wgqGoKGQAGohn1+HM8RFThsLsfF
	 R9CudEYY7kAfIeH3ce9942Wfh9z7QTurMOkdp6AIu0tIJFZCMtc20i8We2ZEGfaw+u
	 9B01gIQamFsl1sgyiPPwl9CmBpQDlgLRjVDhdFflYplNt7WVR+d7g79dmL75wRqNOH
	 4RvKOTHjg+khA3w+i+2au9mKMywnBQ2rpDck8SM9BtXvDi8L742Owh23Poh3igr4hF
	 Icp2b7RhXFI1w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-535dc4ec181so981246e87.3;
        Thu, 12 Sep 2024 08:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5dLlBWTmZiqhyMms5TVpAg1eDXWbqOMwl43ylRec6Khbx031X3g5zjlASlD8+1psC1z75KDP0tt0=@vger.kernel.org, AJvYcCVPIHl7bANpzbEZLgpTLtHqtsOes1jpGOKeoqP2noOSdmX0jjnJOl6YYE/9k0dKmDBdrdQuww99FmWVmVFB@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZ+PXlNaTfrulgEblwTRB/ZYs6cPKgCkEsdvj7PXc8uVXUkdB
	JrC3e9QqYfpYADKqj47vdSyM3UmkRBn07eT0kMKah3h/DINMX97ISTc1YuZ46n9ZRcAt7GGmGQH
	U249OyrlS5ZAzb1LT1xGnKfIRveg=
X-Google-Smtp-Source: AGHT+IHgOs3mfCFDWSz8kmWB+CF7guYg1lA3puiGFoO0qOIGPDEteJfcHHhRjaQATWNg9FoAOzw2KhmhqqNzjmioQ3k=
X-Received: by 2002:a05:6512:3b0e:b0:536:5551:79ec with SMTP id
 2adb3069b0e04-53678faa022mr2183618e87.4.1726154479251; Thu, 12 Sep 2024
 08:21:19 -0700 (PDT)
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
 <20240912-sapphire-koala-of-focus-918cff@leitao>
In-Reply-To: <20240912-sapphire-koala-of-focus-918cff@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 17:21:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Message-ID: <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
>
> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
> > On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
> > > On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> > > > I don't see how this could be an EFI bug, given that it does not deal
> > > > with E820 tables at all.
> > >
> > > I want to back up a little bit and make sure I am following the
> > > discussion.
> > >
> > > From what I understand from previous discussion, we have an EFI bug as
> > > the root cause of this issue.
> > >
> > > This happens because the EFI does NOT mark the EFI TPM event log memory
> > > region as reserved (EFI_RESERVED_TYPE).
> >
> > Why do you think EFI should use EFI_RESERVED_TYPE in this case?
> >
> > The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
> > used for anything by EFI itself. It is quite common for EFI
> > configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
> > EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
> >
> > Reserved memory is mostly for memory that even the firmware does not
> > know what it is for, i.e., particular platform specific uses.
> >
> > In general, it is up to the OS to ensure that EFI configuration tables
> > that it cares about should be reserved in the correct way.
>
> Thanks for the explanation.
>
> So, if I understand what you meant here, the TPM event log memory range
> shouldn't be listed as a memory region in EFI memory map (as passed by
> the firmware to the OS).
>
> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
>
> Am I correct with the statements above?
>

No, not entirely. But I also missed the face that this table is
actually created by the EFI stub in Linux, not the firmware. It is
*not* the same memory region that the TPM2 ACPI table describes, and
so what the various specs say about that is entirely irrelevant.

The TPM event log configuration table is created by the EFI stub,
which uses the TCG2::GetEventLog () protocol method to obtain it. This
must be done by the EFI stub because these protocols will no longer be
available once the OS boots. But the data is not used by the EFI stub,
only by the OS, which is why it is passed in memory like this.

The memory in question is allocated as EFI_LOADER_DATA, and so we are
relying on the OS to know that this memory is special, and needs to be
preserved.

I think the solution here is to use a different memory type:

--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
efi_physical_addr_t log_loca
        }

        /* Allocate space for the logs and copy them. */
-       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
                             sizeof(*log_tbl) + log_size, (void **)&log_tbl);

        if (status != EFI_SUCCESS) {

which will be treated appropriately by the existing EFI-to-E820
conversion logic.

