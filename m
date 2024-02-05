Return-Path: <linux-efi+bounces-482-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4500849DC2
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8862B1F2161E
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE02C6A4;
	Mon,  5 Feb 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="JKTd4s3A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726C2C691
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146026; cv=none; b=kFo4jsgr2vsqo+99RCnQft4/aD2GFZ8+J6GqZFlzcra5eoonrkzQvWOiltmlAowzlp+zgK6k14DUm/pYQV0yH6oSg/RPaPaqIUnXZC6Hlfpb5qBaftORH0G4znmWUovplAubi2Mw62qGjbnmoMe8fmSG9KR7zIdyQpf18unR77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146026; c=relaxed/simple;
	bh=4lYUjKZoJoOWbRTMw/ECdwygSiQSym65x3kZQ+jXib0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ef0JIZQ1hCljKWONAquPIixv1SsS+ij7KsyH/moA0UtIGFYzdoDAQ1+LVHfGxe+KUNEL8r89ii73kNAzU2J0jD0QojwuGwFBR9p+nOR5BR5jYTuMUVZGqcok6TVvJTfjFS8UXxZ8SaXuQMVI6frJgvuccWrOMcQ4yO0/ZpuVREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=JKTd4s3A; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from mail.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3BFBC40755CC;
	Mon,  5 Feb 2024 15:13:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3BFBC40755CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707146023;
	bh=+/ZCUSipj8vma/j2Ih2JOe45y9d+pWQC3fI0EOR3BdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKTd4s3AAkXrAZ2GdskaerKpMoG+BHgP6IMKmmBlJvGagzMQ4xuxqGfNMdKl3KRLx
	 Ek1yxdEXGlqar11bTwmG4Ps8lagWk4eKkL1tU/Pu0gS/FcoJFrAcCEQ0voWBqidVaz
	 Kzp6elz8zxORCMtI14q5yRnLYt0Y2XdxESrOO3Yo=
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Feb 2024 18:13:43 +0300
From: Evgeniy Baskov <baskov@ispras.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mike Beaton <mjsbeaton@gmail.com>, Alexey Khoroshilov
 <khoroshilov@ispras.ru>, linux-efi@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot: Order sections by their RVAs
In-Reply-To: <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
References: <cover.1707141974.git.baskov@ispras.ru>
 <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
 <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <62e0169a301b68f2b985d1a8659f1363@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 17:49, Ard Biesheuvel wrote:
> On Mon, 5 Feb 2024 at 14:44, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Image loaders which check the contiguity of executable images consider
>> sections adjacent in the section table to be adjacent in virtual 
>> memory.
>> 
>> Sort sections by their RVAs in PE section table.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/header.S | 56 
>> +++++++++++++++++++++---------------------
>>  1 file changed, 28 insertions(+), 28 deletions(-)
>> 
> 
> Hi,
> 
> I just sent a fix for this issue:
> 
> https://lore.kernel.org/linux-efi/20240205081106.2415414-2-ardb+git@google.com/T/#u
> 
> Could you please check whether it works for you as well?
> 

Yes, your patch works fine as well. Thanks!

> 
>> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
>> index b2771710ed98..097b84ab288c 100644
>> --- a/arch/x86/boot/header.S
>> +++ b/arch/x86/boot/header.S
>> @@ -153,6 +153,34 @@ section_table:
>>                 IMAGE_SCN_MEM_READ              | \
>>                 IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
>> 
>> +       .ascii  ".text"
>> +       .byte   0
>> +       .byte   0
>> +       .byte   0
>> +       .long   ZO__data
>> +       .long   setup_size
>> +       .long   ZO__data                        # Size of initialized 
>> data
>> +                                               # on disk
>> +       .long   setup_size
>> +       .long   0                               # PointerToRelocations
>> +       .long   0                               # PointerToLineNumbers
>> +       .word   0                               # NumberOfRelocations
>> +       .word   0                               # NumberOfLineNumbers
>> +       .long   IMAGE_SCN_CNT_CODE              | \
>> +               IMAGE_SCN_MEM_READ              | \
>> +               IMAGE_SCN_MEM_EXECUTE           # Characteristics
>> +
>> +       .ascii  ".data\0\0\0"
>> +       .long   ZO__end - ZO__data              # VirtualSize
>> +       .long   setup_size + ZO__data           # VirtualAddress
>> +       .long   ZO__edata - ZO__data            # SizeOfRawData
>> +       .long   setup_size + ZO__data           # PointerToRawData
>> +
>> +       .long   0, 0, 0
>> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> +               IMAGE_SCN_MEM_READ              | \
>> +               IMAGE_SCN_MEM_WRITE             # Characteristics
>> +
>>  #ifdef CONFIG_EFI_MIXED
>>         .asciz  ".compat"
>> 
>> @@ -185,34 +213,6 @@ pecompat_fstart:
>>         .set    pecompat_vsize, 0
>>         .set    pecompat_fstart, setup_size
>>  #endif
>> -       .ascii  ".text"
>> -       .byte   0
>> -       .byte   0
>> -       .byte   0
>> -       .long   ZO__data
>> -       .long   setup_size
>> -       .long   ZO__data                        # Size of initialized 
>> data
>> -                                               # on disk
>> -       .long   setup_size
>> -       .long   0                               # PointerToRelocations
>> -       .long   0                               # PointerToLineNumbers
>> -       .word   0                               # NumberOfRelocations
>> -       .word   0                               # NumberOfLineNumbers
>> -       .long   IMAGE_SCN_CNT_CODE              | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_EXECUTE           # Characteristics
>> -
>> -       .ascii  ".data\0\0\0"
>> -       .long   ZO__end - ZO__data              # VirtualSize
>> -       .long   setup_size + ZO__data           # VirtualAddress
>> -       .long   ZO__edata - ZO__data            # SizeOfRawData
>> -       .long   setup_size + ZO__data           # PointerToRawData
>> -
>> -       .long   0, 0, 0
>> -       .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>> -               IMAGE_SCN_MEM_READ              | \
>> -               IMAGE_SCN_MEM_WRITE             # Characteristics
>> -
>>         .set    section_count, (. - section_table) / 40
>>  #endif /* CONFIG_EFI_STUB */
>> 
>> --
>> 2.43.0
>> 

