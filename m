Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB4138878
	for <lists+linux-efi@lfdr.de>; Sun, 12 Jan 2020 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbgALWpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Jan 2020 17:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbgALWpY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 12 Jan 2020 17:45:24 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9667F2253D
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2020 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578869122;
        bh=0GZEGpPzCGuL/Yh1V/9xQ1rCTWIFkQVZGOa+pizi/yA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IH0moXNZ+raWKby2wZZTkL5pj7cQmLbIaAVRLpQJQwurm4qeKGd07BI/6xEmlMDEG
         6l2rCusL8SAywbGKb3tL8x6diUBkeYZ5u59cnPZL+zSj+aX7GzjmnRuPThPLhz8CsM
         2mf6rxIpZyuwCg41YG9IGeyc3+kwJSO5Nx/M1ebw=
Received: by mail-wr1-f47.google.com with SMTP id w15so6799086wru.4
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2020 14:45:22 -0800 (PST)
X-Gm-Message-State: APjAAAV37Yy5oS3xSOLOZTjt1aMaG6ujDcq9bCssOKBGl6iqZn4aKwsJ
        r7CCfe6C2NpWPcOr3UwOMnzb/zRstYU6w/9IKzLVbQ==
X-Google-Smtp-Source: APXvYqyT6CDS6nQCsUI7FRMpOYPBG+ma/dLH32SCCjPVnRJcoY4JWdZf3QaLnUqHBLjSmocrDg7HXZRTfc9FdqTyIzk=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3933522wrs.106.1578869120894;
 Sun, 12 Jan 2020 14:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20200111145703.533809-1-hdegoede@redhat.com> <20200111145703.533809-3-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-3-hdegoede@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 12 Jan 2020 14:45:09 -0800
X-Gmail-Original-Message-ID: <CALCETrUz4gdVOH=5X+MkB56ST=DNcHKicRST1j1ff0kU1yXWzw@mail.gmail.com>
Message-ID: <CALCETrUz4gdVOH=5X+MkB56ST=DNcHKicRST1j1ff0kU1yXWzw@mail.gmail.com>
Subject: Re: [PATCH v11 02/10] efi: Add embedded peripheral firmware support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 11, 2020 at 6:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Just like with PCI options ROMs, which we save in the setup_efi_pci*
> functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itself
> sometimes may contain data which is useful/necessary for peripheral drivers
> to have access to.
>
> Specifically the EFI code may contain an embedded copy of firmware which
> needs to be (re)loaded into the peripheral. Normally such firmware would be
> part of linux-firmware, but in some cases this is not feasible, for 2
> reasons:
>
> 1) The firmware is customized for a specific use-case of the chipset / use
> with a specific hardware model, so we cannot have a single firmware file
> for the chipset. E.g. touchscreen controller firmwares are compiled
> specifically for the hardware model they are used with, as they are
> calibrated for a specific model digitizer.
>
> 2) Despite repeated attempts we have failed to get permission to
> redistribute the firmware. This is especially a problem with customized
> firmwares, these get created by the chip vendor for a specific ODM and the
> copyright may partially belong with the ODM, so the chip vendor cannot
> give a blanket permission to distribute these.
>
> This commit adds support for finding peripheral firmware embedded in the
> EFI code and makes the found firmware available through the new
> efi_get_embedded_fw() function.
>
> Support for loading these firmwares through the standard firmware loading
> mechanism is added in a follow-up commit in this patch-series.
>
> Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the end
> of start_kernel(), just before calling rest_init(), this is on purpose
> because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large for
> early_memremap(), so the check must be done after mm_init(). This relies
> on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services()
> is called, which means that this will only work on x86 for now.
>

A couple general comments:

How does this interact with modules?  It looks like you're referencing
the dmi table from otherwise modular or potentially modular code in
early EFI code, which seems like it will either prevent modular builds
or will actually fail at compile time depending on config.  Perhaps
you should have a single collection of EFI firmware references in a
separate place in the kernel tree and reference *that* from the EFI
code.

In the event you have many DMI matches (e.g. if anyone ends up using
this in a case where the DMI match has to match very broad things),
you'll iterate over the EFI code and data multiple times and
performance will suck.  It would be much better to iterate once and
search for everything.

I suspect that a rolling hash would be better than the prefix you're
using, but this could be changed later, assuming someone can actually
find all the firmware needed.

> +static int __init efi_check_md_for_embedded_firmware(
> +       efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
> +{
> +       const u64 prefix = *((u64 *)desc->prefix);
> +       struct sha256_state sctx;
> +       struct efi_embedded_fw *fw;
> +       u8 sha256[32];
> +       u64 i, size;
> +       void *map;
> +
> +       size = md->num_pages << EFI_PAGE_SHIFT;
> +       map = memremap(md->phys_addr, size, MEMREMAP_WB);
> +       if (!map) {
> +               pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; (i + desc->length) <= size; i += 8) {
> +               u64 *mem = map + i;
> +
> +               if (*mem != prefix)
> +                       continue;

This is very ugly.  You're casting a pointer to a bunch of bytes to
u64* and then dereferencing it like it's an integer.  This has major
endian issues with are offset by the similar endianness issues when
you type-pun prefix to u64.  You should instead just memcmp the
pointer with the data.  This will get rid of all the type punning in
this function.  You will also fail to detect firmware that isn't
8-byte-aligned.

So perhaps just use memmem() to replace this whole mess?

> +
> +               sha256_init(&sctx);
> +               sha256_update(&sctx, map + i, desc->length);
> +               sha256_final(&sctx, sha256);
> +               if (memcmp(sha256, desc->sha256, 32) == 0)
> +                       break;
> +       }
> +       if ((i + desc->length) > size) {
> +               memunmap(map);
> +               return -ENOENT;
> +       }
> +
> +       pr_info("Found EFI embedded fw '%s'\n", desc->name);
> +

It might be nice to also log which EFI section it was in?

> +       fw = kmalloc(sizeof(*fw), GFP_KERNEL);
> +       if (!fw) {
> +               memunmap(map);
> +               return -ENOMEM;
> +       }
> +
> +       fw->data = kmemdup(map + i, desc->length, GFP_KERNEL);
> +       memunmap(map);
> +       if (!fw->data) {
> +               kfree(fw);
> +               return -ENOMEM;
> +       }
> +
> +       fw->name = desc->name;
> +       fw->length = desc->length;
> +       list_add(&fw->list, &efi_embedded_fw_list);
> +

If you actually copy the firmware name instead of just a pointer to
it, then you could potentially free the list of EFI firmwares.

Why are you copying the firmware into linear (kmemdup) memory here
just to copy it to vmalloc space down below...

> +       return 0;
> +}
> +
> +void __init efi_check_for_embedded_firmwares(void)
> +{
> +       const struct efi_embedded_fw_desc *fw_desc;
> +       const struct dmi_system_id *dmi_id;
> +       efi_memory_desc_t *md;
> +       int i, r;
> +
> +       for (i = 0; embedded_fw_table[i]; i++) {
> +               dmi_id = dmi_first_match(embedded_fw_table[i]);
> +               if (!dmi_id)
> +                       continue;
> +
> +               fw_desc = dmi_id->driver_data;
> +
> +               /*
> +                * In some drivers the struct driver_data contains may contain
> +                * other driver specific data after the fw_desc struct; and
> +                * the fw_desc struct itself may be empty, skip these.
> +                */
> +               if (!fw_desc->name)
> +                       continue;
> +
> +               for_each_efi_memory_desc(md) {
> +                       if (md->type != EFI_BOOT_SERVICES_CODE)
> +                               continue;
> +
> +                       r = efi_check_md_for_embedded_firmware(md, fw_desc);
> +                       if (r == 0)
> +                               break;
> +               }
> +       }
> +
> +       checked_for_fw = true;
> +}

Have you measured how long this takes on a typical system per matching DMI id?

> +
> +int efi_get_embedded_fw(const char *name, void **data, size_t *size)
> +{
> +       struct efi_embedded_fw *iter, *fw = NULL;
> +       void *buf = *data;
> +
> +       if (!checked_for_fw) {

WARN_ON_ONCE?  A stack dump would be quite nice here.

> +       buf = vmalloc(fw->length);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       memcpy(buf, fw->data, fw->length);
> +       *size = fw->length;
> +       *data = buf;

See above.  What's vmalloc() for?  Where's the vfree()?

BTW, it would be very nice to have a straightforward way
(/sys/kernel/debug/efi_firmware/[name]?) to dump all found firmwares.
