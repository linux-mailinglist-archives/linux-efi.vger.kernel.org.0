Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476AF1B302C
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDUTTj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgDUTTi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 15:19:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A3C0610D5
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f20so995632pgl.12
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zV3gw/uKi336nRCyLIo9GVBDExpx/8EbybbTlqONiC8=;
        b=lQTdziWaWdVMMR7+Hgf+u1fu7sE66M6OwtGwtQkmfinY9mlGjvx5AgHISTGKmZEyyE
         +JWjh0H5Cr7W6KNCChqBCCrDA/Paf/KhoaUXuKpdA0R45sIgOj09qiWWTvXpowF8akdb
         IXZ+JZQVbry/QI9l0u1xPTLS+phfl+AOQioKWau0bJfrGMONJK9MtuM32HjAwtIaW+YR
         uG8/8IdXyYCVCfD5BSuoXhgoqytP98crm5MwPYMFkZWhGz29nv5oofRpqARr9SRsUhGh
         2VLb0HYWDOqVETYw9SSKqEu7MmXr2OEJO5M2E3ud77SML2s5I+kK37KeEJVuig4rtGus
         SdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zV3gw/uKi336nRCyLIo9GVBDExpx/8EbybbTlqONiC8=;
        b=DbzoEuUvNzO5A2Hzy6hrltzc17x2+xImrjLgnXtqiUjUoMYtYd82JksLHZCpAV+aHm
         /uxVkObtCVfL5MBL8RgYXR01jXRIVddFm50L/EYa3usKeSyu0XtgzGqu5OHGYm2mEQdY
         Xbz58XFs0+huI+mqWrG9fT0rxh0BOcnU0UVLMEDHZ5BJs+a9wJa1EtgkMwZFntdC3Ul9
         sTSfsWTePN9ZzjDYLdCeQcueBjsRW4lRHCMBn5QNb+e0YG4GmgM9pptlpgDDOzjPQd0Q
         dmdCdu5tF7Gnox8f54cXnjZ0MO3lL+EnAu7oseyc2KsaencTRobhTT+e3yi5T4d4BL2U
         mjOw==
X-Gm-Message-State: AGi0PuZwAQaK+tL627Ekdw6AzwqSFIXi09usgKNjBobBl1hbBdGRZ2c2
        LdZ+68l6Pi1Zhlp3hUfJOM7BUA==
X-Google-Smtp-Source: APiQypJeWmVIOit6du3j3KEdDat9GlbxkfiixP2PltpfTYsCcF/BTSesgtei5NYRwrtfb7Y3piTpkg==
X-Received: by 2002:aa7:9f87:: with SMTP id z7mr3439600pfr.177.1587496777951;
        Tue, 21 Apr 2020 12:19:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h11sm3103183pfn.125.2020.04.21.12.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:19:37 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:19:37 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:16:54 PDT (-0700)
Subject:     Re: [v2 PATCH 1/5] efi: Move arm-stub to a common file
In-Reply-To: <20200413212907.29244-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        mingo@kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, masahiroy@kernel.org,
        linux@armlinux.org.uk
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>, will@kernel.org
Message-ID: <mhng-b521aadc-a209-48d6-886c-957c87f97367@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 14:29:03 PDT (-0700), Atish Patra wrote:
> Most of the arm-stub code is written in an architecture independent manner.
> As a result, RISC-V can reuse most of the arm-stub code.
>
> Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can use it.
> This patch doesn't introduce any functional changes.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

We'll need a bunch of Acked-bys for these, but I'm happy to take this in my
tree.

> ---
>  arch/arm/Kconfig                                     |  2 +-
>  arch/arm64/Kconfig                                   |  2 +-
>  drivers/firmware/efi/Kconfig                         |  4 ++--
>  drivers/firmware/efi/libstub/Makefile                | 12 ++++++------
>  .../firmware/efi/libstub/{arm-stub.c => efi-stub.c}  |  0
>  5 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (100%)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 66a04f6f4775..165987aa5bcd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1954,7 +1954,7 @@ config EFI
>  	select UCS2_STRING
>  	select EFI_PARAMS_FROM_FDT
>  	select EFI_STUB
> -	select EFI_ARMSTUB
> +	select EFI_GENERIC_STUB
>  	select EFI_RUNTIME_WRAPPERS
>  	---help---
>  	  This option provides support for runtime services provided
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 40fb05d96c60..32d818c5ccda 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1785,7 +1785,7 @@ config EFI
>  	select EFI_PARAMS_FROM_FDT
>  	select EFI_RUNTIME_WRAPPERS
>  	select EFI_STUB
> -	select EFI_ARMSTUB
> +	select EFI_GENERIC_STUB
>  	default y
>  	help
>  	  This option provides support for runtime services provided
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 613828d3f106..2a2b2b96a1dc 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -106,12 +106,12 @@ config EFI_PARAMS_FROM_FDT
>  config EFI_RUNTIME_WRAPPERS
>  	bool
>
> -config EFI_ARMSTUB
> +config EFI_GENERIC_STUB
>  	bool
>
>  config EFI_ARMSTUB_DTB_LOADER
>  	bool "Enable the DTB loader"
> -	depends on EFI_ARMSTUB
> +	depends on EFI_GENERIC_STUB
>  	default y
>  	help
>  	  Select this config option to add support for the dtb= command
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 094eabdecfe6..d590504541f6 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -23,7 +23,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
>
> -cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
> +cflags-$(CONFIG_EFI_GENERIC_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
>
>  KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> @@ -45,13 +45,13 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
>  				   skip_spaces.o lib-cmdline.o lib-ctype.o
>
>  # include the stub's generic dependencies from lib/ when building for ARM/arm64
> -arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> +efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
>
>  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
>  	$(call if_changed_rule,cc_o_c)
>
> -lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
> -				   $(patsubst %.c,lib-%.o,$(arm-deps-y))
> +lib-$(CONFIG_EFI_GENERIC_STUB)		+= efi-stub.o fdt.o string.o \
> +				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
>
>  lib-$(CONFIG_ARM)		+= arm32-stub.o
>  lib-$(CONFIG_ARM64)		+= arm64-stub.o
> @@ -73,8 +73,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  # a verification pass to see if any absolute relocations exist in any of the
>  # object files.
>  #
> -extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
> -lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
> +extra-$(CONFIG_EFI_GENERIC_STUB)	:= $(lib-y)
> +lib-$(CONFIG_EFI_GENERIC_STUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
>
>  STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
>  				   --prefix-symbols=__efistub_
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> similarity index 100%
> rename from drivers/firmware/efi/libstub/arm-stub.c
> rename to drivers/firmware/efi/libstub/efi-stub.c

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
