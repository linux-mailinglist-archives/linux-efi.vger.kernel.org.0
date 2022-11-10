Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC7624479
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKJOhj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 09:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJOhj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 09:37:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82829178B3
        for <linux-efi@vger.kernel.org>; Thu, 10 Nov 2022 06:37:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CD931FB;
        Thu, 10 Nov 2022 06:37:43 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96FCB3F703;
        Thu, 10 Nov 2022 06:37:36 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:37:33 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: efi: Force the use of SetVirtualAddressMap() on
 Altra machines
Message-ID: <Y20MradQoIhwOAKW@monolith.localdoman>
References: <20221110094951.2963479-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110094951.2963479-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Thu, Nov 10, 2022 at 10:49:51AM +0100, Ard Biesheuvel wrote:
> Ampere Altra machines are reported to misbehave when the SetTime() EFI
> runtime service is called after ExitBootServices() but before calling
> SetVirtualAddressMap(). Given that the latter is horrid, pointless and
> explicitly documented as optional by the EFI spec, we no longer invoke
> it at boot if the configured size of the VA space guarantees that the
> EFI runtime memory regions can remain mapped 1:1 like they are at boot
> time.
> 
> This means that SetTime() calls on Ampere Altra machines issued by the
> rtc-efi driver now trigger a synchronous exception during boot.  We can
> now recover from those without bringing down the system entirely, due to
> commit 23715a26c8d81291 ("arm64: efi: Recover from synchronous
> exceptions occurring in firmware"). However, it would be better to avoid
> this completely, given that the firmware appears to remain in a funny
> state after this.
> 
> So attempt to identify these machines based on the 'family' field in the
> type #1 SMBIOS record, and call SetVirtualAddressMap() unconditionally
> in that case.

This works for my machine. Tested with this patch on top of the patch [1] that
disables only the misbehaving services, not runtime services altogether (can
test other configurations, if you feel it's necessary):

Tested-by: Alexandru Elisei <alexandru.elisei@gmail.com>

[1] https://lore.kernel.org/all/20221108151509.2250968-1-ardb@kernel.org/

Thanks,
Alex

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile     |  2 +-
>  drivers/firmware/efi/libstub/arm64-stub.c | 17 ++++++-
>  drivers/firmware/efi/libstub/efistub.h    | 28 ++++++++++
>  drivers/firmware/efi/libstub/smbios.c     | 62 +++++++++++++++++++++++
>  include/linux/efi.h                       |  1 +
>  5 files changed, 108 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/smbios.c
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index b1601aad7e1a8d66..ef5045a53ce09653 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -82,7 +82,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>  lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o
>  
>  lib-$(CONFIG_ARM)		+= arm32-stub.o
> -lib-$(CONFIG_ARM64)		+= arm64-stub.o
> +lib-$(CONFIG_ARM64)		+= arm64-stub.o smbios.o
>  lib-$(CONFIG_X86)		+= x86-stub.o
>  lib-$(CONFIG_RISCV)		+= riscv-stub.o
>  lib-$(CONFIG_LOONGARCH)		+= loongarch-stub.o
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 259e4b852d63276d..f9de5217ea65ed93 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -15,6 +15,21 @@
>  
>  #include "efistub.h"
>  
> +static bool system_needs_vamap(void)
> +{
> +	const u8 *type1_family = efi_get_smbios_string(1, family);
> +
> +	/*
> +	 * Ampere Altra machines crash in SetTime() if SetVirtualAddressMap()
> +	 * has not been called prior.
> +	 */
> +	if (!type1_family || strcmp(type1_family, "Altra"))
> +		return false;
> +
> +	efi_warn("Working around broken SetVirtualAddressMap()\n");
> +	return true;
> +}
> +
>  efi_status_t check_platform_features(void)
>  {
>  	u64 tg;
> @@ -24,7 +39,7 @@ efi_status_t check_platform_features(void)
>  	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
>  	 * unnecessary.
>  	 */
> -	if (VA_BITS_MIN >= 48)
> +	if (VA_BITS_MIN >= 48 && !system_needs_vamap())
>  		efi_novamap = true;
>  
>  	/* UEFI mandates support for 4 KB granularity, no need to check */
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index a30fb5d8ef05ae9c..eb03d5a9aac88e84 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -975,4 +975,32 @@ efi_enable_reset_attack_mitigation(void) { }
>  
>  void efi_retrieve_tpm2_eventlog(void);
>  
> +struct efi_smbios_record {
> +	u8	type;
> +	u8	length;
> +	u16	handle;
> +};
> +
> +struct efi_smbios_type1_record {
> +	struct efi_smbios_record	header;
> +
> +	u8				manufacturer;
> +	u8				product_name;
> +	u8				version;
> +	u8				serial_number;
> +	efi_guid_t			uuid;
> +	u8				wakeup_type;
> +	u8				sku_number;
> +	u8				family;
> +};
> +
> +#define efi_get_smbios_string(__type, __name) ({			\
> +	int size = sizeof(struct efi_smbios_type ## __type ## _record);	\
> +	int off = offsetof(struct efi_smbios_type ## __type ## _record,	\
> +			   __name);					\
> +	__efi_get_smbios_string(__type, off, size);			\
> +})
> +
> +const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
> +
>  #endif
> diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
> new file mode 100644
> index 0000000000000000..0b7fbd85cc2f6b4b
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/smbios.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2022 Google LLC
> +// Author: Ard Biesheuvel <ardb@google.com>
> +
> +#include <linux/efi.h>
> +
> +#include "efistub.h"
> +
> +typedef union efi_smbios_protocol efi_smbios_protocol_t;
> +
> +union efi_smbios_protocol {
> +	struct {
> +		efi_status_t (__efiapi *add)(efi_smbios_protocol_t *,
> +					     efi_handle_t, u16 *,
> +					     struct efi_smbios_record *);
> +		efi_status_t (__efiapi *update_string)(efi_smbios_protocol_t *,
> +						       u16 *, unsigned long *,
> +						       u8 *);
> +		efi_status_t (__efiapi *remove)(efi_smbios_protocol_t *, u16);
> +		efi_status_t (__efiapi *get_next)(efi_smbios_protocol_t *,
> +						  u16 *, u8 *,
> +						  struct efi_smbios_record **,
> +						  efi_handle_t *);
> +
> +		u8 major_version;
> +		u8 minor_version;
> +	};
> +	struct {
> +		u32 add;
> +		u32 update_string;
> +		u32 remove;
> +		u32 get_next;
> +
> +		u8 major_version;
> +		u8 minor_version;
> +	} mixed_mode;
> +};
> +
> +const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize)
> +{
> +	struct efi_smbios_record *record;
> +	efi_smbios_protocol_t *smbios;
> +	efi_status_t status;
> +	u16 handle = 0xfffe;
> +	const u8 *strtable;
> +
> +	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
> +			     (void **)&smbios) ?:
> +		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
> +	if (status != EFI_SUCCESS)
> +		return NULL;
> +
> +	strtable = (u8 *)record + recsize;
> +	for (int i = 1; i < ((u8 *)record)[offset]; i++) {
> +		int len = strlen(strtable);
> +
> +		if (!len)
> +			return NULL;
> +		strtable += len + 1;
> +	}
> +	return strtable;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 61b252386d61cc4d..cf88dda630649f87 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -389,6 +389,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>  #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
>  #define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
> +#define EFI_SMBIOS_PROTOCOL_GUID		EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
>  
>  #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
>  #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> -- 
> 2.35.1
> 
