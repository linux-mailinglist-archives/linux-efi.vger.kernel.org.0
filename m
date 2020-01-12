Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041E213889B
	for <lists+linux-efi@lfdr.de>; Sun, 12 Jan 2020 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgALWyS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Jan 2020 17:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbgALWyS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 12 Jan 2020 17:54:18 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC242467C
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2020 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578869657;
        bh=OTPSk1FDbrul0QY/pUOTlMEtUEMURhj6Q/PvlUu/sI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hzhvSFdpz62gogZ9QN7lfmafoGsakUjT1kaPTgxvKWg5Xq+befE3iVxPLwm79hZTC
         daPQyiQvVm0j+WIy9HH+k4T6lNya6yT+5xyuppstOXHcEnLAtcJfMXOwB4xoUxPQBi
         wd32iWGi8yUPDeOVPUB/jfWtezETqeizKYZhYU6U=
Received: by mail-wr1-f53.google.com with SMTP id z7so6757328wrl.13
        for <linux-efi@vger.kernel.org>; Sun, 12 Jan 2020 14:54:16 -0800 (PST)
X-Gm-Message-State: APjAAAWgZYXqmlF8VuYoglCNQUZ7RSVv7NTYh80q0uV9Eg5P/yS6q4l0
        EZRtC6K7yQOLVuqkrKzvedCSFnSxHEoqW8am5qqrNg==
X-Google-Smtp-Source: APXvYqwqvYzhEdydCPNO7qcIvHe+8nzILh5eaIaQCyGHnDLwjQKEoFRnKyCjU2psD4HOU4Uu55mc3jpLpIFWqLzfw5Q=
X-Received: by 2002:adf:f491:: with SMTP id l17mr14897341wro.149.1578869655295;
 Sun, 12 Jan 2020 14:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20200111145703.533809-1-hdegoede@redhat.com> <20200111145703.533809-5-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-5-hdegoede@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 12 Jan 2020 14:54:04 -0800
X-Gmail-Original-Message-ID: <CALCETrXi_P1_nCp27yawLeUKuR=Wo11rKao222SVsnhi6qF9fA@mail.gmail.com>
Message-ID: <CALCETrXi_P1_nCp27yawLeUKuR=Wo11rKao222SVsnhi6qF9fA@mail.gmail.com>
Subject: Re: [PATCH v11 04/10] firmware: Add new platform fallback mechanism
 and firmware_request_platform()
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
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jan 11, 2020 at 6:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> In some cases the platform's main firmware (e.g. the UEFI fw) may contain
> an embedded copy of device firmware which needs to be (re)loaded into the
> peripheral. Normally such firmware would be part of linux-firmware, but in
> some cases this is not feasible, for 2 reasons:
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
> This commit adds a new platform fallback mechanism to the firmware loader
> which will try to lookup a device fw copy embedded in the platform's main
> firmware if direct filesystem lookup fails.
>
> Drivers which need such embedded fw copies can enable this fallback
> mechanism by using the new firmware_request_platform() function.

After finally wrapping my head around how this all fits together:

Early in boot, you check a bunch of firmware descriptors, bundled with
drivers, to search EFI code and data for firmware before you free said
code and data.  You catalogue it by name.  Later on, you use this list
as a fallback, again catalogued by name.  I think it would be rather
nicer if you simply had a list in a single file containing all these
descriptors rather than commingling it with the driver's internal dmi
data.  This gets rid of all the ifdeffery and module issues.  It also
avoids any potential nastiness when you have a dmi entry that contains
driver_data that points into the driver when the driver is a module.

And you can mark the entire list __initdata.  And you can easily (now
or later on) invert the code flow so you map each EFI region exactly
once and then search for all the firmware in it.

--Andy
