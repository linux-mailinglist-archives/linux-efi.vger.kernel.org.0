Return-Path: <linux-efi+bounces-1185-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03D901CBD
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E20D1C21B98
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CCE61FDD;
	Mon, 10 Jun 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLvBV7No"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECF5B69E;
	Mon, 10 Jun 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007469; cv=none; b=XbWgv3KzmCu1KkWVAf/Lybnd7ienETNfI1h22N0Dba59poll1kYYFLviyu4tmDdDrL8zQoBiPc1Fcg92P8gDOLHbwaIaeJh3vTDCFSm5VPQpiJbLS3RbTZgxlsLz40ZNT+8KbeJkJTH/PtFjwIGnDVauQImWfuWsHBCrCPjjKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007469; c=relaxed/simple;
	bh=cbNYI/JUGMzrLwfYyXouN/cF0pszrXdfoVeq804JEfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPMfo+w+Pf12bzLAMLJsbRZhMoRvHFzVR5jvf1UkWYcnSlXRzgL289mVqvNI6gMMz8rKVpgZKAb26aQTe1UMeWytvnDBG8KnqlbefAWuEKaCmrFk4tVyvtnNT0bs9NuqbLuyOry9VvosKq6u2Oeym87hq3UgzIKFEDCo8Q1QC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLvBV7No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD21DC4AF48;
	Mon, 10 Jun 2024 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718007468;
	bh=cbNYI/JUGMzrLwfYyXouN/cF0pszrXdfoVeq804JEfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vLvBV7No0kB2BepWGhre1nP3OiOMW4b21mhPm8F0xP0Az6MTU1iZy9KteXD6rt4wq
	 3hPV667DqfBpjob+ofl4v27cNX04ZHkJrDJ0/qXcJHkUpYaHn4HA1bRMoVyXIIDTl+
	 eDxEbiyZ9aShZkW0/7UGx0roE010DHfisfOfpQx0nMoNs7AwvL+lrun8mXnfifVPOX
	 0OWG0hftNlVxC79/JFjNK8gH1kQJ++DByn/78VjGYWxWJBxVlDcQ1vb7chms0rvwzj
	 oDQL7RREM+I+MLWdDmrfWbRKQkSG3mpH5Dfh24xasB0CZtRL7OjMqaH8BQ85DTfstr
	 5crc8Xkf5QZ3A==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso14671791fa.0;
        Mon, 10 Jun 2024 01:17:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOJTD0ooCiZrgX81DPnNu8LSkpm9jcqdC7F3veXLVJPhmdEkXTtqX3esJRekKG9BHyS+sGvULLffZ34ENVQSS4h2iUxh7ogwEenRI1
X-Gm-Message-State: AOJu0YxDQFfsGCQbQCTp9XPkk4KZwsC9Zkj7AP0mlWU7Foy9BADtmHBx
	m4C4cTvH6b8fg+Ngj+lWYGRM+nfqweGjLP/0FcbujEzy28+7Yw52aOyS2T3RXpZI1gI2aOAeTHp
	WKZrK5fiRhkkopgWtwtwJk18xtsQ=
X-Google-Smtp-Source: AGHT+IGr2LP3LHmaDB4qM/6C4+LArNs0Zzj0ctXZ5LyiUueT4uMS8/SxcBC+5PescZpGMznq7XkmGuvVFf6JYcOk8t4=
X-Received: by 2002:a2e:8712:0:b0:2eb:e312:5af1 with SMTP id
 38308e7fff4ca-2ebe3125cd4mr20814711fa.22.1718007467129; Mon, 10 Jun 2024
 01:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xm26bk4dlqnp.fsf@bsegall.svl.corp.google.com>
In-Reply-To: <xm26bk4dlqnp.fsf@bsegall.svl.corp.google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Jun 2024 10:17:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGnVu7UxEAzL1g2rJB92fN80qMZ5SjT236R-VKrT3JBqQ@mail.gmail.com>
Message-ID: <CAMj1kXGnVu7UxEAzL1g2rJB92fN80qMZ5SjT236R-VKrT3JBqQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Don't add the EFI stub to targets, again
To: Benjamin Segall <bsegall@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arvind Sankar <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 23:14, Benjamin Segall <bsegall@google.com> wrote:
>
> This is a re-commit of the commit da05b143a308 ("x86/boot: Don't add the
> EFI stub to targets") after the tagged patch incorrectly reverted it.
>
> To summarize: vmlinux-objs-y is added to targets, with an assumption
> that they are all relative to $(obj); adding a $(objtree)/drivers/...
> path causes the build to incorrectly create a useless
> arch/x86/boot/compressed/drivers/... directory tree.
>
> Fix this just by using a different make variable for the EFI stub.
>
> Fixes: cb8bda8ad443 ("x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S")
> Signed-off-by: Ben Segall <bsegall@google.com>

Oops, my bad.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Please add

Cc: <stable@vger.kernel.org> # v6.1+

One nit below.


> ---
>  arch/x86/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 243ee86cb1b1..5245c8fedc17 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -103,13 +103,13 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
>  vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>
>  vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> -vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +efi-obj-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>

I'd prefer to call this vmlinux-libs-y rather than efi-obj-y, because
static libraries and locally built objects are being treated
differently here. The other EFI related objects are added to
vmlinux-objs-y, making it entirely unintuitive why this distinction
exists.



> -$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> +$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
>         $(call if_changed,ld)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
>         $(call if_changed,objcopy)
> --
> 2.45.2.505.gda0bf45e8d-goog
>

