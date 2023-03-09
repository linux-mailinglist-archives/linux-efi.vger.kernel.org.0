Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B756B2C89
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCISCT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCISCS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 13:02:18 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0CFCBD9
        for <linux-efi@vger.kernel.org>; Thu,  9 Mar 2023 10:02:16 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id CC61C4077AEC;
        Thu,  9 Mar 2023 18:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CC61C4077AEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678384934;
        bh=nuBgsSLtjPUch6PIcUGmhOZk5Z5IdTQd64eYugbnSZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OxUg+Y9SUWAZ5x6GAzBlpBDScuhgb6t8jm0A7BarycRsTxwOyp40Ktj/ZfqBDP9lf
         fbTWXh3jWf+wSuTWbvA0tyQ24X/hNXA24osrYd/LvQxug4iNPyT/KB9I8IZRqW9LBc
         HniG9yyCQjVA+BObP3DC4rJpy/LSKAVe8HnvYbuc=
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 21:02:14 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [RFC PATCH 4/4] efi: x86: Split PE/COFF .text section into .text
 and .data
In-Reply-To: <20230308202209.2980947-5-ardb@kernel.org>
References: <20230308202209.2980947-1-ardb@kernel.org>
 <20230308202209.2980947-5-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7665e476c2e6ba6f89d85ad87735ff38@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-08 23:22, Ard Biesheuvel wrote:
> Modern PE loader implementations used by EFI will honour the PE section
> permission attributes, and so we can use them to avoid mappings that 
> are
> writable and executable at the same time.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/header.S      | 17 ++++++++++++++++
>  arch/x86/boot/tools/build.c | 21 +++++++++++++++-----
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4f1e1791cda4d316..a8ff8bbb17bca7d7 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -253,6 +253,23 @@ section_table:
>  		IMAGE_SCN_MEM_READ		| \
>  		IMAGE_SCN_MEM_EXECUTE		# Characteristics
> 
> +	.ascii	".data"
> +	.byte	0
> +	.byte	0
> +	.byte	0
> +	.long	0
> +	.long	0x0				# startup_{32,64}
> +	.long	0				# Size of initialized data
> +						# on disk
> +	.long	0x0				# startup_{32,64}
> +	.long	0				# PointerToRelocations
> +	.long	0				# PointerToLineNumbers
> +	.word	0				# NumberOfRelocations
> +	.word	0				# NumberOfLineNumbers
> +	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_WRITE		# Characteristics
> +
>  	.set	section_count, (. - section_table) / 40
>  #endif /* CONFIG_EFI_STUB */
> 
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index 883e6359221cd588..b449c82feaadf2b8 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -119,6 +119,7 @@ static unsigned long efi_boot_params;
>  static unsigned long kernel_info;
>  static unsigned long startup_64;
>  static unsigned long _ehead;
> +static unsigned long _data;
>  static unsigned long _end;
> 
>  
> /*----------------------------------------------------------------------*/
> @@ -347,10 +348,15 @@ static unsigned int
> update_pecoff_sections(unsigned int text_start, unsigned int
>  	init_sz	+= CONFIG_PHYSICAL_ALIGN;
> 
>  	/*
> -	 * Size of code: Subtract the size of the first sector (512 bytes)
> -	 * which includes the header.
> +	 * Size of code: the size of the combined .text/.rodata section, 
> which
> +	 * ends at the _data marker symbol.
>  	 */
> -	put_unaligned_le32(text_sz + bss_sz, &hdr->text_size);
> +	put_unaligned_le32(_data, &hdr->text_size);
> +
> +	/*
> +	 * Size of data: the size of the combined .data/.bss section.
> +	 */
> +	put_unaligned_le32(text_sz - _data + bss_sz, &hdr->data_size);
> 
>  	/* Size of image */
>  	put_unaligned_le32(init_sz, &hdr->image_size);
> @@ -360,9 +366,13 @@ static unsigned int
> update_pecoff_sections(unsigned int text_start, unsigned int
>  	 */
>  	put_unaligned_le32(text_start + efi_pe_entry, &hdr->entry_point);
> 
> -	update_pecoff_section_header_fields(".text", text_start, text_sz + 
> bss_sz,
> -					    text_sz, text_start);
> +	update_pecoff_section_header_fields(".text", text_start, _data,
> +					    _data, text_start);
> 
> +	update_pecoff_section_header_fields(".data", text_start + _data,
> +					    text_sz - _data + bss_sz,
> +					    text_sz - _data,
> +					    text_start + _data);
>  	return text_start + file_sz;
>  }
> 
> @@ -455,6 +465,7 @@ static void parse_zoffset(char *fname)
>  		PARSE_ZOFS(p, kernel_info);
>  		PARSE_ZOFS(p, startup_64);
>  		PARSE_ZOFS(p, _ehead);
> +		PARSE_ZOFS(p, _data);

This also requires _data to be fetched to zoffset.h:

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 8203f1a23f7a..0e5a18c3c165 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE

  SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))

-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] 
\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define 
ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] 
\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|efi_boot_params\|input_data\|kernel_info\|_end\|_ehead\|_text\|_data\|z_.*\)$$/\#define 
ZO_\2 0x\1/p'

  quiet_cmd_zoffset = ZOFFSET $@
        cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@

>  		PARSE_ZOFS(p, _end);
> 
>  		p = strchr(p, '\n');
