Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2965E61ECA2
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 09:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKGIKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 03:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGIKF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 03:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44E13F53
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 00:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667808555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkjAKYc9FXb8vAKFUk+ZLuky94BRi1m+VajvOgs9/zk=;
        b=HIcK9a54NA6bNl3RA7+RX3YCVc8uHk3or8HFSx54TApcz36iAH5SjPQP7X11YnVGKDuGt/
        SdRYktHI/oIpFqa+iQo0Vy8Je66pO9IGYiIW4O+S6ZrWz5kPc+mvbyrJOnYjnh7LiefZfh
        pjpIcnJk74p/xSMxAmOhiS/XqhDZeAs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-xLLi40XEPuyMb5ZLXp3rkQ-1; Mon, 07 Nov 2022 03:09:14 -0500
X-MC-Unique: xLLi40XEPuyMb5ZLXp3rkQ-1
Received: by mail-ej1-f70.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so1042558ejc.17
        for <linux-efi@vger.kernel.org>; Mon, 07 Nov 2022 00:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkjAKYc9FXb8vAKFUk+ZLuky94BRi1m+VajvOgs9/zk=;
        b=5NVym1WrTGoQbUo/MpmnR+mRi2QJzQHr6Y19MV7hlSUlgBgWej79EfmYhjHqgIcNWS
         /9gulC68boQsB8KD6W7u27SepL2kGib7TQs3t4DJCwupqxWBeiP/Gl5OunmCQuMk+68l
         mO5BjmN+JmwZmIT4b4zyW9PsgZnAWSd2HfKL/QuxEBO2hYuq6iyd0mjcz+ztzMlPXuwd
         QNtuqZoB0lCDAvqyE2Hjc6v+ozkU1/h8iDyYoiDcitBs3Ipgecx1ajnddkyknRNnC60K
         useqQF88gKghQEN/nMhCUtdmd+fA3x4xek3cxP5Hi54Qp1qvWVjsIzdIHY69pSKtC2aN
         1XQg==
X-Gm-Message-State: ANoB5pnsD42ocEsNt0fSTLQaHQQSTZi0wWBLQJqpsl7tqA618LIHLqWE
        PYGZDd/0FYe3b3CyUv0g5FOY0dVxIhoRsdfU1IBpp2s2Lplobfffd+t5bwVTd3JikCfvkRcuWpH
        W8iPwx4lC5u3JEMa/JeRkjbtWw3+lnCLJPQwu
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id z26-20020a1709063ada00b007ae566e3a1cmr8476261ejd.223.1667808552868;
        Mon, 07 Nov 2022 00:09:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Dia6htrl0R5Guk3LG6AOv/99O/QRcaC9BRqw2VBHRFhGzOyBhNhbrqYghSv7xD3REtrqxle3Zo6xkCi1mkbQ=
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id
 z26-20020a1709063ada00b007ae566e3a1cmr8476241ejd.223.1667808552587; Mon, 07
 Nov 2022 00:09:12 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
 <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf> <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
 <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com>
 <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
 <CALu+AoTJeMry54KmSWooP5Jm3t0EqCxOid_GzfU51KQmXUYp8Q@mail.gmail.com> <CAMj1kXEyR=fwYO2z3w8C+otpxB33owv6fEBTXs_-++Ln=P4g8w@mail.gmail.com>
In-Reply-To: <CAMj1kXEyR=fwYO2z3w8C+otpxB33owv6fEBTXs_-++Ln=P4g8w@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Mon, 7 Nov 2022 16:08:34 +0800
Message-ID: <CALu+AoQs_msyxpB=072qL9FyVYJzabJ12Xwj_dYA7qab9Pt85g@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ns@tfwno.gf, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 7 Nov 2022 at 15:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 7 Nov 2022 at 08:40, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Mon, 7 Nov 2022 at 15:36, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Mon, 7 Nov 2022 at 15:30, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 7 Nov 2022 at 07:55, Dave Young <dyoung@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
> > > > > >
> > > > > > On 2022-11-05 05:49, Dave Young wrote:
> > > > > > > Baoquan, thanks for cc me.
> > > > > > >
> > > > > > > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> > > > > > >>
> > > > > > >> Add Dave to CC
> > > > > > >>
> > > > > > >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > > > > > >> > Greetings,
> > > > > > >> >
> > > > > > >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > > > > > >> > cause EFI mode (if that's the right term for it) to be unconditionally
> > > > > > >> > disabled, even when not using the --noefi option to kexec.
> > > > > > >> >
> > > > > > >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > > > > > >> > services, is that basically nothing about the system's EFI is visible
> > > > > > >> > post-kexec. Normally you have a message like this in dmesg when the
> > > > > > >> > system is booted in EFI mode:
> > > > > > >> >
> > > > > > >> > [    0.000000] efi: EFI v2.70 by EDK II
> > > > > > >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > > > > > >> > MEMATTR=0x7ec63018
> > > > > > >> > (obviously not the real firmware of the machine I'm talking about, but I
> > > > > > >> > can also send that if it would be of any help)
> > > > > > >> >
> > > > > > >> > No such message pops up in my dmesg as a result of this bug, & this
> > > > > > >> > causes some fallout like being unable to find the system's DMI
> > > > > > >> > information:
> > > > > > >> >
> > > > > > >> > <6>[    0.000000] DMI not present or invalid.
> > > > > > >> >
> > > > > > >> > The efivarfs module also fails to load with -ENODEV.
> > > > > > >> >
> > > > > > >> > I've tried also booting with efi=runtime explicitly but it doesn't
> > > > > > >> > change anything. The kernel still does not print the name of the EFI
> > > > > > >> > firmware, DMI is still missing, & efivarfs still fails to load.
> > > > > > >> >
> > > > > > >> > I've been using the kexec_load syscall for all these tests, if it's
> > > > > > >> > important.
> > > > > > >> >
> > > > > > >> > Also, to make it very clear, all this only ever happens post-kexec. When
> > > > > > >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > > > > > >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > > > > > >> > DMI is properly found, & efivarfs loads & mounts just fine).
> > > > > > >> >
> > > > > > >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > > > > > >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > > > > > >> > mainline kernel builds dating back to 5.17 that have the exact same
> > > > > > >> > issue. It might be worth noting that during this testing, I made sure
> > > > > > >> > the version of the kernel being kexeced & the kernel kexecing were the
> > > > > > >> > same version. It may not have been a problem in older kernels, but that
> > > > > > >> > would be difficult to test for me (a pretty important driver for this
> > > > > > >> > machine was only merged during v5.17-rc4). So it may not have been a
> > > > > > >> > regression & just a hidden problem since time immemorial.
> > > > > > >> >
> > > > > > >> > I am willing to test any patches I may get to further debug or fix
> > > > > > >> > this issue, preferably based on the current state of torvalds/linux.git.
> > > > > > >> > I can build & test kernels quite a few times per day.
> > > > > > >> >
> > > > > > >> > I can also send any important materials (kernel config, dmesg, firmware
> > > > > > >> > information, so on & so forth) on request. I'll also just mention I'm
> > > > > > >> > using kexec-tools 2.0.24 upfront, if it matters.
> > > > > > >
> > > > > > > Can you check the efi runtime in sysfs:
> > > > > > > ls /sys/firmware/efi/runtime-map/
> > > > > > >
> > > > > > > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > > > > > > is needed for kexec UEFI boot on x86_64.
> > > > > >
> > > > > > Oh my, it really is that simple.
> > > > > >
> > > > > > Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> > > > > > blindly disabled it in my quest to downsize the pre-kexec kernel to
> > > > > > reduce boot time (it only runs a bootloader). In hindsight, the firmware
> > > > > > drivers section is not really a good section to tweak on a whim.
> > > > > >
> > > > > > I'm terribly sorry to have taken your time to "fix" this "bug". But I
> > > > > > must ask, is there any reason why this is a visible config option, or at
> > > > > > least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> > > > > > is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> > > > > > probably wants to have kexec work properly if they can even enable it.
> > > > >
> > > > > Glad to know it works with the .config tweaking. I can not recall any
> > > > > reason for that though.
> > > > >
> > > > > Since it sits in the efi code path, let's see how Ard thinks about
> > > > > your proposal.
> > > > >
> > > >
> > > > I don't understand why EFI_RUNTIME_MAP should depend on KEXEC_CORE at
> > > > all: it is documented as a feature that can be enabled for debugging
> > > > as well, and kexec does not work as expected without it.
> > >
> > > Probably debugging only mentioned in text, but not been considered in
> > > the kconfig logic :(
> > >
> > > >
> > > > Should we just change it like this perhaps?
> > > >
> > > > --- a/drivers/firmware/efi/Kconfig
> > > > +++ b/drivers/firmware/efi/Kconfig
> > > > @@ -28,8 +28,8 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
> > > >
> > > >  config EFI_RUNTIME_MAP
> > > >         bool "Export efi runtime maps to sysfs"
> > > > -       depends on X86 && EFI && KEXEC_CORE
> > > > -       default y
> > > > +       depends on X86 && EFI
> > > > +       default KEXEC_CORE
> > > >         help
> > > >
> > > > and maybe add an 'if EXPERT' so that the option is only visible to
> > > > modify when CONFIG_EXPERT=y ?
> > >
> > > Above changes look good to me.
> > >
> > > >
> > > > In any case, I intend to move this code into arch/x86 as well, so I'll
> > > > have a couple of patches out shortly.
> > >
> > > That would be better since it is X86 only.  Thanks, Ard.
> >
> > Hmm,  before doing that, do you think it is useful for debugging
> > purposes? That could be a reason to sit in efi code instead of x86 ..
> >
>
> This code was only ever enabled on x86, and on ARM/arm64, we can
> capture the memory map via efi=debug on any kernel build, and capture
> the virtual mappings using PTDUMP (which also gives us the exact
> attributes for each mapped region)
>
> So I don't think it has that much value on non-x86 tbh.

Ok, fair enough.

Thanks
Dave

