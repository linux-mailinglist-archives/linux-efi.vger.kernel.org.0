Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6240BCE50E
	for <lists+linux-efi@lfdr.de>; Mon,  7 Oct 2019 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfJGOUF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Oct 2019 10:20:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36144 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfJGOUD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Oct 2019 10:20:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so12562608wmc.1;
        Mon, 07 Oct 2019 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKGHMAzLMc3EZjcLnisKCwm5b/7oAc4wt2nUlmMJuJ8=;
        b=s2AlzTzISao1m9V0GrvqIwdFR4iic9QvFkEwMVANloxiVaAimOvWCASU3WgNFcO4LO
         IfMB6n5zkYVNNn/BqEP9woGud/kVZk38WxE6y6GQ2SadCaM4TD0MaZ2yymOZNXk1VZti
         C3XQjeokOyVd14soSonRaCwVVzDBM7mgzL98wUfoAkQ6l1z7xNJzQnO7PLJoID6tDQK0
         7vlCeSGvbxjSeEfQlf9W2KdlhRTFM16XA2gz383tPwaCtMOVPm06qBd8e8KuthS1VpV7
         S8NdgQOeGCYzGoE3JDmF0MUvp4S1JNvfe+ZrpfQVpt4RpzyrNcfMuxf8IRXlxCztGgOx
         QJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKGHMAzLMc3EZjcLnisKCwm5b/7oAc4wt2nUlmMJuJ8=;
        b=BZfAVbxv1ZcD0o6ToYKGCAnNnGu+AI8TmvtPvPJnZpoX3VynT+W+wSzmApYJv1RznQ
         dmaWehGK6ADMAD4/LKzRpmdybUQXTaG+lzeeUH/QLkQINa4NVZ8Q22TprCWXnAGpN+zi
         mWbxF+UFKNKmgbYu2MK13HtWiU3TP/x2GW64+gmxYDM8FnsfclFAr50pFs6+J0ycfYYM
         AQR/gaHkbF8N6niRpwWqlEyWdE3NorRsI0wFWpW68jD5qbTmZ2SAqEnooQkyC+zEJMab
         zO1NxW9X1Fw1rdCpA5Mv2mbzMENLJuKMfZblNXw65kMeTUOYfTayVQInWyAkBIbvOioV
         UuBA==
X-Gm-Message-State: APjAAAXyTphEbDLFd/unT1q6mVdvbepZcENZ+q8Go+kjdwC+TtFbY96E
        zW4SmhPFJLL+/P2Rs9ZvYNI=
X-Google-Smtp-Source: APXvYqxaA5ml4MqxCrD1RL6LrpWQ7cAgIupjWzyMStq6oCHDAv7wcBiM5bVTszmFPhCym58NUYZemg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr21534679wmd.104.1570457999892;
        Mon, 07 Oct 2019 07:19:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g11sm16240295wmh.45.2019.10.07.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 07:19:59 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:19:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Message-ID: <20191007141956.GA25347@gmail.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> Here is v7 of my patch-set to add support for EFI embedded fw to the kernel.
> 
> v6 was posted a long time ago, around the 4.18 days. The long wait was for
> a suitable secure-hash for checking the firmware we find embedded in the EFI
> is the one we expect.
> 
> With 5.4-rc1 we finally have a standalone sha256 lib, so that hurdle for
> this patch-set is now gone.
> 
> I've tried to address all review-remarks against v6 in this new version:
> 
> Changes in v7:
> - Split drivers/firmware/efi and drivers/base/firmware_loader changes into
>   2 patches
> - Use new, standalone, lib/crypto/sha256.c code
> - Address kdoc comments from Randy Dunlap
> - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
>   _request_firmware() wrapper, as requested by Luis R. Rodriguez
> - Stop using "efi-embedded-firmware" device-property, now that drivers need to
>   use the new firmware_request_platform() to enable fallback to a device fw
>   copy embedded in the platform's main firmware, we no longer need a property
>   on the device to trigger this behavior
> - Use security_kernel_load_data instead of calling
>   security_kernel_read_file with a NULL file pointer argument
> - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
> - Document the new firmware_request_platform() function in
>   Documentation/driver-api/firmware/request_firmware.rst
> - Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
>   to use the new firmware_request_platform() method
> - Rebased on top of 5.4-rc1
> 
> I guess this will probably need another round (ot two) of review + fixing,
> but eventually this can hopefully be merged. Since this touches a bunch
> of different subsystems the question is how to merge this? Most of the
> touched files outside of the firmware-loader code do not see a lot of
> churn, so my proposal would be to merge patches 1-6 through the tree
> which carries firmware-loader changes; and then provide an immutable
> branch for the platform/x86 maintainers to merge and then they can merge
> the last 2 patches (as the touchscreen_dmi.c file does see quite a bit
> of changes every release).

So I was looking for a high level 0/ boilerplate description of this 
series, to explain what "EFI embedded fw" is, what problems it solves and 
how it helps the kernel in general - and found this in 2/8:

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
>> Reported-by: Dave Olsthoorn <dave@bewaar.me>
>> Suggested-by: Peter Jones <pjones@redhat.com>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

There's also patch #3, which explains how this is used:

>> This commit adds a new platform fallback mechanism to the firmware loader
>> which will try to lookup a device fw copy embedded in the platform's main
>> firmware if direct filesystem lookup fails.
>>
>> Drivers which need such embedded fw copies can enable this fallback
>> mechanism by using the new firmware_request_platform() function.
>>
>> Note that for now this is only supported on EFI platforms and even on
>> these platforms firmware_fallback_platform() only works if
>> CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
>> which need this), in all other cases firmware_fallback_platform() simply
>> always returns -ENOENT.

Plus there's 3 patches that opt in three drivers to this new EFI-firmware 
loading mechanism, right?

A couple of high level questions:

- How common are these kinds of firmware files that should be loaded into 
  the device by the OS device driver? Common? Or 1% of systems? 0.1% of 
  systems? 0.0001%?

- Can there be a situation where linux-firmware already includes an older 
  copy of the firmware, and the EFI firmware has a newer version? If this 
  can plausibly happen, shouldn't the fallback mechanism do some sort of 
  version check (if that's possible), and load the newer version?

- I'm worried about the explicit opt-in nature of these firmware files - 
  the OS driver has to be explicitly aware of this possibility. Shouldn't 
  we at minimum have some sort of boot time check to see whether a device 
  has an embedded fw blob, and warn the user if we don't actually load 
  it? Which would generate some gentle pressure to fix our drivers?

- I think the config option should be default-y, because AFAICS this 
  mechanism makes broken drivers/devices work.

- Finally, is there any question of trust or a potential for other 
  security pitfalls here, where we'd trust linux-firmware over what the 
  EFI firmware says is the proper firmware for a device? My default 
  assumption would be that we are exposed to the EFI firmware anyway, and 
  it comes with the hardware just like the devices come with the 
  hardware, so we can generally trust it. But I might be missing 
  something. If there's any plausible question of trust (for example can 
  attackers hide rooted firmware in the EFI image, without triggering 
  filesystem integrity checks on the regular filesystem side?) then it 
  might make sense to offer a boot parameter to disable this, beyond the 
  config parameter.

Thanks,

	Ingo
