Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D4413A935
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2020 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANMZL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Jan 2020 07:25:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729169AbgANMZK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Jan 2020 07:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579004709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCV5TnIbzWRUdBv1D4tK+HJinEhGyz7JTddDYPek7wk=;
        b=OCyFVZzDht5fMRINfmR1MZNtWspu7wQnrxOBevDThSlfnc3JyH+Z4chVgcOJJO5ohOJXQ7
        8+AMacHKvpxgmDhjEMPJru57IkMmp2VwlIbTAKQXI3bSVUFwdp82jCE8M48XSC3IEakP43
        8JfvWgupPtlwq6VRfll1wDEmhUUxWow=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-cGmA0vOJMQm31AZpj3RtRg-1; Tue, 14 Jan 2020 07:25:07 -0500
X-MC-Unique: cGmA0vOJMQm31AZpj3RtRg-1
Received: by mail-wr1-f69.google.com with SMTP id z10so6356862wrt.21
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2020 04:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TCV5TnIbzWRUdBv1D4tK+HJinEhGyz7JTddDYPek7wk=;
        b=gu2yEF8MIeWAZBhXtGc3MtYUbX8M+wEy+QE3q9e3OagiU1MZOxjjJ5WjHUTt/XAv9o
         Sv2P9eki5+q6rUoUdIaW5JHm5m/Ze3XRzc9UHMFvBOZemnEMz1+BusUNgJHmHzXmyzhH
         bu7Rv9uE54MEmQIU3MxdTdiNeB/YGf0RhP016EnWUtzGo85bxJ8kQvZezHc/oTx7Jt9e
         c9yDc6mDTTOy0ZnThS+S4WqyLdZ2L3qf9bBVryqLJIjDp3KsdscEd+IeP6+8fUvLQMG2
         l7eMCn6lV6S3pFx6QadieOTLvBXzbMkfrWQWiG8uQffsPFOzrfNLTKffEPMWosLZaQHW
         J8sw==
X-Gm-Message-State: APjAAAXVPkllfwgRJiJ6gGTZvA06kq0BIv+XSVqWVfREJonGy1LAYexy
        mT9agBLYtAI9tiy8ZqwVUh1FkJzHgZ7k8rSxMyoaifHOKruPmFBDPLRzhlQoKmXZp/ZMDaljR4l
        tGvNJDQ2qDN9X3IsPuaDc
X-Received: by 2002:adf:f78e:: with SMTP id q14mr1915910wrp.186.1579004705579;
        Tue, 14 Jan 2020 04:25:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxf9lENElInXFP/3VQX2YX7CugrtpLakWFQOGWuhgBVNb8tPLK4+EdF8kc1SVigKdGJQayGrQ==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr1915841wrp.186.1579004704864;
        Tue, 14 Jan 2020 04:25:04 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x7sm18712328wrq.41.2020.01.14.04.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 04:25:03 -0800 (PST)
Subject: Re: [PATCH v11 02/10] efi: Add embedded peripheral firmware support
To:     Andy Lutomirski <luto@kernel.org>
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
References: <20200111145703.533809-1-hdegoede@redhat.com>
 <20200111145703.533809-3-hdegoede@redhat.com>
 <CALCETrUz4gdVOH=5X+MkB56ST=DNcHKicRST1j1ff0kU1yXWzw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b5b8304-74bc-4e5c-5030-98bd6e12eaf0@redhat.com>
Date:   Tue, 14 Jan 2020 13:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CALCETrUz4gdVOH=5X+MkB56ST=DNcHKicRST1j1ff0kU1yXWzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy,

Thank you for your feedback.

On 12-01-2020 23:45, Andy Lutomirski wrote:
> On Sat, Jan 11, 2020 at 6:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Just like with PCI options ROMs, which we save in the setup_efi_pci*
>> functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itself
>> sometimes may contain data which is useful/necessary for peripheral drivers
>> to have access to.
>>
>> Specifically the EFI code may contain an embedded copy of firmware which
>> needs to be (re)loaded into the peripheral. Normally such firmware would be
>> part of linux-firmware, but in some cases this is not feasible, for 2
>> reasons:
>>
>> 1) The firmware is customized for a specific use-case of the chipset / use
>> with a specific hardware model, so we cannot have a single firmware file
>> for the chipset. E.g. touchscreen controller firmwares are compiled
>> specifically for the hardware model they are used with, as they are
>> calibrated for a specific model digitizer.
>>
>> 2) Despite repeated attempts we have failed to get permission to
>> redistribute the firmware. This is especially a problem with customized
>> firmwares, these get created by the chip vendor for a specific ODM and the
>> copyright may partially belong with the ODM, so the chip vendor cannot
>> give a blanket permission to distribute these.
>>
>> This commit adds support for finding peripheral firmware embedded in the
>> EFI code and makes the found firmware available through the new
>> efi_get_embedded_fw() function.
>>
>> Support for loading these firmwares through the standard firmware loading
>> mechanism is added in a follow-up commit in this patch-series.
>>
>> Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the end
>> of start_kernel(), just before calling rest_init(), this is on purpose
>> because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large for
>> early_memremap(), so the check must be done after mm_init(). This relies
>> on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services()
>> is called, which means that this will only work on x86 for now.
>>
> 
> A couple general comments:
> 
> How does this interact with modules?  It looks like you're referencing
> the dmi table from otherwise modular or potentially modular code in
> early EFI code, which seems like it will either prevent modular builds
> or will actually fail at compile time depending on config.  Perhaps
> you should have a single collection of EFI firmware references in a
> separate place in the kernel tree and reference *that* from the EFI
> code.

You are right that this currently relies on the DMI tables
added to the embedded_fw_table[] being built in.

There currently really only is one (niche) group of X86 devices which
benefit from this patch-set. On some cheap X86 tablets and 2-in-1s
cheap touchscreen controllers are used which do not have their
(model specific) firmware in (p)ROM instead it needs to be loaded
by the touchscreen driver. We load the firmware using a model-specific
firmware filename through the standard firmware loading mechanism.
This is painful for end users of such devices, since they need to get
the firmware from somewhere (despite repeated tries we do not
have redistribution rights to put them in linux-firmware).

Dave Olsthoorn pointed out to me that on his device model the touchscreen
worked in Refind, so there is an EFI driver for it, so the firmware should
be somewhere in the EFI firmware addressspace. That resulted in this
patch-set which will make the touchscreen work OOTB on devices where
the firmware is embedded in the UEFI code somewhere.

So (for now) this new mechanism is only used by a small niche
group of devices.

The X86 devices which these touchscreens already need a bunch of
device model specific metadata, like the model specific firmware
filename and also the resolution of the touchscreen, orientation, etc.

We already have a "driver" which adds this info to the device
during enumeration using device-properties:
drivers/platform/x86/touchscreen_dmi.c

This code already is builtin as it needs to add a bus-notifier
before i2c bus enumeration to be able to add the device-properties
before the devices are proped (it uses an arch_initcall).

So here we already have a dmi_system_id table with matches for
all devices in our small niche group. The current mechanism
where a driver "registers" its dmi_system_id table in the
embedded_fw_table[] table is based on this use-case.

This avoids needing to duplicate the dmi-match strings in 2
places and allows us keeping all the info related to a
touchscreen in a single place, e.g. the entry for the Cube
iWorks 8 air looks like this:

static const struct property_entry cube_iwork8_air_props[] = {
         PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
         PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
         PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
         PROPERTY_ENTRY_U32("touchscreen-size-y", 896),
         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
         PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
         PROPERTY_ENTRY_U32("silead,max-fingers", 10),
         { }
};

static const struct ts_dmi_data cube_iwork8_air_data = {
         .embedded_fw = {
                 .name   = "silead/gsl3670-cube-iwork8-air.fw",
                 .prefix = { 0xf0, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00 },
                 .length = 38808,
                 .sha256 = { 0xff, 0x62, 0x2d, 0xd1, 0x8a, 0x78, 0x04, 0x7b,
                             0x33, 0x06, 0xb0, 0x4f, 0x7f, 0x02, 0x08, 0x9c,
                             0x96, 0xd4, 0x9f, 0x04, 0xe1, 0x47, 0x25, 0x25,
                             0x60, 0x77, 0x41, 0x33, 0xeb, 0x12, 0x82, 0xfc },
         },
         .acpi_name      = "MSSL1680:00",
         .properties     = cube_iwork8_air_props,
};

And then the driver_data for the DMI match for this device
points to cube_iwork8_air_data.

For now doing it this way makes more sense IMHO then duplicating the
DMI matches inside drivers/firmware/efi/embedded-firmware.c and
putting the embedded_fw info there, where the rest of the info
lives in drivers/platform/x86/touchscreen_dmi.c.

This is all internal kernel API (not even exported to modules) so
if more users of the EFI-embedded-fw mechanism show up and this is a
poor fit for them, then we can re-evaluate this.

Also note that the drivers/platform/x86/touchscreen_dmi.c sees a number
of commits each kernel cycle, keeping the churn for adding touchscreen
info for new device models located to 1 file also is a good thing
about the current approach. So far the drivers/platform/x86 maintainers
have not complained about the churn being concentrated there...

> In the event you have many DMI matches (e.g. if anyone ends up using
> this in a case where the DMI match has to match very broad things),
> you'll iterate over the EFI code and data multiple times and
> performance will suck.  It would be much better to iterate once and
> search for everything.

As I said this is targeting a small niche group of X86 device models,
so this is very much optimized for there being zero DMI matches and
since all the touchscreen info is model specific we use narrow DMI
matches up to matching the exact BIOS version and/or date when the
other DMI info is too generic.

And since ATM touchscreen drivers are the only user there should
never be more then 1 DMI match. Note this is also assumed in
the code, it only calls dmi_first_match() once on each registered
dmi_system_id table and ATM we only have 0 or 1 registered
dmi_system_id tables.

Even if we get more use of this the chances of 1 device model using
more then 1 embedded fw are small. Where as if we first map the
EFI_BOOT_SERVICES_CODE segment before doing the DMI match then we
do this for all EFI_BOOT_SERVICES_CODE segments on all hardware.
The current implementation is very much optimized to do as little
work as possible when there is no DMI match, which will be true
on almost all devices out there.

> I suspect that a rolling hash would be better than the prefix you're
> using, but this could be changed later, assuming someone can actually
> find all the firmware needed.
> 
>> +static int __init efi_check_md_for_embedded_firmware(
>> +       efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
>> +{
>> +       const u64 prefix = *((u64 *)desc->prefix);
>> +       struct sha256_state sctx;
>> +       struct efi_embedded_fw *fw;
>> +       u8 sha256[32];
>> +       u64 i, size;
>> +       void *map;
>> +
>> +       size = md->num_pages << EFI_PAGE_SHIFT;
>> +       map = memremap(md->phys_addr, size, MEMREMAP_WB);
>> +       if (!map) {
>> +               pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for (i = 0; (i + desc->length) <= size; i += 8) {
>> +               u64 *mem = map + i;
>> +
>> +               if (*mem != prefix)
>> +                       continue;
> 
> This is very ugly.  You're casting a pointer to a bunch of bytes to
> u64* and then dereferencing it like it's an integer.  This has major
> endian issues with are offset by the similar endianness issues when
> you type-pun prefix to u64.  You should instead just memcmp the
> pointer with the data.  This will get rid of all the type punning in
> this function.

Ok, I will switch to memcmp for the next version.

> You will also fail to detect firmware that isn't
> 8-byte-aligned.

This is by design, currently being 8 byte aligned holds true for
all devices on which this is used, also see the kdoc added in
"[PATCH v11 04/10] firmware: Add new platform fallback mechanism and firmware_request_platform()"

Specifically:

+EFI embedded firmware fallback mechanism
+========================================
+
+On some devices the system's EFI code / ROM may contain an embedded copy
+of firmware for some of the system's integrated peripheral devices and
+the peripheral's Linux device-driver needs to access this firmware.
+
+Device drivers which need such firmware can use the
+firmware_request_platform() function for this, note that this is a
+separate fallback mechanism from the other fallback mechanisms and
+this does not use the sysfs interface.
+
+A device driver which needs this can describe the firmware it needs
+using an efi_embedded_fw_desc struct:
+
+.. kernel-doc:: include/linux/efi_embedded_fw.h
+   :functions: efi_embedded_fw_desc
+
+The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE memory
+segments for an eight byte sequence matching prefix; if the prefix is found it
+then does a sha256 over length bytes and if that matches makes a copy of length
+bytes and adds that to its list with found firmwares.
+
+To avoid doing this somewhat expensive scan on all systems, dmi matching is
+used. Drivers are expected to export a dmi_system_id array, with each entries'
+driver_data pointing to an efi_embedded_fw_desc.
+
+To register this array with the efi-embedded-fw code, a driver needs to:
+
+1. Always be builtin to the kernel or store the dmi_system_id array in a
+   separate object file which always gets builtin.
+
+2. Add an extern declaration for the dmi_system_id array to
+   include/linux/efi_embedded_fw.h.
+
+3. Add the dmi_system_id array to the embedded_fw_table in
+   drivers/firmware/efi/embedded-firmware.c wrapped in a #ifdef testing that
+   the driver is being builtin.
+
+4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
+
+The firmware_request_platform() function will always first try to load firmware
+with the specified name directly from the disk, so the EFI embedded-fw can
+always be overridden by placing a file under /lib/firmware.
+
+Note that:
+
+1. The code scanning for EFI embedded-firmware runs near the end
+   of start_kernel(), just before calling rest_init(). For normal drivers and
+   subsystems using subsys_initcall() to register themselves this does not
+   matter. This means that code running earlier cannot use EFI
+   embedded-firmware.
+
+2. At the moment the EFI embedded-fw code assumes that firmwares always start at
+   an offset which is a multiple of 8 bytes, if this is not true for your case
+   send in a patch to fix this.


Note this also documents your concern about the dmi_system_id
table needing to be builtin.

> So perhaps just use memmem() to replace this whole mess?

If we hit firmware which is not 8 byte aligned, then yes that would be
a good idea, but for now I feel that that would just cause a slowdown
in the scanning without any benefits.

>> +
>> +               sha256_init(&sctx);
>> +               sha256_update(&sctx, map + i, desc->length);
>> +               sha256_final(&sctx, sha256);
>> +               if (memcmp(sha256, desc->sha256, 32) == 0)
>> +                       break;
>> +       }
>> +       if ((i + desc->length) > size) {
>> +               memunmap(map);
>> +               return -ENOENT;
>> +       }
>> +
>> +       pr_info("Found EFI embedded fw '%s'\n", desc->name);
>> +
> 
> It might be nice to also log which EFI section it was in?

The EFI sections do not have names, so all I could is log
the section number which does not really feel useful?

>> +       fw = kmalloc(sizeof(*fw), GFP_KERNEL);
>> +       if (!fw) {
>> +               memunmap(map);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       fw->data = kmemdup(map + i, desc->length, GFP_KERNEL);
>> +       memunmap(map);
>> +       if (!fw->data) {
>> +               kfree(fw);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       fw->name = desc->name;
>> +       fw->length = desc->length;
>> +       list_add(&fw->list, &efi_embedded_fw_list);
>> +
> 
> If you actually copy the firmware name instead of just a pointer to
> it, then you could potentially free the list of EFI firmwares.

If we move to having a separate dmi_system_id table for this then
that would be true. ATM the dmi_system_id from
drivers/platform/x86/touchscreen_dmi.c
is not freed as it is referenced from a bus-notifier.

> Why are you copying the firmware into linear (kmemdup) memory here

The kmemdup is because the EFI_BOOT_SERVICES_CODE section is
free-ed almost immediately after we run.

> just to copy it to vmalloc space down below...

The vmalloc is because the efi_get_embedded_fw() function is
a helper for later implementing firmware_Request_platform
which returns a struct firmware *fw and release_firmware()
uses vfree() to free the firmware contents.

I guess we could have efi_get_embedded_fw() return an const u8 *
and have the firmware code do the vmalloc + memcpy but it boils
down to the same thing.


> 
>> +       return 0;
>> +}
>> +
>> +void __init efi_check_for_embedded_firmwares(void)
>> +{
>> +       const struct efi_embedded_fw_desc *fw_desc;
>> +       const struct dmi_system_id *dmi_id;
>> +       efi_memory_desc_t *md;
>> +       int i, r;
>> +
>> +       for (i = 0; embedded_fw_table[i]; i++) {
>> +               dmi_id = dmi_first_match(embedded_fw_table[i]);
>> +               if (!dmi_id)
>> +                       continue;
>> +
>> +               fw_desc = dmi_id->driver_data;
>> +
>> +               /*
>> +                * In some drivers the struct driver_data contains may contain
>> +                * other driver specific data after the fw_desc struct; and
>> +                * the fw_desc struct itself may be empty, skip these.
>> +                */
>> +               if (!fw_desc->name)
>> +                       continue;
>> +
>> +               for_each_efi_memory_desc(md) {
>> +                       if (md->type != EFI_BOOT_SERVICES_CODE)
>> +                               continue;
>> +
>> +                       r = efi_check_md_for_embedded_firmware(md, fw_desc);
>> +                       if (r == 0)
>> +                               break;
>> +               }
>> +       }
>> +
>> +       checked_for_fw = true;
>> +}
> 
> Have you measured how long this takes on a typical system per matching DMI id?

I originally wrote this approx. 18 months ago, it has been on hold for a while
since it needed a sha256 method which would work before subsys_initcall-s
run so I couldn't use the standard crypto_alloc_shash() stuff. In the end
I ended up merging the duplicate purgatory and crypto/sha256_generic.c
generic C SHA256 implementation into a set of new directly callable lib
functions in lib/crypto/sha256.c, just so that I could move forward with
this...

Anyways the reason for this background info is that because this is a while
ago I do not remember exactly how, but yes I did measure this (but not
very scientifically) and there was no discernible difference in boot
to init (from the initrd) with this in place vs without this.

>> +
>> +int efi_get_embedded_fw(const char *name, void **data, size_t *size)
>> +{
>> +       struct efi_embedded_fw *iter, *fw = NULL;
>> +       void *buf = *data;
>> +
>> +       if (!checked_for_fw) {
> 
> WARN_ON_ONCE?  A stack dump would be quite nice here.

As discussed when this check was added (discussion in v7 of
the set I guess, check added in v8) we can also hit this without
it being a bug, e.g. when booted through kexec the whole
efi_check_for_embedded_firmwares() call we be skipped, hence the
pr_warn.


>> +       buf = vmalloc(fw->length);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       memcpy(buf, fw->data, fw->length);
>> +       *size = fw->length;
>> +       *data = buf;
> 
> See above.  What's vmalloc() for?  Where's the vfree()?

See above for my answer. I'm fine with moving this into the
firmware code, since that is where the matching vfree is, please
let me know how you want to proceed with this.

> BTW, it would be very nice to have a straightforward way
> (/sys/kernel/debug/efi_firmware/[name]?) to dump all found firmwares.

That is an interesting idea, we could add a subsys_init call or
some such to add this to debugfs (efi_check_for_embedded_firmwares runs
too early).

But given how long this patch-set has been in the making I would really
like to get this (or at least the first 2 patches as a start) upstream,
so for now I would like to keep the changes to a minimum. Are you ok
with me adding the debugfs support with a follow-up patch ?

Let me also reply to your summary comment elsewhere in the thread here:

 > Early in boot, you check a bunch of firmware descriptors, bundled with
 > drivers, to search EFI code and data for firmware before you free said
 > code and data.  You catalogue it by name.  Later on, you use this list
 > as a fallback, again catalogued by name.  I think it would be rather
 > nicer if you simply had a list in a single file containing all these
 > descriptors rather than commingling it with the driver's internal dmi
 > data.  This gets rid of all the ifdeffery and module issues.  It also
 > avoids any potential nastiness when you have a dmi entry that contains
 > driver_data that points into the driver when the driver is a module.
 >
 > And you can mark the entire list __initdata.  And you can easily (now
 > or later on) invert the code flow so you map each EFI region exactly
 > once and then search for all the firmware in it.

I believe we have mostly discussed this above. At least for the
X86 touchscreen case, which is the only user of this for now, I
believe that re-using the table from drivers/platform/x86/touchscreen_dmi.c
is better as it avoids duplication of DMI strings and it keeps all
the info in one place (also avoiding churn in 2 files / 2 different
trees when new models are added).

I agree that when looking at this as a generic mechanism which may be
used elsewhere, your suggestion makes a lot of sense. But even though
this is very much written so that it can be used as a generic mechanism
I'm not sure if other users will appear. So for now, with only the X86
touchscreen use-case actually using this I believe the current
implementation is best, but I'm definitely open to changing this around
if more users show up.

Regards,

Hans

