Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57558D57E
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiHIIi4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiHIIi4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 04:38:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8284E20F50
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 01:38:54 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 65B4C3F135
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660034332;
        bh=GtQQEgXOZSX7eFCfcrWB3AQl1IMJXTqN8TBy+fNut3k=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IG84rRO6/z3YTtzc1yw/kxHAffi0OoMYPwy/BYUTwz88Kh9hwYSnN+UGKP6btIqgU
         LJUMp2BBJ9ym9QJJWStirNhnoWRT8Xk8g3yqm40kPoaCQz18vWR8zU6lgVrSVjZMIX
         RbAQ+iSAAljjeUfcbj/LJ7HeGK9MWdcwZ+8yB9xlqWZjPqOeq7GNMll0onLfahY3Kx
         E6KQ9R8TvWATc2n0J1I9HAqDgeGkh1YCZDgVvhZdOXkpcJ8yxgJ7ZGu4r8pk3sn1ot
         Eg4gGWWCGehnpMmQ4XCRRvoWmndhb1KH1SN+gUkmcrtZ1U3uf9xMaxpB4g1B8q6q2W
         cLG3ZSNcGYnYA==
Received: by mail-ed1-f71.google.com with SMTP id g8-20020a056402424800b0043e81c582a4so6928305edb.17
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 01:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GtQQEgXOZSX7eFCfcrWB3AQl1IMJXTqN8TBy+fNut3k=;
        b=m6Hy4fWJA2K2xEzno7m/lT9BE62jm5HNfngRDXZLZYEKbAgyuiOFhJXhbGDJiDT8TZ
         07pQTkut2Xvxg+dNMNtNGC3Fk4WIIEObduaJKofHIXnqS6bmqF7Kq0icKzs81tUd68WZ
         NE4KzXw52IOB7JdLk6wURXfw19MtOnBIyU+yw2iCbsfy/1aOBLTYHCjBTKzfoo+1f80v
         dLYilK+djrdmSfRZxsfR1QQtGNgC3U1f976PbIN8YK0vLtdYtiA67v06n5z3jaCLoBfQ
         Z9nITlOTdZd7cGBcNPRsGurFwq/ZKhGmJ+rkoLAysuVTogP/Yf5cOIYa/p/PPU6M56Oe
         p+Rw==
X-Gm-Message-State: ACgBeo25h3ijmHmo2lPa09iSx6NysOOHUC/14MFs4J4d5XNW/+TQdbRC
        TVuZTteRPJ+GlF4NMusD38ffMx9sZoC7B81GcihUZ5plmgTOhel+v/rsxQvOkRa48mqoBtIIHBw
        utGjvlHciBBI0ShDFVixEUD2ucPL7KElJBb7tNA==
X-Received: by 2002:a17:907:7f05:b0:730:e4ad:e5df with SMTP id qf5-20020a1709077f0500b00730e4ade5dfmr14469191ejc.663.1660034332071;
        Tue, 09 Aug 2022 01:38:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR791SVcE/6Y/l3MB/yPFsiKzkSh4uEmCA5Re2ixV9F26a8f5lpw+KzIP0ppgMiKS2qeyafNKw==
X-Received: by 2002:a17:907:7f05:b0:730:e4ad:e5df with SMTP id qf5-20020a1709077f0500b00730e4ade5dfmr14469176ejc.663.1660034331757;
        Tue, 09 Aug 2022 01:38:51 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id o25-20020a509b19000000b0043d8d0ba6a3sm5699450edi.85.2022.08.09.01.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:38:51 -0700 (PDT)
Message-ID: <28a84915-7fa0-7691-08e7-69db792979c7@canonical.com>
Date:   Tue, 9 Aug 2022 10:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 0/6] efi: implement generic compressed boot support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        linux-efi@vger.kernel.org
References: <20220809080944.1119654-1-ardb@kernel.org>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220809080944.1119654-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/9/22 10:09, Ard Biesheuvel wrote:
> Relatively modern architectures such as arm64 or RISC-V don't implement
> a self-decompressing kernel, and leave it up to the bootloader to
> decompress the compressed image before executing it. For bare metal
> boot, this policy makes sense, as a self-decompressing image essentially
> duplicates a lot of fiddly preparation work to create a 1:1 mapping and
> set up the C runtime, and to discover or infer where DRAM lives from
> device trees or other firmware tables.
> 
> For EFI boot, the situation is a bit different: the EFI entrypoint is
> called with a 1:1 cached mapping covering all of DRAM already active,
> and with a stack, a heap, a memory map and boot services to load and
> start images. This means it is rather trivial to implement a
> self-decompressing wrapper for EFI boot in a generic manner, and reuse
> it across architectures that implement EFI boot.
> 
> The only slight downside is that when UEFI secure boot is enabled, the
> generic LoadImage/StartImage only allow signed images to be loaded and
> started, and we prefer to avoid the need to sign both the inner and
> outer PE/COFF images. This series adopts the EFI shim approach, i.e., to
> override an internal UEFI/PI protocol that is used by the image loader,
> to allow the inner image to be booted after decompression. This has been

We should avoid requiring anything that is not in the UEFI 
specification. If you have any additional requirements, please, create a 
change request for the UEFI specification.

Overriding the services of the system table is dangerous and should be 
avoided.

There is no need for two UEFI binaries one inside the other and we 
should avoid such overengineering.

Today we append an uncompressed kernel to the EFI stub. The stub 
relocates it, sets up the memory map and calls it entry point.

Just add decompressor code to the EFI stub and instead of appending an 
uncompressed kernel append a compressed one. Then sign a binary 
consisting of the EFI stub and the compressed kernel.

This way you don't need any change to UEFI firmware at all and you don't 
need to override UEFI services.

Another reasonable approach would be to zip the signed UEFI binary (EFI 
stub with uncompressed kernel) and let the UEFI firmware unzip it and 
check the signature of the decompressed UEFI binary. This would not 
require any patch in Linux at all and would be simple to implement in 
U-Boot.

Best regards

Heinrich

> tested to work with Tianocore based EFI implementations on arm64, but
> u-boot will need some interoperability tweaks as well, ideally just a
> protocol that exposes a LoadImage/StartImage combo that the decompresor
> can use directly to circumvent the signature check. (Note that EFI apps
> have full control over the CPU, page tables, etc. so having code that
> circumvents authentication checks is not as crazy as it sounds, given
> that the app can do anything it pleases already.)
> 
> The code is wired up for arm64 and RISC-V. The latter was build tested
> only.
> 
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Lennart Poettering <lennart@poettering.net>
> 
> Ard Biesheuvel (6):
>    efi: stub: add some missing boot service prototypes
>    efi: stub: split off printk() routines
>    efi: stub: move efi_system_table global var into separate object
>    efi: stub: implement generic EFI zboot
>    arm64: efi: enable generic EFI compressed boot
>    riscv: efi: enable generic EFI compressed boot
> 
>   arch/arm64/Makefile                            |   5 +
>   arch/arm64/boot/Makefile                       |  12 ++
>   arch/riscv/Makefile                            |   5 +
>   arch/riscv/boot/Makefile                       |  14 ++
>   drivers/firmware/efi/Kconfig                   |   9 +
>   drivers/firmware/efi/libstub/Makefile          |   7 +-
>   drivers/firmware/efi/libstub/Makefile.zboot    |  30 +++
>   drivers/firmware/efi/libstub/efi-stub-helper.c | 141 ---------------
>   drivers/firmware/efi/libstub/efi-stub.c        |   2 -
>   drivers/firmware/efi/libstub/efistub.h         |  12 +-
>   drivers/firmware/efi/libstub/printk.c          | 158 ++++++++++++++++
>   drivers/firmware/efi/libstub/systable.c        |   8 +
>   drivers/firmware/efi/libstub/zboot-header.S    | 144 +++++++++++++++
>   drivers/firmware/efi/libstub/zboot.c           | 191 ++++++++++++++++++++
>   drivers/firmware/efi/libstub/zboot.lds         |  41 +++++
>   include/linux/efi.h                            |   2 +
>   16 files changed, 633 insertions(+), 148 deletions(-)
>   create mode 100644 drivers/firmware/efi/libstub/Makefile.zboot
>   create mode 100644 drivers/firmware/efi/libstub/printk.c
>   create mode 100644 drivers/firmware/efi/libstub/systable.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot-header.S
>   create mode 100644 drivers/firmware/efi/libstub/zboot.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot.lds
> 

