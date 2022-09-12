Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748E25B5C29
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 16:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiILO05 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiILO0z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 10:26:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44DF5FF8
        for <linux-efi@vger.kernel.org>; Mon, 12 Sep 2022 07:26:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so11122398wma.2
        for <linux-efi@vger.kernel.org>; Mon, 12 Sep 2022 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=DjcO4dNmye3EVVtObp5mpaYNW3jQcHLdikiqrEza6oI=;
        b=Bb8YGxVQI1UhUglJf3OMoVepgHXPJKYXn7yugzendPbuqgaPRZpLEC5etYsrrgXPm/
         HqefvLGFQb3oQjB+xXhAxWWda94lLN5nsJEMVCnEDXCuU19Z+DqSIDNszw4yUEa04U+7
         C3+sl8ZefhMM+K7OP5iNSzanaFPcUnQVT8BqZFSYqYu11N/StoYksjxIQ1IRzESEYI7H
         4OKS43foYjHffjSSwJ/6HhcuVHglYsebTsZIRNJkoaWgRui5eE8KlnH0d0Lz0J76Q+EJ
         vqmn9kEC8njGGMJaj/fCIMWY7CHfAWJk/9ylUaszdSaCf5nt+Qo31HRnXTWFxXP/3UN3
         fs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DjcO4dNmye3EVVtObp5mpaYNW3jQcHLdikiqrEza6oI=;
        b=jLcXEt9dc2sZvSz23X5lFfTpSoXbVugytRQnQv6IxM8RFXvqcsbiVKEVXLiCJ5y6dT
         I9Pp4RSf55JPR3UKUT/4+VoQ08Yqt4RoGvSe2cXF9DUmvXmKMXxAhoPG3xIkns8j8h19
         bS5qrXFchgEosY8bBwhJIL5NaggTzi0TLn/fagXc+hN0l/AULr5S16Imee6KLqP23qCO
         njv/EEw4NeAqAkUUlxkmf7Gc2cD8/U17MauqxiY0P4YZK0o9gciy1htv2gtnm6RGyE1+
         7F70rDJ60A64kfuWF9uW3bMCJTHVZANo1vXeXy/WTzK1wNd7mZxm6avNsTDNAz11r3yL
         fitQ==
X-Gm-Message-State: ACgBeo3Ij54wXT1FI4iW2Om68ILQDir+3vLaBq4QNqBaLqtDa/0saIVv
        eRQFwB8MUt6DTSm5XQCUfSKGFQm7IDY1lCj+
X-Google-Smtp-Source: AA6agR6qr8XqVKo8qadSOnponLu74R0zIA2Tabgg8WzS/rrHuZrED/Z5KZZiM0OCeSn43z3cU9Yn9A==
X-Received: by 2002:a05:600c:1da0:b0:3b4:91f3:4132 with SMTP id p32-20020a05600c1da000b003b491f34132mr1872622wms.185.1662992811866;
        Mon, 12 Sep 2022 07:26:51 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a5ea1cc63csm11211199wmq.39.2022.09.12.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:26:50 -0700 (PDT)
Date:   Mon, 12 Sep 2022 07:26:50 -0700 (PDT)
X-Google-Original-Date: Mon, 12 Sep 2022 07:26:45 PDT (-0700)
Subject:     Re: [PATCH v2 6/6] riscv: efi: enable generic EFI compressed boot
In-Reply-To: <20220809080944.1119654-7-ardb@kernel.org>
CC:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        James.Bottomley@HansenPartnership.com, mjg59@srcf.ucam.org,
        pjones@redhat.com, ilias.apalodimas@linaro.org,
        heinrich.schuchardt@canonical.com, takahiro.akashi@linaro.org,
        atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>,
        chenhuacai@loongson.cn, lennart@poettering.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ardb@kernel.org
Message-ID: <mhng-e27d053d-86d5-4e15-9131-12102bc33e27@palmer-ri-x1c9>
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

On Tue, 09 Aug 2022 01:09:44 PDT (-0700), ardb@kernel.org wrote:
> Wire up the generic EFI zboot support for RISC-V.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/Makefile      |  5 +++++
>  arch/riscv/boot/Makefile | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 81029d40a672..c30ea65ec877 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -142,6 +142,11 @@ $(BOOT_TARGETS): vmlinux
>  Image.%: Image
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>
> +ifneq ($(CONFIG_EFI_ZBOOT),)
> +zImage.efi: Image
> +	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> +endif
> +
>  install: KBUILD_IMAGE := $(boot)/Image
>  zinstall: KBUILD_IMAGE := $(boot)/Image.gz
>  install zinstall:
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index becd0621071c..60cd319685ea 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -58,3 +58,17 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>
>  $(obj)/loader.bin: $(obj)/loader FORCE
>  	$(call if_changed,objcopy)
> +
> +ZBOOT_PAYLOAD		:= $(obj)/Image
> +ZBOOT_BFD_TARGET	:= elf$(BITS)-littleriscv
> +ZBOOT_LD_FLAGS		:= --defsym=__efistub_strnlen=strnlen \
> +			   --defsym=__efistub_memmove=memmove \
> +			   --defsym=__efistub_memcpy=memcpy \
> +			   --defsym=__efistub_memset=memset
> +
> +ZBOOT_EXTRA_OBJS	:= memcpy.o memset.o memmove.o
> +ZBOOT_EXTRA_DEPS	:= $(objtree)/lib/string.o \
> +			   $(objtree)/lib/ctype.o \
> +			   $(addprefix $(objtree)/arch/riscv/lib/,$(ZBOOT_EXTRA_OBJS))
> +
> +include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
