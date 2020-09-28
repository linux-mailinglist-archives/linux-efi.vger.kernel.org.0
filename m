Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F027A94A
	for <lists+linux-efi@lfdr.de>; Mon, 28 Sep 2020 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1IHR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Sep 2020 04:07:17 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:50596 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1IHR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Sep 2020 04:07:17 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 08S86hJQ020143; Mon, 28 Sep 2020 17:06:43 +0900
X-Iguazu-Qid: 2wHHD8Mc0ow5N7A8gs
X-Iguazu-QSIG: v=2; s=0; t=1601280402; q=2wHHD8Mc0ow5N7A8gs; m=wyJW3X7i3huENYMQ7/lLyT141B4MpZI3/qHSzRMZx5Y=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 08S86eGE006235;
        Mon, 28 Sep 2020 17:06:40 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 08S86elB000843;
        Mon, 28 Sep 2020 17:06:40 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 08S86c4l003317;
        Mon, 28 Sep 2020 17:06:39 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
        <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
        <20200923140512.GJ28545@zn.tnic>
        <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
        <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
        <20200924175023.GN5030@zn.tnic>
        <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
        <20200925161940.GA21194@yaz-nikka.amd.com>
Date:   Mon, 28 Sep 2020 17:06:36 +0900
X-TSB-HOP: ON
Message-ID: <87lfgugwab.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Yazen Ghannam <yazen.ghannam@amd.com> writes:

> On Fri, Sep 25, 2020 at 09:54:06AM +0900, Punit Agrawal wrote:
>> Borislav Petkov <bp@alien8.de> writes:
>> 
>> > On Thu, Sep 24, 2020 at 12:23:27PM -0500, Smita Koralahalli Channabasappa wrote:
>> >> > Even though it's not defined in the UEFI spec, it doesn't mean a
>> >> > structure definition cannot be created.
>> >
>> > Created for what? That structure better have a big fat comment above it, what
>> > firmware generates its layout.
>> 
>> Maybe I could've used a better choice of words - I meant to define a
>> structure with meaningful member names to replace the *(ptr + i)
>> accesses in the patch.
>> 
>> The requirement for documenting the record layout doesn't change -
>> whether using raw pointer arithmetic vs a structure definition.
>> 
>> >> > After all, the patch is relying on some guarantee of the meaning of
>> >> > the values and their ordering.
>> >
>> > AFAICT, this looks like an ad-hoc definition and the moment they change
>> > it in some future revision, that struct of yours becomes invalid so we'd
>> > need to add another one.
>> 
>> If there's no spec backing the current layout, then it'll indeed be an
>> ad-hoc definition of a structure in the kernel. But considering that
>> it's part of firmware / OS interface for an important part of the RAS
>> story I would hope that the code is based on a spec - having that
>> reference included would help maintainability.
>> 
>> Incompatible changes will indeed break the assumptions in the kernel and
>> code will need to be updated - regardless of the choice of kernel
>> implementation; pointer arithmetic, structure definition - ad-hoc or
>> spec provided.
>> 
>> Having versioning will allow running older kernels on newer hardware and
>> vice versa - but I don't see why that is important only when using a
>> structure based access.
>>
>
> There is no versioning option for the x86 context info structure in the
> UEFI spec, so I don't think there'd be a clean way to include version
> information.
>
> The format of the data in the context info is not totally ad-hoc, and it
> does follow the UEFI spec. The "Register Array" field is raw data. This
> may follow one of the predefined formats in the UEFI spec like the "X64
> Register State", etc. Or, in the case of MSR and Memory Mapped
> Registers, this is a raw dump of the registers starting from the address
> shown in the structure. The two values that can be changed are the
> starting address and the array size. These two together provide a window
> to the registers. The registers are fixed, so a single context info
> struture should include a single contiguous range of registers. Multiple
> context info structures can be provided to include registers from
> different, non-contiguous ranges.
>
> This patch is checking if an MSR context info structure lines up with
> the MCAX register space used on Scalable MCA systems. This register
> space is defined in the AMD Processor Programming Reference for various
> products. This is considered a hardware feature extension, so the
> existing register layout won't change though new registers may be added.
> A layout change would require moving to another register space which is
> what happened going from legacy MCA (starting at address 0x400) to MCAX
> (starting at address 0xC0002000) registers.

Thanks for the SMCA related background.
>
> The only two things firmware can change are from what address does the
> info start and where does the info end. So the implementation-specific
> details here are that currently the starting address is MCA_STATUS (in
> MCAX space) for a bank and the remaining info includes the other MCA
> registers for this bank.
>
> So I think the kernel can be strict with this format, i.e. the two
> variables match what we're looking for. This patch already has a check
> on the starting address. It should also include a check that "Register
> Array Size" is large enough to include all the registers we want to
> extract. If the format doesn't match, then we fall back to a raw dump
> of the data like we have today.
>
> Or the kernel can be more flexible and try to find the window of
> registers based on the starting address. I think this is really
> open-ended though.

I think I understand the hesitancy here if the firmware can arbitrarily
move the starting address. Though I hope that doesn't happen as it would
break the feature introduced in $SUBJECT.

The way I read the code / spec led me to believe that the MSR context
info records in the SMCA space are just encoding the layout of MC Bank
registers[0] and making it explicit can only help.

But Boris seems to think the current approach is good enough. So no
objections from me.

Thanks,
Punit

[0] AMD Processor Programming Reference for Family 17H, Sec 3.1.5
