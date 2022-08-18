Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A28598922
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbiHRQmv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbiHRQmu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 12:42:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19991C00D5
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:42:49 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 932D83FB9E
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660840967;
        bh=rR9okm6hCFO94qO66xIhOxckTJyOJWYqgG2P3pNcmQc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eXUa3/R9XcedqOdQqdP3QEhDaUNaS+p7V68hv2fumBNX7ztQ1Qd/HvI9RPWg99Qy7
         DYA/FatWE7e535wTRLXXVqMIVhQjpFHqIxHD5cGNZMQIC8PTIYr87JYDV1e4SQBBN6
         GdTqRzA2CVtkODrfDzBtZTlWHVceXLlU88iL59D4ZjcdNbjvQUGO7qrlMIYZhzGKh6
         2Ej9Um2LXJe0sy4oWQJgNf6QBw8DhZADha6Zs+0H/IHuf4jdS6SlOMTUFtAHADYy5+
         JK5ddCnPxVR+ky7NdSR1/JHgJdGiFu8Wu5x4JbrqkDE0+nvmhcthoXDltOIO5ev1YG
         lcxab1Zek1C0g==
Received: by mail-wm1-f72.google.com with SMTP id ay21-20020a05600c1e1500b003a6271a9718so933214wmb.0
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 09:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rR9okm6hCFO94qO66xIhOxckTJyOJWYqgG2P3pNcmQc=;
        b=rHx5JHhBAddvlCQV3TUyI5GPYCotxe71PujjrmxQUqOQNsXhibxOPZLdZefvnqqYhM
         B9fUvyQsK+3xyOVnj3iP7IzrfP5K4jjsueg/Tb5BUBWnc7u904RL6jgOOQS92f/i8rhN
         zz9bdqhWm3+X1mWbTXWdjbIhm/2HLeE3oU0AWalaHv4tMjs/vXo4iHmW5FwCXKEdMS5p
         +jJn4JddUJQHHiHPBH5NjIKt0zdX73MIDRVKrKJQie76gEC5B18QF0RdaxcI/Dqp0nwB
         Y2SnJykIunzWBsZz82R/b3MACEzyw02GRltV8pTKiWo+hw8JNqRVvMNZaYaNRVTYQSZF
         qd9g==
X-Gm-Message-State: ACgBeo1YYNkoFYvm3ErZ6uRC0ORvMpslRI4/4Z70tTqYdY/xK56QXvzP
        6w3gdbpZSCKq6SaLnIVtp8eOHV32t50lOe45rHI8MZthKLC68wFcmDl/aJJO6MV4BhRo2SoHd1K
        s++Nb5n7/Rx037KW3XQSJmDV9uVXJn1LiqW6GJQ==
X-Received: by 2002:a5d:6712:0:b0:225:337c:3889 with SMTP id o18-20020a5d6712000000b00225337c3889mr826817wru.59.1660840966967;
        Thu, 18 Aug 2022 09:42:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6t36rH+Xq+LVjbGAp4c5JqVYldXde7FfT8Vrqd3IW35axsTNI7kXll01FrFtYBRD4BvUOUyQ==
X-Received: by 2002:a5d:6712:0:b0:225:337c:3889 with SMTP id o18-20020a5d6712000000b00225337c3889mr826801wru.59.1660840966584;
        Thu, 18 Aug 2022 09:42:46 -0700 (PDT)
Received: from [192.168.123.67] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id k5-20020adfd845000000b0022528903834sm1844418wrl.87.2022.08.18.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 09:42:45 -0700 (PDT)
Message-ID: <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com>
Date:   Thu, 18 Aug 2022 18:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-efi@vger.kernel.org
References: <20220817110345.1771267-1-ardb@kernel.org>
 <20220817110345.1771267-5-ardb@kernel.org>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220817110345.1771267-5-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/17/22 13:03, Ard Biesheuvel wrote:
> Implement a minimal EFI app that decompresses the real kernel image and
> launches it using the firmware's LoadImage and StartImage boot services.
> This removes the need for any arch-specific hacks.
> 
> Note that on systems that have UEFI secure boot policies enabled,
> LoadImage/StartImage require images to be signed, or their hashes known
> a priori, in order to be permitted to boot.
> 
> There are various possible strategies to work around this requirement,
> but they all rely either on overriding internal PI/DXE protocols (which
> are not part of the EFI spec) or omitting the firmware provided
> LoadImage() and StartImage() boot services, which is also undesirable,
> given that they encapsulate platform specific policies related to secure
> boot and measured boot, but also related to memory permissions (whether
> or not and which types of heap allocations have both write and execute
> permissions.)
> 
> The only generic and truly portable way around this is to simply sign
> both the inner and the outer image with the same key/cert pair, so this
> is what is implemented here.
> 
> BZIP2 has been omitted from the set of supported compression algorithms,
> given that its performance is mediocre both in speed and size, and it
> uses a disproportionate amount of memory. For optimal compression, use
> LZMA. For the fastest boot speed, use LZO.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   drivers/firmware/efi/Kconfig                |  31 ++++-
>   drivers/firmware/efi/libstub/Makefile       |   8 +-
>   drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
>   drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
>   drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
>   drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
>   6 files changed, 382 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 6cb7384ad2ac..0c7beb8e3633 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -105,9 +105,36 @@ config EFI_RUNTIME_WRAPPERS
>   config EFI_GENERIC_STUB
>   	bool
>   
> +config EFI_ZBOOT
> +	bool "Enable the generic EFI decompressor"
> +	depends on EFI_GENERIC_STUB && !ARM
> +	select HAVE_KERNEL_GZIP
> +	select HAVE_KERNEL_LZ4
> +	select HAVE_KERNEL_LZMA
> +	select HAVE_KERNEL_LZO
> +
> +config EFI_ZBOOT_SIGNED
> +	bool "Sign the EFI decompressor for UEFI secure boot"
> +	depends on EFI_ZBOOT
> +	help
> +	  Use the 'sbsign' command line tool (which must exist on the host
> +	  path) to sign both the EFI decompressor PE/COFF image, as well as the
> +	  encapsulated PE/COFF image, which is subsequently compressed and
> +	  wrapped by the former image.
> +
> +config EFI_ZBOOT_SIGNING_CERT
> +	string "Certificate to use for signing the compressed EFI boot image"
> +	depends on EFI_ZBOOT_SIGNED
> +	default ""
> +
> +config EFI_ZBOOT_SIGNING_KEY
> +	string "Private key to use for signing the compressed EFI boot image"
> +	depends on EFI_ZBOOT_SIGNED
> +	default ""
> +
>   config EFI_ARMSTUB_DTB_LOADER
>   	bool "Enable the DTB loader"
> -	depends on EFI_GENERIC_STUB && !RISCV
> +	depends on EFI_GENERIC_STUB && !RISCV && !EFI_ZBOOT
>   	default y
>   	help
>   	  Select this config option to add support for the dtb= command
> @@ -124,7 +151,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
>   	bool "Enable the command line initrd loader" if !X86
>   	depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
>   	default y if X86
> -	depends on !RISCV
> +	depends on !RISCV && !EFI_ZBOOT
>   	help
>   	  Select this config option to add support for the initrd= command
>   	  line parameter, allowing an initrd that resides on the same volume
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 1406dc78edaa..a3d3d38d5afd 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -73,6 +73,11 @@ lib-$(CONFIG_X86)		+= x86-stub.o
>   lib-$(CONFIG_RISCV)		+= riscv-stub.o
>   CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>   
> +lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o
> +
> +extra-y				:= $(lib-y)
> +lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
> +
>   # Even when -mbranch-protection=none is set, Clang will generate a
>   # .note.gnu.property for code-less object files (like lib/ctype.c),
>   # so work around this by explicitly removing the unwanted section.
> @@ -112,9 +117,6 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
>   # a verification pass to see if any absolute relocations exist in any of the
>   # object files.
>   #
> -extra-y				:= $(lib-y)
> -lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
> -
>   STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
>   				   --prefix-symbols=__efistub_
>   STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
> diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
> new file mode 100644
> index 000000000000..38dee29103ae
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/Makefile.zboot
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# to be include'd by arch/$(ARCH)/boot/Makefile after setting
> +# EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET and EFI_ZBOOT_MACH_TYPE
> +
> +comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
> +comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
> +comp-type-$(CONFIG_KERNEL_LZMA)		:= lzma
> +comp-type-$(CONFIG_KERNEL_LZO)		:= lzo
> +
> +# in GZIP, the appended le32 carrying the uncompressed size is part of the
> +# format, but in other cases, we just append it at the end for convenience,
> +# causing the original tools to complain when checking image integrity.
> +# So disregard it when calculating the payload size in the zimage header.
> +zimage-method-y				:= $(comp-type-y)_with_size
> +zimage-size-len-y			:= 4
> +
> +zimage-method-$(CONFIG_KERNEL_GZIP)	:= gzip
> +zimage-size-len-$(CONFIG_KERNEL_GZIP)	:= 0
> +
> +quiet_cmd_sbsign = SBSIGN  $@
> +      cmd_sbsign = sbsign --out $@ $< \
> +		   --key $(CONFIG_EFI_ZBOOT_SIGNING_KEY) \
> +		   --cert $(CONFIG_EFI_ZBOOT_SIGNING_CERT) \
> +		   2>/dev/null
> +
> +$(obj)/Image.signed: $(EFI_ZBOOT_PAYLOAD) FORCE
> +	$(call if_changed,sbsign)
> +
> +ZBOOT_PAYLOAD-y				 := $(EFI_ZBOOT_PAYLOAD)
> +ZBOOT_PAYLOAD-$(CONFIG_EFI_ZBOOT_SIGNED) := $(obj)/Image.signed
> +
> +$(obj)/zImage: $(ZBOOT_PAYLOAD-y) FORCE
> +	$(call if_changed,$(zimage-method-y))
> +
> +OBJCOPYFLAGS_zImage.o := -I binary -O $(EFI_ZBOOT_BFD_TARGET) \
> +			 --rename-section .data=.gzdata,load,alloc,readonly,contents
> +$(obj)/zImage.o: $(obj)/zImage FORCE
> +	$(call if_changed,objcopy)
> +
> +AFLAGS_zboot-header.o += -DMACHINE_TYPE=IMAGE_FILE_MACHINE_$(EFI_ZBOOT_MACH_TYPE) \
> +			 -DZIMG_EFI_PATH="\"$(realpath $(obj)/zImage.efi.elf)\"" \
> +			 -DZIMG_SIZE_LEN=$(zimage-size-len-y) \
> +			 -DCOMP_TYPE="\"$(comp-type-y)\""
> +
> +$(obj)/zboot-header.o: $(srctree)/drivers/firmware/efi/libstub/zboot-header.S FORCE
> +	$(call if_changed_rule,as_o_S)
> +
> +ZBOOT_DEPS := $(obj)/zboot-header.o $(objtree)/drivers/firmware/efi/libstub/lib.a
> +
> +LDFLAGS_zImage.efi.elf := -T $(srctree)/drivers/firmware/efi/libstub/zboot.lds
> +$(obj)/zImage.efi.elf: $(obj)/zImage.o $(ZBOOT_DEPS) FORCE
> +	$(call if_changed,ld)
> +
> +ZIMAGE_EFI-y				:= zImage.efi
> +ZIMAGE_EFI-$(CONFIG_EFI_ZBOOT_SIGNED)	:= zImage.efi.unsigned
> +
> +OBJCOPYFLAGS_$(ZIMAGE_EFI-y) := -O binary
> +$(obj)/$(ZIMAGE_EFI-y): $(obj)/zImage.efi.elf FORCE
> +	$(call if_changed,objcopy)
> +
> +targets += zboot-header.o zImage zImage.o zImage.efi.elf zImage.efi
> +
> +ifneq ($(CONFIG_EFI_ZBOOT_SIGNED),)
> +$(obj)/zImage.efi: $(obj)/zImage.efi.unsigned FORCE
> +	$(call if_changed,sbsign)
> +
> +targets += Image.signed zImage.efi.unsigned
> +endif
> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> new file mode 100644
> index 000000000000..ee6a3cd69773
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/pe.h>
> +
> +#ifdef CONFIG_64BIT
> +	.set		.Lextra_characteristics, 0x0
> +	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32PLUS
> +#else
> +	.set		.Lextra_characteristics, IMAGE_FILE_32BIT_MACHINE
> +	.set		.Lpe_opt_magic, PE_OPT_MAGIC_PE32
> +#endif
> +
> +	.section	".head", "a"
> +	.globl		__efistub_efi_zboot_header
> +__efistub_efi_zboot_header:
> +.Ldoshdr:
> +	.long		MZ_MAGIC
> +	.ascii		"zimg"					// image type
> +	.long		__efistub__gzdata_start - .Ldoshdr	// payload offset
> +	.long		__efistub__gzdata_size - ZIMG_SIZE_LEN	// payload size
> +	.long		0, 0					// reserved
> +	.asciz		COMP_TYPE				// compression type
> +	.org		.Ldoshdr + 0x3c
> +	.long		.Lpehdr - .Ldoshdr			// PE header offset
> +
> +.Lpehdr:
> +	.long		PE_MAGIC
> +	.short		MACHINE_TYPE
> +	.short		.Lsection_count
> +	.long		0
> +	.long		0
> +	.long		0
> +	.short		.Lsection_table - .Loptional_header
> +	.short		IMAGE_FILE_DEBUG_STRIPPED | \
> +			IMAGE_FILE_EXECUTABLE_IMAGE | \
> +			IMAGE_FILE_LINE_NUMS_STRIPPED |\
> +			.Lextra_characteristics
> +
> +.Loptional_header:
> +	.short		.Lpe_opt_magic
> +	.byte		0, 0
> +	.long		_etext - .Lefi_header_end
> +	.long		__data_size
> +	.long		0
> +	.long		__efistub_efi_zboot_entry - .Ldoshdr
> +	.long		.Lefi_header_end - .Ldoshdr
> +
> +#ifdef CONFIG_64BIT
> +	.quad		0
> +#else
> +	.long		_etext - .Ldoshdr, 0x0
> +#endif
> +	.long		4096
> +	.long		512
> +	.short		0, 0
> +	.short		LINUX_EFISTUB_MAJOR_VERSION	// MajorImageVersion
> +	.short		LINUX_EFISTUB_MINOR_VERSION	// MinorImageVersion
> +	.short		0, 0
> +	.long		0
> +	.long		_end - .Ldoshdr
> +
> +	.long		.Lefi_header_end - .Ldoshdr
> +	.long		0
> +	.short		IMAGE_SUBSYSTEM_EFI_APPLICATION
> +	.short		0
> +	.quad		0, 0, 0, 0
> +	.long		0
> +	.long		(.Lsection_table - .) / 8
> +
> +	.quad		0				// ExportTable
> +	.quad		0				// ImportTable
> +	.quad		0				// ResourceTable
> +	.quad		0				// ExceptionTable
> +	.quad		0				// CertificationTable
> +	.quad		0				// BaseRelocationTable
> +#ifdef CONFIG_DEBUG_EFI
> +	.long		.Lefi_debug_table - .Ldoshdr	// DebugTable
> +	.long		.Lefi_debug_table_size
> +#endif
> +
> +.Lsection_table:
> +	.ascii		".text\0\0\0"
> +	.long		_etext - .Lefi_header_end
> +	.long		.Lefi_header_end - .Ldoshdr
> +	.long		_etext - .Lefi_header_end
> +	.long		.Lefi_header_end - .Ldoshdr
> +
> +	.long		0, 0
> +	.short		0, 0
> +	.long		IMAGE_SCN_CNT_CODE | \
> +			IMAGE_SCN_MEM_READ | \
> +			IMAGE_SCN_MEM_EXECUTE
> +
> +	.ascii		".data\0\0\0"
> +	.long		__data_size
> +	.long		_etext - .Ldoshdr
> +	.long		__data_rawsize
> +	.long		_etext - .Ldoshdr
> +
> +	.long		0, 0
> +	.short		0, 0
> +	.long		IMAGE_SCN_CNT_INITIALIZED_DATA | \
> +			IMAGE_SCN_MEM_READ | \
> +			IMAGE_SCN_MEM_WRITE
> +
> +	.set		.Lsection_count, (. - .Lsection_table) / 40
> +
> +#ifdef CONFIG_DEBUG_EFI
> +	.section	".rodata", "a"
> +	.align		2
> +.Lefi_debug_table:
> +	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
> +	.long		0				// Characteristics
> +	.long		0				// TimeDateStamp
> +	.short		0				// MajorVersion
> +	.short		0				// MinorVersion
> +	.long		IMAGE_DEBUG_TYPE_CODEVIEW	// Type
> +	.long		.Lefi_debug_entry_size		// SizeOfData
> +	.long		0				// RVA
> +	.long		.Lefi_debug_entry - .Ldoshdr	// FileOffset
> +
> +	.set		.Lefi_debug_table_size, . - .Lefi_debug_table
> +	.previous
> +
> +.Lefi_debug_entry:
> +	// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
> +	.ascii		"NB10"				// Signature
> +	.long		0				// Unknown
> +	.long		0				// Unknown2
> +	.long		0				// Unknown3
> +
> +	.asciz		ZIMG_EFI_PATH
> +
> +	.set		.Lefi_debug_entry_size, . - .Lefi_debug_entry
> +#endif
> +
> +	.p2align	12
> +.Lefi_header_end:
> +
> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> new file mode 100644
> index 000000000000..9cf968e90775
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi.h>
> +#include <linux/pe.h>
> +#include <asm/efi.h>
> +
> +#include "efistub.h"
> +
> +static unsigned char zboot_heap[SZ_64K] __aligned(64);
> +static unsigned long free_mem_ptr, free_mem_end_ptr;
> +
> +#define STATIC static
> +#if defined(CONFIG_KERNEL_GZIP)
> +#include "../../../../lib/decompress_inflate.c"
> +#elif defined(CONFIG_KERNEL_LZ4)
> +#include "../../../../lib/decompress_unlz4.c"
> +#elif defined(CONFIG_KERNEL_LZMA)
> +#include "../../../../lib/decompress_unlzma.c"
> +#elif defined(CONFIG_KERNEL_LZO)
> +#include "../../../../lib/decompress_unlzo.c"
> +#endif
> +
> +extern char _gzdata_start[], _gzdata_end[];
> +extern u32 uncompressed_size __aligned(1);
> +
> +static void log(efi_char16_t str[])
> +{
> +	efi_call_proto(efi_table_attr(efi_system_table, con_out),
> +		       output_string, L"EFI decompressor: ");
> +	efi_call_proto(efi_table_attr(efi_system_table, con_out),
> +		       output_string, str);
> +}
> +
> +static void error(char *x)
> +{
> +	log(L"error() called from decompressor library\n");
> +}
> +
> +efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
> +				      efi_system_table_t *systab)
> +{
> +	static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
> +	efi_loaded_image_t *parent, *child;
> +	unsigned long image_buffer;
> +	efi_handle_t child_handle;
> +	efi_status_t status;
> +	int ret;
> +
> +	WRITE_ONCE(efi_system_table, systab);
> +
> +	free_mem_ptr = (unsigned long)&zboot_heap;
> +	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
> +
> +	status = efi_bs_call(handle_protocol, handle, &loaded_image,
> +			     (void **)&parent);
> +	if (status != EFI_SUCCESS) {
> +		log(L"Failed to locate parent's loaded image protocol\n");
> +		return status;
> +	}
> +
> +	status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
> +	if (status != EFI_SUCCESS) {
> +		log(L"Failed to allocate memory\n");
> +		return status;
> +	}
> +
> +	ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
> +			   NULL, (unsigned char *)image_buffer, 0, NULL,
> +			   error);
> +	if (ret	< 0) {
> +		log(L"Decompression failed\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +
> +	status = efi_bs_call(load_image, false, handle, NULL,

I would prefer to pass the device path of the compressed image instead 
of NULL. This way information is not lost.

> +			     (void *)image_buffer, uncompressed_size,
> +			     &child_handle);
> +	if (status != EFI_SUCCESS) {
> +		log(L"Failed to load image\n");
> +		return status;
> +	}
> +
> +	status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
> +			     (void **)&child);
> +	if (status != EFI_SUCCESS) {
> +		log(L"Failed to locate child's loaded image protocol\n");
> +		return status;
> +	}
> +
> +	// Copy the kernel command line
> +	child->load_options = parent->load_options;
> +	child->load_options_size = parent->load_options_size;
> +
> +	status = efi_bs_call(start_image, child_handle, NULL, NULL);
> +	if (status != EFI_SUCCESS) {
> +		log(L"StartImage() returned with error\n");

Please, pass pointers for ExitDataSize and ExitData. If ExitDataSize != 
0 a string is provided in ExitData. Return that data to the caller of 
the compressed image. You may additionally print the string here.

The caller then will then take care of freeing ExitData (via FreePool()) 
and optionally log the information.

Best regards

Heinrich

> +		return status;
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
> new file mode 100644
> index 000000000000..d6ba89a0c294
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/zboot.lds
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +ENTRY(__efistub_efi_zboot_header);
> +
> +SECTIONS
> +{
> +	.text : ALIGN(4096) {
> +		*(.head)
> +		*(.text* .init.text*)
> +	}
> +
> +	.rodata : ALIGN(8) {
> +		__efistub__gzdata_start = .;
> +		*(.gzdata)
> +		__efistub__gzdata_end = .;
> +		*(.rodata* .init.rodata* .srodata*)
> +		_etext = ALIGN(4096);
> +		. = _etext;
> +	}
> +
> +	.data : ALIGN(4096) {
> +		*(.data* .init.data*)
> +		_edata = ALIGN(512);
> +		. = _edata;
> +	}
> +
> +	.bss : {
> +		*(.bss* .init.bss*)
> +		_end = ALIGN(512);
> +		. = _end;
> +	}
> +}
> +
> +PROVIDE(__efistub__gzdata_size = ABSOLUTE(. - __efistub__gzdata_start));
> +
> +PROVIDE(__efistub_uncompressed_size = __efistub__gzdata_end - 4);
> +
> +PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
> +PROVIDE(__data_size = ABSOLUTE(_end - _etext));

