Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577EA15593A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 15:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGOZE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 09:25:04 -0500
Received: from mail.csgraf.de ([188.138.100.120]:43476 "EHLO
        zulu616.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOZE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 09:25:04 -0500
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 09:25:03 EST
Received: from 38f9d3867b82.ant.amazon.com (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com [3.122.114.9])
        by csgraf.de (Postfix) with ESMTPSA id 48DB43900464;
        Fri,  7 Feb 2020 15:18:11 +0100 (CET)
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
References: <20200206140352.6300-1-ardb@kernel.org>
 <20200206140352.6300-2-ardb@kernel.org>
 <a6d7fefb-2f02-86a3-66aa-c3c129a91fb1@gmx.de>
 <CAKv+Gu9Z24GeqrqKhPJN+aAu8crSKvT0ZBeFL=0ik=z2Sd1FmQ@mail.gmail.com>
 <b2535bc9-f9be-e250-4da1-bce0b67abb6f@gmx.de>
 <CAKv+Gu-X6DKhtbfVgRLPomkkKJ7=4vRs-crLL0p7E7043J4H0g@mail.gmail.com>
 <081d152a-fa9b-886a-565d-b244dea08cd5@gmx.de>
 <CAKv+Gu-f9O4eon_E7=OUu_tNwybi7u6bF2zMowPHbA-MhiTjNg@mail.gmail.com>
 <9e7c378a-782f-f56e-2ce3-0af6386b0bff@gmx.de>
 <CAKv+Gu_++Uwky51i2rpNmXWVhvneDxANsaJU=BKw+6NWzTxXCw@mail.gmail.com>
From:   Alexander Graf <agraf@csgraf.de>
Message-ID: <ba00f9d2-c159-912b-35b4-30895186fe74@csgraf.de>
Date:   Fri, 7 Feb 2020 15:18:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_++Uwky51i2rpNmXWVhvneDxANsaJU=BKw+6NWzTxXCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 07.02.20 13:58, Ard Biesheuvel wrote:
> On Fri, 7 Feb 2020 at 13:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>>
>> On 2/7/20 9:12 AM, Ard Biesheuvel wrote:
>>> On Fri, 7 Feb 2020 at 00:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>>> On 2/7/20 1:21 AM, Ard Biesheuvel wrote:
>>>>> On Fri, 7 Feb 2020 at 00:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>>>>> On 2/6/20 11:35 PM, Ard Biesheuvel wrote:
>>>>>>> On Thu, 6 Feb 2020 at 18:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>> ...
>>>>>>>> Please, indicate which software you expect to expose the initrd related
>>>>>>>> EFI_LOAD_FILE2_PROTOCOL.
>>>>>>>>
>>>>>>> The primary use case is GRUB and other intermediate loaders, since it
>>>>>>> would remove any need for these components to know any such details.
>>>>>>> My aim is to make the next architecture that gets added to GRUB for
>>>>>>> EFI boot 100% generic.
>>>>>>>
>>>>>>>> Using an UEFI variable for passing the initrd device path would be a
>>>>>>>> leaner solution on the bootloader side than requiring an extra
>>>>>>>> EFI_LOAD_FILE2_PROTOCOL implementation.
>>>>>>>>
>>>>>>> This would also require kernel changes, since we don't currently load
>>>>>>> initrds from arbitrary device paths. The EFI_FILE_PROTOCOL is much
>>>>>>> more complicated than needed, and it doesn't work well with mixed
>>>>>>> mode. It also requires GRUB to expose the filesystem it loads the
>>>>>>> initrd from via EFI protocols, which is currently unnecessary and
>>>>>>> therefore not implemented.
>>>>>> This means you move the complexity of EFI_FILE_PROTOCOL from Linux to GRUB.
>>>>>>
>>>>> No. I am not interested in EFI_FILE_PROTOCOL, only in LoadFile2, which
>>>>> is a single method that needs to be implemented.
>>>> I said you move complexity because GRUB will need to use the
>>>> EFI_FILE_PROTOCOL to do the job that you do not want to do in Linux.
>>>>
>>>>>> I would not have a problem if this would only touch GRUB. But if listen
>>>>>> to Ilias we are replacing one implementation in Linux by one in GRUB and
>>>>>> one in U-Boot and one in EDK2 and one in any other firmware.
>>>>>>
>>>>> If u-boot will be used to boot RISC-V in EFI mode without GRUB, then I
>>>>> expect that we will need an implementation of this in u-boot.
>>>> What sets RISC-V apart? GRUB for RISC-V is available.
>>    >>
>>> RISC-V EFI boot is not supported yet in upstream Linux.
>> It is currently prepared Atish Patra of WDC.
>>
> Exactly. So it is not in the upstream yet, and I want to converge on a
> sane generic interface before it gets merged.
>
>>>>>>> Also, using an EFI variable defeats the purpose. The whole point of
>>>>>>> this is making it more likely that the kernel loaded the initrd that
>>>>>>> the bootloader or firmware intended it to load, and having a piece of
>>>>>>> simple [signed] code that implements this is the easiest way to
>>>>>>> achieve that.
>>>>>> At least on my Debian system it is the operating system creating initrd
>>>>>> and defining which initrd matches which kernel. GRUB simply assumes that
>>>>>> files ending on the same version number match. Therefore I would say
>>>>>> Linux hopes that GRUB loads what Linux intended.
>>>>>>
>>>>>> The chain of trust would not be broken if the kernel were responsible
>>>>>> for loading the initrd and for checking if it matches the kernel. Linux
>>>>>> already does this for the kernel modules in initrd.
>>>>>>
>>>>> We can still sign the initrd and Linux can verify the signature. What
>>>>> I am after is an interface that does not require the initrd to
>>>>> originate from a EFI file system protocol, and which doesn't require
>>>>> the loaded initrd to sit in memory for an unspecified amount of time
>>>>> and its information passed via DT properties or bootparams structs.
>>>>>
>>>>> So invoking EFI_FILE_PROTOCOL directly is not going to work,
>>>>> regardless of whether we get the devicepath from the command line or
>>>>> from a EFI variable.
>>>> What do you mean by "is not going to work"?
>>>>
>>>> With the device path you can find the handle implementing the
>>>> EFI_SIMPLE_FIL_SYSTEM_PROTOCOL.
>>>>
>>>>>>> For u-boot, it should be trivial to implement a simple LoadFile2
>>>>>>> protocol wrapper around EFI_FILE_PROTOCOL that can be installed on a
>>>>>>> handle that also carries EFI_FILE_PROTOCOL.
>>>>>>>
>>>>>> A U-Boot implementation of the EFI_LOAD_FILE2_PROTOCOL would need a
>>>>>> device path variable to find the block device and to open the
>>>>>> EFI_SIMPLE_FILE_SYSTEM_PROTOCOL before accessing the file.
>>>>>>
>>>>>> Linux would not be needing more lines and we would not repeat the same
>>>>>> code in GRUB, U-Boot, EDK2, etc.
>>>>>>
>>>>>> As said Linux updates the initrd often. If that file is not signed by
>>>>>> Linux in a well defined way, do not expect any security at all.
>>>>>>
>>>>> It is not only about security. The primary goal is to remove the need
>>>>> for arch specific knowledge in the firmware about DT, bootparams and
>>>>> initrd allocation policies without being forced to load the initrd
>>>>> from a filesystem that is exposed via a EFI protocol.
>>>> Where are device-trees touched by this patch?
>>>>
>>>> When booting via UEFI there is no need for knowledge of initrd
>>>> allocation policies in U-Boot because up to now Linux or GRUB or iPXE
>>>> load initrd.
>>>>
>>>> Furthermore I need no knowledge of bootparams in U-Boot once we properly
>>>> we support UEFI variables at runtime because grub-update will pass the
>>>> command line in one of the Bootxxxx UEFI variables.
>>>>
>>>> But most importantly I do not have to implement anything Linux specific
>>>> in U-Boot for booting via UEFI up to now.
>>>>
>>> Adding Linux specific stuff to u-boot is arguably more appropriate
>>> than adding architecture specific stuff to EFI loaders that could
>>> otherwise be entirely generic.
>>>
>>> ...
>>>> Your patch claims to fend off a specific threat scenario: A user puts an
>>>> untrusted initrd on the disk and references it in the Linux command line.
>>>>
>>>> If he is able to do so with your current bootloader (signed or not
>>>> signed), he most probably will also be able to delete a good initrd from
>>>> the filesystem and thus force your code into the unsafe path.
>>>>
>>>> That is why I say that with the current fallback logic this patch
>>>> achieves no increase in security. Of cause you could remove the fallback
>>>> logic. But in this case your Linux will not boot with any legacy
>>>> bootloader or firmware.
>>>>
>>> If there is a better way to expose the initrd that
>>> a) does not require the initrd to reside on a file system that is
>>> accessible via EFI protocols, and
>>> b) does not require the loader to know about arch specific policies
>>> regarding the placement of the initrd in memory, and
>>> c) does not leave a time window between the time that the initrd is
>>> loaded/verified/measured by the firmware and the time that the kernel
>>> gets handed the buffer
>>>
>>> then I am happy to discuss it. This proposal is the best I could come
>>> up with to achieve the above.
>>>
>> Hello Ard,
>>
>> I think part of our different views is that we are thinking about two
>> different use cases which both have their relevance:
>>
>> If I understand you correctly, you are thinking about an embedded device
>> where the kernel and the initrd is essentially part of the firmware
>> provided by the device.
>>
>> I am thinking of a system running a standard Linux distribution like
>> Debian where the initrd is generated by the operating system
>>
>> In both use cases verifying the initrd is of importance.
>>
>> Now concerning the requirements:
>>
>> a) In U-Boot all file systems on block devices can be made accessible
>> via EFI protocols. Are you thinking about initrds that are not in a file
>> system?
>>
> The typical GRUB deployment keeps the core GRUB itself (or the entire
> thing if it is built as standalone) in the ESP, and the GRUB modules,
> kernel images and initrds are in /boot, which is typically not a file
> system that EFI understands. So in that case, initrd= does not work,
> which is why GRUB loads the initrd into memory directly and passes the
> base address and size via DT or bootparams structure.
>
>> b) My suggestion to use a UEFI variable for communicating the device
>> path would not require any arch specific policies either.
>>
> Passing the EFI device path is not going to help us since the initrd
> may not be representable as a device path. That is the whole point,
> actually - this series makes the initrd representable as a device
> path, but in a simple way that doesn't rely on EFI_FILE_PROTOCOL but
> only on EFI_LOAD_FILE2_PROTOCOL, which is *much* simpler.


So if we had support in grub to just export its own file systems as UEFI 
protocols, that problem would disappear, right? What other reasons are 
left to not just use normal file load operations from the Linux EFI stub?

IIRC you mentioned that the fwcfg -kernel and -initrd parameters are 
already exposed as pseudo filesystem inside AAVMF, so that one is solved.

I think that only leaves the UEFI shell case? But if you have a UEFI 
shell, then you can only load from an existing file system as well, no?

What I can't quite grasp yet is how you would handle multiple initrds 
with a single device path. How would that work?


>
>> c) I proposed that the kernel does the verification. So there would be
>> equally nothing in between loading the file and its verification. Yet
>> responsibilities would be changed.
>>
>> But possibly I missed some requirements you have in mind that I should
>> consider.
>>
> 1) The assumption that the initrd can always be loaded from a EFI
> device path directly does not hold.


Can you think of good reasons why this is true? I understand the grub 
one, but that's solvable. What other cases are there?


> 2) Loading the initrd into memory and passing the address and size is
> not acceptable.


This would basically be the option to pass the initrd as configuration 
table, right? The only reason that definitely goes against that one that 
I can think of right now is to avoid double copying?


> 3) Having a special device path that designates the initrd
> specifically (which will be treated in a special way by the kernel)
> makes it very easy for the boot firmware to attach policy to the
> loading of the initrd that can be enforced right when the file is
> being passed into the kernel.


I don't fully understand this one. Can you give examples for such 
policies? :)


> Putting an arbitrary device path in a EFI variable doesn't address 1),
> and it complicates 3), since you cannot easily distinguish whether the
> file load that is occurring is the EFI stub loading the initrd at
> boot.


Why do we need to distinguish? I'm missing creativity for the use case 
right now. For 1), we just need to make sure that boot loaders that 
implement their own file systems also expose those file systems as UEFI 
protocols, right?


That said, I don't think the proposed approach of using 
EFI_LOAD_FILE2_PROTOCOL is bad. Whatever we do, we always will need to 
treat initrds special in one way or another; at least by exposing a 
command to specify which one(s) you want to load.


Alex


