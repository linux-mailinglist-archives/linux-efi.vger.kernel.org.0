Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92E66A1E3
	for <lists+linux-efi@lfdr.de>; Fri, 13 Jan 2023 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjAMSYL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Jan 2023 13:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjAMSXu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Jan 2023 13:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72908CD2B;
        Fri, 13 Jan 2023 10:17:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E19A622D6;
        Fri, 13 Jan 2023 18:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFE8C433F2;
        Fri, 13 Jan 2023 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633845;
        bh=2zt1D0WkkskMOK0GYplJHioCRPNOKgvrMlF6jK6c7fY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gcC9AtYmV15ho6s/FGqW+fBfBymuG7jtYE2DYBqPh2BwKShziWJJHlE9GoRjgsuyV
         E2QI75QHMvqUESuipUyvzGl4b8nqRZM6qGiXlthRiyvKNZfWzL0fa2ULA1jxhupmds
         tLR+Zyxml4t8BKaDd4zQWKPpfdoRacfPEo3CPswarV4l1lGSiWk/wisJfG/s/Nm5IR
         /OAstUhwB8fAXU/zcrO7+Jjn94mTRahMyTeG/19RotsUCpve5QdjzsyqMVENrpqWx1
         EDpgh7yoRlhWUq836PndUWP0ZrQ5udQ3yw9VKbKcw78vHZzmfYDi8ApBYpvfaSuCHF
         +jypPudTeOQeA==
Received: by mail-lf1-f44.google.com with SMTP id b3so34240989lfv.2;
        Fri, 13 Jan 2023 10:17:25 -0800 (PST)
X-Gm-Message-State: AFqh2kqmKV9/rU8LgCDm8xvfCvRrJiVn6m8mcVOZXOTfl0rM1jc/5THh
        SGgTVizFrWjMWQ7WMCBImOtqtAXX+UhbC18VmCI=
X-Google-Smtp-Source: AMrXdXtAQC189esz+FEuEDqXM+pU5DM7V+8adrbBeL1UXtKeBq+EQOfFW2ONtlX5651QLe/i/MZ0vs3r5X8pZ/q1bTU=
X-Received: by 2002:ac2:4a72:0:b0:4b6:f37c:c123 with SMTP id
 q18-20020ac24a72000000b004b6f37cc123mr5760052lfp.539.1673633843862; Fri, 13
 Jan 2023 10:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20230113171125.2846306-1-dionnaglaze@google.com>
In-Reply-To: <20230113171125.2846306-1-dionnaglaze@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Jan 2023 19:17:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFFQ6QvbnjUBHhQOu+UxniMR9k+tB7kthBwjudw8tG38A@mail.gmail.com>
Message-ID: <CAMj1kXFFQ6QvbnjUBHhQOu+UxniMR9k+tB7kthBwjudw8tG38A@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Safely enable unaccepted memory in UEFI
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, jiewen.yao@intel.com,
        devel@edk2.groups.io, "Min M. Xu" <min.m.xu@intel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc linux-efi)

On Fri, 13 Jan 2023 at 18:11, Dionna Glaze <dionnaglaze@google.com> wrote:
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
> indicate support to the firmware.
>
> Enabling unaccepted memory requires calling a 0-argument enablement
> protocol before ExitBootServices. This call is only made if the kernel
> is compiled with UNACCEPTED_MEMORY=y
>
> The naming of the protocol guid is dependent on the standardization of
> the protocol, which is being discussed. Acceptance is contingent on
> the kernel community's approval.
>
> Cc: Ard Biescheuvel <ardb@kernel.org>
> Cc: "Min M. Xu" <min.m.xu@intel.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Jiewen Yao <jiewen.yao@intel.com>
> Cc: Erdem Aktas <erdemaktas@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 36 +++++++++++++++++++++++++
>  include/linux/efi.h                     |  1 +
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba..5e9ebfbb49e6 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -26,6 +26,17 @@ const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
>  static efi_loaded_image_t *image = NULL;
>
> +union memory_acceptance_protocol {
> +       struct {
> +               efi_status_t (__efiapi *allow_unaccepted_memory)(
> +                       union memory_acceptance_protocol *);
> +       };
> +       struct {
> +               u32 allow_unaccepted_memory;
> +       } mixed_mode;
> +};
> +typedef union memory_acceptance_protocol memory_acceptance_protocol_t;
> +

Please put the typedef first, and use the defined type in the function
prototype, not the union.


>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  {
> @@ -310,6 +321,29 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
>  #endif
>  }
>
> +
> +static void setup_unaccepted_memory(void)
> +{
> +#ifdef CONFIG_UNACCEPTED_MEMORY

Please drop the #ifdef

> +       efi_guid_t mem_acceptance_proto = EFI_MEMORY_ACCEPTANCE_PROTOCOL_GUID;
> +       memory_acceptance_protocol_t *proto;
> +       efi_status_t status;
> +

... and here, do

if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
    return;

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
> +#endif
> +}
> +
>  static const efi_char16_t apple[] = L"Apple";
>
>  static void setup_quirks(struct boot_params *boot_params,
> @@ -899,6 +933,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>
>         setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
>
> +       setup_unaccepted_memory();
> +
>         status = exit_boot(boot_params, handle);
>         if (status != EFI_SUCCESS) {
>                 efi_err("exit_boot() failed!\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4b27519143f5..bfc0e4f2aba5 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -391,6 +391,7 @@ void efi_native_runtime_setup(void);
>  #define EFI_RT_PROPERTIES_TABLE_GUID           EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
>  #define EFI_DXE_SERVICES_TABLE_GUID            EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
>  #define EFI_SMBIOS_PROTOCOL_GUID               EFI_GUID(0x03583ff6, 0xcb36, 0x4940,  0x94, 0x7e, 0xb9, 0xb3, 0x9f, 0x4a, 0xfa, 0xf7)
> +#define EFI_MEMORY_ACCEPTANCE_PROTOCOL_GUID    EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
>
>  #define EFI_IMAGE_SECURITY_DATABASE_GUID       EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
>  #define EFI_SHIM_LOCK_GUID                     EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> --
> 2.39.0.314.g84b9a713c41-goog
>
