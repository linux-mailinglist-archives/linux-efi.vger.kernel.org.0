Return-Path: <linux-efi+bounces-2020-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654129AFB20
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 09:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D0F1C21B60
	for <lists+linux-efi@lfdr.de>; Fri, 25 Oct 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D827C1C07E7;
	Fri, 25 Oct 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNeY1mvy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC319B59F;
	Fri, 25 Oct 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841465; cv=none; b=bRbQPnuS/3gKwwSJJvwFTeHnmazkZrDP5RSeaMTQA7Ar8BJL1IAMOQPBAAnoErD43Wg7dwEjWdkcgXURKOqTcA6J2BtbcZt8av3vMb9F8gsb+/Pt0QDiLrhjG4/ME4uiIbLTWwhMWl4Y6a3POMlpJk5Jx+Mg1XRpSTo9k4KMfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841465; c=relaxed/simple;
	bh=I6C3lzf5t1tuMs2GU6e4c4+bPnAS/CPrRU9TVC+oAuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF9pzjhsIUSuCKjpck9BqB/H93cl7shzO37A2f0m3qeDSLdKp6dKQ8mE1tisVBwTy46Y2KVp3Y+l0cdMuWcAfeXiGhi9t0hJZADBQoIyG1wouB9lOBb6cJzd3RkWdm5kbo136mxFpO8NKOktsm/wjghhhvfxXpfWLUCXQkLNkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNeY1mvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310CEC4AF0B;
	Fri, 25 Oct 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729841465;
	bh=I6C3lzf5t1tuMs2GU6e4c4+bPnAS/CPrRU9TVC+oAuU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uNeY1mvyGaoYmQv0bKXmWcwH0KXLyoCWVrM3XsEbqYdCsCWkFWqr7K2twMdtv8Scc
	 DEJtkXoTRD0RXGPNaaNmsqBW7deyrQiMCAAaMl164lE4TS1A7fNFbUNBhIs5Qpuq9a
	 E+wHqdVbrruHWN4xMLxoeagYVbQe1h3dpok0zQ9HxgJ+XU9yXeR8CGE+k/G8Uv6qNU
	 HQw13+DVg1biADPdWbd0curs/3GBH2yXjPAz8r/suz4XJg9OCpD/jD0+3owsDUmonz
	 vC8bmQdXU4XuRPJbH7eyclRqrsq7rj4vuHSxYLaYjJVyvc89+FGgiR2sBJqJ2UdP99
	 /Ngz5QTSJjx3Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so3181862e87.3;
        Fri, 25 Oct 2024 00:31:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFjhzdSZ+nlKxYuORqyqs6ygE+ZfzzUI0R2nKWqCCLvSjF3wWzXkNxmU0QFhCpoTvYtv7TpNbhHwo=@vger.kernel.org, AJvYcCXd6wvC4K0tq5ubWMY7xR5/atWARUwB5861zL23jszAyFrvN3zkpLno5+Q9zH0zryHPiOWSSfkr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3H7K/DKwJgOR/0Bf5FyJidmZJF0lneqmcvi+jXlfVPDhCiwM3
	QIP/XciV38HJyMxoEBXG0E0sf8MdS2lJsYbu+eueG0U6VRF3+LmzE+LYbZmq3q+tnwxO2NNhlTG
	tq8t1PyEZDQm6LmIMZWQsGAzRLr0=
X-Google-Smtp-Source: AGHT+IGt3ZTJYMxSusAj+Pm9vLCBdgXBSwkrXUPMn49mM0ynXJ9Rf8X/V6qWtqiYxvjPNirJ81R3z4ZkjWvFJMdapdY=
X-Received: by 2002:a05:6512:3d09:b0:536:7377:7d23 with SMTP id
 2adb3069b0e04-53b1a39b073mr9047217e87.40.1729841463346; Fri, 25 Oct 2024
 00:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155159.1951792-2-ardb+git@google.com> <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org> <58da4824-523c-4368-9da1-05984693c811@kernel.org>
In-Reply-To: <58da4824-523c-4368-9da1-05984693c811@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 25 Oct 2024 09:30:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqgZ-fD=oSAr7E0h9kTj_yzDv=_o2ifCCD0cYNgXv9RQ@mail.gmail.com>
Message-ID: <CAMj1kXHqgZ-fD=oSAr7E0h9kTj_yzDv=_o2ifCCD0cYNgXv9RQ@mail.gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 07:09, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 25. 10. 24, 7:07, Jiri Slaby wrote:
> > On 24. 10. 24, 18:20, Jiri Slaby wrote:
> >> On 12. 09. 24, 17:52, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> The TPM event log table is a Linux specific construct, where the data
> >>> produced by the GetEventLog() boot service is cached in memory, and
> >>> passed on to the OS using a EFI configuration table.
> >>>
> >>> The use of EFI_LOADER_DATA here results in the region being left
> >>> unreserved in the E820 memory map constructed by the EFI stub, and this
> >>> is the memory description that is passed on to the incoming kernel by
> >>> kexec, which is therefore unaware that the region should be reserved.
> >>>
> >>> Even though the utility of the TPM2 event log after a kexec is
> >>> questionable, any corruption might send the parsing code off into the
> >>> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
> >>> instead, which is always treated as reserved by the E820 conversion
> >>> logic.
> >>>
> >>> Cc: <stable@vger.kernel.org>
> >>> Reported-by: Breno Leitao <leitao@debian.org>
> >>> Tested-by: Usama Arif <usamaarif642@gmail.com>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>   drivers/firmware/efi/libstub/tpm.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/
> >>> efi/libstub/tpm.c
> >>> index df3182f2e63a..1fd6823248ab 100644
> >>> --- a/drivers/firmware/efi/libstub/tpm.c
> >>> +++ b/drivers/firmware/efi/libstub/tpm.c
> >>> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
> >>> efi_physical_addr_t log_loca
> >>>       }
> >>>       /* Allocate space for the logs and copy them. */
> >>> -    status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> >>> +    status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> >>>                    sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> >>
> >> Hi,
> >>
> >> this, for some reason, corrupts system configuration table. On good
> >> boots, memattr points to 0x77535018, on bad boots (this commit
> >> applied), it points to 0x77526018.
> >>
> >> And the good content at 0x77526018:
> >> tab=0x77526018 size=16+45*48=0x0000000000000880
> >>
> >> bad content at 0x77535018:
> >> tab=0x77535018 size=16+2*1705353216=0x00000000cb4b4010
> >>
> >> This happens only on cold boots. Subsequent boots (having the commit
> >> or not) are all fine.
> >>
> >> Any ideas?
> >
> > ====
> > EFI_ACPI_RECLAIM_MEMORY
> >
> > This memory is to be preserved by the UEFI OS loader and OS until ACPI
> > is enabled. Once ACPI is enabled, the memory in this range is available
> > for general use.
> > ====
> >
> > BTW doesn't the above mean it is released by the time TPM actually reads
> > it?
> >
> > Isn't the proper fix to actually memblock_reserve() that TPM portion.
> > The same as memattr in efi_memattr_init()?
>
> And this is actually done in efi_tpm_eventlog_init().
>

EFI_ACPI_RECLAIM_MEMORY may be reclaimed by the OS, but we never
actually do that in Linux.

To me, it seems like the use of EFI_ACPI_RECLAIM_MEMORY in this case
simply tickles a bug in the firmware that causes it to corrupt the
memory attributes table. The fact that cold boot behaves differently
is a strong indicator here.

I didn't see the results of the memory attribute table dumps on the
bugzilla thread, but dumping this table from EFI is not very useful
because it will get regenerated/updated at ExitBootServices() time.
Unfortunately, that also takes away the console so capturing the state
of that table before the EFI stub boots the kernel is not an easy
thing to do.

Is the memattr table completely corrupted? It also has a version
field, and only versions 1 and 2 are defined so we might use that to
detect corruption.

