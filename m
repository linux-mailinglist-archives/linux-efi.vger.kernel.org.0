Return-Path: <linux-efi+bounces-2201-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC39D8B47
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A197B28CC1
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EA1B415F;
	Mon, 25 Nov 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLUtf7mq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C4192D6C;
	Mon, 25 Nov 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555511; cv=none; b=ZZGoi77fOrEdoV5Gw+KXag0DSio+KhDZnpv0Cs7e2BuNOK5+QibKrsAz1tQoig5VQM0eSAOItoh/uX8RsoU5ZgGyhnlcrzc41pZbOHgYxD/Igyp0tDT3n2m286f4yDjV2vzIZ7TXw2Bo1e6rlZLoZM1sGG8IywYHegay0Y8zkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555511; c=relaxed/simple;
	bh=k++Q5AiJfKWV3B5XEpjnJiw/wCMyTABKIynpHC8/ZOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APUyz9pL7F54Ri9SqpWe1moo0FjXJburM3eVfMSwY2mDwphsn05kGeKfXE1I1Ctv9yQLsTllagMwR59NC4SfG+ADFxX9UGunu/Km6+5jm09KRpxpVKM/nJz7ONWmo1u1km4fN3zWi9NatWx1Aacl2NUvRUshtFOBDi8ci5QHwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLUtf7mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD41C4CED7;
	Mon, 25 Nov 2024 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732555510;
	bh=k++Q5AiJfKWV3B5XEpjnJiw/wCMyTABKIynpHC8/ZOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aLUtf7mqKqoZu345LXzaQpXqs1FYtALOVG1+IY544q6guYF1w8oh8ixjuTMoFlTVf
	 GCmtJTnBtSzNcpwhu2YpDEy7WQsTZhs7h21G9vxOn3RC1ZyDLpYAibiP8bBi3fC/+/
	 iBMkD2fMnOO1m0LiIU6GVCtsVtFMYQUQ3WfnX+onZQLySxs5sxz4IsaJXtXtoSrbvB
	 6OKQgZhJMS7gJhqHK2VpNvAfasFhCeKPUhyzOUsF2SmV0OmXp6n6O2Ctc5Xaydyj7Y
	 tKvnREvIarB81cqPJM+FNp+F4tslUJcTgtIsbGwXDiOtMDU4OgrWJIK5jcvyYeLOfu
	 /cKGsaP1tvFbw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffba235991so15321331fa.0;
        Mon, 25 Nov 2024 09:25:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXP3RB2WijI1kFuyotIVIpqgUctJcwUcvNKLigINzr/lkC6dKti00RXW8P2WMuCGCE+kxT3wiZwb/s=@vger.kernel.org, AJvYcCXuYPHzcBuC5OsiaUg3uYelIEE9Nr3c2C4nIMtPyjfC6sJ1Wdt9lCxYSuWJhT79Qd7MKjgfGA01xKMQi+nL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4saDnACDlYa+1/pQgfU//dTsSlS7m8CswsWMV4xdnO2K9VPSw
	sF2siKFuOLWkwwVQJgI7eg/2msX6hpqjE8h5bs27VSyd07Rts09vAAVHbx6/aCBHTa0yMp4vSgQ
	17wuDwiPpRkN04mkegg9ilxTlh48=
X-Google-Smtp-Source: AGHT+IHzV1ladglErctQdKdglEcprMGEHo+6nkDCkPJtDLxCJieoLazlhNtDyqoHbD8whZunRWVLLv/o+th6Qn+fO80=
X-Received: by 2002:a05:6512:1393:b0:539:93e8:7ed8 with SMTP id
 2adb3069b0e04-53de881abc4mr80069e87.15.1732555508706; Mon, 25 Nov 2024
 09:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125170758.518943-1-yeoreum.yun@arm.com> <20241125170758.518943-3-yeoreum.yun@arm.com>
In-Reply-To: <20241125170758.518943-3-yeoreum.yun@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Nov 2024 18:24:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
Message-ID: <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with force
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, hagarhem@amazon.com, catalin.marinas@arm.com, 
	will@kernel.org, guohanjun@huawei.com, Jonathan.Cameron@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 18:08, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> Since acpi=force doesn't use dt fallback, it's meaningless to load dt
> from comaand line option or from configuration table.
> Skip loading dt when acpi=force option is used.
> otherwise it could produce unnecessary error message
> while scanning dt if passed dt's format is invalid.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

I take it this is working around buggy firmware that passes both a DT
and ACPI tables, and the DT in question is broken?

If so, this should be fixed in the firmware. The EFI stub does not
reason at all about ACPI boot vs DT boot, and I would prefer to keep
it that way, especially because this code is shared with other
architectures. For instance, the meaning of acpi= could differ between
architectures, or they may not implement ACPI in the first place.

If not, I don't think there is anything to solve here. Those error
messages are not fatal, right? Note that older GRUB builds might use
the DT to pass initrd information even when booting via ACPI.



> ---
>  drivers/firmware/efi/libstub/fdt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 6a337f1f8787..27291ef7c773 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -231,6 +231,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>         struct exit_boot_struct priv;
>         unsigned long fdt_addr = 0;
>         unsigned long fdt_size = 0;
> +       bool acpi_force = false;
> +
>
>         if (!efi_novamap) {
>                 status = efi_alloc_virtmap(&priv.runtime_map, &desc_size,
> @@ -241,13 +243,17 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                 }
>         }
>
> +       if (strstr(cmdline_ptr, "acpi=force"))
> +               acpi_force = true;
> +
>         /*
>          * Unauthenticated device tree data is a security hazard, so ignore
>          * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
>          * boot is enabled if we can't determine its state.
>          */
>         if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
> -           efi_get_secureboot() != efi_secureboot_mode_disabled) {
> +           efi_get_secureboot() != efi_secureboot_mode_disabled ||
> +                       acpi_force) {
>                 if (strstr(cmdline_ptr, "dtb="))
>                         efi_err("Ignoring DTB from command line.\n");
>         } else {
> @@ -261,7 +267,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>
>         if (fdt_addr) {
>                 efi_info("Using DTB from command line\n");
> -       } else {
> +       } else if (!acpi_force) {
>                 /* Look for a device tree configuration table entry. */
>                 fdt_addr = (uintptr_t)get_fdt(&fdt_size);
>                 if (fdt_addr)
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

