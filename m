Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54B612E75B
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgABOqk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 09:46:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40591 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgABOqk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 09:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577976398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cs0DxL3L5LViDAAQWBCfgd2galLHmMbEqLpqGODhF8=;
        b=GQm2KGm17wcHVk15qbVULuAP0pbjHNry0vf3AbNP3fz18FjHpEQEJ3ibjaszDOHpj1aS74
        W20U0utgLqKJTt8cbFA0/nqyiML39JpRFWNfXYkQC/qZAwoxTrcKO0q/xCpRT0vUpyW9Zn
        a0TRe6sVPMO2cH1Lg1kyUyqffL7CIkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-_WGNraMBMRCDYdYEAmEmkA-1; Thu, 02 Jan 2020 09:46:32 -0500
X-MC-Unique: _WGNraMBMRCDYdYEAmEmkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16EE2DB6E;
        Thu,  2 Jan 2020 14:46:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-90.ams2.redhat.com [10.36.117.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7FD1CB;
        Thu,  2 Jan 2020 14:46:28 +0000 (UTC)
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CAKv+Gu9-pcUGmpMVrYd+q+DJNU_737fpqwm5O2-yJJbS5KuGeg@mail.gmail.com>
 <F25F57AE-15C5-4240-99D6-F6C93CFDA447@amacapital.net>
 <CAKv+Gu8g8=yMXMNdHee7rsMWNwkhk43ZgbDEwAPHUX6Fj1jscA@mail.gmail.com>
 <20191220194157.GA251736@rani.riverdale.lan>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <fcad423a-6f24-6b86-ff78-2bcad0c73008@redhat.com>
Date:   Thu, 2 Jan 2020 15:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191220194157.GA251736@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/20/19 20:41, Arvind Sankar wrote:
> On Fri, Dec 20, 2019 at 10:11:00AM +0200, Ard Biesheuvel wrote:
>> On Fri, 20 Dec 2019 at 09:17, Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>>
>>>
>>>
>>>> On Dec 20, 2019, at 3:07 PM, Ard Biesheuvel <ard.biesheuvel@linaro.o=
rg> wrote:
>>>>
>>>> =EF=BB=BFOn Thu, 19 Dec 2019 at 22:05, Matthew Garrett <mjg59@google=
.com> wrote:
>>>>>
>>>>>> On Wed, Dec 18, 2019 at 9:03 AM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>>>>>> +       status =3D efi_call_early(create_event, EVT_SIGNAL_EXIT_BO=
OT_SERVICES,
>>>>>> +                               TPL_CALLBACK, handle_exit_boot_ser=
vices_event,
>>>>>> +                               NULL, &exit_boot_services_event);
>>>>>> +       if (status !=3D EFI_SUCCESS) {
>>>>>> +               pr_efi_err("Failed to register for EBS() event\n")=
;
>>>>>> +               goto free_handle;
>>>>>> +       }
>>>>>
>>>>> OVMF's SEV implementation appears to tear down AMD's IOMMU mappings=
 at
>>>>> EVT_SIGNAL_EXIT_BOOT_SERVICES. How are we ensuring that this happen=
s
>>>>> first?
>>>>
>>>> It doesn't, and that is kind of the point. The only guarantee you ha=
ve
>>>> is that this runs before ExitBootServices() returns, but after any
>>>> other callbacks that have been registered. I know this is not 100%
>>>> what you're after, but it is the only way we can avoid poking device=
s
>>>> behind the backs of their drivers.
>>>>
>=20
> Could we add a comment to describe why we have the two-step event
> notification, i.e. to ensure the ordering?
>=20
> Regarding SEV, from what Laszlo had said [1] I had understood that the
> SEV driver left everything blacklisted -- is this necessary at all for
> SEV or did I misunderstand his comment?
>=20
> [1] https://lore.kernel.org/lkml/9c58f2d2-5712-0972-6ea7-092500f37cf9@r=
edhat.com/

Leaving all guest RAM encrypted after EBS may not be a technical
requirement for SEV. It is a security goal, however. The OS should
inherit the most secure environment possible from the firmware, and not
have to look for pages that were left unencrypted.

>>> Can you clarify (in the changelog or a comment perhaps) why you=E2=80=
=99re doing this instead of turning off busmastering before calling ExitB=
ootServices()?  Maybe this was covered in this thread, but I missed it.
>>>
>>
>> Sure. The problem is that EBS() is the place where drivers tear down
>> rings etc and gracefully take down the device. So killing DMA for all
>> of them by clearing the BM bit of every bridge is likely to cause
>> problems, because the teardown code wasn't written with the idea in
>> mind that DMA is no longer possible. On arm64 at least, it may result
>> in the kernel being entered with a pending SError which will kill the
>> OS as soon as they are unmasked. But the UEFI drivers themselves may
>> simply hang or timeout on some DMA access.
>>
>=20
> As I understand it, the order in which we want the bus-mastering
> disable to happen is
> - all PCI device drivers are stopped
> - bus mastering is disabled
> - depending on firmware, iommu might get disabled (probably out of our
>   control)
>=20
> Instead of using the event notifier, could we not explicitly call
> DisconnectController() for all the PCI devices, then disable
> bus-mastering, and only then call ExitBootServices()?

This sounds worth investigating to me.

>>> Also, surely this whole mess is a a design error in EFI, at least whe=
n SEV is involved, and there should be an EFI extension to keep IOMMU ena=
bled.  Or a specified way to *guarantee* that DMA is off when we exit boo=
t services without hackery.
>>
>> The UEFI spec requires that all devices stop doing DMA at
>> ExitBootServices() time, which is why they register for this event and
>> disable DMA in their drivers. So from this pov, the state of the IOMMU
>> is irrelevant since no device should be doing DMA anyway. The UEFI
>> spec does not reason at all about IOMMUs.
>>
>> But indeed, the whole idea that the IOMMU is a 'feature' that you can
>> ignore if you want since it will be in passthrough mode otherwise is
>> misguided, but I'm not sure this is a firmware problem. The desire to
>> be able to run yesterday's OS on today's hardware, especially in the
>> Windows world, resulted in a situation where many security and
>> hardening features are opt-in rather than opt-out, with the adoption
>> you might expect.
>=20
> Looking at the intel iommu driver [2] there is a PCD entry to control
> whether to leave the IOMMU enabled. Is it possible to check its value t=
o
> see whether the bus-master disabling is necessary -- ie IOMMU was
> enabled during boot and its going to get turned off during
> ExitBootServices, or even check whether it's settable and if so set it
> to leave the IOMMU enabled?
>=20
> [2] https://github.com/tianocore/edk2-platforms/blob/0d4d661b5a7cf3114a=
7d81e1c59e5cb57ceaf139/Silicon/Intel/IntelSiliconPkg/Feature/VTd/IntelVTd=
Dxe/DmaProtection.c#L601
>=20

The platform config database is a PI concept, not a UEFI concept. IOW,
EFI_PCD_PROTOCOL is specified in the Platform Init spec, and not the
UEFI spec. A UEFI OS should only rely on the UEFI spec.

Thanks
Laszlo

