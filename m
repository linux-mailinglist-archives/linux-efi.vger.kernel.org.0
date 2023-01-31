Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1F5682681
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 09:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAaIe1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 03:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAaIdt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 03:33:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BF46D50;
        Tue, 31 Jan 2023 00:33:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5006144E;
        Tue, 31 Jan 2023 08:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCDDC433EF;
        Tue, 31 Jan 2023 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675154016;
        bh=Pujbv6gOrxHZ5rL+jGTrkcPRCLivAzdLrLQmZz1ZCd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r59Woo7WSozh7WaZU0g3FG8xtU9m0p+s1t5AFzlvF2+tlyYKhnI8T4iS0UMPH1FDu
         WrgqrPONiNPAh7BU4P29kINz5xV1a5UEaOqANa+5kr4dvjPbne97oJN8PFhZpWYwnK
         FDZBLDDVoGLURGTeu0XLUZUxkoKwSOLYQwgSuryVTSCEeTVfde14jJgSaGvCbzwgtz
         upXl1D5uXtgeU91bWGzLkbdOUindsZshJsT0XsXPd6wscQMQMUlhnSkkP6oR5v65Lp
         CDgHFZJTHxMuEbog8lKcKLscBqmonNhX0TmM7xWytNqHCdWMEBBiE9iqXx/z8pb1Yw
         hP/ocDTcum2zw==
Received: by mail-lj1-f170.google.com with SMTP id h17so15201004ljq.4;
        Tue, 31 Jan 2023 00:33:36 -0800 (PST)
X-Gm-Message-State: AO0yUKWTkAJFoF5oUsJQlX//hV2SFbXS+u99lD045WJ5hQfauFzTJjsr
        +22KVMpL67wMyGjiCwmEDyvo9wRwz0JgIF3e0nA=
X-Google-Smtp-Source: AK7set87raWj6liMl/2WMk45Ok2UbUGwjuNPa/5lqOfx1hsj5n2wrQgh06mKFCbVyX6LXwInHF+pAD3AVzHXTkb3HrE=
X-Received: by 2002:a2e:b00c:0:b0:290:5011:2332 with SMTP id
 y12-20020a2eb00c000000b0029050112332mr1297705ljk.120.1675154014748; Tue, 31
 Jan 2023 00:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20230131004928.153623-1-dionnaglaze@google.com>
In-Reply-To: <20230131004928.153623-1-dionnaglaze@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 09:33:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG9ONi4_AD1G0Py_qrLLzRfSXGCTEOeu2xowViO0mJkuA@mail.gmail.com>
Message-ID: <CAMj1kXG9ONi4_AD1G0Py_qrLLzRfSXGCTEOeu2xowViO0mJkuA@mail.gmail.com>
Subject: Re: [PATCH v2, RESEND] x86/efi: Safely enable unaccepted memory in UEFI
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux-efi@vger.kernel.org, "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Jan 2023 at 01:49, Dionna Glaze <dionnaglaze@google.com> wrote:
>
> This patch depends on Kirill A. Shutemov's series
>
> [PATCHv8 00/14] mm, x86/cc: Implement support for unaccepted memory
>
> The UEFI v2.9 specification includes a new memory type to be used in
> environments where the OS must accept memory that is provided from its
> host. Before the introduction of this memory type, all memory was
> accepted eagerly in the firmware. In order for the firmware to safely
> stop accepting memory on the OS's behalf, the OS must affirmatively
> indicate support to the firmware. This is only a problem for AMD
> SEV-SNP, since Linux has had support for it since 5.19. The other
> technology that can make use of unaccepted memory, Intel TDX, does not
> yet have Linux support, so it can strictly require unaccepted memory
> support as a dependency of CONFIG_TDX and not require communication with
> the firmware.
>
> Enabling unaccepted memory requires calling a 0-argument enablement
> protocol before ExitBootServices. This call is only made if the kernel
> is compiled with UNACCEPTED_MEMORY=y
>
> This protocol will be removed after the end of life of the first LTS
> that includes it, in order to give firmware implementations an
> expiration date for it. When the protocol is removed, firmware will
> strictly infer that a SEV-SNP VM is running an OS that supports the
> unaccepted memory type. At the earliest convenience, when unaccepted
> memory support is added to Linux, SEV-SNP may take strict dependence in
> it. After the firmware removes support for the protocol, this patch
> should be reverted.
>
> Change since v1:
> * protocol name, as it is in OVMF
> https://github.com/tianocore/edk2/commit/26847fb6be7fff83a834a3154224588afede0073
> * protocol typedef moved before struct definition.
>
> Cc: Ard Biescheuvel <ardb@kernel.org>
> Cc: "Min M. Xu" <min.m.xu@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Jiewen Yao <jiewen.yao@intel.com>
> Cc: Erdem Aktas <erdemaktas@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 37 +++++++++++++++++++++++++
>  include/linux/efi.h                     |  4 +++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba..e4c04444edab 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
>  static efi_loaded_image_t *image = NULL;
>
> +typedef union sev_memory_acceptance_protocol sev_memory_acceptance_protocol_t;
> +union sev_memory_acceptance_protocol {
> +       struct {
> +               efi_status_t (__efiapi *allow_unaccepted_memory)(
> +                       sev_memory_acceptance_protocol_t *);
> +       };
> +       struct {
> +               u32 allow_unaccepted_memory;
> +       } mixed_mode;
> +};
> +
>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  {
> @@ -310,6 +321,30 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
>  #endif
>  }
>
> +
> +static void setup_unaccepted_memory(void)
> +{
> +       efi_guid_t mem_acceptance_proto = OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
> +       sev_memory_acceptance_protocol_t *proto;
> +       efi_status_t status;
> +
> +       if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))

Do we need to check for IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) here as well?

> +               return;
> +
> +       /*
> +        * Enable unaccepted memory before calling exit boot services in order
> +        * for the UEFI to not accept all memory on EBS.
> +        */
> +       status = efi_bs_call(locate_protocol, &mem_acceptance_proto, NULL,
> +                            (void **)&proto);
> +       if (status != EFI_SUCCESS)
> +               return;
> +
> +       status = efi_call_proto(proto, allow_unaccepted_memory);
> +       if (status != EFI_SUCCESS)
> +               efi_err("Memory acceptance protocol failed\n");
> +}
> +
>  static const efi_char16_t apple[] = L"Apple";
>
>  static void setup_quirks(struct boot_params *boot_params,
> @@ -899,6 +934,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>
>         setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
>
> +       setup_unaccepted_memory();
> +
>         status = exit_boot(boot_params, handle);
>         if (status != EFI_SUCCESS) {
>                 efi_err("exit_boot() failed!\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4b27519143f5..ac812978a03a 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -434,6 +434,10 @@ void efi_native_runtime_setup(void);
>  #define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
>  #define AMD_SEV_MEM_ENCRYPT_GUID               EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
>
> +/* OVMF protocol GUIDs */
> +#define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID       EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
> +
> +
>  typedef struct {
>         efi_guid_t guid;
>         u64 table;
> --
> 2.39.1.456.gfc5497dd1b-goog
>
