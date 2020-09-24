Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71C02764DA
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 02:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIXADP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 20:03:15 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:44786 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIXADP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Sep 2020 20:03:15 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 08O02lcW002993; Thu, 24 Sep 2020 09:02:47 +0900
X-Iguazu-Qid: 34trYbPuXK3Y6WokyV
X-Iguazu-QSIG: v=2; s=0; t=1600905766; q=34trYbPuXK3Y6WokyV; m=0KDuZXTtA84FWvgU79W3hotyFURS5UbU6LM7nkZ0KNg=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1511) id 08O02iHp036909;
        Thu, 24 Sep 2020 09:02:44 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 08O02iOw020352;
        Thu, 24 Sep 2020 09:02:44 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 08O02h4O023471;
        Thu, 24 Sep 2020 09:02:43 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
        <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
        <20200923140512.GJ28545@zn.tnic>
Date:   Thu, 24 Sep 2020 09:02:42 +0900
In-Reply-To: <20200923140512.GJ28545@zn.tnic> (Borislav Petkov's message of
        "Wed, 23 Sep 2020 16:05:12 +0200")
X-TSB-HOP: ON
Message-ID: <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> Smita,
>
> pls sync the time of the box where you create the patch:
>
>  Date: Fri,  4 Sep 2020 09:04:44 -0500
>
> but your mail headers have:
>
>  Received: from ... with mapi id 15.20.3370.019; Fri, 18 Sep 2020 14:49:12 +0000
>  						^^^^^^^^^^^^^^^^^^
>
> On Wed, Sep 23, 2020 at 07:07:17PM +0900, Punit Agrawal wrote:
>> I know Boris asked you to add the reason for the Reported-by, but
>> usually we don't track version differences in the committed patch.
>> 
>> Boris, can you confirm if you want the Reported-by to be retained?
>
> How else would you explain what the Reported-by: tag is for on a patch
> which adds a feature?

As Ard clarified, I was questioning the inclusion of the Reported-by:
tag in the patch itself. But I also don't have enough of a strong
opinion to obsess about it.

[ Aside: One interesting consequence of this though is that by the same
argument, changes resulting from comments on earlier versions are also
legitimate content for the final patch. Not saying I agree. ]

>
>> > + * The first expected register in the register layout of MCAX address space.
>> > + * The address defined must match with the first MSR address extracted from
>> > + * BERT which in SMCA systems is the bank's MCA_STATUS register.
>> > + *
>> > + * Note that the decoding of the raw MSR values in BERT is implementation
>> > + * specific and follows register offset order of MCAX address space.
>> > + */
>> > +#define MASK_MCA_STATUS 0xC0002001
>> 
>> The macro value is already defined in mce.h as
>> MSR_AMD64_SMCA_MC0_STATUS.  Is there any reason to not use it?
>
> Good point.
>
>> You can move the comment to where you check the status register.
>
> No need if he really wants to use the first MCi_STATUS address.
>
>> > +	m.apicid = lapic_id;
>> > +	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
>> > +	m.status = *i_mce;
>> > +	m.addr = *(i_mce + 1);
>> > +	m.misc = *(i_mce + 2);
>> > +	/* Skipping MCA_CONFIG */
>> > +	m.ipid = *(i_mce + 4);
>> > +	m.synd = *(i_mce + 5);
>> 
>> Instead of using the raw pointer arithmetic, it is better to define a
>> structure for the MCA registers? Something like -
>> 
>>     struct {
>>         u64 addr;
>>         u64 misc;
>>         u64 config;
>>         u64 ipid;
>>         ...
>>     }
>> 
>> Checking back, this was mentioned in the previous review comments as
>> well. Please address all comments before posting a new version - either
>> by following the suggestion or explaining why it is not a good idea.
>
> Well, that was addressed in his reply last time:
>
> https://lkml.kernel.org/r/a28aa613-8353-0052-31f6-34bc733abf59@amd.com

Oops. My bad - sorry I missed the response.

Copying the relevant comment here for discussion -

>>> The registers here are implementation specific and applies only for
>>> SMCA systems. So I have used pointer arithmetic as it is not defined
>>> in the spec.

Even though it's not defined in the UEFI spec, it doesn't mean a
structure definition cannot be created. After all, the patch is relying
on some guarantee of the meaning of the values and their ordering.

If the patch is relying on the definitions in the SMCA spec it is a good
idea to reference it here - both for review and providing relevant
context for future developers.

> You might've missed it because you weren't CCed directly.

Indeed, I missed it. Thanks for the pointer.

Cheers,
Punit
