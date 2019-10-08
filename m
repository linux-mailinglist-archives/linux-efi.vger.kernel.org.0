Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53F7CF61F
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfJHJfh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 05:35:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfJHJff (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Oct 2019 05:35:35 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D246C054C52
        for <linux-efi@vger.kernel.org>; Tue,  8 Oct 2019 09:35:34 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so1120549wmb.7
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2019 02:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYQbtKBKne4ecHd8MqLNXHTzN59LTiSeMUIzD+b26dM=;
        b=YqDyZuNNCqgzFxERzhT78AhsO8XFc4ZXYNsexGdjd2+6IAPd+Xy6RrBc5UL4dhotDC
         bfyJpKUaIGpzzKkzVIf88PV1XASiDXMwnw6StPsOpgxw1cTfMrOsjBZOaGZSEP2jItVC
         VjnRr8k4eiVGv0QH1AB4zX5swaXixBHQEh21LU19WHRVPDLxmqRVy72OKLvSmMRW9uos
         4MHXCRWVFnfTuT5pzHANibe3muZLqV0kOPiFBFE01OAz6HQUj5h0E7v91QEP+d/KuPov
         6d4OS3u1hfvVlpV8xxELTN/rDRFiWn6XCp+VCQ+cpYGlJU31nRUm2gE9ZfNuE1VIB8Ps
         /DIQ==
X-Gm-Message-State: APjAAAVSS9W2S3K/mrMgxfncF2I29xH+R/rWQsimLlOXtTneVpMP8iQQ
        zDhI3xtkeAtSiWm+L+LRBWltAOFuvRYPwgJRA7pNPW5n1WryGbEBiomG8UNzzvFHv+qpKQghHMw
        I5V31IMnrOktThI+B86c8
X-Received: by 2002:a7b:c451:: with SMTP id l17mr2713223wmi.61.1570527332839;
        Tue, 08 Oct 2019 02:35:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyg+uc8leCI2/IjSBHH3vY6BjPvvbk0gliL/w1NrUe4xAquHPZi8D64XZFB7Cim1pCgaatxog==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr2713195wmi.61.1570527332337;
        Tue, 08 Oct 2019 02:35:32 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id g1sm17657184wrv.68.2019.10.08.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 02:35:31 -0700 (PDT)
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191007141956.GA25347@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c7f1678f-ff03-1c3a-02e3-a68025b87969@redhat.com>
Date:   Tue, 8 Oct 2019 11:35:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007141956.GA25347@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ingo,

On 07-10-2019 16:19, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi All,
>>
>> Here is v7 of my patch-set to add support for EFI embedded fw to the kernel.
>>
>> v6 was posted a long time ago, around the 4.18 days. The long wait was for
>> a suitable secure-hash for checking the firmware we find embedded in the EFI
>> is the one we expect.
>>
>> With 5.4-rc1 we finally have a standalone sha256 lib, so that hurdle for
>> this patch-set is now gone.
>>
>> I've tried to address all review-remarks against v6 in this new version:
>>
>> Changes in v7:
>> - Split drivers/firmware/efi and drivers/base/firmware_loader changes into
>>    2 patches
>> - Use new, standalone, lib/crypto/sha256.c code
>> - Address kdoc comments from Randy Dunlap
>> - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
>>    _request_firmware() wrapper, as requested by Luis R. Rodriguez
>> - Stop using "efi-embedded-firmware" device-property, now that drivers need to
>>    use the new firmware_request_platform() to enable fallback to a device fw
>>    copy embedded in the platform's main firmware, we no longer need a property
>>    on the device to trigger this behavior
>> - Use security_kernel_load_data instead of calling
>>    security_kernel_read_file with a NULL file pointer argument
>> - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
>> - Document the new firmware_request_platform() function in
>>    Documentation/driver-api/firmware/request_firmware.rst
>> - Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
>>    to use the new firmware_request_platform() method
>> - Rebased on top of 5.4-rc1
>>
>> I guess this will probably need another round (or two) of review + fixing,
>> but eventually this can hopefully be merged. Since this touches a bunch
>> of different subsystems the question is how to merge this? Most of the
>> touched files outside of the firmware-loader code do not see a lot of
>> churn, so my proposal would be to merge patches 1-6 through the tree
>> which carries firmware-loader changes; and then provide an immutable
>> branch for the platform/x86 maintainers to merge and then they can merge
>> the last 2 patches (as the touchscreen_dmi.c file does see quite a bit
>> of changes every release).
> 
> So I was looking for a high level 0/ boilerplate description of this
> series, to explain what "EFI embedded fw" is, what problems it solves and
> how it helps the kernel in general - and found this in 2/8:

Sorry you had to dig into the individual patch changelogs for that
I sorta assumed that everyone involved would still vaguely remember
what this series is about.

>>> Just like with PCI options ROMs, which we save in the setup_efi_pci*
>>> functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itself
>>> sometimes may contain data which is useful/necessary for peripheral drivers
>>> to have access to.
>>>
>>> Specifically the EFI code may contain an embedded copy of firmware which
>>> needs to be (re)loaded into the peripheral. Normally such firmware would be
>>> part of linux-firmware, but in some cases this is not feasible, for 2
>>> reasons:
>>>
>>> 1) The firmware is customized for a specific use-case of the chipset / use
>>> with a specific hardware model, so we cannot have a single firmware file
>>> for the chipset. E.g. touchscreen controller firmwares are compiled
>>> specifically for the hardware model they are used with, as they are
>>> calibrated for a specific model digitizer.
>>>
>>> 2) Despite repeated attempts we have failed to get permission to
>>> redistribute the firmware. This is especially a problem with customized
>>> firmwares, these get created by the chip vendor for a specific ODM and the
>>> copyright may partially belong with the ODM, so the chip vendor cannot
>>> give a blanket permission to distribute these.
>>>
>>> This commit adds support for finding peripheral firmware embedded in the
>>> EFI code and makes the found firmware available through the new
>>> efi_get_embedded_fw() function.
>>>
>>> Support for loading these firmwares through the standard firmware loading
>>> mechanism is added in a follow-up commit in this patch-series.
>>>
>>> Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the end
>>> of start_kernel(), just before calling rest_init(), this is on purpose
>>> because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large for
>>> early_memremap(), so the check must be done after mm_init(). This relies
>>> on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services()
>>> is called, which means that this will only work on x86 for now.
>>>
>>> Reported-by: Dave Olsthoorn <dave@bewaar.me>
>>> Suggested-by: Peter Jones <pjones@redhat.com>
>>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> There's also patch #3, which explains how this is used:
> 
>>> This commit adds a new platform fallback mechanism to the firmware loader
>>> which will try to lookup a device fw copy embedded in the platform's main
>>> firmware if direct filesystem lookup fails.
>>>
>>> Drivers which need such embedded fw copies can enable this fallback
>>> mechanism by using the new firmware_request_platform() function.
>>>
>>> Note that for now this is only supported on EFI platforms and even on
>>> these platforms firmware_fallback_platform() only works if
>>> CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
>>> which need this), in all other cases firmware_fallback_platform() simply
>>> always returns -ENOENT.
> 
> Plus there's 3 patches that opt in three drivers to this new EFI-firmware
> loading mechanism, right?

There is 1 pseudo driver drivers/platform/touchscreen_dmi.c which provides
info which under Windows is hardcoded in device-model specific drivers to
the touchscreen drivers as device-properties.

This pseudo driver is modified to provide the info which
drivers/firmware/efi/embedded-firmware.c needs to find the firmware,
so that we keep the per-model info in 1 file.

Then 2 normal touchscreen drivers are modified to opt-in into the
new EFI-firmware loading mechanism.

> A couple of high level questions:
> 
> - How common are these kinds of firmware files that should be loaded into
>    the device by the OS device driver? Common? Or 1% of systems? 0.1% of
>    systems? 0.0001%?

This whole thing is a clever hack to get around us being unable to get
redistribution permission for (touchscreen) firmwares where the chip vendor
says the firmware is model specific so part of the copyright lays with the
odm/oem and we should talk to them (the odm) and the odm/oem points back
to the chip vendor...

Windows does not get the firmware from the UEFI copy, the windows driver
is model specific. The windows driver is part of the os-image the device ships
with and you are in trouble if you loose the driver. This windows driver
has its own embedded copy of the model specific touchscreen firmware
(oh if only they had put said firmware in some nvram on the chip).

In some cases, mostly on Intel Cherry Trail based tablets, which are
cheap and thus use the cheapest touchscreens which have this problem,
the UEFI contains a "mouse" driver which has a copy, which is what this
patch set adds support for to get around the not being able to distribute
problem.

As such this is not really common, still there are a lot of those cheap
Cherry Trail tablets and new ones are still being manufactured. One of the
reasons I'm spending time on making these work 100% OOTB is to get around
the standard Linux sucks at tablets because desktop devs have no tablet
hw to develop a tablet ui on issue.

I also have tried to make the mechanism generic since I guess it might
become in handy for some other scenarios in the future.

Putting a number on this is hard. I do know several members of my
local hackerspace have such tablets since they are cheap and it is nice
to play around with Linux on them. I would guess a number would be between
1% and 0.1%, but I may be way off.

> - Can there be a situation where linux-firmware already includes an older
>    copy of the firmware, and the EFI firmware has a newer version? If this
>    can plausibly happen, shouldn't the fallback mechanism do some sort of
>    version check (if that's possible), and load the newer version?

I would assume that if we can get distribution permission we will also
be able to update the linux-firmware version later. So atm I'm not worried
about this scenario.

> - I'm worried about the explicit opt-in nature of these firmware files -
>    the OS driver has to be explicitly aware of this possibility. Shouldn't
>    we at minimum have some sort of boot time check to see whether a device
>    has an embedded fw blob, and warn the user if we don't actually load
>    it? Which would generate some gentle pressure to fix our drivers?

The way this works is that drivers/firmware/efi/embedded-firmware.c
only checks for firmwares listed in its embedded_fw_table[]. Entries in
this table need to be manually added. We basically do a brute-force
search of the EFI_BOOT_SERVICES_CODE segments looking for a magic prefix
and then checking for a known SHA256 sum. This is triggered by a DMI
match to avoid slowing the boot with the search on other devices
(UEFI has no standard way to get embedded firmware copies out of it).

I would assume someone going through the trouble to add an entry
to embedded_fw_table[] to also check that things work without a copy
in /lib/firmware.

So the scenario of a new entry showing up, without the matching driver
getting modified is somewhat unlikely. At the same time the firmware-loader
people want to avoid changing the fw-load code paths for all drivers, for
something which so far is used by only very few drivers.

> - I think the config option should be default-y, because AFAICS this
>    mechanism makes broken drivers/devices work.

It is a hidden option and drivers which need this already select it in
this patch-set.

> - Finally, is there any question of trust or a potential for other
>    security pitfalls here, where we'd trust linux-firmware over what the
>    EFI firmware says is the proper firmware for a device? My default
>    assumption would be that we are exposed to the EFI firmware anyway, and
>    it comes with the hardware just like the devices come with the
>    hardware, so we can generally trust it. But I might be missing
>    something. If there's any plausible question of trust (for example can
>    attackers hide rooted firmware in the EFI image, without triggering
>    filesystem integrity checks on the regular filesystem side?) then it
>    might make sense to offer a boot parameter to disable this, beyond the
>    config parameter.

You are right that we are exposed to the EFI firmware anyway on top we
only load embedded firmwares with a known SHA256 and so far the firmware
only gets used for touchscreen controllers which cannot do DMA.

So all in all I am not concerned about security. An attacker would need
to be able to write EFI_BOOT_SERVICES_CODE segments, yet not be able to
find a better attack vector then this; and he would need to be able to
fake an expected SHA256 sum on a Trojan firmware payload, which all
is quite unlikely.

Regards,

Hans
