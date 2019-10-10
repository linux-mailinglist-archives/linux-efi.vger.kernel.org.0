Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37237D20D5
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 08:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfJJGhF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 02:37:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfJJGhE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 02:37:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so6276127wro.4
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 23:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39vL/RjFbpzLu5bkAOs1K86XiNbeAZ4i2GoTlfcf4x4=;
        b=LG6OY8Ifh2UAofGEue5rrXE+63Iw2DQ4XcKKST6nHpnkTIm+Xi7vYiN9h7p7DhgdGo
         MetSI9e8ryaSLrYm2j+3toTnDUM1XufXB1rRQ8hzX+ChgU5atdy0v2XTIZy+v+j7N1pT
         BBRAWQEBjW3nGG4K4RyfL8QaQX7p5UzcdC3kvK50siY0lf6ezCXhioUy7fVNkM7WFsig
         U1tqB8Ddnvt66XzEbIJ9K9dQCeJKk4AoHEn64Qk3ITT9CWHpiZYThN/hAWwrdfx6K2Rk
         R5Aj4Ll6e71WIf6oJ0g5fO3DESV3CHMUzmY00XS8Q/9auLi/LY8nOI+llMdnHbVqiWSD
         DIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39vL/RjFbpzLu5bkAOs1K86XiNbeAZ4i2GoTlfcf4x4=;
        b=TeX/JOmzi8t0zO4sx1NyTtz4Rpv9c7XTbF05wOG/o2V2FHhB46PRxY7UhrxOvEqxT3
         qHdrJTeeGiDMbASqqfjxMOpFooz5AmtvTk4tgLrO0EFD359Oqmo6gf3VExYTbCSmKq2D
         JT3N7wB5+NBAqBS0FNtktaUsMfvmm0yb6v5vtPaZNBkwzH2+EhYmFawxWA0dCKN2Ub7b
         5Z5D2JXb3RKi7bpCPctVp86VLiVnHU8CRjR6xVRkXeMqt4m9i27vNGRGvVB0D1FKjVhv
         i821mnS21GXReBL5O4xvKX8rzHsLCQUXE8LuflI1LkJdNndlGv227vmEY2zkuVYcigDx
         R/Nw==
X-Gm-Message-State: APjAAAXNf5JTbcLOcliHZ3wjWgLfZlxnJJ7dgiH9272DBtHCkkxmNkq7
        oY85YRTrWnWUZhMN0ThwWOsEbyJgMOSyz7BY96PjhQ==
X-Google-Smtp-Source: APXvYqz2UpiOk7Jsv91cVM9s0b5LHK+kyw4OAekcJw3qQGAv+2SCCXQz/+vZSOLup3set0dvqH15r8Bymf/YQRUCBkU=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr7212983wrp.0.1570689420029;
 Wed, 09 Oct 2019 23:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066229757.1059972.16873416956816693344.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157066229757.1059972.16873416956816693344.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 10 Oct 2019 08:36:48 +0200
Message-ID: <CAKv+Gu89w+HCR2LVnFL5yBQbpy3Gi-rr_0ffrJ9N3fjpY4Jh5w@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] efi: Common enable/disable infrastructure for
 EFI soft reservation
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
>
> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> interpretation of the EFI Memory Types as "reserved for a specific
> purpose".
>
> The proposed Linux behavior for specific purpose memory is that it is
> reserved for direct-access (device-dax) by default and not available for
> any kernel usage, not even as an OOM fallback.  Later, through udev
> scripts or another init mechanism, these device-dax claimed ranges can
> be reconfigured and hot-added to the available System-RAM with a unique
> node identifier. This device-dax management scheme implements "soft" in
> the "soft reserved" designation by allowing some or all of the
> reservation to be recovered as typical memory. This policy can be
> disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> efi=nosoftreserve.
>
> As for this patch, define the common helpers to determine if the
> EFI_MEMORY_SP attribute should be honored. The determination needs to be
> made early to prevent the kernel from being loaded into soft-reserved
> memory, or otherwise allowing early allocations to land there. Follow-on
> changes are needed per architecture to leverage these helpers in their
> respective mem-init paths.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  Documentation/admin-guide/kernel-parameters.txt |    9 ++++++++-
>  drivers/firmware/efi/Kconfig                    |   21 +++++++++++++++++++++
>  drivers/firmware/efi/efi.c                      |    9 +++++++++
>  drivers/firmware/efi/libstub/efi-stub-helper.c  |   19 +++++++++++++++++++
>  include/linux/efi.h                             |    8 ++++++++
>  5 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..47478a730011 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1168,7 +1168,8 @@
>                         Format: {"off" | "on" | "skip[mbr]"}
>
>         efi=            [EFI]
> -                       Format: { "old_map", "nochunk", "noruntime", "debug" }
> +                       Format: { "old_map", "nochunk", "noruntime", "debug",
> +                                 "nosoftreserve" }
>                         old_map [X86-64]: switch to the old ioremap-based EFI
>                         runtime services mapping. 32-bit still uses this one by
>                         default.
> @@ -1177,6 +1178,12 @@
>                         firmware implementations.
>                         noruntime : disable EFI runtime services support
>                         debug: enable misc debug output
> +                       nosoftreserve: The EFI_MEMORY_SP (Specific Purpose)
> +                       attribute may cause the kernel to reserve the
> +                       memory range for a memory mapping driver to
> +                       claim. Specify efi=nosoftreserve to disable this
> +                       reservation and treat the memory by its base type
> +                       (i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
>
>         efi_no_storage_paranoia [EFI; X86]
>                         Using this parameter you can use more than 50% of
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 178ee8106828..9fa79f9fa0af 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -75,6 +75,27 @@ config EFI_MAX_FAKE_MEM
>           Ranges can be set up to this value using comma-separated list.
>           The default value is 8.
>
> +config EFI_SOFT_RESERVE
> +       bool "Reserve EFI Specific Purpose Memory"
> +       depends on EFI && ACPI_HMAT
> +       default ACPI_HMAT
> +       help
> +         On systems that have mixed performance classes of memory EFI
> +         may indicate specific purpose memory with an attribute (See
> +         EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> +         attribute may have unique performance characteristics compared
> +         to the system's general purpose "System RAM" pool. On the
> +         expectation that such memory has application specific usage,
> +         and its base EFI memory type is "conventional" answer Y to
> +         arrange for the kernel to reserve it as a "Soft Reserved"
> +         resource, and set aside for direct-access (device-dax) by
> +         default. The memory range can later be optionally assigned to
> +         the page allocator by system administrator policy via the
> +         device-dax kmem facility. Say N to have the kernel treat this
> +         memory as "System RAM" by default.
> +
> +         If unsure, say Y.
> +
>  config EFI_PARAMS_FROM_FDT
>         bool
>         help
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 68a4ec24b823..911a58be4a36 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -81,6 +81,12 @@ bool efi_runtime_disabled(void)
>         return disable_runtime;
>  }
>
> +bool __pure efi_soft_reserve_enabled(void)
> +{
> +       return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
> +              !efi_enabled(EFI_MEM_NO_SOFT_RESERVE);
> +}
> +
>  static int __init parse_efi_cmdline(char *str)
>  {
>         if (!str) {
> @@ -94,6 +100,9 @@ static int __init parse_efi_cmdline(char *str)
>         if (parse_option_str(str, "noruntime"))
>                 disable_runtime = true;
>
> +       if (parse_option_str(str, "nosoftreserve"))
> +               set_bit(EFI_MEM_NO_SOFT_RESERVE, &efi.flags);
> +
>         return 0;
>  }
>  early_param("efi", parse_efi_cmdline);
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 3caae7f2cf56..5d901c56ac5f 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -32,6 +32,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
>  static int __section(.data) __nokaslr;
>  static int __section(.data) __quiet;
>  static int __section(.data) __novamap;
> +static bool __section(.data) efi_nosoftreserve;
>
>  int __pure nokaslr(void)
>  {
> @@ -45,6 +46,10 @@ int __pure novamap(void)
>  {
>         return __novamap;
>  }
> +bool __pure efi_soft_reserve_enabled(void)
> +{
> +       return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) && !efi_nosoftreserve;
> +}
>
>  #define EFI_MMAP_NR_SLACK_SLOTS        8
>
> @@ -211,6 +216,10 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>                 if (desc->type != EFI_CONVENTIONAL_MEMORY)
>                         continue;
>
> +               if (efi_soft_reserve_enabled() &&
> +                   (desc->attribute & EFI_MEMORY_SP))
> +                       continue;
> +
>                 if (desc->num_pages < nr_pages)
>                         continue;
>
> @@ -305,6 +314,10 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>                 if (desc->type != EFI_CONVENTIONAL_MEMORY)
>                         continue;
>
> +               if (efi_soft_reserve_enabled() &&
> +                   (desc->attribute & EFI_MEMORY_SP))
> +                       continue;
> +
>                 if (desc->num_pages < nr_pages)
>                         continue;
>
> @@ -489,6 +502,12 @@ efi_status_t efi_parse_options(char const *cmdline)
>                         __novamap = 1;
>                 }
>
> +               if (IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
> +                   !strncmp(str, "nosoftreserve", 7)) {
> +                       str += strlen("nosoftreserve");
> +                       efi_nosoftreserve = 1;
> +               }
> +
>                 /* Group words together, delimited by "," */
>                 while (*str && *str != ' ' && *str != ',')
>                         str++;
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index baa275c56401..959c9650018f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1202,6 +1202,7 @@ extern int __init efi_setup_pcdp_console(char *);
>  #define EFI_DBG                        8       /* Print additional debug info at runtime */
>  #define EFI_NX_PE_DATA         9       /* Can runtime data regions be mapped non-executable? */
>  #define EFI_MEM_ATTR           10      /* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
> +#define EFI_MEM_NO_SOFT_RESERVE        11      /* Is the kernel configured to ignore soft reservations? */
>
>  #ifdef CONFIG_EFI
>  /*
> @@ -1212,6 +1213,8 @@ static inline bool efi_enabled(int feature)
>         return test_bit(feature, &efi.flags) != 0;
>  }
>  extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
> +
> +bool __pure efi_soft_reserve_enabled(void);
>  #else
>  static inline bool efi_enabled(int feature)
>  {
> @@ -1225,6 +1228,11 @@ efi_capsule_pending(int *reset_type)
>  {
>         return false;
>  }
> +
> +static inline bool efi_soft_reserve_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  extern int efi_status_to_err(efi_status_t status);
>
