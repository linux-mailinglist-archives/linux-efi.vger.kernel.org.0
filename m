Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4E44CDA1
	for <lists+linux-efi@lfdr.de>; Thu, 11 Nov 2021 00:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhKJXKN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 18:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233936AbhKJXKM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Nov 2021 18:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636585644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNqnwKhWBogq634MYnDNtILb7/Z3YcmwIVgNJ2lvEOU=;
        b=C6RjmY9hs7Bz8adQccsn4nV8U2oazp3oZsEHb31YOHhSt2t6wmSjBbAJrs1YSwh6ipqT4r
        lE0VuJTwXpVs59U9xXuPV652l/rLjMqV3hJmLnDaFV4u2SdexGfR2TnBW0I99jwS2iX0Qp
        72isnhgbrq+uLC81TjsAAlv0UAi7NJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-W_vhmsrNPAG3kTCNlX2pCA-1; Wed, 10 Nov 2021 18:07:22 -0500
X-MC-Unique: W_vhmsrNPAG3kTCNlX2pCA-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so857068wma.3
        for <linux-efi@vger.kernel.org>; Wed, 10 Nov 2021 15:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fNqnwKhWBogq634MYnDNtILb7/Z3YcmwIVgNJ2lvEOU=;
        b=AExy879TLRXzUS/c9TBYy3CznTR1Q4eNJmYPW2eaFu8TaOa9zCgfmvPLr4jbTvTdE7
         fZWb2uMuCbR8L1ysK58uwMlfngTzSgd4LNBHqXAx3aLa09VFf7xSl4eDvAOL556axRos
         sJmAs7zNZ3OOiDCSG/j18ZQb8lMVqWZAPmtF6W0DGJ6XANwKsdA4jFx/0Jrk1MDP7q+l
         qp/vjSSt/iOo8ZxogZAeMV6ii8Zgo67rozwbQRtrKnWzQM+m2HvywAnmWPaD6planwZl
         EmIuX6mhR807Y5zDDw3GA6qivWLF3W67bq2b7PIZFN+d6H45s10f/NOisNzkaqkKC7KT
         dZbA==
X-Gm-Message-State: AOAM533GG+jovLAmCYCuzwfpz8Xh8a8ShaL+bgdkAxY6nQbCOM0i8HPi
        K1xgVrQWjBkYLuz1sKAmr+2eTr3TRoxK+OH23vcnkDX9AmzvmkgIm20V5YToyXjC6e2ML0NpV6i
        Nt1b4bsFqiZ8wZvSsT4jC
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr3225584wmj.166.1636585641629;
        Wed, 10 Nov 2021 15:07:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl8v+8TdkAuH6HhmNcnUIDPdJyrAREIk366BfGPfLKWxfIMdkdjMj7Jyx5DErLhB6++HOAsQ==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr3225528wmj.166.1636585641310;
        Wed, 10 Nov 2021 15:07:21 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c6sm8755344wmq.46.2021.11.10.15.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 15:07:21 -0800 (PST)
Message-ID: <627b6cd1-3446-5e55-ea38-5283a186af39@redhat.com>
Date:   Thu, 11 Nov 2021 00:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [REGRESSION]: drivers/firmware: move x86 Generic System
 Framebuffers support
Content-Language: en-US
To:     Ilya Trukhanov <lahvuun@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-pm@vger.kernel.org, tzimmermann@suse.de, ardb@kernel.org,
        rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20211110200253.rfudkt3edbd3nsyj@lahvuun>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211110200253.rfudkt3edbd3nsyj@lahvuun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[ adding dri-devel mailing list as Cc ]

Hello Ilya,

On 11/10/21 21:02, Ilya Trukhanov wrote:
> Suspend-to-RAM with elogind under Wayland stopped working in 5.15.
> 
> This occurs with 5.15, 5.15.1 and latest master at
> 89d714ab6043bca7356b5c823f5335f5dce1f930. 5.14 and earlier releases work
> fine.
> 
> git bisect gives d391c58271072d0b0fad93c82018d495b2633448.
>

That's strange because this patch is just moving code around, there shouldn't
be any functional changes...

> To reproduce:
> - Use elogind and Linux 5.15.1 with CONFIG_SYSFB_SIMPLEFB=n.
> - Start a Wayland session. I tested sway and weston, neither worked.
> - In a terminal emulator (I used alacritty) execute `loginctl suspend`.
> 
> Normally after the last step the system would suspend, but it no longer
> does so after I upgraded to Linux 5.15. After running `loginctl suspend`
> in dmesg I get the following:
> [  103.098782] elogind-daemon[2357]: Suspending system...
> [  103.098794] PM: suspend entry (deep)
> [  103.124621] Filesystems sync: 0.025 seconds
> 
> But nothing happens afterwards.
> 
> Suspend works as expected if I do any of the following:
> - Revert d391c58271072d0b0fad93c82018d495b2633448.
> - Build with CONFIG_SYSFB_SIMPLEFB=y.

Can you please share the kernel boot log for any of these cases too ?

> - Suspend from tty, even if a Wayland session is running in parallel.
> - Suspend from under an X11 session.
> - Suspend with `echo mem > /sys/power/state`.
> 
> If I attach strace to the elogind-daemon process after running
> `loginctl suspend` then the system immediately suspends. However, if
> I attach strace *prior* to running `loginctl suspend` then no suspend,
> and the process gets stuck on a write syscall to `/sys/power/state`.
> 
> I "traced" a little bit with printk (sorry, I don't know of a better
> way) and the call chain is as follows:
> state_store -> pm_suspend -> enter_state -> suspend_prepare
> -> pm_prepare_console -> vt_move_to_console -> vt_waitactive
> -> __vt_event_wait
> 
> __vt_event_wait just waits until wait_event_interruptible completes, but
> it never does (not until I attach to elogind-daemon with strace, at
> least). I did not follow the chain further.
> 
> - Linux version 5.15.1 (lahvuun@lahvuun) (gcc (Gentoo 11.2.0 p1) 11.2.0,
>   GNU ld (Gentoo 2.37_p1 p0) 2.37) #51 SMP PREEMPT Tue Nov 9 23:39:25
>   EET 2021
> - Gentoo Linux 2.8
> - x86_64 AuthenticAMD
> - dmesg: https://pastebin.com/duj33bY8
> - .config: https://pastebin.com/7Hew1g0T
> 

Looking at your .config and dmesg output, my guess is that is related to the
fact that you have both CONFIG_FB_EFI=y and CONFIG_DRM_AMDGPU=y.

The code that adds the "efi-framebuffer" platform device used to be in the
arch/x86/kernel/sysfb.c file but now is in drivers/firmware/sysfb.c, and it
could affect the order in which the device <--> driver matching happens.

From your kernel boot log:

...
[    0.375796] [drm] amdgpu kernel modesetting enabled.
[    0.375819] amdgpu: CRAT table disabled by module option
[    0.375823] amdgpu: Virtual CRAT table created for CPU
[    0.375831] amdgpu: Topology: Add CPU node
[    0.375865] amdgpu 0000:0a:00.0: vgaarb: deactivate vga console
[    0.375911] [drm] initializing kernel modesetting (VEGA10 0x1002:0x687F 0x1DA2:0xE376 0xC3).
...
[    0.868997] fbcon: amdgpu (fb0) is primary device
[    1.004397] Console: switching to colour frame buffer device 240x67
[    1.017815] amdgpu 0000:0a:00.0: [drm] fb0: amdgpu frame buffer device
...
[    1.133997] efifb: probing for efifb
[    1.134716] efifb: framebuffer at 0xe0000000, using 8100k, total 8100k
[    1.135438] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.136180] efifb: scrolling: redraw
[    1.136891] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.137638] fb1: EFI VGA frame buffer device

Usually the efifb is to have early framebuffer output before the native DRM
driver probes, but in your case is the opposite. This wouldn't happen if the
amdpug driver was built as a module.

Probably before the mentioned commit, the efifb driver was probed earlier and
then the amdgpu driver would had removed the conflicting efifb framebuffer
before registering its DRM device. But that doesn't happen here and the efifb
framebuffer is still around since is registered after the one for the amdgpu.

Which would explain why also works with CONFIG_SYSFB_SIMPLEFB=y for you, since
in that case a "simple-framebuffer" platform device is added instead of an
"efi-framebuffer". But since neither CONFIG_FB_SIMPLE nor CONFIG_DRM_SIMPLEDRM
are enabled in your kernel config, no device driver will match that device.

This is just a guess though. Would be good if you could test following cases:

1) CONFIG_FB_EFI not set
2) CONFIG_FB_EFI=y and CONFIG_DRM_AMDGPU=m
3) CONFIG_SYSFB_SIMPLEFB=y and CONFIG_FB_SIMPLE=y

And for each check /proc/fb, the kernel boot log, and if Suspend-to-RAM works.

If the explanation above is correct, then I would expect (1) and (2) to work and
(3) to also fail.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

