Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF8777833
	for <lists+linux-efi@lfdr.de>; Thu, 10 Aug 2023 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjHJMXd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Aug 2023 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHJMXc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Aug 2023 08:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4594E54
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691670171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9b2wApsrg6L8nRmVBrW3r1woQ5yXmP1wcsJljkjos1Q=;
        b=FU5UizTlFRbNjv2u+r8kKqCVvrypY0lEoCfM0P9xbrwuNhD8zPMe1apQqanIcqikR59CyR
        udaqB32fnMHD78LIxL71YeCrVYTP/lMHHIJT+Rgjq+g3F8JR8glypXQYYi+FDXGmKA/fvu
        bzUxwcsfLjhimcIUEhMeOykwPNjAYxo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-U5SkuEVJM-uJqyEq9aSLrw-1; Thu, 10 Aug 2023 08:22:50 -0400
X-MC-Unique: U5SkuEVJM-uJqyEq9aSLrw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe65cd1b3cso768807e87.2
        for <linux-efi@vger.kernel.org>; Thu, 10 Aug 2023 05:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691670168; x=1692274968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9b2wApsrg6L8nRmVBrW3r1woQ5yXmP1wcsJljkjos1Q=;
        b=KJRreT9Yrr669425ckISMdiRU7H6kaZC7ql+wKIGwCfVvsIzZP/CLrvCDEzZ76vv+Q
         gNLNjrefSzImg/AOYqRzaf8lbDKSm0tDeTtg17xSD3CTMtkcj+wbKugf74tsxc4QVYmT
         3GKgfGO8Dt1xZ9td1ltEPRqt2ccoschw5nU/xJaAsiBL1mTUNwTdQh6MIG0JcZ/McavD
         kme91B7sHCWaPoR8m51opKACywaCCNlaEMaC1XPofodwJs//Kf5BBEfJsxQocVyTkKs7
         PwrtXalkfrkYjauzfDyjhhCfSS8qfa7zRDeCX7l2ZoQD0tqr6VlqAhoPoXgpkEZtIgRV
         SY/g==
X-Gm-Message-State: AOJu0YxJ2IBH/dOtfZep+779KwyjnYqkF7C/x8GTgvbcZ+DCcLizIizN
        wCSOkTzriLq9G/xANn15XS3i0p+Qyc5qqI0hVHDA8Rx/A52YgXZWMO6NbR28JfcpiOKqUm96lHd
        H+IqCaNBq8XeXhbbP7ri0
X-Received: by 2002:a05:6512:238e:b0:4fd:faa1:fefc with SMTP id c14-20020a056512238e00b004fdfaa1fefcmr2078635lfv.56.1691670168618;
        Thu, 10 Aug 2023 05:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjao/L6vpI3Te9CJosg7WzqcWCibBhANGr4Mt76J94W9vdz9VwrG7UYtOY1nbyu301Gxx0ew==
X-Received: by 2002:a05:6512:238e:b0:4fd:faa1:fefc with SMTP id c14-20020a056512238e00b004fdfaa1fefcmr2078613lfv.56.1691670168231;
        Thu, 10 Aug 2023 05:22:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d9-20020aa7d689000000b0052237dfa82fsm737291edr.64.2023.08.10.05.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:22:47 -0700 (PDT)
Message-ID: <905ea3ae-daf0-a668-b407-8d267c6102dc@redhat.com>
Date:   Thu, 10 Aug 2023 14:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] efi/x86: Limit mixed mode support to runtime services
Content-Language: en-US, nl
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Steve McIntyre <steve@einval.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20230810092835.1025088-1-ardb@kernel.org>
 <e135fd0d-86d3-6c01-1b50-0736b21aaab2@redhat.com>
 <CAMj1kXHbOvw=_G_90+Jm_devVsH8OojaGXJwLc1fRdf=NR=jxQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXHbOvw=_G_90+Jm_devVsH8OojaGXJwLc1fRdf=NR=jxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 8/10/23 13:34, Ard Biesheuvel wrote:
> On Thu, 10 Aug 2023 at 12:32, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> On 8/10/23 11:28, Ard Biesheuvel wrote:
>>> As currently implemented, mixed mode support on x86 depends on special
>>> Linux/x86 specific logic in the bootloader that is not covered by the
>>> UEFI specification: it relies on the so-called EFI handover protocol to
>>> invoke a special 32-bit entrypoint into the EFI stub that 64-bit Linux
>>> builds expose if they were configured with CONFIG_EFI_MIXED=y (and
>>> CONFIG_EFI_HANDOVER_PROTOCOL=y)
>>>
>>> When EFI mixed mode was introduced, booting via the EFI stub was a
>>> prerequisite, as the stub code captured the context that was restored
>>> again when invoking firmware services, both at boot time and at runtime.
>>> (segment selectors, GDTs, IDTs etc). However, since commit 96738c69a7fc
>>> ("x86/efi: Avoid triple faults during EFI mixed mode calls"), the
>>> runtime logic no longer uses any of this preserved context, and simply
>>> invokes the firmware services in compatibility mode instead.
>>>
>>> Given that the EFI handover protocol was never implemented except in
>>> distro forks of GRUB, mainline GRUB does not support it. However, its
>>> legacy x86 boot code will happily boot a 64-bit kernel from a 32-bit
>>> build, and given that booting via the EFI stub is no longer needed, it
>>> can also invoke the 32-bit EFI runtime services without problems. And
>>> even Debian's GRUB fork, which implements the EFI handover protocol for
>>> native boot, will happily boot in mixed mode with all the EFI stub
>>> pieces ripped out.
>>>
>>> This means that the complex and messy EFI mixed mode support in the EFI
>>> stub is redundant, and can be removed.
>>
>> How do you see this working, esp. wrt upgrade paths for distros which currently have a patched grub which will execute the EFI stub when EFI booting, both for 32 bits and for 64 bit grub builds ?
>>
>> If I understand this correctly the 32 bit grub UEFI binaries will need to boot through the x86 boot protocol now instead of using the EFI stub. Will the current (distro patched) UEFI grub binaries be able to detect stub support is missing and then automatically fall back to the x86 boot protocol? I doubt that the current EFI handover / stub support patches in grub actually do this.
>>
> 
> As mentioned in the commit log, Debian's GRUB already does this.

Right in my memories Debian's GRUB actually never uses the stub at all, not even in 64 bit mode. At least IIRC one of the times I had issues with UEFI booting using the x86 boot proto on a 64 bit UEFI machine was actually with Debian and swapping Debian's grub for Fedora's grub fixed things.

Maybe they have separate linux and efilinux commands for grub, one to boot using the x86 boot proto and one to use the efistub ?

> However, as far as I can tell, its mixed mode support never enters via
> the stub, so I imagine Fedora's GRUB behaves differently in this
> regard.

I believe that Fedora's grub does use the stub when booting on both 32 bit and 64 bit UEFI. Is there an easy way to verify this ?  I guess one cannot just add a printk to the stub ...

>> AFAICT this would mean that if this lands in lets say 6.7 and that lets say Fedora 39 then moves to 6.7 once approx. 6.7.4 is out all Fedora 40 x86_64 installs done on low-end machines using 32 bit UEFI will then stop booting ?
>>
> 
> Of course, this is not the intent.
> 
>> And this will also completely break booting 64 bit kernels on 32 bit UEFI using systemd-boot.
>> systemd-boot exclusively relies on the UEFI stub, since the whole concept of system-boot is to do as little as possible and rely on UEFI for pretty much everything. As such I also consider it quite unlikely that systemd-boot will ever get support for the x86 boot protocol.
>>
> 
> I don't think it will. I didn't realize systemd-boot actually went
> ahead with this, although I did get pulled into some discussions about
> this a while ago.

systemd did went ahead with this, support for this was merged here:
https://github.com/systemd/systemd/pull/22550

> So, to be clear, mixed mode boot using systemd-boot is a supported
> configuration on Fedora?

We offer systemd-boot as an alternative bootloader and some people are using it. Also there are discussions in Fedora to outright switch to systemd-boot for UEFI installs because of its much simpler and smaller code base.

>> Another thing to consider is that booting through the stub tends to be more reliable then using grub. There is a reason why Fedora has been patched grub to use the stub even long before 32/64 bit mixed mode support was implemented. I've more then once seen 64 bit UEFI systems where upstream grub would fail to boot the system, where as a grub patched to handover booting to the EFI stub would boot. And since the often low qualitty of 32 bit UEFI BIOS-es I'm worried that some of them likewise will fail to boot when using the x86 boot protocol.
>>
> 
> I'd argue that the less we involve the boot services on such systems,
> the better it is.
> 
>> I'm sorry, but to me breaking grub distro upgrade paths and completely loosing support for systemd-boot seems like an unacceptable regression.
>>
>> I can understand the desire to remove this hairy code, but the diffstat shows this only removes about 800 lines. Now if we were talking 10 kloc or some such we could maybe look into some sort of migration path.
>>
>> IMHO the balance between amount of cleanups versus the severity of the regressions / lost functionality tips the scale to the regressions being worse then the positve effect of the code cleanup. So based on my current understanding of this I'm against the proposed change.
>>
> 
> Fair enough, thanks for the input.
> 
> I think we all agree that we should not regress or block the upgrade
> path for existing installations that rely on this.

Thanks, that is good to hear.

> The question is
> really for how much longer this needs to be supported, as I imagine
> the set of machines relying on this (and keeping up with the latest
> distro) is shrinking quickly.

Some of these systems are point-of-sale systems running enterprise Linux distros because their vendors/users expect to be able to use them for a long long time.

These use some Bay Trail CPU models for which Intel also offers an extended support lifetime.

So I'm fraid that these will likely be with us for a long time, sorry.

Regards,

Hans


