Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA024E62A1
	for <lists+linux-efi@lfdr.de>; Thu, 24 Mar 2022 12:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349852AbiCXLrs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Mar 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbiCXLrs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Mar 2022 07:47:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC62A145C
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:46:16 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B10B3F197
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648122374;
        bh=5o2Wrz52BFS+sHKlhOBzNp+TO7Z2H2kPAxclwT0DlNs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nlaokuM5R7KBQ1FrF/S/YHJ1nQ/0JeFUSV3eqcsCUgM6ADYckZYXK2E4j6afPuMOq
         EfCIRHUKXtmKbRmTNOtn7JIXtFL8RmHqaYI/u6fwASvdSULZD+OMNPF4u9/laG8KeP
         jkvHxcm9EkFIB0vb5NaMyvPmLTCdyGeFiMv/vQhlKrWVhSh3KN19tPgFzpJUjXP9TV
         plhGjGuxoitFmGQOwXDulY1v5m1hXZEWJdrwcxMn3LbT5Rzm3Tk4bfxJQfx8slNgEm
         ML+jIZqQlBq8MkL4G4TJ4CNQf1QQuFFgp6ClE22xfaHaqtfJ5c+uDUB2ehDvh7Y+Vs
         KP+0LPo2CNc4g==
Received: by mail-ed1-f69.google.com with SMTP id v15-20020a50f08f000000b0041902200ab4so2847380edl.22
        for <linux-efi@vger.kernel.org>; Thu, 24 Mar 2022 04:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5o2Wrz52BFS+sHKlhOBzNp+TO7Z2H2kPAxclwT0DlNs=;
        b=S5dWiv20muWPdgs7u7v4UsvCITpnme9u8Pam0W7Wm93EvSB+dwfpP5YsMDoin1vqF6
         +ZJJzpnLvTBYN2AnCMLqWXx+kLx9aEj+xt3znKJccHUzehBgDNBcdHtr943wPRRudHBD
         HewlWzYpgKkdHgxnj2jMnnlRX0Y9mli7rmUCi65kRGxI/d4QC2YJeWXMdzvUhyw3vBgY
         OpdSfJKvURc5ST0+9b9ka/mtbsgN5mioJmP7VOSJMKDBwLl7KbvZR2FqqthRXvRGteE5
         YaDQodTRg19mEpIkt+15P29OjKkq1DfNzsp4o+nnHxCMJA372p1IPEL+PEBTP+T9GQjO
         AkDQ==
X-Gm-Message-State: AOAM531U6rXuRMHf5cJs8ehhaebEBMso8fKetRTodUozOjP8LpCLHoY5
        l4EDX7jtYL/NQTMZkBIqZCGTd46BWTNHkEb5AEVaP7LedCM+syaW8XjkuGOdN0ZcsGN15+UyT8R
        g/4zXqsapnx/P5QZ0wmRijgYfghBGPU7YjlXREQ==
X-Received: by 2002:a05:6402:42c6:b0:419:276c:4a64 with SMTP id i6-20020a05640242c600b00419276c4a64mr6192830edc.119.1648122374007;
        Thu, 24 Mar 2022 04:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAJl37gIxQer/kIdtYQq2sgJrHG4K/gYURQV6bVjRyGvag5Ey+tedIIX1T3ZH/Jjoo4nJdPQ==
X-Received: by 2002:a05:6402:42c6:b0:419:276c:4a64 with SMTP id i6-20020a05640242c600b00419276c4a64mr6192805edc.119.1648122373772;
        Thu, 24 Mar 2022 04:46:13 -0700 (PDT)
Received: from [192.168.123.67] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm1350630edk.13.2022.03.24.04.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:46:13 -0700 (PDT)
Message-ID: <14f87d29-ebc9-51a3-020c-353878bcb1ba@canonical.com>
Date:   Thu, 24 Mar 2022 12:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Abner Chang <abner.chang@hpe.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220324112534.209959-1-sunilvl@ventanamicro.com>
 <20220324112534.209959-2-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220324112534.209959-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/24/22 12:25, Sunil V L wrote:
> This patch adds the support for getting the boot hart ID in
> Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
> is preferred method over existing DT based solution since it
> works irrespective of DT or ACPI.
> 
> The specification of the protocol is hosted at:
> https://github.com/riscv-non-isa/riscv-uefi
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

This seems to be v3 of the patch. v2 is available in
https://lore.kernel.org/all/20220303145944.307321-2-sunilvl@ventanamicro.com/

v3 replaces a message in efi_status_t check_platform_features():

<+   efi_err("/chosen/boot-hartid missing or invalid!\n");
 >+   efi_err("Failed to get boot hartid!\n");

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
>   drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
>   include/linux/efi.h                       |  1 +
>   3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index edb77b0621ea..aced62a0907e 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -720,6 +720,13 @@ union efi_tcg2_protocol {
>   	} mixed_mode;
>   };
>   
> +struct riscv_efi_boot_protocol {
> +	u64 revision;
> +
> +	efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
> +						  size_t *boot_hartid);
> +};
> +
>   typedef union efi_load_file_protocol efi_load_file_protocol_t;
>   typedef union efi_load_file_protocol efi_load_file2_protocol_t;
>   
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 9c460843442f..012504f6f9a4 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -23,7 +23,7 @@
>   
>   typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
>   
> -static u32 hartid;
> +static size_t hartid;
>   
>   static int get_boot_hartid_from_fdt(void)
>   {
> @@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
>   	return 0;
>   }
>   
> +static efi_status_t get_boot_hartid_from_efi(void)
> +{
> +	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> +	efi_status_t status;
> +	struct riscv_efi_boot_protocol *boot_protocol;
> +
> +	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> +			     (void **)&boot_protocol);
> +	if (status == EFI_SUCCESS) {
> +		status = efi_call_proto(boot_protocol,
> +					get_boot_hartid, &hartid);
> +	}
> +	return status;
> +}
> +
>   efi_status_t check_platform_features(void)
>   {
>   	int ret;
> +	efi_status_t status;
>   
> -	ret = get_boot_hartid_from_fdt();
> -	if (ret) {
> -		efi_err("/chosen/boot-hartid missing or invalid!\n");
> -		return EFI_UNSUPPORTED;
> +	status = get_boot_hartid_from_efi();
> +	if (status != EFI_SUCCESS) {
> +		ret = get_boot_hartid_from_fdt();
> +		if (ret) {
> +			efi_err("Failed to get boot hartid!\n");
> +			return EFI_UNSUPPORTED;
> +		}
>   	}
>   	return EFI_SUCCESS;
>   }
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index ccd4d3f91c98..9822c730207c 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
>   #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>   #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
>   #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> +#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>   #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
>   #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>   #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)

