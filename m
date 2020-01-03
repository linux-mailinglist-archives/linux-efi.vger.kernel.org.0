Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA01A12F761
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgACLgT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:36:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39784 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgACLgS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jan 2020 06:36:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so8299015wmj.4
        for <linux-efi@vger.kernel.org>; Fri, 03 Jan 2020 03:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7DT90yNYzpotuhZbO7YzjctV3QDX926/xXbSOdOjQY=;
        b=ZBaIyouJ0qA70SM7p5DyerQa2uQWgDtJhC4GbSx0hOsI/TDxuRvkxLeM/Gjh4+t5BD
         8mLL88na5LlyM+Ru9ClkIF5V49bhZwiyL/B6iVR0HZkRuCVGXbUNp29rm56yXDXGXn1L
         hsY2+qw9x8qVEtcjCKfRG7L2odRQTpMZ99hFiBshe/fli1jftchSUwVU5ao7NcjChP0g
         QFYGSRUMT8eUf5VgN0lNextSA2ZWGhhUZ5g7aApgoes0q0yvjzWNeE1KhdkRM5Qcr3XQ
         uxxCr8ik6WFbMku8P4ydKLZE9RHbiD+Od7OgjiflWZbAiaIfXkNNHX5W6M4PUjo1ZjYV
         TF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7DT90yNYzpotuhZbO7YzjctV3QDX926/xXbSOdOjQY=;
        b=BUE/oG8PUbKi1kwllAf5Wc++azFPKLzTT9at1TIOI1v/tvDChGBs21g+CmctzOONe5
         O+wXy38O4lwjV81A3Ab1t7TiOTyAkqM9Mp7AkZAC54d+6zHKNPUSehG5RCYX6GJNnwyB
         oiSX/Ltpn+saZq7H2AQspzATV/4xwfPLvcMopoDVkrprC/r9TTj11QkAORAc7zFbI3Pb
         mLz8avNElEeaeDhHGRgw1CI/YRQIpo5ICx2meK1C7CNtCLt1n+E9Wu7WQFeW29AjKMVx
         enu6VxsCboKdf83Wy/A4hntStEXyzS3WqMDAmSvo9ntk8JyF0Cxs9jQJ5DSsJvzH73jj
         17uQ==
X-Gm-Message-State: APjAAAUj/My4TDo1yt584/UcHCHx1Wk0kYsgJCFguhNriXvWN1XFVaIF
        9Ipu8L9XAyHKxIkwqntyXUqsLKexciDRK4H2JzxbQw==
X-Google-Smtp-Source: APXvYqydiWnwY4UHWadUrF7IJW2FmFX3+OirWMWypHZ7Si7pbMd/pNtvurx2xKUHmEQ4etOr9y6r2vkU3Mpz1OxIG8Q=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr18546289wma.95.1578051375492;
 Fri, 03 Jan 2020 03:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20191210115117.303935-1-hdegoede@redhat.com> <66f45932-756d-0bb0-d7a8-330d61785663@redhat.com>
In-Reply-To: <66f45932-756d-0bb0-d7a8-330d61785663@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Jan 2020 12:36:04 +0100
Message-ID: <CAKv+Gu_X+UM95MJJMjT69upL9zN3H9BnUkv8s9TjcpevANbYEw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] efi/firmware/platform-x86: Add EFI embedded fw support
To:     Hans de Goede <hdegoede@redhat.com>, Ingo Molnar <mingo@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Jan 2020 at 12:27, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Since I send this out, efi-next has seen some changes causing the first
> 2 patches to no longer cleanly apply. So it looks like we need to
> merge this one bit at a time with immutable branches.
>
> Ard, the first 2 patches in this series should be merged through your
> efi tree. AFAIK everyone is happy with them in their current state
> so they are ready for merging. Can you create an immutable branch
> with these 2 patches and merge that into your efi-next branch?
>
> Note if you do the immutable branch on 5.5-rc1 + just these 2 patches,
> there will be a conflict when you merge this into efi-next, but it is
> trivial to resolve.
>

I will need to defer to Ingo here, as he usually applies the EFI
changes piecemeal rather than merging my branches directly.

I'd be fine with just annotating the conflict in the pull request if
it is trivial, though, but it is really up to Luis and Ingo to align
here.

Note that I was just about to send out a PR for the second batch of
EFI changes, but there will be more this cycle in any case.



> Luis, the rest of the series is almost ready for merging, it just needs
> your review of the 2 new patches (patch 5 and 6) adding the selftests for
> the new firmware_request_platform api, if you can review those that would
> be great.
>
> Regards,
>
> Hans
>
>
>
> On 10-12-2019 12:51, Hans de Goede wrote:
> > Hi All,
> >
> > Here is v10 of my patch-set to add support for EFI embedded fw to the
> > kernel. This version has been rebased on top 5.5-rc1 to fix 2 conflicts
> > with the first 2 (efi) patches in the series. There are no changes
> > versus v9 other then the rebase.
> >
> > Below is the cover-letter of v9:
> >
> > The main new feature in this version is the addition of some selftests for
> > the new firmware_request_platform api (patch 5 and 6, both new). My plan
> > was to send the patches adding the selftests out as a follow up series.
> >
> > But during unrelated testing of my personal tree I found a small but nasty
> > bug in the "efi: Add embedded peripheral firmware support" patch, the minor
> > refactoring done in v8 exposed a bug which causes a hard crash on boot for
> > devices which have a DMI match in the touchscreen_dmi_table but do not use
> > EFI-embedded fw, this is fixed in this new version.
> >
> > Assuming the 2 new patches adding the selftests are ok, I believe that
> > this series is ready for merging now.  I believe it would be best to merge
> > patches 1-8 through Greg's driver-core tree where firmware-loader changes go.
> > The non firmware patches already have Acked-by-s from the maintainers of
> > the EFI/input trees.
> >
> > Patches 9-10 touch a quirks file under drivers/platform/x86 which sees
> > multipe updates each cycle. So my proposal is that once 1-8 has landed
> > Greg creates an immutable branch with those changes and then
> > Andy and/or Darren can merge in that branch and then apply 9 and 10.
> >
> > Regards,
> >
> > Hans
> >
> >
> > Changes in v10:
> > - Rebase on top of 5.5-rc1
> >
> > Changes in v9:
> > - Add 2 new patches adding selftests
> > - At least touchscreen_dmi.c uses the same dmi_table for its own private
> >    data and the fw_desc structs, putting the fw_desc struct first in the
> >    data driver_data points to so that the dmi_table can be shared with
> >    efi_check_for_embedded_firmwares(). But not all entries there have
> >    embedded-fw so in some cases the fw_desc is empty (zero-ed out).
> >    This can lead to a possible crash because fw_desc->length now is
> >    less then 8, so if the segment size is close enough to a multiple of the
> >    page_size, then the memcmp to check the prefix my segfault. Crashing the
> >    machine. v9 checks for and skips these empty fw_desc entries avoiding this.
> > - Add static inline wrapper for firmware_request_platform() to firmware.h,
> >    for when CONFIG_FW_LOADER is not set
> >
> > Changes in v8:
> > - Add pr_warn if there are mode then EFI_DEBUGFS_MAX_BLOBS boot service segments
> > - Document how the EFI debugfs boot_service_code? files can be used to check for
> >    embedded firmware
> > - Properly deal with the case of an EFI segment being smaller then the fw we
> >    are looking for
> > - Log a warning when efi_get_embedded_fw get called while we did not (yet)
> >    check for embedded firmwares
> > - Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defined,
> >    otherwise make firmware_fallback_platform() a static inline stub
> >
> > Changes in v7:
> > - Split drivers/firmware/efi and drivers/base/firmware_loader changes into
> >    2 patches
> > - Use new, standalone, lib/crypto/sha256.c code
> > - Address kdoc comments from Randy Dunlap
> > - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
> >    _request_firmware() wrapper, as requested by Luis R. Rodriguez
> > - Stop using "efi-embedded-firmware" device-property, now that drivers need to
> >    use the new firmware_request_platform() to enable fallback to a device fw
> >    copy embedded in the platform's main firmware, we no longer need a property
> >    on the device to trigger this behavior
> > - Use security_kernel_load_data instead of calling
> >    security_kernel_read_file with a NULL file pointer argument
> > - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
> > - Document the new firmware_request_platform() function in
> >    Documentation/driver-api/firmware/request_firmware.rst
> > - Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
> >    to use the new firmware_request_platform() method
> > - Rebased on top of 5.4-rc1
> >
> > Changes in v6:
> > -Rework code to remove casts from if (prefix == mem) comparison
> > -Use SHA256 hashes instead of crc32 sums
> > -Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
> > -Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
> >   to check if this is allowed before looking at EFI embedded fw
> > -Document why we are not using the PI Firmware Volume protocol
> >
> > Changes in v5:
> > -Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
> >
> > Changes in v4:
> > -Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
> >   UEFI proper, so the EFI maintainers don't want us referring people to it
> > -Use new EFI_BOOT_SERVICES flag
> > -Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
> >   file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
> > -Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
> >   EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
> >   in firmware_loader/main.c
> > -Properly call security_kernel_post_read_file() on the firmware returned
> >   by efi_get_embedded_fw() to make sure that we are allowed to use it
> >
> > Changes in v2:
> > -Rebased on driver-core/driver-core-next
> > -Add documentation describing the EFI embedded firmware mechanism to:
> >   Documentation/driver-api/firmware/request_firmware.rst
> > -Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
> >   fw support if this is set. This is an invisible option which should be
> >   selected by drivers which need this
> > -Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
> >   from the efi-embedded-fw code, instead drivers using this are expected to
> >   export a dmi_system_id array, with each entries' driver_data pointing to a
> >   efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
> > -Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
> >   this avoids us messing with the EFI memmap and avoids the need to make
> >   changes to efi_mem_desc_lookup()
> > -Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
> >   passed in device has the "efi-embedded-firmware" device-property bool set
> > -Skip usermodehelper fallback when "efi-embedded-firmware" device-property
> >   is set
> >
> >
>
