Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FC3D5890
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 13:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhGZKyy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 06:54:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:56936 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233113AbhGZKyy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Jul 2021 06:54:54 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16QBXFoH004871;
        Mon, 26 Jul 2021 06:33:16 -0500
Message-ID: <1e369a16b4d78b007661753649d6bcf619c8de02.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] efi/libstub: arm64: Force Image reallocation if
 BSS was not reserved
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Date:   Mon, 26 Jul 2021 21:33:15 +1000
In-Reply-To: <20210726100922.120029-2-ardb@kernel.org>
References: <20210726100922.120029-1-ardb@kernel.org>
         <20210726100922.120029-2-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-07-26 at 12:09 +0200, Ard Biesheuvel wrote:
> Distro versions of GRUB replace the usual LoadImage/StartImage calls
> used to load the kernel image with some local code that fails to
> honor the allocation requirements described in the PE/COFF header, as
> it does not account for the image's BSS section at all: it fails to
> allocate space for it, and fails to zero initialize it.
> 
> Since the EFI stub itself is allocated in the .init segment, which is
> in the middle of the image, its BSS section is not impacted by this,
> and the main consequence of this omission is that the BSS section may
> overlap with memory regions that are already used by the firmware.
> 
> So let's warn about this condition, and force image reallocation to
> occur in this case, which works around the problem.

Ah I did miss that... looking at drivers/firmware/efi/libstub/Makefile:

STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \

and arm64's .lds:

	.init.data : {
		INIT_DATA
		INIT_SETUP(16)
		INIT_CALLS
		CON_INITCALL
		INIT_RAM_FS
		*(.init.rodata.* .init.bss)	/* from the EFI stub */
	}

Gosh ... that does indeed save the day in the relocation case. Any
particular reason why we did this though ? This causes the kernel image
to be bigger than it {c,sh}ould ... We already had cases of broken
bootloaders we knew about or just luck ?

Cheers.
Ben.

> Fixes: 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset
> with alignment check")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 49 +++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c
> b/drivers/firmware/efi/libstub/arm64-stub.c
> index 7bf0a7acae5e..3698c1ce2940 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -34,6 +34,51 @@ efi_status_t check_platform_features(void)
>  	return EFI_SUCCESS;
>  }
>  
> +/*
> + * Distro versions of GRUB may ignore the BSS allocation entirely
> (i.e., fail
> + * to provide space, and fail to zero it). Check for this condition
> by double
> + * checking that the first and the last byte of the image are
> covered by the
> + * same EFI memory map entry.
> + */
> +static bool check_image_region(u64 base, u64 size)
> +{
> +	unsigned long map_size, desc_size, buff_size;
> +	efi_memory_desc_t *memory_map;
> +	struct efi_boot_memmap map;
> +	efi_status_t status;
> +	bool ret = false;
> +	int map_offset;
> +
> +	map.map =	&memory_map;
> +	map.map_size =	&map_size;
> +	map.desc_size =	&desc_size;
> +	map.desc_ver =	NULL;
> +	map.key_ptr =	NULL;
> +	map.buff_size =	&buff_size;
> +
> +	status = efi_get_memory_map(&map);
> +	if (status != EFI_SUCCESS)
> +		return false;
> +
> +	for (map_offset = 0; map_offset < map_size; map_offset +=
> desc_size) {
> +		efi_memory_desc_t *md = (void *)memory_map +
> map_offset;
> +		u64 end = md->phys_addr + md->num_pages *
> EFI_PAGE_SIZE;
> +
> +		/*
> +		 * Find the region that covers base, and return whether
> +		 * it covers base+size bytes.
> +		 */
> +		if (base >= md->phys_addr && base < end) {
> +			ret = (base + size) <= end;
> +			break;
> +		}
> +	}
> +
> +	efi_bs_call(free_pool, memory_map);
> +
> +	return ret;
> +}
> +
>  /*
>   * Although relocatable kernels can fix up the misalignment with
> respect to
>   * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly
> out of
> @@ -92,7 +137,9 @@ efi_status_t handle_kernel_image(unsigned long
> *image_addr,
>  	}
>  
>  	if (status != EFI_SUCCESS) {
> -		if (IS_ALIGNED((u64)_text, min_kimg_align())) {
> +		if (!check_image_region((u64)_text, kernel_memsize)) {
> +			efi_err("FIRMWARE BUG: Image BSS overlaps
> adjacent EFI memory region\n");
> +		} else if (IS_ALIGNED((u64)_text, min_kimg_align())) {
>  			/*
>  			 * Just execute from wherever we were loaded by
> the
>  			 * UEFI PE/COFF loader if the alignment is
> suitable.

