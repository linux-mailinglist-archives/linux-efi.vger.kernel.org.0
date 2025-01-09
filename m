Return-Path: <linux-efi+bounces-2550-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DEA07D24
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B0188A92E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213922257D;
	Thu,  9 Jan 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSzElXff"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B8222576;
	Thu,  9 Jan 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439323; cv=none; b=q9TrjACSGc206SQ19w4OAtp4gGrF6zLD4KggRperjrVYSqSp3JLLe2HyVHnmmRS40lMz5MCWkZRSz/L2PICc6xgGAuQqirY3Ua78+6DriP6O1ffA9ni/QksJ+I/VFWdP1U/I8BUkWR5UXLpml1cIyg+1zIoOaU/j9KjFb7xGYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439323; c=relaxed/simple;
	bh=qCtk5pfLZyjZcPyM6VJTEyV+PYMtmo6DSOVdTmKsAlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7X367GnmjHGaTSbw5CyL3906PBjo6iCbhlmoTrtHlDUZ9wrlTmSWIJ8M8awO1x1JlVd+eYP94HJ29GTBlTrjJk28RpD5BrbF1qtZdOqW7mWAyu6YeB9eKYG4ZlbuTJwalpiCXXLS0Vd8h953Ba68/5d44oDUyviPwVnwKYW4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSzElXff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF861C4CEE9;
	Thu,  9 Jan 2025 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439323;
	bh=qCtk5pfLZyjZcPyM6VJTEyV+PYMtmo6DSOVdTmKsAlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZSzElXffYVnIjM2iuNOv26CfYNPXphh3xbTTCTyq8Hq1W8+OJWqH5BFNO7lhVKWbN
	 Fbdlmvs5FktY2yrKQCCoeXa9BhpUgCS+KIQra4rL5KXzt7wE9O4JHYHT1Jfyjy0dNe
	 KUxzlv1axsP8aWOtxKUsJs3dwifojpe+UFMF0cer3MoJwLDY1cx8QvzdZZCVrxXoKG
	 yLgJcN9kT5Z8kskDBxzhFGCadJKiUY9wnkEy+xIUkoTJE1gYeMN/VYgYKozLdPXcoy
	 uNm9m4/FhnR8rJ1t2TtPkAz6dhbqmvKvKNpVuM0nh2ZRvp+YYHEIp0kofMQhMipXjd
	 NuO/Ctn1PZHSA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54263b52b5aso1208636e87.1;
        Thu, 09 Jan 2025 08:15:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiEZhEAcEVSpvrDLl+EsahZ42o+1KiWVdwYQGj8p+TOTW8tL4RdI/cFCvZUvVp7MG4zGRx6aHSoWTsgBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4jyLfwKvkaU/pNsvVgfLvKtmVVbUnbCxKNsWNvXGJD8R39XW
	vgvj/CjtugWJlOWa4svx3Dinuo5+RzkRMr6biMfOWT731f7GDIS2ry8wH9TO25ClL+mq6IrkkIT
	hnRveqFhmb6xI258FX6NrqC8NqBM=
X-Google-Smtp-Source: AGHT+IEgDc3Ath4/1uyTCs9JWOOHZZDwY9mK/b9amglFhjwS7HHJIIvUsHf0MoF/tIeatS4zttGxIxrfylS/16CHrcE=
X-Received: by 2002:a05:6512:304f:b0:540:2339:3761 with SMTP id
 2adb3069b0e04-542845d61e4mr2632246e87.31.1736439321978; Thu, 09 Jan 2025
 08:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-3-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-3-usamaarif642@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Jan 2025 17:15:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
X-Gm-Features: AbW1kvYuGkq4yLIfsQUdM5PMmU94RQMf4rX_EMMrLutlK12hhu_mxZhaeTrMs-4
Message-ID: <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> When this area is not reserved, it comes up as usable in
> /sys/firmware/memmap. This means that kexec, which uses that memmap
> to find usable memory regions, can select the region where
> efi_mem_attr_table is and overwrite it and relocate_kernel.
>
> Since the patch in [1] was merged, all boots after kexec
> are producing the warning that it introduced.
>
> Having a fix in firmware can be difficult to get through.

I don't follow. I don't think there is anything wrong with the
firmware here. Could you elaborate?


> The next ideal place would be in libstub. However, it looks like
> InstallMemoryAttributesTable [2] is not available as a boot service
> call option [3], [4], and install_configuration_table does not
> seem to work as a valid substitute.
>

To do what, exactly?

> As a last option for a fix, this patch marks that region as reserved in
> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
> use it for kernel segments.
>
> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  arch/x86/include/asm/e820/api.h | 2 ++
>  arch/x86/kernel/e820.c          | 6 ++++++
>  arch/x86/platform/efi/efi.c     | 9 +++++++++
>  drivers/firmware/efi/memattr.c  | 1 +
>  include/linux/efi.h             | 7 +++++++
>  5 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 2e74a7f0e935..4e9aa24f03bd 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> +                                       enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 82b96ed9890a..01d7d3c0d299 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
>         return __e820__range_update(t, start, size, old_type, new_type);
>  }
>
> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> +                                      enum e820_type new_type)
> +{
> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
> +}
> +
>  /* Remove a range of memory from the E820 table: */
>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
>  {
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index a7ff189421c3..13684c5d7c05 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
>         e820__update_table(e820_table);
>  }
>
> +/* Reserve firmware area if it was marked as RAM */
> +void arch_update_firmware_area(u64 addr, u64 size)
> +{
> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +               e820__update_table(e820_table_firmware);
> +       }
> +}
> +
>  /*
>   * Given add_efi_memmap defaults to 0 and there is no alternative
>   * e820 mechanism for soft-reserved memory, import the full EFI memory
> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> index d3bc161361fb..d131781e2d7b 100644
> --- a/drivers/firmware/efi/memattr.c
> +++ b/drivers/firmware/efi/memattr.c
> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
>         size = tbl->num_entries * tbl->desc_size;
>         tbl_size = sizeof(*tbl) + size;
>         memblock_reserve(efi_mem_attr_table, tbl_size);
> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
>         set_bit(EFI_MEM_ATTR, &efi.flags);
>
>  unmap:
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index e5815867aba9..8eb9698bd6a4 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
>  void efivars_generic_ops_register(void);
>  void efivars_generic_ops_unregister(void);
>
> +#ifdef CONFIG_X86_64
> +void __init arch_update_firmware_area(u64 addr, u64 size);
> +#else
> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
> +{
> +}
> +#endif
>  #endif /* _LINUX_EFI_H */
> --
> 2.43.5
>

