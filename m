Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1C6F261C
	for <lists+linux-efi@lfdr.de>; Sat, 29 Apr 2023 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjD2Tuf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Apr 2023 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Tue (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Apr 2023 15:50:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297C19A5
        for <linux-efi@vger.kernel.org>; Sat, 29 Apr 2023 12:50:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so1011650a12.1
        for <linux-efi@vger.kernel.org>; Sat, 29 Apr 2023 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682797832; x=1685389832;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFul2q32s1U18/F4ScM/1n9uTU+OLaKLdL28ZcuGRps=;
        b=5Eq5l/MGUkXeNeGdzswMuyeVvlCdkjDeGgoRSLhOWbwQD+JxnNTjljM1DWYA2NTcMT
         KWiyM89pPxZu0+qUGyHtcCLIvlJmVFA2NyeV2G6QV0XWEZp2mgIbeYJh7CO616hK/97G
         tIGQRoKti3ltRsdSyT3IfE1gUHmwsQHwvUxXc2meu01kfdqFDUeje5okAw59jq/l+vvW
         kPrq8SlpHveejGZcqQ+I5QeiF3HMbM3RHqvWxEKvppcgtHDt8wz41T3p5CW/sg1KNZTb
         SporKBc8sK6rr8IbHE87Ubw7Hke0GTZpuqfeh0+FUYuWEP0P5FeNlifYxboKBbhGZhQ1
         Ursg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682797832; x=1685389832;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFul2q32s1U18/F4ScM/1n9uTU+OLaKLdL28ZcuGRps=;
        b=hM8yJbRYugoZAT0y/WCIkHvwCKPyhMAtT+Uge/D/FgnwcaPRw2jDTsR+73BMBYHo9t
         I9t2TVvzC0IO5fh+x69WqA6ALXSbhkLu9aEJ2OSoVQ366UsTz1NOz1HIHi3isYvcAMn4
         /J1Ic3VwS6dB+hAkCIV9qr7sDeK1kNENGmRNqA8fFemw14jXS5OkiXLZqePX69Qwtmpe
         zfPmK8WNoUjxUeybztt+P4NBayQfJbav8ixK34VII7KyE6KoMrGEk2s3SvGb0xDE/YVq
         AfX4ku35pWL/7bez/3ZutHW+IjzXWOAqC1s8tBtpQN6oXA/K6J9tE56P98nqr+WiH1Rr
         kopA==
X-Gm-Message-State: AC+VfDzHlaC4rQOaNw1uS6X+d4ccazDWv22EbJKYL352LzUZzeZ02J6p
        DNoj8+8rhBoE250IfOZgKY6zUg==
X-Google-Smtp-Source: ACHHUZ7ZIBrFzHJgGOUjwZ0TbD24DYfHqHIk8pAvpdZsqpijm0eaTX0QhQHdRALa/D33JDxvm3Eb6w==
X-Received: by 2002:a05:6a20:2447:b0:ec:8f81:e9f7 with SMTP id t7-20020a056a20244700b000ec8f81e9f7mr13138849pzc.16.1682797832102;
        Sat, 29 Apr 2023 12:50:32 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d19-20020a63f253000000b00528da88275bsm778344pgk.47.2023.04.29.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 12:50:31 -0700 (PDT)
Date:   Sat, 29 Apr 2023 12:50:31 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 12:50:14 PDT (-0700)
Subject:     Re: [PATCH v2 3/4] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
In-Reply-To: <20230329052926.69632-4-alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-bde481b8-a88c-4ba4-b410-da80d1947bcf@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Mar 2023 22:29:25 PDT (-0700), alexghiti@rivosinc.com wrote:
> This prepares for riscv to use the same functions to handle the pĥysical
> kernel move when KASLR is enabled.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c     | 111 +------------

This LGTM, but I'd prefer at least an Ack from either the Arm or EFI 
folks.  I think that makes it too late for this merge window.

>  .../firmware/efi/libstub/efi-stub-helper.c    | 151 ++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |   8 +
>  3 files changed, 167 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index d4a6b12a8741..b9e0d2cf09aa 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -14,42 +14,6 @@
>
>  #include "efistub.h"
>
> -/*
> - * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
> - * to provide space, and fail to zero it). Check for this condition by double
> - * checking that the first and the last byte of the image are covered by the
> - * same EFI memory map entry.
> - */
> -static bool check_image_region(u64 base, u64 size)
> -{
> -	struct efi_boot_memmap *map;
> -	efi_status_t status;
> -	bool ret = false;
> -	int map_offset;
> -
> -	status = efi_get_memory_map(&map, false);
> -	if (status != EFI_SUCCESS)
> -		return false;
> -
> -	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
> -		efi_memory_desc_t *md = (void *)map->map + map_offset;
> -		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
> -
> -		/*
> -		 * Find the region that covers base, and return whether
> -		 * it covers base+size bytes.
> -		 */
> -		if (base >= md->phys_addr && base < end) {
> -			ret = (base + size) <= end;
> -			break;
> -		}
> -	}
> -
> -	efi_bs_call(free_pool, map);
> -
> -	return ret;
> -}
> -
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
>  				 unsigned long *image_size,
>  				 unsigned long *reserve_addr,
> @@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  {
>  	efi_status_t status;
>  	unsigned long kernel_size, kernel_codesize, kernel_memsize;
> -	u32 phys_seed = 0;
> -	u64 min_kimg_align = efi_get_kimg_min_align();
> -
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> -		efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
> -		void *p;
> -
> -		if (efi_nokaslr) {
> -			efi_info("KASLR disabled on kernel command line\n");
> -		} else if (efi_bs_call(handle_protocol, image_handle,
> -				       &li_fixed_proto, &p) == EFI_SUCCESS) {
> -			efi_info("Image placement fixed by loader\n");
> -		} else {
> -			status = efi_get_random_bytes(sizeof(phys_seed),
> -						      (u8 *)&phys_seed);
> -			if (status == EFI_NOT_FOUND) {
> -				efi_info("EFI_RNG_PROTOCOL unavailable\n");
> -				efi_nokaslr = true;
> -			} else if (status != EFI_SUCCESS) {
> -				efi_err("efi_get_random_bytes() failed (0x%lx)\n",
> -					status);
> -				efi_nokaslr = true;
> -			}
> -		}
> -	}
>
>  	if (image->image_base != _text)
>  		efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value\n");
> @@ -96,49 +35,15 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  	kernel_codesize = __inittext_end - _text;
>  	kernel_memsize = kernel_size + (_end - _edata);
>  	*reserve_size = kernel_memsize;
> +	*image_addr = (unsigned long)_text;
>
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
> -		/*
> -		 * If KASLR is enabled, and we have some randomness available,
> -		 * locate the kernel at a randomized offset in physical memory.
> -		 */
> -		status = efi_random_alloc(*reserve_size, min_kimg_align,
> -					  reserve_addr, phys_seed,
> -					  EFI_LOADER_CODE);
> -		if (status != EFI_SUCCESS)
> -			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
> -	} else {
> -		status = EFI_OUT_OF_RESOURCES;
> -	}
> -
> -	if (status != EFI_SUCCESS) {
> -		if (!check_image_region((u64)_text, kernel_memsize)) {
> -			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
> -		} else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
> -			   (u64)_end < EFI_ALLOC_LIMIT) {
> -			/*
> -			 * Just execute from wherever we were loaded by the
> -			 * UEFI PE/COFF loader if the placement is suitable.
> -			 */
> -			*image_addr = (u64)_text;
> -			*reserve_size = 0;
> -			return EFI_SUCCESS;
> -		}
> -
> -		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> -						    ULONG_MAX, min_kimg_align,
> -						    EFI_LOADER_CODE);
> -
> -		if (status != EFI_SUCCESS) {
> -			efi_err("Failed to relocate kernel\n");
> -			*reserve_size = 0;
> -			return status;
> -		}
> -	}
> -
> -	*image_addr = *reserve_addr;
> -	memcpy((void *)*image_addr, _text, kernel_size);
> -	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
> +	status = efi_kaslr_relocate_kernel(image_addr,
> +					   reserve_addr, reserve_size,
> +					   kernel_size, kernel_codesize,
> +					   kernel_memsize,
> +					   efi_kaslr_get_phys_seed(image_handle));
> +	if (status != EFI_SUCCESS)
> +		return status;
>
>  	return EFI_SUCCESS;
>  }
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 1e0203d74691..40ac2625949c 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -718,3 +718,154 @@ void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>  			efi_warn("Failed to remap data region non-executable\n");
>  	}
>  }
> +
> +/**
> + * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KASLR
> + * @image_handle:	Handle to the image
> + *
> + * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOCOL
> + * that will be used to move the kernel physical mapping.
> + *
> + * Return:	the random seed
> + */
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
> +{
> +	efi_status_t status;
> +	u32 phys_seed;
> +	efi_guid_t li_fixed_proto = LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
> +	void *p;
> +
> +	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +		return 0;
> +
> +	if (efi_nokaslr) {
> +		efi_info("KASLR disabled on kernel command line\n");
> +	} else if (efi_bs_call(handle_protocol, image_handle,
> +			       &li_fixed_proto, &p) == EFI_SUCCESS) {
> +		efi_info("Image placement fixed by loader\n");
> +	} else {
> +		status = efi_get_random_bytes(sizeof(phys_seed),
> +					      (u8 *)&phys_seed);
> +		if (status == EFI_SUCCESS) {
> +			return phys_seed;
> +		} else if (status == EFI_NOT_FOUND) {
> +			efi_info("EFI_RNG_PROTOCOL unavailable\n");
> +			efi_nokaslr = true;
> +		} else if (status != EFI_SUCCESS) {
> +			efi_err("efi_get_random_bytes() failed (0x%lx)\n",
> +				status);
> +			efi_nokaslr = true;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
> + * to provide space, and fail to zero it). Check for this condition by double
> + * checking that the first and the last byte of the image are covered by the
> + * same EFI memory map entry.
> + */
> +static bool check_image_region(u64 base, u64 size)
> +{
> +	struct efi_boot_memmap *map;
> +	efi_status_t status;
> +	bool ret = false;
> +	int map_offset;
> +
> +	status = efi_get_memory_map(&map, false);
> +	if (status != EFI_SUCCESS)
> +		return false;
> +
> +	for (map_offset = 0; map_offset < map->map_size; map_offset += map->desc_size) {
> +		efi_memory_desc_t *md = (void *)map->map + map_offset;
> +		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
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
> +	efi_bs_call(free_pool, map);
> +
> +	return ret;
> +}
> +
> +/**
> + * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR enabled)
> + * @image_addr:	Pointer to the current kernel location
> + * @reserve_addr:	Pointer to the relocated kernel location
> + * @reserve_size:	Size of the relocated kernel
> + * @kernel_size:	Size of the text + data
> + * @kernel_codesize:	Size of the text
> + * @kernel_memsize:	Size of the text + data + bss
> + * @phys_seed:		Random seed used for the relocation
> + *
> + * If KASLR is not enabled, this function relocates the kernel to a fixed
> + * address (or leave it as its current location). If KASLR is enabled, the
> + * kernel physical location is randomized using the seed in parameter.
> + *
> + * Return:	status code, EFI_SUCCESS if relocation is successful
> + */
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +				       unsigned long *reserve_addr,
> +				       unsigned long *reserve_size,
> +				       unsigned long kernel_size,
> +				       unsigned long kernel_codesize,
> +				       unsigned long kernel_memsize,
> +				       u32 phys_seed)
> +{
> +	efi_status_t status;
> +	u64 min_kimg_align = efi_get_kimg_min_align();
> +
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
> +		/*
> +		 * If KASLR is enabled, and we have some randomness available,
> +		 * locate the kernel at a randomized offset in physical memory.
> +		 */
> +		status = efi_random_alloc(*reserve_size, min_kimg_align,
> +					  reserve_addr, phys_seed,
> +					  EFI_LOADER_CODE);
> +		if (status != EFI_SUCCESS)
> +			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
> +	} else {
> +		status = EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	if (status != EFI_SUCCESS) {
> +		if (!check_image_region(*image_addr, kernel_memsize)) {
> +			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
> +		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> +			   (u64)_end < EFI_ALLOC_LIMIT) {
> +			/*
> +			 * Just execute from wherever we were loaded by the
> +			 * UEFI PE/COFF loader if the placement is suitable.
> +			 */
> +			*reserve_size = 0;
> +			return EFI_SUCCESS;
> +		}
> +
> +		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> +						    ULONG_MAX, min_kimg_align,
> +						    EFI_LOADER_CODE);
> +
> +		if (status != EFI_SUCCESS) {
> +			efi_err("Failed to relocate kernel\n");
> +			*reserve_size = 0;
> +			return status;
> +		}
> +	}
> +
> +	memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
> +	*image_addr = *reserve_addr;
> +
> +	caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize);
> +
> +	return status;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 6bd3bb86d967..64273371ce96 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1098,5 +1098,13 @@ const u8 *__efi_get_smbios_string(u8 type, int offset, int recsize);
>
>  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>  		     unsigned long code_size);
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +				       unsigned long *reserve_addr,
> +				       unsigned long *reserve_size,
> +				       unsigned long kernel_size,
> +				       unsigned long kernel_codesize,
> +				       unsigned long kernel_memsize,
> +				       u32 phys_seed);
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
>
>  #endif
