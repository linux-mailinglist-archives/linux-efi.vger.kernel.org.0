Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658311F966F
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgFOMYp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 08:24:45 -0400
Received: from mail-out2.in.tum.de ([131.159.0.36]:46783 "EHLO
        mail-out2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgFOMYp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 08:24:45 -0400
Received: by mail.in.tum.de (Postfix, from userid 107)
        id 0CF3C1C0A04; Mon, 15 Jun 2020 14:24:43 +0200 (CEST)
Received: (Authenticated sender: fent)
        by mail.in.tum.de (Postfix) with ESMTPSA id 17B151C0A02;
        Mon, 15 Jun 2020 14:24:41 +0200 (CEST)
        (Extended-Queue-bit tech_mqvai@fff.in.tum.de)
Subject: Re: [PATCH] efi/libstub: Fix path separator regression
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <20200615115109.7823-1-fent@in.tum.de>
 <CAMj1kXGiG1opT8OyO-fN30YnrwAwSN6VttfhN5Hz1fMHd5EbVA@mail.gmail.com>
From:   Philipp Fent <fent@in.tum.de>
Message-ID: <0ff1f982-6165-dfef-cada-e8da5c615cbf@in.tum.de>
Date:   Mon, 15 Jun 2020 14:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGiG1opT8OyO-fN30YnrwAwSN6VttfhN5Hz1fMHd5EbVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 15.06.20 14:15, Ard Biesheuvel wrote:
>> ---
>>  drivers/firmware/efi/libstub/file.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
>> index 2005e33b33d5..f8a28a6e0bde 100644
>> --- a/drivers/firmware/efi/libstub/file.c
>> +++ b/drivers/firmware/efi/libstub/file.c
>> @@ -102,11 +102,21 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
>>         if (!found)
>>                 return 0;
>>
>> +       /* Skip any leading slashes */
>> +       while (cmdline[i] == L'/' || cmdline[i] == L'\\')
>> +               i++;
>> +
>>         while (--result_len > 0 && i < cmdline_len) {
>>                 if (cmdline[i] == L'\0' ||
>>                     cmdline[i] == L'\n' ||
>>                     cmdline[i] == L' ')
>>                         break;
>> +               /* Replace UNIX dir separators with EFI standard separators */
>> +               if (cmdline[i] == L'/') {
>> +                       *result++ = L'\\';
>> +                       i++;
>> +                       continue;
>> +               }
> 
> Any objections if I change this to
> 
> 
> ---%<---
> efi_char16_t c = cmdline[i++];
> 
> if (c == L'\0' || c == L'\n' || c == L' ')
>   break;
> else if (c == L'/')
>   /* Replace UNIX dir separators with EFI standard ones */
>   *result++ = L'\\';
> else
>   *result++ = c;
> ---%<---
> 
> 
> (no need to resend)
> 
> 
>>                 *result++ = cmdline[i++];
>>         }
>>         *result = L'\0';
>> --
>> 2.27.0
>>

Sure, go ahead. I wasn't sure about the style, but yours looks more terse.

Thanks for queueing as a fix!
