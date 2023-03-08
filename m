Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9609C6B0308
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCHJiZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 04:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCHJiW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 04:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6C5C138;
        Wed,  8 Mar 2023 01:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260CE61714;
        Wed,  8 Mar 2023 09:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA1C4339B;
        Wed,  8 Mar 2023 09:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268300;
        bh=ejHpkDT2inDJQSoJM6Sjz5eQ33tTqYdoLD5h1ZsU9iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hylhuCjbIh3L4I/rCThYp4XIIWzTmmdyMbrIgNRRuTfmmK3f+SNtlYfhlstvAgVzn
         yfDAlbE0RCpQDvs7VGf2gkTte6bOYIs4YUExRyTg/8+U0OsMhSeMWx2agi06/E2aou
         S0f0aJyg463f9ErozEMBE9i8geaoeMHokpYXxSK/NmtJEnaiP1FPMvjBh5SF6IPOKU
         YLepAVB9wbN6MuZpxrVd7Ypt9nTAacY53jNDd0wGow+O5Qiv4Ay7WuHq3SHrthGDI2
         9MdIV4z4rEXA1TeohRE2XjpAvdsIs0BWMn7nq/j8XUO0uQmbCku3Txt+Jp6MEovipg
         a4c2N3GEf27mA==
Received: by mail-lj1-f172.google.com with SMTP id a32so15921021ljr.9;
        Wed, 08 Mar 2023 01:38:20 -0800 (PST)
X-Gm-Message-State: AO0yUKWl1a/RlzmmnFeJmBumRXXhn8jPM/tz8nQBHRDl+X91QSPZbyVB
        8csYMCvmcfRSdDj184RcGyajm4xNgeGsC2NV4w0=
X-Google-Smtp-Source: AK7set9Wbo2nCta5ECrJ+N/eh5JFMLCTlz5GO8sy8tkd35vILrIAEvVxOvAAD3TghKlsMXoVsQzgsA4gL8c6ev0vDF4=
X-Received: by 2002:a2e:b8d2:0:b0:295:b0cd:522 with SMTP id
 s18-20020a2eb8d2000000b00295b0cd0522mr5604517ljp.2.1678268298549; Wed, 08 Mar
 2023 01:38:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <760c19466ac26c09edb76e64d8c4812ff4aa7365.1671098103.git.baskov@ispras.ru>
In-Reply-To: <760c19466ac26c09edb76e64d8c4812ff4aa7365.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 10:38:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtEZtso0Gcuj-PhGiK1QRhp9SDFLwouX3qdgSha=ACjA@mail.gmail.com>
Message-ID: <CAMj1kXFtEZtso0Gcuj-PhGiK1QRhp9SDFLwouX3qdgSha=ACjA@mail.gmail.com>
Subject: Re: [PATCH v4 08/26] x86/boot: Map memory explicitly
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Implicit mappings hide possible memory errors, e.g. allocations for
> ACPI tables were not included in boot page table size.
>
> Replace all implicit mappings from page fault handler with
> explicit mappings.
>

I agree with the motivation but this patch seems to break the boot
under SeaBIOS/QEMU, and I imagine other legacy BIOS boot scenarios as
well.

Naively, I would assume that there is simply a legacy BIOS region that
we fail to map here, but I am fairly clueless when it comes to non-EFI
x86 boot so take this with a grain of salt.


> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/acpi.c  | 25 ++++++++++++++++++++++++-
>  arch/x86/boot/compressed/efi.c   | 19 ++++++++++++++++++-
>  arch/x86/boot/compressed/kaslr.c |  4 ++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 9caf89063e77..c775e01fc7db 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -93,6 +93,8 @@ static u8 *scan_mem_for_rsdp(u8 *start, u32 length)
>
>         end = start + length;
>
> +       kernel_add_identity_map((unsigned long)start, (unsigned long)end, 0);
> +
>         /* Search from given start address for the requested length */
>         for (address = start; address < end; address += ACPI_RSDP_SCAN_STEP) {
>                 /*
> @@ -128,6 +130,9 @@ static acpi_physical_address bios_get_rsdp_addr(void)
>         unsigned long address;
>         u8 *rsdp;
>
> +       kernel_add_identity_map((unsigned long)ACPI_EBDA_PTR_LOCATION,
> +                               (unsigned long)ACPI_EBDA_PTR_LOCATION + 2, 0);
> +
>         /* Get the location of the Extended BIOS Data Area (EBDA) */
>         address = *(u16 *)ACPI_EBDA_PTR_LOCATION;
>         address <<= 4;
> @@ -215,6 +220,9 @@ static unsigned long get_acpi_srat_table(void)
>         if (!rsdp)
>                 return 0;
>
> +       kernel_add_identity_map((unsigned long)rsdp,
> +                               (unsigned long)(rsdp + 1), 0);
> +
>         /* Get ACPI root table from RSDP.*/
>         if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
>             !strncmp(arg, "rsdt", 4)) &&
> @@ -231,10 +239,17 @@ static unsigned long get_acpi_srat_table(void)
>                 return 0;
>
>         header = (struct acpi_table_header *)root_table;
> +
> +       kernel_add_identity_map((unsigned long)header,
> +                               (unsigned long)(header + 1), 0);
> +
>         len = header->length;
>         if (len < sizeof(struct acpi_table_header) + size)
>                 return 0;
>
> +       kernel_add_identity_map((unsigned long)header,
> +                               (unsigned long)header + len, 0);
> +
>         num_entries = (len - sizeof(struct acpi_table_header)) / size;
>         entry = (u8 *)(root_table + sizeof(struct acpi_table_header));
>
> @@ -247,8 +262,16 @@ static unsigned long get_acpi_srat_table(void)
>                 if (acpi_table) {
>                         header = (struct acpi_table_header *)acpi_table;
>
> -                       if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_SRAT))
> +                       kernel_add_identity_map(acpi_table,
> +                                               acpi_table + sizeof(*header),
> +                                               0);
> +
> +                       if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_SRAT)) {
> +                               kernel_add_identity_map(acpi_table,
> +                                                       acpi_table + header->length,
> +                                                       0);
>                                 return acpi_table;
> +                       }
>                 }
>                 entry += size;
>         }
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 6edd034b0b30..ce70103fbbc0 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -57,10 +57,14 @@ enum efi_type efi_get_type(struct boot_params *bp)
>   */
>  unsigned long efi_get_system_table(struct boot_params *bp)
>  {
> -       unsigned long sys_tbl_pa;
> +       static unsigned long sys_tbl_pa __section(".data");
>         struct efi_info *ei;
> +       unsigned long sys_tbl_size;
>         enum efi_type et;
>
> +       if (sys_tbl_pa)
> +               return sys_tbl_pa;
> +
>         /* Get systab from boot params. */
>         ei = &bp->efi_info;
>  #ifdef CONFIG_X86_64
> @@ -73,6 +77,13 @@ unsigned long efi_get_system_table(struct boot_params *bp)
>                 return 0;
>         }
>
> +       if (efi_get_type(bp) == EFI_TYPE_64)
> +               sys_tbl_size = sizeof(efi_system_table_64_t);
> +       else
> +               sys_tbl_size = sizeof(efi_system_table_32_t);
> +
> +       kernel_add_identity_map(sys_tbl_pa, sys_tbl_pa + sys_tbl_size, 0);
> +
>         return sys_tbl_pa;
>  }
>
> @@ -92,6 +103,10 @@ static struct efi_setup_data *get_kexec_setup_data(struct boot_params *bp,
>
>         pa_data = bp->hdr.setup_data;
>         while (pa_data) {
> +               unsigned long pa_data_end = pa_data + sizeof(struct setup_data)
> +                                         + sizeof(struct efi_setup_data);
> +               kernel_add_identity_map(pa_data, pa_data_end, 0);
> +
>                 data = (struct setup_data *)pa_data;
>                 if (data->type == SETUP_EFI) {
>                         esd = (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
> @@ -160,6 +175,8 @@ int efi_get_conf_table(struct boot_params *bp, unsigned long *cfg_tbl_pa,
>                 return -EINVAL;
>         }
>
> +       kernel_add_identity_map(*cfg_tbl_pa, *cfg_tbl_pa + *cfg_tbl_len, 0);
> +
>         return 0;
>  }
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 454757fbdfe5..c0ee116c4fa2 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -688,6 +688,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>         u32 nr_desc;
>         int i;
>
> +       kernel_add_identity_map((unsigned long)e, (unsigned long)(e + 1), 0);
> +
>         signature = (char *)&e->efi_loader_signature;
>         if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
>             strncmp(signature, EFI64_LOADER_SIGNATURE, 4))
> @@ -704,6 +706,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>         pmap = (e->efi_memmap | ((__u64)e->efi_memmap_hi << 32));
>  #endif
>
> +       kernel_add_identity_map(pmap, pmap + e->efi_memmap_size, 0);
> +
>         nr_desc = e->efi_memmap_size / e->efi_memdesc_size;
>         for (i = 0; i < nr_desc; i++) {
>                 md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
> --
> 2.37.4
>
