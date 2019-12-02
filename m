Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D510E7B9
	for <lists+linux-efi@lfdr.de>; Mon,  2 Dec 2019 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLBJfP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 04:35:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLBJfP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 04:35:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so43256744wru.3
        for <linux-efi@vger.kernel.org>; Mon, 02 Dec 2019 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsomJDEnPS1SeuqmJo1Um2y9Uve/ujNAly1vGnk2Wnw=;
        b=PJ4fMewuOtG8ott73XB4wcNp/ELlbBp8phss1wfiPvivwfGxnWW855kS4lrm4jxN5e
         odOP4guLhWbyqMqKIxBr504trIh1bR4wpK+G4mVEI41N1zTWtZso3L3iqzG70jo9qk67
         XzS14gmuZK54bkj+bkprbmjgr+qWo8HAszuI8hw/1qKkYzzdzIX0wH47sSLXyU5piI6O
         eEGCOXj0k+1zkSN7eWe/HCv6riTYSbiN8U4JImU4KcxsWGQnDhr3M42Lp3GrWp6eJSVw
         n6Cnh8BY7Di1yZQOtsyKagscZZRVXzMzWLKqYSF9RTtKj/miu53kJZ489bHwCpzMNE+C
         i+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsomJDEnPS1SeuqmJo1Um2y9Uve/ujNAly1vGnk2Wnw=;
        b=U6ZHi8Pv4zZWRo3lwBfYvquwsavfqUZt4Gu0F12U8o9O8jHR6uIg/43RVpi8eVMaX6
         MnrkgfTwmmr/sWE2XWMWAA3A7XlCAYxdoTRLoUG7za1KrBFbKmRCqJk5Oi+XJRaftSQ6
         9baHuHlQONHh87DsQTJlF7pRqyt7b6hnHa1oY9CH6k2gDBZzYEKAccEvf7UGZcygdmqQ
         qG31WO5G/6LbBFDrs6NWoZGaEpdBsxWDYOcFFuzZ9LIBxjdAFTU8Q3f4EdcWRhIS8Q0E
         dtsbcJ/yMGZPcAl5+SAENi6a7Rp+viQBAe5gwosAYY2skAZmqdcaPPPAOqdR3Bi1+U3h
         MiAw==
X-Gm-Message-State: APjAAAU3HucWMryFvCf+fKCyFYQu+kC5iW1u73S/AJhK3ncC6hLnXs/y
        2EDSyWB4xoeaPyVxlQFw8BlkQyymp3/0ip3aE7TIwQ3AOhSNBA==
X-Google-Smtp-Source: APXvYqzB1kelzlTBEO6JhwtzoB6hvrB8nJisEMcHG1OTRpfRgKSL0aRStSFTwmv3nM9gluzSuO82HynhYXOJl+BOrH0=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr46786997wrs.200.1575279312562;
 Mon, 02 Dec 2019 01:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20191130195045.2005835-1-robdclark@gmail.com>
In-Reply-To: <20191130195045.2005835-1-robdclark@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 2 Dec 2019 10:35:05 +0100
Message-ID: <CAKv+Gu_HXD=59q9zeK6-WoEEngHPrEJpPTyT8U4TZZ3AOs=TcA@mail.gmail.com>
Subject: Re: [PATCH] efi/fdt: install new fdt config table
To:     Rob Clark <robdclark@gmail.com>
Cc:     Leif Lindholm <leif.lindholm@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kairui Song <kasong@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 30 Nov 2019 at 20:51, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If there is an fdt config table, replace it with the newly allocated one
> before calling ExitBootServices().
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> The DtbLoader.efi[1] driver, which Leif created for EBBR boot on the
> "windows" aarch64 laptops, tries to detect in an EBS hook, whether the
> HLOS is using DT.  It does this by realizing that the kernel cmdline is
> patched in to the fdt, and comparing the CRC.  If the CRC has changed,
> that means the HLOS is using DT boot, so it removes the ACPI config
> tables, so that the HLOS does not see two conflicting sets of config
> tables.
>
> However, I realized this mechanism does not work when directly loading
> the linux kernel as an efi executable (ie. without an intermediary like
> grub doing it's own DT modifications), because efi/libstub is modifying
> a copy of the DT config table.
>
> If we update the config table with the new DT, then it will realize
> properly that the HLOS is using DT.
>

Hey Rob,

I understand what you are trying to do here, but this is not the right solution.

I have rejected patches in the past where config tables are used to
communicate information back to the firmware, as creating reverse
dependencies like this is a recipe for disaster.

IIUC, the problem is that the DtbLoader attempts to be smart about
whether to install the DT config table, and to only do so if the OS is
going to boot in DT mode. This is based on the principle that we
should not expose both ACPI and DT tables, and make it the OS's
problem to reason about which one is the preferred description.

I agree with that approach in general, but in this particular case, I
don't think it makes sense. Windows only cares about ACPI, and Linux
only cares about DT unless you instruct it specifically to prioritize
ACPI over DT. So the problem that this solves does not exist in
practice, and we're much better off just exposing the DT alongside the
ACPI tables, and let the OS use whichever one it wants.

Also, the stub always reallocates the FDT, and so the CRC check is
only detecting whether the DT is being touched by GRUB or not.

So removing the ACPI tables like this is not something I think we
should be doing at all. As a compromise, you might add 'acpi=off' to
/chosen/cmdline so that GRUBless boot into Linux does not
inadvertently ends up booting in ACPI mode.

Thanks,
Ard.




> [1] https://git.linaro.org/people/leif.lindholm/edk2.git/log/?h=dtbloader
>
>  .../firmware/efi/libstub/efi-stub-helper.c    | 32 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h        |  2 ++
>  drivers/firmware/efi/libstub/fdt.c            |  2 ++
>  3 files changed, 36 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 35dbc2791c97..210070f3b231 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -953,3 +953,35 @@ void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
>         else
>                 return get_efi_config_table32(sys_table, guid);
>  }
> +
> +#define REPLACE_EFI_CONFIG_TABLE(bits)                                 \
> +static void *replace_efi_config_table##bits(efi_system_table_t *_sys_table, \
> +                                       efi_guid_t guid, void *table)   \
> +{                                                                      \
> +       efi_system_table_##bits##_t *sys_table;                         \
> +       efi_config_table_##bits##_t *tables;                            \
> +       int i;                                                          \
> +                                                                       \
> +       sys_table = (typeof(sys_table))_sys_table;                      \
> +       tables = (typeof(tables))(unsigned long)sys_table->tables;      \
> +                                                                       \
> +       for (i = 0; i < sys_table->nr_tables; i++) {                    \
> +               if (efi_guidcmp(tables[i].guid, guid) != 0)             \
> +                       continue;                                       \
> +                                                                       \
> +               tables[i].table = (uintptr_t)table;                     \
> +               return;                                                 \
> +       }                                                               \
> +}
> +REPLACE_EFI_CONFIG_TABLE(32)
> +REPLACE_EFI_CONFIG_TABLE(64)
> +
> +/* replaces an existing config table: */
> +void replace_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid,
> +                         void *table)
> +{
> +       if (efi_is_64bit())
> +               replace_efi_config_table64(sys_table, guid, table);
> +       else
> +               replace_efi_config_table32(sys_table, guid, table);
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 7f1556fd867d..66f2927ce26f 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -66,6 +66,8 @@ efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
>  efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
>
>  void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
> +void replace_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid,
> +                         void *table);
>
>  /* Helper macros for the usual case of using simple C variables: */
>  #ifndef fdt_setprop_inplace_var
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 0bf0190917e0..15887ec2dc3b 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -313,6 +313,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
>         priv.runtime_entry_count        = &runtime_entry_count;
>         priv.new_fdt_addr               = (void *)*new_fdt_addr;
>
> +       replace_efi_config_table(sys_table, DEVICE_TREE_GUID, priv.new_fdt_addr);
> +
>         status = efi_exit_boot_services(sys_table, handle, &map, &priv, exit_boot_func);
>
>         if (status == EFI_SUCCESS) {
> --
> 2.23.0
>
