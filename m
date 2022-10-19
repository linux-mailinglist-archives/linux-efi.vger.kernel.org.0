Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DD603AC7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJSHkH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJSHkF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:40:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5F2ED55;
        Wed, 19 Oct 2022 00:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CE9B822B2;
        Wed, 19 Oct 2022 07:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6665C43142;
        Wed, 19 Oct 2022 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666165200;
        bh=koGM4QUlX3Z3F/zWfsNG64fnfsI9UI1KqgRPl+otoFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JcMOdtDaKiKogIPq8hLwT5vvpsuTcVSZn7PVoHcIfw7bmygiBco6nOgyi605RV4WK
         y9hPKmEEwF3QpNumKFXieqzajPXmbQK2y9DNORu5KMhxgytZZciNglEKluCEpp60mn
         uN9DjCfE57rqnY8LL0g4WqvSIQROBumI40njZbgYFB5gadDIT1HopoqsNpWJ+WVyEJ
         qEQhGxn/Rc2PcPRCv+IgIbdSZfpr3x3Rly1iRcnbhOBizJ4wDhl/4A7U6IPGGLgoAH
         5GSrui+8gP+TxumYpcwaE3/8WI81vvniKcK8HbMOk27VPueUKfAW9oXeS4u9UNEQvf
         0kQPKm8fyivNA==
Received: by mail-lf1-f53.google.com with SMTP id j4so26759374lfk.0;
        Wed, 19 Oct 2022 00:40:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Yo2q6R5/mQ2Yj2rZ+HgaWC5Vm/JgeHxzcMf2bY5dhQ3hYc8tK
        pXkeWt4G+xtHHHwoHqF0d3m56mDJXHKhx6PXjYk=
X-Google-Smtp-Source: AMsMyM5Ak9lq2iGrA4cmagBm/X5SPnIx1XNlKhbnJWqsSRgdLwcdeBruy1Kafp8DXvT/bJTqNARE5DFVw6U8wKGWlPs=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr2256695lfb.583.1666165198780; Wed, 19
 Oct 2022 00:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662459668.git.baskov@ispras.ru> <c923e39f76baedfdb743ab9c9c6aa638f94f9aff.1662459668.git.baskov@ispras.ru>
In-Reply-To: <c923e39f76baedfdb743ab9c9c6aa638f94f9aff.1662459668.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Oct 2022 09:39:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHVJ35CrT2RePx7njW-iCvqoACwZKM0m7x0mUDe17YUiQ@mail.gmail.com>
Message-ID: <CAMj1kXHVJ35CrT2RePx7njW-iCvqoACwZKM0m7x0mUDe17YUiQ@mail.gmail.com>
Subject: Re: [PATCH 15/16] efi/libstub: Add memory attribute protocol definitions
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 6 Sept 2022 at 12:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
> DXE services for setting memory attributes in EFI Boot Services
> environment. This protocol is better since it is a part of UEFI
> specification itself and not UEFI PI specification like DXE
> services.
>
> Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
> Support mixed mode properly for its calls.
>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/include/asm/efi.h             |  7 +++++++
>  drivers/firmware/efi/libstub/efistub.h | 22 ++++++++++++++++++++++
>  include/linux/efi.h                    |  1 +
>  3 files changed, 30 insertions(+)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 233ae6986d6f..522ff2e443b3 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -325,6 +325,13 @@ static inline u32 efi64_convert_status(efi_status_t status)
>  #define __efi64_argmap_set_memory_space_attributes(phys, size, flags) \
>         (__efi64_split(phys), __efi64_split(size), __efi64_split(flags))
>
> +/* Memory Attribute Protocol */
> +#define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
> +       ((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
> +
> +#define __efi64_argmap_clear_memory_attributes(protocol, phys, size, flags) \
> +       ((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
> +
>  /*
>   * The macros below handle the plumbing for the argument mapping. To add a
>   * mapping for a specific EFI method, simply define a macro
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index cdd1bb50c786..87973f104731 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -39,6 +39,9 @@ extern const efi_system_table_t *efi_system_table;
>  typedef union efi_dxe_services_table efi_dxe_services_table_t;
>  extern const efi_dxe_services_table_t *efi_dxe_table;
>
> +typedef union efi_memory_attribute_protocol efi_memory_attribute_protocol_t;
> +extern efi_memory_attribute_protocol_t *efi_mem_attrib_proto;
> +
>  efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>                                    efi_system_table_t *sys_table_arg);
>
> @@ -403,6 +406,25 @@ union efi_dxe_services_table {
>         } mixed_mode;
>  };
>
> +union  efi_memory_attribute_protocol {
> +       struct {
> +               void *get_memory_attributes;
> +               efi_status_t (__efiapi *set_memory_attributes)(efi_memory_attribute_protocol_t *,
> +                                                               efi_physical_addr_t,
> +                                                               u64,
> +                                                               u64);
> +               efi_status_t (__efiapi *clear_memory_attributes)(efi_memory_attribute_protocol_t *,
> +                                                                 efi_physical_addr_t,
> +                                                                 u64,
> +                                                                 u64);
> +       };
> +       struct {
> +               u32 get_memory_attributes;
> +               u32 set_memory_attributes;
> +               u32 clear_memory_attributes;
> +       } mixed_mode;
> +};
> +
>  typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
>
>  union efi_uga_draw_protocol {
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index d2b84c2fec39..d32368a32285 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -386,6 +386,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_LOAD_FILE2_PROTOCOL_GUID           EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
>  #define EFI_DXE_SERVICES_TABLE_GUID            EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
> +#define EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID     EFI_GUID(0xf4560cf6, 0x40ec, 0x4b4a,  0xa1, 0x92, 0xbf, 0x1d, 0x57, 0xd0, 0xb1, 0x89)
>
>  #define EFI_IMAGE_SECURITY_DATABASE_GUID       EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
>  #define EFI_SHIM_LOCK_GUID                     EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> --
> 2.35.1
>
