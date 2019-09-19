Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFCB8087
	for <lists+linux-efi@lfdr.de>; Thu, 19 Sep 2019 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfISSBx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Sep 2019 14:01:53 -0400
Received: from bear.techie.net ([205.134.185.202]:38512 "EHLO bear.techie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389114AbfISSBx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Sep 2019 14:01:53 -0400
Received: by bear.techie.net (Postfix, from userid 545)
        id 4DF7E22A0951; Thu, 19 Sep 2019 14:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=techie.net; s=default;
        t=1568916112; bh=Ij82XtQInROv8wfez7eqNzdkFhje3hpYfIIEz2dPhBs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zeOTARKa6AY45YPFtLflBUFm7lJQtKmSo0Nn8snL13N3n7lffuYAJIiPWl1wIzBqJ
         DePbaO0xUlbWpHFNFFmQY3JzG1Coc7qzoqmVpC8PVAbVfodqSahRzM5E7U+TocB4ON
         MkcwgMXhYVlNBVuM34wRxp2x0PPSUtBBE01m2xpg=
Received: from localhost (localhost [127.0.0.1])
        by bear.techie.net (Postfix) with ESMTP id 31DBC22A094B;
        Thu, 19 Sep 2019 14:01:52 -0400 (EDT)
Date:   Thu, 19 Sep 2019 14:01:52 -0400 (EDT)
From:   Scott Talbert <swt@techie.net>
X-X-Sender: talbert@bear.techie.net
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi: don't iterate over EFI vars pointlessly if no SSDT
 override was specified
In-Reply-To: <CAKv+Gu95wtjPXRUF=wK3-Y6+zNcvaqpr+T4Z4-wV3OJH+oNgVg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909191400240.3069@bear.techie.net>
References: <20190911233239.5916-1-ard.biesheuvel@linaro.org> <alpine.DEB.2.21.1909121533270.30174@bear.techie.net> <CAKv+Gu95wtjPXRUF=wK3-Y6+zNcvaqpr+T4Z4-wV3OJH+oNgVg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Sep 2019, Ard Biesheuvel wrote:

>>> The kernel command line option efivar_ssdt= allows a EFI variable name
>>> to be specified which contains an ACPI SSDT table that will be loaded
>>> into memory by the OS.
>>>
>>> Currently, that code will always iterate over the EFI variables and
>>> compare each name with the provided name, even if the command line
>>> option wasn't set to begin with.
>>>
>>> So bail early when no variable name was provided.
>>>
>>> Cc: Scott Talbert <swt@techie.net>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> drivers/firmware/efi/efi.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>>> index ad3b1f4866b3..8f020827cdd3 100644
>>> --- a/drivers/firmware/efi/efi.c
>>> +++ b/drivers/firmware/efi/efi.c
>>> @@ -282,6 +282,9 @@ static __init int efivar_ssdt_load(void)
>>>       void *data;
>>>       int ret;
>>>
>>> +     if (!efivar_ssdt[0])
>>> +             return 0;
>>> +
>>>       ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
>>>
>>>       list_for_each_entry_safe(entry, aux, &entries, list) {
>>
>> Thanks for the quick fix!
>>
>> I can confirm this fixes booting on my Mac Pro 2012 system when applied to
>> 5.3-rc7.
>>
>> Whenever this makes it in, if it could be targeted for the stable kernels
>> as well, that would be appreciated.
>>
>
> I'll send it out as a fix with a cc to -stable.

Hi - just a quick reminder on this as I don't see it in Linus' tree yet. 
Not that I need it urgently, but just want to make sure it isn't 
forgotten.

Thanks,
Scott
