Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5461E6A69B0
	for <lists+linux-efi@lfdr.de>; Wed,  1 Mar 2023 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCAJWK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Mar 2023 04:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCAJV4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Mar 2023 04:21:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D08D3028F;
        Wed,  1 Mar 2023 01:21:53 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8DxUOUdGf9j2MQGAA--.7280S3;
        Wed, 01 Mar 2023 17:21:33 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxaL3CGP9jtlJDAA--.53207S3;
        Wed, 01 Mar 2023 17:20:03 +0800 (CST)
Subject: Re: [PATCH] efi/loongarch: Reintroduce efi_relocate_kernel() to
 relocate kernel
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <20230301085545.2373646-1-chenhuacai@loongson.cn>
Cc:     linux-efi@vger.kernel.org, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <aba37b65-6fc4-721e-ebc5-df52533e4791@loongson.cn>
Date:   Wed, 1 Mar 2023 17:20:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230301085545.2373646-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxaL3CGP9jtlJDAA--.53207S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr1rCr17ZF4DXr18Aw15XFb_yoW5JF17p3
        sxAr40yr47Xr4rA3Z7J34UuF98Xws7trWagF9Fyw1ruryav3WDZr1rWrZ7WFWjyFWkK3y5
        XF1IyF12ka1UGw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b2AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc80
        4VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY2
        0_WwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRByIUUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, Huacai

On 03/01/2023 04:55 PM, Huacai Chen wrote:
> Since Linux-6.3, LoongArch supports PIE kernel now, so let's reintroduce
> efi_relocate_kernel() to relocate the core kernel.

If we strongly rely on the PIE feature after the modification, we need
to modify it as follows,

--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -137,6 +137,7 @@ config LOONGARCH
         select PCI_MSI_ARCH_FALLBACKS
         select PCI_QUIRKS
         select PERF_USE_VMALLOC
+       select RELOCATABLE
         select RTC_LIB
         select SMP
         select SPARSE_IRQ

or:

--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -360,6 +360,7 @@ config EFI_STUB
         default y
         depends on EFI
         select EFI_GENERIC_STUB
+       select RELOCATABLE
         help

Youling.

>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/firmware/efi/libstub/loongarch-stub.c | 24 ++++++-------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> index eee7ed43cdfb..72c71ae201f0 100644
> --- a/drivers/firmware/efi/libstub/loongarch-stub.c
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -21,26 +21,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  				 efi_loaded_image_t *image,
>  				 efi_handle_t image_handle)
>  {
> -	int nr_pages = round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
> -	efi_physical_addr_t kernel_addr = EFI_KIMG_PREFERRED_ADDRESS;
>  	efi_status_t status;
> +	unsigned long kernel_addr = 0;
>
> -	/*
> -	 * Allocate space for the kernel image at the preferred offset. This is
> -	 * the only location in memory from where we can execute the image, so
> -	 * no point in falling back to another allocation.
> -	 */
> -	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
> -			     EFI_LOADER_DATA, nr_pages, &kernel_addr);
> -	if (status != EFI_SUCCESS)
> -		return status;
> -
> -	*image_addr = EFI_KIMG_PREFERRED_ADDRESS;
> -	*image_size = kernel_asize;
> +	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> +
> +	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
> +		     EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
>
> -	memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
> -	       (void *)&kernel_offset - kernel_offset,
> -	       kernel_fsize);
> +	*image_addr = kernel_addr;
> +	*image_size = kernel_asize;
>
>  	return status;
>  }
>

