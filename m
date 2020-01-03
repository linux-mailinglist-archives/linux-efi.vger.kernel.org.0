Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51B212F735
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgACL1j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:27:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727453AbgACL1i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jan 2020 06:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578050856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKOOwHs2ZDIRxWjWlTFCn8p7FYAVgQaVXWf4ImCfYuo=;
        b=enI2VYUGfJ7wpSqc/gAvmfK93kmJPjWqawxUo8N/uD/Sg0VFFLezEwsWBXtE+83k5HocSr
        KSHiMKMySaUsoaeVQ19d11CPpjr25cdHsX9UPQdjg4/MtV7lPOfGZ+h4/YMcAPPjzwm/cj
        V8VRbFkYq4KptT5h9zj/P4OlbTJQ77o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-n5saVHL1P0qyirIA0ndOhg-1; Fri, 03 Jan 2020 06:27:35 -0500
X-MC-Unique: n5saVHL1P0qyirIA0ndOhg-1
Received: by mail-wr1-f72.google.com with SMTP id k18so21943369wrw.9
        for <linux-efi@vger.kernel.org>; Fri, 03 Jan 2020 03:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKOOwHs2ZDIRxWjWlTFCn8p7FYAVgQaVXWf4ImCfYuo=;
        b=PRZQtktmCH9dud5YOH3bkbFNPnLC8a0cg2J9R6EeZCIYTg4A0W+q7Fj5sUH2KSnIk6
         CJjghOev1TnDEb6TfmDWx6Td3LA5kUOwwjoJfPx7EpdxCkuvlBG2CE5eR15mXA0Ft2WA
         wTHzzT4mztMwtdJLureuzDtmv67sl7IRAJRmGEgmnk4lYmocZ5RjRW2X+qes+YHUazuV
         e3h74WsHrd8Gh3zIlY9oBTVesFTj++b3f5zra+U1UsVTyE+W8GrEm4q6mPVU1WH7/e6C
         P38ojg5G/xrLAEexfhiv24l56LelENbdExKC/mJs8/pKzbQwWC2A6goRIeybDvQsS7/9
         f5XA==
X-Gm-Message-State: APjAAAX5bUv0OLXNc1u93XvGhgwG6DFC2ho8nwg0DnJPiVEQkKfVKYkH
        vPCHpOHCZOs4D50uo+7xthlfBCMjRuJ24yT3YGylgNCnYzWr5otFgBVFAf7JQAd3ibsFTPJ6jw7
        JWfoRMxJII2QyHE5A13zt
X-Received: by 2002:a1c:a406:: with SMTP id n6mr19221990wme.40.1578050853991;
        Fri, 03 Jan 2020 03:27:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZFNItZbvteC2IYwnmx0jlBP0nRcHjtSlcxUvpNI4Px9I2AyLJtHNp/+ME2brZ+/LsbjnDSw==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr19221951wme.40.1578050853665;
        Fri, 03 Jan 2020 03:27:33 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id h8sm62312534wrx.63.2020.01.03.03.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 03:27:32 -0800 (PST)
Subject: Re: [PATCH v10 00/10] efi/firmware/platform-x86: Add EFI embedded fw
 support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-input@vger.kernel.org
References: <20191210115117.303935-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <66f45932-756d-0bb0-d7a8-330d61785663@redhat.com>
Date:   Fri, 3 Jan 2020 12:27:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191210115117.303935-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Since I send this out, efi-next has seen some changes causing the first
2 patches to no longer cleanly apply. So it looks like we need to
merge this one bit at a time with immutable branches.

Ard, the first 2 patches in this series should be merged through your
efi tree. AFAIK everyone is happy with them in their current state
so they are ready for merging. Can you create an immutable branch
with these 2 patches and merge that into your efi-next branch?

Note if you do the immutable branch on 5.5-rc1 + just these 2 patches,
there will be a conflict when you merge this into efi-next, but it is
trivial to resolve.

Luis, the rest of the series is almost ready for merging, it just needs
your review of the 2 new patches (patch 5 and 6) adding the selftests for
the new firmware_request_platform api, if you can review those that would
be great.

Regards,

Hans



On 10-12-2019 12:51, Hans de Goede wrote:
> Hi All,
> 
> Here is v10 of my patch-set to add support for EFI embedded fw to the
> kernel. This version has been rebased on top 5.5-rc1 to fix 2 conflicts
> with the first 2 (efi) patches in the series. There are no changes
> versus v9 other then the rebase.
> 
> Below is the cover-letter of v9:
> 
> The main new feature in this version is the addition of some selftests for
> the new firmware_request_platform api (patch 5 and 6, both new). My plan
> was to send the patches adding the selftests out as a follow up series.
> 
> But during unrelated testing of my personal tree I found a small but nasty
> bug in the "efi: Add embedded peripheral firmware support" patch, the minor
> refactoring done in v8 exposed a bug which causes a hard crash on boot for
> devices which have a DMI match in the touchscreen_dmi_table but do not use
> EFI-embedded fw, this is fixed in this new version.
> 
> Assuming the 2 new patches adding the selftests are ok, I believe that
> this series is ready for merging now.  I believe it would be best to merge
> patches 1-8 through Greg's driver-core tree where firmware-loader changes go.
> The non firmware patches already have Acked-by-s from the maintainers of
> the EFI/input trees.
> 
> Patches 9-10 touch a quirks file under drivers/platform/x86 which sees
> multipe updates each cycle. So my proposal is that once 1-8 has landed
> Greg creates an immutable branch with those changes and then
> Andy and/or Darren can merge in that branch and then apply 9 and 10.
> 
> Regards,
> 
> Hans
> 
> 
> Changes in v10:
> - Rebase on top of 5.5-rc1
> 
> Changes in v9:
> - Add 2 new patches adding selftests
> - At least touchscreen_dmi.c uses the same dmi_table for its own private
>    data and the fw_desc structs, putting the fw_desc struct first in the
>    data driver_data points to so that the dmi_table can be shared with
>    efi_check_for_embedded_firmwares(). But not all entries there have
>    embedded-fw so in some cases the fw_desc is empty (zero-ed out).
>    This can lead to a possible crash because fw_desc->length now is
>    less then 8, so if the segment size is close enough to a multiple of the
>    page_size, then the memcmp to check the prefix my segfault. Crashing the
>    machine. v9 checks for and skips these empty fw_desc entries avoiding this.
> - Add static inline wrapper for firmware_request_platform() to firmware.h,
>    for when CONFIG_FW_LOADER is not set
> 
> Changes in v8:
> - Add pr_warn if there are mode then EFI_DEBUGFS_MAX_BLOBS boot service segments
> - Document how the EFI debugfs boot_service_code? files can be used to check for
>    embedded firmware
> - Properly deal with the case of an EFI segment being smaller then the fw we
>    are looking for
> - Log a warning when efi_get_embedded_fw get called while we did not (yet)
>    check for embedded firmwares
> - Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defined,
>    otherwise make firmware_fallback_platform() a static inline stub
> 
> Changes in v7:
> - Split drivers/firmware/efi and drivers/base/firmware_loader changes into
>    2 patches
> - Use new, standalone, lib/crypto/sha256.c code
> - Address kdoc comments from Randy Dunlap
> - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
>    _request_firmware() wrapper, as requested by Luis R. Rodriguez
> - Stop using "efi-embedded-firmware" device-property, now that drivers need to
>    use the new firmware_request_platform() to enable fallback to a device fw
>    copy embedded in the platform's main firmware, we no longer need a property
>    on the device to trigger this behavior
> - Use security_kernel_load_data instead of calling
>    security_kernel_read_file with a NULL file pointer argument
> - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
> - Document the new firmware_request_platform() function in
>    Documentation/driver-api/firmware/request_firmware.rst
> - Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
>    to use the new firmware_request_platform() method
> - Rebased on top of 5.4-rc1
> 
> Changes in v6:
> -Rework code to remove casts from if (prefix == mem) comparison
> -Use SHA256 hashes instead of crc32 sums
> -Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
> -Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
>   to check if this is allowed before looking at EFI embedded fw
> -Document why we are not using the PI Firmware Volume protocol
> 
> Changes in v5:
> -Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
> 
> Changes in v4:
> -Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
>   UEFI proper, so the EFI maintainers don't want us referring people to it
> -Use new EFI_BOOT_SERVICES flag
> -Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
>   file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
> -Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
>   EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
>   in firmware_loader/main.c
> -Properly call security_kernel_post_read_file() on the firmware returned
>   by efi_get_embedded_fw() to make sure that we are allowed to use it
> 
> Changes in v2:
> -Rebased on driver-core/driver-core-next
> -Add documentation describing the EFI embedded firmware mechanism to:
>   Documentation/driver-api/firmware/request_firmware.rst
> -Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
>   fw support if this is set. This is an invisible option which should be
>   selected by drivers which need this
> -Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
>   from the efi-embedded-fw code, instead drivers using this are expected to
>   export a dmi_system_id array, with each entries' driver_data pointing to a
>   efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
> -Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
>   this avoids us messing with the EFI memmap and avoids the need to make
>   changes to efi_mem_desc_lookup()
> -Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
>   passed in device has the "efi-embedded-firmware" device-property bool set
> -Skip usermodehelper fallback when "efi-embedded-firmware" device-property
>   is set
> 
> 

