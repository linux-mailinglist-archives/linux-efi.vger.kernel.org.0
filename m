Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61C661DAC6
	for <lists+linux-efi@lfdr.de>; Sat,  5 Nov 2022 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKEOQi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Nov 2022 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiKEOQi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Nov 2022 10:16:38 -0400
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1876026AC9;
        Sat,  5 Nov 2022 07:16:34 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
        t=1667657790; bh=J7AqfEf7LvFDpqBYRlFhO8k4vfiTi6BH8M8TJ5Qv02s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KbjOkyroeyovBXygh35SwSIFVx4a8Xt4hpUdDp97q6+8nixOx0RL4hiUij+/vaePB
         2t4XRTbjU72AtJckqln8KAw7Gq8M7xAGwh8wRnj4Zy8Hk67eCM8ewY41eb5w/gph0+
         V1nz7lFLcltMnB2qPASazgNWMFpbSZKEoWWWXTxPWedNps1MM17/CrukWl+qquu3yG
         oyaaW5bvy3r4UZfFujMTt/VeUM+DZRoQigihRWBAbRuXOCQKZt11WaLyOovNeKA8YN
         QZxKHIUQBZJ8Klzj+4IXMfcHwEADJvCTxze47rpdqMyJX0xxEeIItilpzTyM70OY0a
         Xz2px1nk9okRQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 05 Nov 2022 14:16:30 +0000
From:   ns@tfwno.gf
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
In-Reply-To: <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
 <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
Message-ID: <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
X-Sender: ns@tfwno.gf
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-11-05 05:49, Dave Young wrote:
> Baoquan, thanks for cc me.
> 
> On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
>> 
>> Add Dave to CC
>> 
>> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
>> > Greetings,
>> >
>> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
>> > cause EFI mode (if that's the right term for it) to be unconditionally
>> > disabled, even when not using the --noefi option to kexec.
>> >
>> > What I mean by "EFI mode" being disabled, more than just EFI runtime
>> > services, is that basically nothing about the system's EFI is visible
>> > post-kexec. Normally you have a message like this in dmesg when the
>> > system is booted in EFI mode:
>> >
>> > [    0.000000] efi: EFI v2.70 by EDK II
>> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
>> > MEMATTR=0x7ec63018
>> > (obviously not the real firmware of the machine I'm talking about, but I
>> > can also send that if it would be of any help)
>> >
>> > No such message pops up in my dmesg as a result of this bug, & this
>> > causes some fallout like being unable to find the system's DMI
>> > information:
>> >
>> > <6>[    0.000000] DMI not present or invalid.
>> >
>> > The efivarfs module also fails to load with -ENODEV.
>> >
>> > I've tried also booting with efi=runtime explicitly but it doesn't
>> > change anything. The kernel still does not print the name of the EFI
>> > firmware, DMI is still missing, & efivarfs still fails to load.
>> >
>> > I've been using the kexec_load syscall for all these tests, if it's
>> > important.
>> >
>> > Also, to make it very clear, all this only ever happens post-kexec. When
>> > booting straight from UEFI (with the EFI stub), all the aforementioned
>> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
>> > DMI is properly found, & efivarfs loads & mounts just fine).
>> >
>> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
>> > bisect it, but it seems like it goes pretty far back. I've got vanilla
>> > mainline kernel builds dating back to 5.17 that have the exact same
>> > issue. It might be worth noting that during this testing, I made sure
>> > the version of the kernel being kexeced & the kernel kexecing were the
>> > same version. It may not have been a problem in older kernels, but that
>> > would be difficult to test for me (a pretty important driver for this
>> > machine was only merged during v5.17-rc4). So it may not have been a
>> > regression & just a hidden problem since time immemorial.
>> >
>> > I am willing to test any patches I may get to further debug or fix
>> > this issue, preferably based on the current state of torvalds/linux.git.
>> > I can build & test kernels quite a few times per day.
>> >
>> > I can also send any important materials (kernel config, dmesg, firmware
>> > information, so on & so forth) on request. I'll also just mention I'm
>> > using kexec-tools 2.0.24 upfront, if it matters.
> 
> Can you check the efi runtime in sysfs:
> ls /sys/firmware/efi/runtime-map/
> 
> If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> is needed for kexec UEFI boot on x86_64.

Oh my, it really is that simple.

Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
blindly disabled it in my quest to downsize the pre-kexec kernel to
reduce boot time (it only runs a bootloader). In hindsight, the firmware
drivers section is not really a good section to tweak on a whim.

I'm terribly sorry to have taken your time to "fix" this "bug". But I
must ask, is there any reason why this is a visible config option, or at
least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
probably wants to have kexec work properly if they can even enable it.
I admit the help text for it is arguably pretty good, but I feel like
the config option is only really useful for embedded, the same
enviroments where people would disable stuff like CONFIG_DMI -- a config
option that I would argue is pretty justifiably gated behind
CONFIG_EXPERT, because far too many systems break without it & it's
pretty small code, so really not worth it unless you absolutely know
what you're doing. Similarly, I don't really think there's much value
in disabling the ability to kexec without the firmware except if you're
heavily informed & must have the size reduction, especially since in
EFI land that's where your DMI info comes from, if I were to argue for
it on the basis of CONFIG_DMI being gated. In summary, it can cause
quite a bit of unnecessary confusion despite only being useful to a very
small minority of users.

Thank you!

> 
> Otherwise you can add debug printf in kexec-tools efi error path to
> see what is wrong.
> kexec/arch/i386/x86-linux-setup.c : function setup_efi_data
> 
> And if it still not work please post your kernel config, I can have a
> try although I do not have the t480 now.
> 
> 
>> >
>> > Regards,
>> >
>> > _______________________________________________
>> > kexec mailing list
>> > kexec@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/kexec
>> >
>> 
