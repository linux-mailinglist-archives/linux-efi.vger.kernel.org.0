Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559C41A4939
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJRiJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 13:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJRiJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 13:38:09 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0ED21655
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586540288;
        bh=2wBThtjAAWWNSHUFTC4TdIiiV8t4ITeV+jakkez+W3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EIlZ6r3XrJ8qGcMyvbnCI4fTSxxFe1guQxor1z8WMmbyAiDidTh02iGvXx+qNsyb0
         CDvLRym0CBHISSN8fLWmsEmreZ05eX9sV3QtA5bT+LBrNSV21CNtuOcjWb2Bh3/Jfn
         Pz8TyvAmFEBnVkhw8pslCn+kiMiCmTaOzbgQ6uxY=
Received: by mail-io1-f54.google.com with SMTP id h6so2454756iok.11
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 10:38:08 -0700 (PDT)
X-Gm-Message-State: AGi0PubwDdsKlA/StbcUiAz1cKWKnZfPceiBiVYmDZnqisP52jNGkRaL
        ivM+21xVu9dt0JHvce1Wiqg9b1+eT9W7gPf90JA=
X-Google-Smtp-Source: APiQypJld0+m6ZPTgnMOb7+XBKltcfH3gEraOzyJ8TcIPfcyLmyTyXG0g7hMFE+CgN8Kkvsi/Xirj3glWfcYDQRX1RQ=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr5414059ioq.142.1586540287769;
 Fri, 10 Apr 2020 10:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200410172824.86217-1-ignat@cloudflare.com>
In-Reply-To: <20200410172824.86217-1-ignat@cloudflare.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 19:37:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFu5Jd7RzY1tC-RXKof4_s=qU+xRa37qKSQqiZ5tta9Bg@mail.gmail.com>
Message-ID: <CAMj1kXFu5Jd7RzY1tC-RXKof4_s=qU+xRa37qKSQqiZ5tta9Bg@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Expose number of entries in the EFI
 configuration table via sysfs
To:     Ignat Korchagin <ignat@cloudflare.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ignat,

Thanks for the patch.

On Fri, 10 Apr 2020 at 19:28, Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> Currently Linux exposes the physical address of the EFI configuration table via
> sysfs, but not the number of entries.
>

It does so on x86 only, and the purpose is specifically defined as
kexec. This is for a good reason: kexec on x86 EFI machines has
accumulated some historical quirks dealing with issues that do not
exist on other architectures.

> The number of entries for the EFI configuration table is located in the EFI
> system table and the EFI system table is not exposed, so there is no way for
> a userspace application to reliably navigate the EFI configuration table.
>
> One potential use case for such a userspace program would be a monitoring agent,
> which parses Image Execution Information Table from the EFI configuration table
> and reports all the UEFI executables, which have been denied execution due to
> the enforced Secure Boot policy thus providing intrusion detection capabilities.
>

Exposing a physical address via syfs and using /dev/mem to scoop up
the data is not a robust, secure or portable interface, especially in
the quoted context of a UEFI secure boot enabled system.

If you need to access this table from userland, I suggest we come up
with a generic method that does not rely on /dev/mem. It would be even
better if we could come up with some infrastructure that makes this
easily extendable to other configuration tables. But simply exposing
the address and size of the config table array in memory is not the
right way.

> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  Documentation/ABI/testing/sysfs-firmware-efi | 12 +++++++++-
>  arch/x86/platform/efi/efi.c                  | 24 +++++++++++++++-----
>  drivers/firmware/efi/efi.c                   |  2 ++
>  3 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
> index 5e4d0b27cdfe..37d0364c16cb 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-efi
> +++ b/Documentation/ABI/testing/sysfs-firmware-efi
> @@ -17,7 +17,9 @@ Date:         December 2013
>  Contact:       Dave Young <dyoung@redhat.com>
>  Description:   It shows the physical address of config table entry in the EFI
>                 system table.
> -Users:         Kexec
> +Users:         Kexec, userspace tools for reading information from UEFI
> +               configuration table (for example, Image Execution Information
> +               Table)
>
>  What:          /sys/firmware/efi/systab
>  Date:          April 2005
> @@ -36,3 +38,11 @@ Description: Displays the content of the Runtime Configuration Interface
>                 Table version 2 on Dell EMC PowerEdge systems in binary format
>  Users:         It is used by Dell EMC OpenManage Server Administrator tool to
>                 populate BIOS setup page.
> +
> +What:          /sys/firmware/efi/nr_tables
> +Date:          April 2020
> +Contact:       linux-efi@vger.kernel.org
> +Description:   It shows number of entries in the config table entry in the EFI
> +               system table.
> +Users:         Userspace tools for reading information from UEFI configuration
> +               table (for example, Image Execution Information Table)
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 1aae5302501d..83574db489d4 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -57,9 +57,9 @@
>  static unsigned long efi_systab_phys __initdata;
>  static unsigned long prop_phys = EFI_INVALID_TABLE_ADDR;
>  static unsigned long uga_phys = EFI_INVALID_TABLE_ADDR;
> -static unsigned long efi_runtime, efi_nr_tables;
> +static unsigned long efi_runtime;
>
> -unsigned long efi_fw_vendor, efi_config_table;
> +unsigned long efi_fw_vendor, efi_config_table, efi_nr_tables;
>
>  static const efi_config_table_type_t arch_tables[] __initconst = {
>         {EFI_PROPERTIES_TABLE_GUID, "PROP", &prop_phys},
> @@ -963,20 +963,29 @@ char *efi_systab_show_arch(char *str)
>
>  #define EFI_FIELD(var) efi_ ## var
>
> -#define EFI_ATTR_SHOW(name) \
> +#define EFI_ATTR_SHOW_ADDR(name) \
>  static ssize_t name##_show(struct kobject *kobj, \
>                                 struct kobj_attribute *attr, char *buf) \
>  { \
>         return sprintf(buf, "0x%lx\n", EFI_FIELD(name)); \
>  }
>
> -EFI_ATTR_SHOW(fw_vendor);
> -EFI_ATTR_SHOW(runtime);
> -EFI_ATTR_SHOW(config_table);
> +#define EFI_ATTR_SHOW_ULONG(name) \
> +static ssize_t name##_show(struct kobject *kobj, \
> +                                struct kobj_attribute *attr, char *buf) \
> +{ \
> +        return sprintf(buf, "%lu\n", EFI_FIELD(name)); \
> +}
> +
> +EFI_ATTR_SHOW_ADDR(fw_vendor);
> +EFI_ATTR_SHOW_ADDR(runtime);
> +EFI_ATTR_SHOW_ADDR(config_table);
> +EFI_ATTR_SHOW_ULONG(nr_tables);
>
>  struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
>  struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
>  struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
> +struct kobj_attribute efi_attr_nr_tables = __ATTR_RO(nr_tables);
>
>  umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
>  {
> @@ -990,6 +999,9 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
>         } else if (attr == &efi_attr_config_table.attr) {
>                 if (efi_config_table == EFI_INVALID_TABLE_ADDR)
>                         return 0;
> +       } else if (attr == &efi_attr_nr_tables.attr) {
> +               if (efi_config_table == EFI_INVALID_TABLE_ADDR)
> +                       return 0;
>         }
>         return attr->mode;
>  }
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 911a2bd0f6b7..0fe064582f33 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -150,6 +150,7 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
>  extern __weak struct kobj_attribute efi_attr_fw_vendor;
>  extern __weak struct kobj_attribute efi_attr_runtime;
>  extern __weak struct kobj_attribute efi_attr_config_table;
> +extern __weak struct kobj_attribute efi_attr_nr_tables;
>  static struct kobj_attribute efi_attr_fw_platform_size =
>         __ATTR_RO(fw_platform_size);
>
> @@ -159,6 +160,7 @@ static struct attribute *efi_subsys_attrs[] = {
>         &efi_attr_fw_vendor.attr,
>         &efi_attr_runtime.attr,
>         &efi_attr_config_table.attr,
> +       &efi_attr_nr_tables.attr,
>         NULL,
>  };
>
> --
> 2.20.1
>
