Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013386826A0
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 09:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAaIiI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 03:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAaIiH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 03:38:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771D1816D;
        Tue, 31 Jan 2023 00:38:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62925B81A16;
        Tue, 31 Jan 2023 08:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA42C433A1;
        Tue, 31 Jan 2023 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675154283;
        bh=Z44W+zfjJk+Ef6tLx+XI6YfDYsU0Ot2kOOWNsh91O8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HUP98q+b1Sf78RGW4i2FZWVqgu3iHcLvUxfbYA/jQJMK3oJU4vTdJaxp0QOfSa21W
         N+lBbzx8pM4dMw1QU8JCG3DZ+WPslTD1I6FnSt/LaO5Sqb1ZXlb7pUKk895ogGbA+z
         yl73YqlMzvJwaNwWYoHQTkS5Tf2ywyt54ELcXiS7xGqeqT0o/WqHRFOq/xNwax4r5/
         zI5EFVzRhA6UQcygj3X21owiN5/TxBFC2/9h+wIN2wO5mBhTyB2RALQBx+iVP+xq+9
         DagHGL5AX3RpKmO3t6wM9m5AwnffjRZPOV0byticoq8RHt1Wl75xLaD1jBjD209g7X
         7oHLnmnT8EeJw==
Received: by mail-lf1-f42.google.com with SMTP id y25so23069524lfa.9;
        Tue, 31 Jan 2023 00:38:02 -0800 (PST)
X-Gm-Message-State: AFqh2krODuAbsgqUwK7yuQFKKPXJqaXTdXYSOCAsq+SZGRn9mWHCBehX
        +egiEEVJwBpCV2lWdLH8HgYjGoUsiXYDnyXfs28=
X-Google-Smtp-Source: AMrXdXsSyOVrbv9F80MsXj+CDZPyPDHb7/JAjTSOGgW5RdvOOYoSoHkQ6BxI8njF1bc/I0wn/MF/gY5iR+bjJkyqDdE=
X-Received: by 2002:ac2:44af:0:b0:4b6:e197:3aeb with SMTP id
 c15-20020ac244af000000b004b6e1973aebmr6799097lfm.233.1675154280935; Tue, 31
 Jan 2023 00:38:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668958803.git.baskov@ispras.ru> <44539c8c6afdba66f791942deae95c7b13d1e13b.1668958803.git.baskov@ispras.ru>
In-Reply-To: <44539c8c6afdba66f791942deae95c7b13d1e13b.1668958803.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 09:37:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF5tE+vj_Kf_z=KTqoi12PBq5g5Ds+097w9ge+U4NQong@mail.gmail.com>
Message-ID: <CAMj1kXF5tE+vj_Kf_z=KTqoi12PBq5g5Ds+097w9ge+U4NQong@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] efi/libstub: Add memory attribute protocol definitions
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 22 Nov 2022 at 12:14, Evgeniy Baskov <baskov@ispras.ru> wrote:
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
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

I have fixed up just this patch, as there is another user for the
protocol in zboot.


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
> index c74ac2875e31..343cae662bec 100644
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
> @@ -415,6 +418,25 @@ union efi_dxe_services_table {
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
> index 7603fc58c47c..5f880e8f96bd 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -390,6 +390,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
>  #define EFI_DXE_SERVICES_TABLE_GUID            EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
>  #define EFI_SMBIOS_PROTOCOL_GUID               EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
> +#define EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID     EFI_GUID(0xf4560cf6, 0x40ec, 0x4b4a,  0xa1, 0x92, 0xbf, 0x1d, 0x57, 0xd0, 0xb1, 0x89)
>
>  #define EFI_IMAGE_SECURITY_DATABASE_GUID       EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
>  #define EFI_SHIM_LOCK_GUID                     EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> --
> 2.37.4
>
