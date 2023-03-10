Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36916B4B2F
	for <lists+linux-efi@lfdr.de>; Fri, 10 Mar 2023 16:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjCJPdh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Mar 2023 10:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjCJPdL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Mar 2023 10:33:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB94B465;
        Fri, 10 Mar 2023 07:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 721AEB822C2;
        Fri, 10 Mar 2023 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30458C433A1;
        Fri, 10 Mar 2023 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678461665;
        bh=UGSJeidk55aYB/mqlgimvqc73fEPWHGHH+aLuRRV1Vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hd/UDayVkDnoVJiTWwWMYmFSMZmdj/5UWuo4Kb7LuG1+Q+3kQjPlvxs1iw6dM3hRH
         07P4GZ8PDtqYIemE9zY8hl2CquLwcY3ygsvtS9Rqu9+cXg4kNsJC3FPdIU4/dkxvAd
         zkUlrZ1bkOaqpPlc0CF51oMLlteueHdefYFbzW5Ha/cCR5Rz4iBonhfEPannoCtgU0
         8mDZtljRKWBet1F70S/i/e0OvCyLOE027qzKu/r/7PU0d75Xf+OJSbbNFjJhmuPtpb
         htcU4UHuvrm8kIFdByaZcPzt4kh4hQjjCjrbotsXNsWpsehj3CQep6LZHliLb5nitk
         PYTX8Q8VVbO+w==
Received: by mail-lj1-f170.google.com with SMTP id y14so5666551ljq.4;
        Fri, 10 Mar 2023 07:21:05 -0800 (PST)
X-Gm-Message-State: AO0yUKUZZ79naG7boTSeSCixUlzd95ab6JvpaUxOQMo4g4tV4TvGr68r
        4CW56vFQx4k8tSrlzN35ARq5ebB5ERJUlpmUByM=
X-Google-Smtp-Source: AK7set8y6ycN0CYvwyL/kfBORtmKENALXeCm6hOuV53tD20N+3yn0SRZ3CW1Ct6//7ijSdpYHPXsIM1mGjzvEisbdLw=
X-Received: by 2002:a2e:b8d2:0:b0:295:b0cd:522 with SMTP id
 s18-20020a2eb8d2000000b00295b0cd0522mr8518274ljp.2.1678461663173; Fri, 10 Mar
 2023 07:21:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <c38ad7a1b89aff743d4a29882a7022d97d4fea58.1671098103.git.baskov@ispras.ru>
In-Reply-To: <c38ad7a1b89aff743d4a29882a7022d97d4fea58.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Mar 2023 16:20:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com>
Message-ID: <CAMj1kXGzXLp20nbg-NoToENbDQhn1b0Gpi2s8f9DgSSM28BbeQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/26] efi/x86: Explicitly set sections memory attributes
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

On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Explicitly change sections memory attributes in efi_pe_entry in case
> of incorrect EFI implementations and to reduce access rights to
> compressed kernel blob. By default it is set executable due to
> restriction in maximum number of sections that can fit before zero
> page.
>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

I don't think we need this patch. Firmware that cares about W^X will
map the PE image with R-X for text/rodata and RW- for data/bss, which
is sufficient, and firmware that doesn't is a lost cause anyway.


> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 54 +++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1f0a2e7075c3..60697fcd8950 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -27,6 +27,12 @@ const efi_dxe_services_table_t *efi_dxe_table;
>  u32 image_offset __section(".data");
>  static efi_loaded_image_t *image __section(".data");
>
> +extern char _head[], _ehead[];
> +extern char _compressed[], _ecompressed[];
> +extern char _text[], _etext[];
> +extern char _rodata[], _erodata[];
> +extern char _data[];
> +
>  static efi_status_t
>  preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
>  {
> @@ -343,6 +349,52 @@ void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
>                 asm("hlt");
>  }
>
> +
> +/*
> + * Manually setup memory protection attributes for each ELF section
> + * since we cannot do it properly by using PE sections.
> + */
> +static void setup_sections_memory_protection(unsigned long image_base)
> +{
> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
> +       efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
> +
> +       if (!efi_dxe_table ||
> +           efi_dxe_table->hdr.signature != EFI_DXE_SERVICES_TABLE_SIGNATURE) {
> +               efi_warn("Unable to locate EFI DXE services table\n");
> +               efi_dxe_table = NULL;
> +               return;
> +       }
> +
> +       /* .setup [image_base, _head] */
> +       efi_adjust_memory_range_protection(image_base,
> +                                          (unsigned long)_head - image_base,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .head.text [_head, _ehead] */
> +       efi_adjust_memory_range_protection((unsigned long)_head,
> +                                          (unsigned long)_ehead - (unsigned long)_head,
> +                                          EFI_MEMORY_RO);
> +       /* .rodata..compressed [_compressed, _ecompressed] */
> +       efi_adjust_memory_range_protection((unsigned long)_compressed,
> +                                          (unsigned long)_ecompressed - (unsigned long)_compressed,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .text [_text, _etext] */
> +       efi_adjust_memory_range_protection((unsigned long)_text,
> +                                          (unsigned long)_etext - (unsigned long)_text,
> +                                          EFI_MEMORY_RO);
> +       /* .rodata [_rodata, _erodata] */
> +       efi_adjust_memory_range_protection((unsigned long)_rodata,
> +                                          (unsigned long)_erodata - (unsigned long)_rodata,
> +                                          EFI_MEMORY_RO | EFI_MEMORY_XP);
> +       /* .data, .bss [_data, _end] */
> +       efi_adjust_memory_range_protection((unsigned long)_data,
> +                                          (unsigned long)_end - (unsigned long)_data,
> +                                          EFI_MEMORY_XP);
> +#else
> +       (void)image_base;
> +#endif
> +}
> +
>  void __noreturn efi_stub_entry(efi_handle_t handle,
>                                efi_system_table_t *sys_table_arg,
>                                struct boot_params *boot_params);
> @@ -687,6 +739,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>                 efi_dxe_table = NULL;
>         }
>
> +       setup_sections_memory_protection(bzimage_addr - image_offset);
> +
>  #ifdef CONFIG_CMDLINE_BOOL
>         status = efi_parse_options(CONFIG_CMDLINE);
>         if (status != EFI_SUCCESS) {
> --
> 2.37.4
>
