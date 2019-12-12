Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB311CD65
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfLLMpO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 07:45:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55457 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729230AbfLLMpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 07:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576154713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8XMXlSrioOnOfeDKPU+ZNQ5TUt5nM7tjeiQ2QQ5IRM=;
        b=jEgFwghE5UHGU9YQVAqdAqj2TV1k4M3rZkGL1AOR/Ok3Nsx0sHYdonZyYpA+by5BkvnqxI
        HHGTZOyNpD4xvPFI+aapufc2RhHdRx8Sypipg1TvlVrNfHxNg0rNqjFQ/i91TnHKIZ0kwe
        vhXugHllrj1ubbqOauhvFk6jZjjnSDo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-emsYiQYIOPmqdRYUaM7POQ-1; Thu, 12 Dec 2019 07:45:08 -0500
X-MC-Unique: emsYiQYIOPmqdRYUaM7POQ-1
Received: by mail-wm1-f69.google.com with SMTP id l11so1624860wmi.0
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 04:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8XMXlSrioOnOfeDKPU+ZNQ5TUt5nM7tjeiQ2QQ5IRM=;
        b=ZAIQyW5g7p2Wdmz5sZMHrMT4YUuEwN67CSNT8HyJ/nswj6P83wN90AWWF+O6B/fkNw
         2XhGkMmH+g6VLnmZ15ZO3xgN7XqxmViBt0J2kX4wuXsyz/l+PFGeTsvjQx3VgIZLDLio
         4doBBq0Vd1Wb37pNvxp1zT8+1CR2rOBvQZSvDzlB9iT2v97r9TkVCFoLLI0kMVQ9QUph
         UzVjgOZFjW/1F9IKPxxhDuAVWnc4o+vs/cz5/VMetaRvbnmJjSVlC5vuGaoGf26knbrh
         OUEJ6UXIgbW5p76YY+SPZeAtkNCMwvGrQ2h7m9HPTTSQDGJI183FqjNP05SwhCH71CVL
         MJ0Q==
X-Gm-Message-State: APjAAAX7bbRcDRQOhTEl6zP50yWVzHM+TDtOMr4c9X1AVSBogzN2sSnh
        e3CG6eo/pOMV1TkvpXZnW+CqGCPENPj6onxBSILxR5xgW/wpBy0MltFodRLyns4AZvT2sFPkG1x
        KcXja/ireLSuBKdP9Smoh
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6714343wmc.30.1576154706785;
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVtZo9PoHdbcef4Py9AQSp4/jHgWN059LxqFaFtahljOu3LTi9o5jxbXjjmDp3FweDwy6Qmg==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6714317wmc.30.1576154706605;
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x10sm5873465wrv.60.2019.12.12.04.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
Subject: Re: [PATCH 5.5 regression fix 2/2] efi/libstub/helper: Initialize
 pointer variables to zero for mixed mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20191212103158.4958-1-hdegoede@redhat.com>
 <20191212103158.4958-3-hdegoede@redhat.com>
 <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <82c65f05-1140-e10e-ba2f-0c4c5c85bbc8@redhat.com>
Date:   Thu, 12 Dec 2019 13:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 12-12-2019 12:29, Ard Biesheuvel wrote:
> On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> When running in EFI mixed mode (running a 64 bit kernel on 32 bit EFI
>> firmware), we _must_ initialize any pointers which are returned by
>> reference by an EFI call to NULL before making the EFI call.
>>
>> In mixed mode pointers are 64 bit, but when running on a 32 bit firmware,
>> EFI calls which return a pointer value by reference only fill the lower
>> 32 bits of the passed pointer, leaving the upper 32 bits uninitialized
>> unless we explicitly set them to 0 before the call.
>>
>> We have had this bug in the efi-stub-helper.c file reading code for
>> a while now, but this has likely not been noticed sofar because
>> this code only gets triggered when LILO style file=... arguments are
>> present on the kernel cmdline.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> index e02579907f2e..6ca7d86743af 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> @@ -365,7 +365,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
>>                                    u64 *file_sz)
>>   {
>>          efi_file_handle_t *h, *fh = __fh;
> 
> What about h? Doesn't it suffer from the same problem?
> 
>> -       efi_file_info_t *info;
>> +       efi_file_info_t *info = NULL;
>>          efi_status_t status;
>>          efi_guid_t info_guid = EFI_FILE_INFO_ID;
>>          unsigned long info_sz;
> 
> And info_sz?

And "efi_file_io_interface_t *io" and "efi_file_handle_t *fh"
in efi_open_volume().

I think that is all of them.

Regards,

Hans

