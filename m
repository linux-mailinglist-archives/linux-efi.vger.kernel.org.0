Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3326633D4D0
	for <lists+linux-efi@lfdr.de>; Tue, 16 Mar 2021 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhCPNZ5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Mar 2021 09:25:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:52055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234887AbhCPNZ2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Mar 2021 09:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615901115;
        bh=JELzd7mtJYFvg8I5KV8bTQ0uD6TX8eXa+yKBNp0PCd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EH+eTw1pJaINuL0eRGQbH7aEHfZeQuipoNCTmG6nOD9QpGBRj8oKuRVtYOdEs5+5T
         TNnMlWLnSsbDYMeSp36L3NJFi5j5EV4SwkuXw4gHuDMAhIbycthYFmqN7Ul8i8Tsvq
         hSYKDyTsEzhdfy+3+3UFBpCFInSx3DEuCtp5LvYQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([62.143.246.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1lmAia2okZ-018MrX; Tue, 16
 Mar 2021 14:25:15 +0100
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based on
 EFI variable
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Steve McIntyre <steve@einval.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20210307110228.GP17424@dragon>
 <CAMj1kXFiqXwCqJE9Wxu-tc3HYSh1qCqPLL_Csc=gW6SOYrweWw@mail.gmail.com>
 <20210309032248.GR17424@dragon>
 <CAF6AEGu6ZpfFK5FnQjtE33kkYL_t63J=yJLeK70_46FaLPq7eQ@mail.gmail.com>
 <CAMj1kXGwhx9Z-JCw2NvWBYtHbzVb=EmJn_Jfd97wGzDYNQG2Lw@mail.gmail.com>
 <20210315031119.GY17424@dragon>
 <CAMj1kXE1mZm2jYwv80FNVh0m6wHEWqq14+jQWnJSUThnX4Eedw@mail.gmail.com>
 <20210316075214.GA32651@dragon>
 <CAMj1kXHfo9AMZEw9btOPCzso85AS+gQdV5ycmyk8wcqfLaRn8Q@mail.gmail.com>
 <20210316090609.GB32651@dragon> <YFB7Y0FSSXmPEByF@enceladus>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <d3d25724-6777-3c9e-5dbe-0e1570544376@gmx.de>
Date:   Tue, 16 Mar 2021 14:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFB7Y0FSSXmPEByF@enceladus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EZGK3eqG68xFRQEtJh7tqJfDFCWWIfQzQ1Rz2z/1InGLDsBACms
 +giC4lFHS0zQ4ENROJui/KrwA5lTHLYjLCGA+QlAiGdiwnGOKxWrRGKhqzymzU0rS+R1ME2
 tp5dtUUj8AHxeK1rltWZoBC2M1XTsweFvP2HP1SquKhx35BWNA/XZaWt9p21SNOyr4jYgsN
 TRiZK/DogS/T9FBqj9oRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X8Ih26FO0sY=:BEvkBNeTZicvGG5vqh/FSi
 5DCO/3H7BtWojZi0zl7ENOGVu/tVfPR6mq1SMV0A5knQfk1Z8zUcDlupoQghTB+bJ7XP25ati
 ITHKnN0JnC6slexcLzmYYuH3as3Xl6UQ8MGYs0x7DKklfp9kkyqxs/PQfuUiNQbcmEkOXRa/h
 OglbyrlC/P4y8LCiOq/wWAiPs6sdhmhfpGqUCvGQpv6UFDlEvyg9/T3NiawX9R9jOVlJqAo3g
 u3931wpZujJ4k3FjyE1HsWf7PIwq2fONbhWK/7chzBIXNiC6Go+W0+O6fFq/FYKSNMTWwvcGc
 jQ+7dxbTQXdJ9/OH+gmROak458ZLyYpkDW3ZbjoYDEUhzC7gnhIKr5dXn/Fp2OmzvPU0RXb09
 xi3scnBXVM4pToR1Z8ncXcmSPeGFu1Z0sl/jQ67+Fni45fzxhoyWPBXNsqYC8DBkBS84AbLJR
 Sg4rWUz9PVkCxuIPvXn9IzJXrNahl6oevmpaGHg0P1tXaYOXnlDGPseLRjv4As/MttZooRRwY
 YIX1STJzINC4hFq2lao0J0kA2LXa87pmsqvDQ+IRbkDASl7TvMwCe6+7q8mhZmnZEccuexIma
 4ibgqueAl6m7JCxDPTf6kgPrzJ+yjP58Kne+L7ho7EloBuBrzf4O1FeeaGtgenvp1ENLyXLIQ
 cqGpFo9nSM1NzNn5wqsCcw85mTGVFapfoNxs4tMEwEOIAsYJBnvTlswdzj9ZHrBj2MSe0OjFl
 SI8UJpctJ1m2BFYNFxjIEEaobdybbNsaSTQ0+e9YczRMy2Y1XlQ7qZLHWd1fMPRMq5kZDraea
 8nmD74hrgvgW5eaFnfOumDz3GJyIkcQuw94UTxj7S9HKX0i9RZ+XESeduKrO/h6/Vep0JaEQe
 wh6TXMzI+jD+H/nhbgKA==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 16.03.21 10:33, Ilias Apalodimas wrote:
> Hi Shawn,
>
>>>>>>> So an installer either needs to set the EFI variable, or pass
>>>>>>> efi=3Dnovamap on the first boot. Note that there are no arm64 EFI
>>>>>>> systems known where efi=3Dnovamap causes problems. In fact, I woul=
d
>>>>>>> prefer to stop using SetVirtualAddressMap() altogether, as it does=
 not
>>>>>>> provide any benefit whatsoever. So perhaps we should make efi=3Dno=
vamap
>>>>>>> the default and be done with it.
>>>>>>>
>>>>>>> Broken poweroff is hardly a showstopper for an installer, given th=
at
>>>>>>> we cannot even install GRUB correctly.
>>>>>>>
>>>>>>> In summary, I am more than happy to collaborate constructively on =
this
>>>>>>> (which is why I wrote the patch), but I don't think we're at a poi=
nt
>>>>>>> yet where this is the only thing standing in our way when it comes=
 to
>>>>>>> a smooth out-of-the-box Linux installation experience.
>>>>>>
>>>>>> There might be more to be done for getting a smooth Linux installat=
ion
>>>>>> experience.  But IMHO, this `OverrideSupported` thing is definitely
>>>>>> a big step to that.
>>>>>>
>>>>>
>>>>> So the problem here seems to be that grub-install (or efibootmgr)
>>>>> tolerates efivarfs being absent entirely, but bails out if it exists
>>>>> but gives an error when trying to access it, right?
>>>>
>>>> Yes, with EFI variables runtime service marked as unsupported,
>>>> efibootmgr will just exit on efi_variables_supported() check [1] in
>>>> a way that its parent process, i.e. grub-install, doesn't take as an
>>>> error.  But otherwise, efibootmgr will go much further and exit with
>>>> a real error when trying to access efivars.
>>>>
>>>
>>> OK, so I suggest we fix efibootmgr, by extending the
>>> efi_variables_supported() check to perform a GetVariable() call on an
>>> arbitrary variable (e.g., BootOrder),
>>
>> Hmm, I'm not sure we should ask more from user space, as it's already
>> been doing the right thing, and efi_variables_supported() is proved to
>> work properly with any sane low-level software (kernel + firmware),
>> either EFI variables service is supported or not.  That said, IMHO,

No, there is not one but there are three EFI variable services.

GetVariable() available after ExitBootServices() and SetVariable() not
available() is completely legal according to the current UEFI specificatio=
n.

>> right now the low-level software on Snapdragon laptops is insane, i.e.
>> the unsupported/broken EFI runtime services are not communicated to
>> user space properly in established way.

Please, describe:

* Which UEFI version is reported by your Snapdragon laptop?
* What is the observed behavior?

>
> But the EFI_UNSUPPORTED is an error that's allowed from the spec.
> Yes the sane thing to do is not expose it at all, but it's not violating
> any spec by doing so.
> So why shouldn't a userspace application be able to handle all return co=
des
> explicitly and instead treat them as a single error? And when that happe=
ns why
> should the kernel mask that error out for it?

The runtime services must always be callable even they can only report
EFI_UNSUPPORTED.

Only since UEFI specification 2.8 errata B do we have the
EFI_RT_PROPERTIES_TABLE which tells us which runtime services are
implemented.

UEFI 2.8 B makes it clear that any runtime service may be reported as
unsupported. EFI applications are expected to cope with a service being
unavailable.

For embedded systems we have the EBBR specification which specifies that
the SetVariable() runtime service is not required to be implemented at
runtime
(https://github.com/ARM-software/ebbr/blob/main/source/chapter2-uefi.rst#u=
efi-runtime-services).
Ony SetVirtualAddressMap() and ConvertPointer() are required by the EBBR.

Software should not mess with EFI variables without explicit consent by
the user. In this respect GRUB is a real nuisance. Given a Windows
computer installing GRUB changes the BootOrder variable. This results in
a system that directly starts into GRUB instead of Windows. GRUB
provides a menu entry for Windows that cannot boot because it conflicts
with Windows measured boot.

Best regards

Heinrich

>
> Thanks
> /Ilias
>>
>> Shawn
>>
>>> and treat EFI_UNSUPPORTED as a
>>> special case that means that carrying on is pointless.
>>>
>>> (but someone please confirm that the snapdragon efi firmware does
>>> return EFI_UNSUPPORTED and not some other return value when calling
>>> GetVariable() from under the OS)

