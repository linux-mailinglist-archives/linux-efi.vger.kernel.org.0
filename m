Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E7141217
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jan 2020 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQUGS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jan 2020 15:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgAQUGS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 17 Jan 2020 15:06:18 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4689C22464
        for <linux-efi@vger.kernel.org>; Fri, 17 Jan 2020 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579291577;
        bh=zlUQicqWtn1RliknLWKWm7sEYt4NefZp0gNvmqIw488=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m6E0EVKs8qpGyynmy9WDYQ7jWJqUVJwVidknDV0iJ/oQxv01EU1jIPUxZjB7PZa+m
         aV+Rampx/QrhVr+cwCJs8vmxk3ddOtiPWQV0XXH3GWf1imiuaMmi9DDiQwfYHi5Ews
         TkyHmE8LrwXlPOsYR/TgrLhFUe0Nc1As1QaUkLm8=
Received: by mail-wm1-f50.google.com with SMTP id w5so10198237wmi.1
        for <linux-efi@vger.kernel.org>; Fri, 17 Jan 2020 12:06:17 -0800 (PST)
X-Gm-Message-State: APjAAAUWRuWpPgXRINYW2HRdxTT5zW0cpSV+4KA3wjkzE6c6O6oQDcBl
        LiiWmPxuI1Z3Asuct92g8A3yy+PErCjWA06Ukd/58g==
X-Google-Smtp-Source: APXvYqwawazLywdb2Oy7uHqxVHomoEfaLVG4a9tdL505slD/JJ9wZrwPXYXJ1YNzKwmPFG5/lnC3TIoyyBJheNygp/U=
X-Received: by 2002:a7b:c957:: with SMTP id i23mr6570340wml.49.1579291575471;
 Fri, 17 Jan 2020 12:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20200111145703.533809-1-hdegoede@redhat.com> <20200111145703.533809-3-hdegoede@redhat.com>
 <CALCETrUz4gdVOH=5X+MkB56ST=DNcHKicRST1j1ff0kU1yXWzw@mail.gmail.com> <9b5b8304-74bc-4e5c-5030-98bd6e12eaf0@redhat.com>
In-Reply-To: <9b5b8304-74bc-4e5c-5030-98bd6e12eaf0@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Jan 2020 12:06:03 -0800
X-Gmail-Original-Message-ID: <CALCETrWtf3iEdZS8zu=k60cnZtokbxRaH5dfkWoM7JokkhAL2w@mail.gmail.com>
Message-ID: <CALCETrWtf3iEdZS8zu=k60cnZtokbxRaH5dfkWoM7JokkhAL2w@mail.gmail.com>
Subject: Re: [PATCH v11 02/10] efi: Add embedded peripheral firmware support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> On Jan 14, 2020, at 4:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>
> =EF=BB=BFHi Andy,
>

> Even if we get more use of this the chances of 1 device model using
> more then 1 embedded fw are small. Where as if we first map the
> EFI_BOOT_SERVICES_CODE segment before doing the DMI match then we
> do this for all EFI_BOOT_SERVICES_CODE segments on all hardware.
> The current implementation is very much optimized to do as little
> work as possible when there is no DMI match, which will be true
> on almost all devices out there.

Fine with me.


> If we hit firmware which is not 8 byte aligned, then yes that would be
> a good idea, but for now I feel that that would just cause a slowdown
> in the scanning without any benefits.
>

It would shorten the code and remove a comment :). Also, a good memmem
implementation should be very fast, potentially faster than your loop.
I suspect the latter is only true in user code where SSE would get
used, but still.

it would also be unfortunate if some firmware update switches to
4-byte alignment and touchscreens stop working with no explanation.


>>> +
>>> +               sha256_init(&sctx);
>>> +               sha256_update(&sctx, map + i, desc->length);
>>> +               sha256_final(&sctx, sha256);
>>> +               if (memcmp(sha256, desc->sha256, 32) =3D=3D 0)
>>> +                       break;
>>> +       }
>>> +       if ((i + desc->length) > size) {
>>> +               memunmap(map);
>>> +               return -ENOENT;
>>> +       }
>>> +
>>> +       pr_info("Found EFI embedded fw '%s'\n", desc->name);
>>> +
>> It might be nice to also log which EFI section it was in?
>
> The EFI sections do not have names, so all I could is log
> the section number which does not really feel useful?
>
>>> +       fw =3D kmalloc(sizeof(*fw), GFP_KERNEL);
>>> +       if (!fw) {
>>> +               memunmap(map);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       fw->data =3D kmemdup(map + i, desc->length, GFP_KERNEL);
>>> +       memunmap(map);
>>> +       if (!fw->data) {
>>> +               kfree(fw);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       fw->name =3D desc->name;
>>> +       fw->length =3D desc->length;
>>> +       list_add(&fw->list, &efi_embedded_fw_list);
>>> +
>> If you actually copy the firmware name instead of just a pointer to
>> it, then you could potentially free the list of EFI firmwares.
>
> If we move to having a separate dmi_system_id table for this then
> that would be true. ATM the dmi_system_id from
> drivers/platform/x86/touchscreen_dmi.c
> is not freed as it is referenced from a bus-notifier.
>
>> Why are you copying the firmware into linear (kmemdup) memory here
>
> The kmemdup is because the EFI_BOOT_SERVICES_CODE section is
> free-ed almost immediately after we run.
>
>> just to copy it to vmalloc space down below...
>
> The vmalloc is because the efi_get_embedded_fw() function is
> a helper for later implementing firmware_Request_platform
> which returns a struct firmware *fw and release_firmware()
> uses vfree() to free the firmware contents.
>
> I guess we could have efi_get_embedded_fw() return an const u8 *
> and have the firmware code do the vmalloc + memcpy but it boils
> down to the same thing.
>
>
>>> +       return 0;
>>> +}
>>> +
>>> +void __init efi_check_for_embedded_firmwares(void)
>>> +{
>>> +       const struct efi_embedded_fw_desc *fw_desc;
>>> +       const struct dmi_system_id *dmi_id;
>>> +       efi_memory_desc_t *md;
>>> +       int i, r;
>>> +
>>> +       for (i =3D 0; embedded_fw_table[i]; i++) {
>>> +               dmi_id =3D dmi_first_match(embedded_fw_table[i]);
>>> +               if (!dmi_id)
>>> +                       continue;
>>> +
>>> +               fw_desc =3D dmi_id->driver_data;
>>> +
>>> +               /*
>>> +                * In some drivers the struct driver_data contains may =
contain
>>> +                * other driver specific data after the fw_desc struct;=
 and
>>> +                * the fw_desc struct itself may be empty, skip these.
>>> +                */
>>> +               if (!fw_desc->name)
>>> +                       continue;
>>> +
>>> +               for_each_efi_memory_desc(md) {
>>> +                       if (md->type !=3D EFI_BOOT_SERVICES_CODE)
>>> +                               continue;
>>> +
>>> +                       r =3D efi_check_md_for_embedded_firmware(md, fw=
_desc);
>>> +                       if (r =3D=3D 0)
>>> +                               break;
>>> +               }
>>> +       }
>>> +
>>> +       checked_for_fw =3D true;
>>> +}
>> Have you measured how long this takes on a typical system per matching D=
MI id?
>
> I originally wrote this approx. 18 months ago, it has been on hold for a =
while
> since it needed a sha256 method which would work before subsys_initcall-s
> run so I couldn't use the standard crypto_alloc_shash() stuff. In the end
> I ended up merging the duplicate purgatory and crypto/sha256_generic.c
> generic C SHA256 implementation into a set of new directly callable lib
> functions in lib/crypto/sha256.c, just so that I could move forward with
> this...
>
> Anyways the reason for this background info is that because this is a whi=
le
> ago I do not remember exactly how, but yes I did measure this (but not
> very scientifically) and there was no discernible difference in boot
> to init (from the initrd) with this in place vs without this.
>
>>> +
>>> +int efi_get_embedded_fw(const char *name, void **data, size_t *size)
>>> +{
>>> +       struct efi_embedded_fw *iter, *fw =3D NULL;
>>> +       void *buf =3D *data;
>>> +
>>> +       if (!checked_for_fw) {
>> WARN_ON_ONCE?  A stack dump would be quite nice here.
>
> As discussed when this check was added (discussion in v7 of
> the set I guess, check added in v8) we can also hit this without
> it being a bug, e.g. when booted through kexec the whole
> efi_check_for_embedded_firmwares() call we be skipped, hence the
> pr_warn.
>
>
>>> +       buf =3D vmalloc(fw->length);
>>> +       if (!buf)
>>> +               return -ENOMEM;
>>> +
>>> +       memcpy(buf, fw->data, fw->length);
>>> +       *size =3D fw->length;
>>> +       *data =3D buf;
>> See above.  What's vmalloc() for?  Where's the vfree()?
>
> See above for my answer. I'm fine with moving this into the
> firmware code, since that is where the matching vfree is, please
> let me know how you want to proceed with this.
>
>> BTW, it would be very nice to have a straightforward way
>> (/sys/kernel/debug/efi_firmware/[name]?) to dump all found firmwares.
>
> That is an interesting idea, we could add a subsys_init call or
> some such to add this to debugfs (efi_check_for_embedded_firmwares runs
> too early).
>
> But given how long this patch-set has been in the making I would really
> like to get this (or at least the first 2 patches as a start) upstream,
> so for now I would like to keep the changes to a minimum. Are you ok
> with me adding the debugfs support with a follow-up patch ?
>
> Let me also reply to your summary comment elsewhere in the thread here:
>
> > Early in boot, you check a bunch of firmware descriptors, bundled with
> > drivers, to search EFI code and data for firmware before you free said
> > code and data.  You catalogue it by name.  Later on, you use this list
> > as a fallback, again catalogued by name.  I think it would be rather
> > nicer if you simply had a list in a single file containing all these
> > descriptors rather than commingling it with the driver's internal dmi
> > data.  This gets rid of all the ifdeffery and module issues.  It also
> > avoids any potential nastiness when you have a dmi entry that contains
> > driver_data that points into the driver when the driver is a module.
> >
> > And you can mark the entire list __initdata.  And you can easily (now
> > or later on) invert the code flow so you map each EFI region exactly
> > once and then search for all the firmware in it.
>
> I believe we have mostly discussed this above. At least for the
> X86 touchscreen case, which is the only user of this for now, I
> believe that re-using the table from drivers/platform/x86/touchscreen_dmi=
.c
> is better as it avoids duplication of DMI strings and it keeps all
> the info in one place (also avoiding churn in 2 files / 2 different
> trees when new models are added).
>
> I agree that when looking at this as a generic mechanism which may be
> used elsewhere, your suggestion makes a lot of sense. But even though
> this is very much written so that it can be used as a generic mechanism
> I'm not sure if other users will appear. So for now, with only the X86
> touchscreen use-case actually using this I believe the current
> implementation is best, but I'm definitely open to changing this around
> if more users show up.
>
> Regards,
>
> Hans
>
