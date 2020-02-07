Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9D155474
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 10:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBGJWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 04:22:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgBGJWx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 04:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581067371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9G854gH0yt32vL5cWXqi6Q0NJ8XwpZFZsqnHu0e32+o=;
        b=ANcxrCYb+7DBgoK0lwmyTR6bJKpr+myxvj0MHbb2l6+gRvwGQ+yh1Iqk+BIELU21RThqct
        Gc20yaWujQ8t5dUgkUuo6Jpx3n74QgveN04mJvyjme2a+kkIITyrwvOOmQ8LcIAm8P1adv
        eAU+irEPIwirSYOT9qvzq0ySiOg/vhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-1bZ4vXbeOeOcU3F6bYifiw-1; Fri, 07 Feb 2020 04:22:49 -0500
X-MC-Unique: 1bZ4vXbeOeOcU3F6bYifiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C36A1088382;
        Fri,  7 Feb 2020 09:22:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9DD1001B05;
        Fri,  7 Feb 2020 09:22:45 +0000 (UTC)
Subject: Re: [PATCH 0/2] arch-agnostic initrd loading method for EFI systems
From:   Laszlo Ersek <lersek@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com
References: <20200206140352.6300-1-ardb@kernel.org>
 <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
Message-ID: <cfb38b38-14f2-c61a-60a0-dfe14667b49c@redhat.com>
Date:   Fri, 7 Feb 2020 10:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fa3b3103-e77d-571d-71a4-604fa48368e6@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/07/20 10:09, Laszlo Ersek wrote:
> On 02/06/20 15:03, Ard Biesheuvel wrote:
>> This series introduces an arch agnostic way of loading the initrd into
>> memory from the EFI stub. This addresses a number of shortcomings that
>> affect the current implementations that exist across architectures:
>>
>> - The initrd=<file> command line option can only load files that reside
>>   on the same file system that the kernel itself was loaded from, which
>>   requires the bootloader or firmware to expose that file system via the
>>   appropriate EFI protocol, which is not always feasible. From the kernel
>>   side, this protocol is problematic since it is incompatible with mixed
>>   mode on x86 (this is due to the fact that some of its methods have
>>   prototypes that are difficult to marshall)
>>
>> - The approach that is ordinarily taken by GRUB is to load the initrd into
>>   memory, and pass it to the kernel proper via the bootparams structure or
>>   via the device tree. This requires the boot loader to have an understanding
>>   of those structures, which are not always set in stone, and of the policies
>>   around where the initrd may be loaded into memory. In the ARM case, it
>>   requires GRUB to modify the hardware description provided by the firmware,
>>   given that the initrd base and offset in memory are passed via the same
>>   data structure. It also creates a time window where the initrd data sits
>>   in memory, and can potentially be corrupted before the kernel is booted.
>>
>> Considering that we will soon have new users of these interfaces (EFI for
>> kvmtool on ARM, RISC-V in u-boot, etc), it makes sense to add a generic
>> interface now, before having another wave of bespoke arch specific code
>> coming in.
>>
>> Another aspect to take into account is that support for UEFI secure boot
>> and measured boot is being taken into the upstream, and being able to
>> rely on the PE entry point for booting any architecture makes the GRUB
>> vs shim story much cleaner, as we should be able to rely on LoadImage
>> and StartImage on all architectures, while retaining the ability to
>> load initrds from anywhere.
>>
>> Note that these patches depend on a fair amount of cleanup work that I
>> am targetting for v5.7. Branch can be found at:
>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-unification2
>>
>> An implementation for ArmVirtQemu (OVMF for ARM aka AAVMF) can be found
>> at https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic.
>> The change is for ARM only, but the exact same code could be used on x86.
> 
> I like this ArmVirtQemu feature, but I think it should be implemented as
> an addition, rather than a replacement. Older kernels (older EFI stubs)
> will try to fetch the initrd from the same fs where grub loaded the
> kernel from (exactly as you describe in the blurb).
> 
> For example, virt-install's "--location" option "can recognize certain
> distribution trees and fetches a bootable kernel/initrd pair to launch
> the install". It would be nice to keep that working for older distros.
> 
> I think LoadFile[2] can co-exist with SimpleFs.
> 
> I also think that the "try SimpleFs first, fall back to LoadFile[2]
> second" requirement applies only to the UEFI boot manager, and not to
> the kernel's EFI stub. IOW in the new approach the kernel is free to
> ignore (abandon) the old approach for good.

... But that might not be good for compatibility with grub and/or the
platform firmware, from the kernel's own perspective, perhaps?...

Who is supposed to produce LoadFile2 with the new VenMedia devpath?

Thanks
Laszlo

>>
>> Cc: lersek@redhat.com
>> Cc: leif@nuviainc.com
>> Cc: pjones@redhat.com
>> Cc: mjg59@google.com
>> Cc: agraf@csgraf.de
>> Cc: ilias.apalodimas@linaro.org
>> Cc: xypron.glpk@gmx.de 
>> Cc: daniel.kiper@oracle.com
>>
>> Ard Biesheuvel (2):
>>   efi/libstub: add support for loading the initrd from a device path
>>   efi/libstub: take noinitrd cmdline argument into account for devpath
>>     initrd
>>
>>  drivers/firmware/efi/libstub/arm-stub.c       | 21 ++++--
>>  .../firmware/efi/libstub/efi-stub-helper.c    | 74 +++++++++++++++++++
>>  drivers/firmware/efi/libstub/efistub.h        | 13 ++++
>>  drivers/firmware/efi/libstub/x86-stub.c       | 51 ++++++++++---
>>  include/linux/efi.h                           |  1 +
>>  5 files changed, 146 insertions(+), 14 deletions(-)
>>
> 

