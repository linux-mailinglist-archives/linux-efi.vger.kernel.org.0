Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C98D0FCB
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfJINSW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 09:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbfJINSW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Oct 2019 09:18:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D5E88E58C
        for <linux-efi@vger.kernel.org>; Wed,  9 Oct 2019 13:18:21 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w8so1119781wrm.3
        for <linux-efi@vger.kernel.org>; Wed, 09 Oct 2019 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSGtDck56uyZ7bQZy6YNbrPNRWeC06OlNw7fuz6920g=;
        b=Ju7BS1/f0Qou+YXn5EjBPcn8nTuZtTS5hGx3V4AyWFSeqWMdHYEzAe4rtrb7Ln0zxV
         77boK6WU5XYIQ55nDX7QK4mUl6yf/Ej/ut/mKgT0IgSzS/KDEwZCyPLPXNIFpciIcO5Q
         9J2IJUYqSoOd5UPucYu/LFUBigIzH3riWjPOH7vF5ZwRIHqi+ROy1gSbUt2PwfmWeFlr
         CGOLs52XvYjxnMy9PZAgGOHo1BLeH8Jn+rvrKY2yU2Dj6UjPBlT1TDn8id8rv14iM9YS
         2W8YAeV6dn96tyg1hOFMryrNVVdUwhk01HH9+KBJzQwiyDvMGC65Sg4p5XThLxfrIMIE
         UM6A==
X-Gm-Message-State: APjAAAXfuNnEDQsQBR8fYMG9MNfr8uL19zn9NfvOpR9QTvCk8JoHonBM
        PQe4AkEpAQyTr46DlTFusj+fbNQrB0dBz5yeE4ngOAK2+xF/H657BYWZzhBuZB/dtC4jY2fkMPS
        Eb34ttFNwOAId61gwrhzj
X-Received: by 2002:a5d:654a:: with SMTP id z10mr2870818wrv.159.1570627100020;
        Wed, 09 Oct 2019 06:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEhsE6YKwEHTEE/HZcg+u2Ek0JtIlYFKf+FQD7oObjzI3Nse2MJ3NOgl7JFiN+/rZpZf7MuA==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr2870794wrv.159.1570627099787;
        Wed, 09 Oct 2019 06:18:19 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id v6sm4176570wma.24.2019.10.09.06.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:18:18 -0700 (PDT)
Subject: Re: [PATCH v7 1/8] efi: Export boot-services code and data as
 debugfs-blobs
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        the arch/x86 maintainers <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-2-hdegoede@redhat.com>
 <CAKv+Gu9OU3rS-j+L+pxpK7HZi41XtQZTq9BDs6VpUC8RCq5X6g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c0256726-0aa3-b005-0a18-7b6a41533a0b@redhat.com>
Date:   Wed, 9 Oct 2019 15:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9OU3rS-j+L+pxpK7HZi41XtQZTq9BDs6VpUC8RCq5X6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 09-10-2019 15:07, Ard Biesheuvel wrote:
> On Fri, 4 Oct 2019 at 16:51, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Sometimes it is useful to be able to dump the efi boot-services code and
>> data. This commit adds these as debugfs-blobs to /sys/kernel/debug/efi,
>> but only if efi=debug is passed on the kernel-commandline as this requires
>> not freeing those memory-regions, which costs 20+ MB of RAM.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v5:
>> -Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
>>
>> Changes in v4:
>> -Add new EFI_BOOT_SERVICES flag and use it to determine if the boot-services
>>   memory segments are available (and thus if it makes sense to register the
>>   debugfs bits for them)
>>
>> Changes in v2:
>> -Do not call pr_err on debugfs call failures
>> ---
>>   arch/x86/platform/efi/efi.c    |  1 +
>>   arch/x86/platform/efi/quirks.c |  4 +++
>>   drivers/firmware/efi/efi.c     | 53 ++++++++++++++++++++++++++++++++++
>>   include/linux/efi.h            |  1 +
>>   4 files changed, 59 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>> index c202e1b07e29..847730f7e74b 100644
>> --- a/arch/x86/platform/efi/efi.c
>> +++ b/arch/x86/platform/efi/efi.c
>> @@ -232,6 +232,7 @@ int __init efi_memblock_x86_reserve_range(void)
>>               efi.memmap.desc_version);
>>
>>          memblock_reserve(pmap, efi.memmap.nr_map * efi.memmap.desc_size);
>> +       set_bit(EFI_PRESERVE_BS_REGIONS, &efi.flags);
> 
> Should we add a Kconfig symbol to opt into this behavior [set by the
> driver in question], instead of always preserving all boot services
> regions on all x86 systems?

This bit does not control anything, it merely signals that the arch early
boot EFI code keeps the boot-services code around, which is something
which the x86 code already does. Where as e.g. on arm / aarch64 this is
freed early on, this ties in with the other bits:

> 
>>
>>          return 0;
>>   }
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 3b9fd679cea9..fab12ebf0ada 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -411,6 +411,10 @@ void __init efi_free_boot_services(void)
>>          int num_entries = 0;
>>          void *new, *new_md;
>>
>> +       /* Keep all regions for /sys/kernel/debug/efi */
>> +       if (efi_enabled(EFI_DBG))
>> +               return;
>> +

This is the point where normally on x86 we do actually free the boot-services
code which is a lot later then on other arches. And this new code actually
does change things to keep the boot-services code *forever* but only
if EFI debugging is enabled on the kernel commandline.

This ties in with the next bit:

>>          for_each_efi_memory_desc(md) {
>>                  unsigned long long start = md->phys_addr;
>>                  unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 8d3e778e988b..abba49c4c46d 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c

<snip>

>> @@ -370,6 +420,9 @@ static int __init efisubsys_init(void)
>>                  goto err_remove_group;
>>          }
>>
>> +       if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
>> +               efi_debugfs_init();
>> +
>>          return 0;
>>
>>   err_remove_group:

Here we register the debugfs dir + files, but only when the
boot services code has been kept around, so only if the
EFI_PRESERVE_BS_REGIONS arch feature flag has been set and
EFI debugging has been requested on the kernel commandline.

IOW this patch already offers to configurability you ask for, but instead
of through a Kconfig option (which IMHO would be cumbersome) the decision
is made runtime based on the presence of efi=debug on the kernel commandline.

Regards,

Hans




>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index bd3837022307..2a30a1bd8bdf 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -1202,6 +1202,7 @@ extern int __init efi_setup_pcdp_console(char *);
>>   #define EFI_DBG                        8       /* Print additional debug info at runtime */
>>   #define EFI_NX_PE_DATA         9       /* Can runtime data regions be mapped non-executable? */
>>   #define EFI_MEM_ATTR           10      /* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
>> +#define EFI_PRESERVE_BS_REGIONS        11      /* Are EFI boot-services memory segments available? */
>>
>>   #ifdef CONFIG_EFI
>>   /*
>> --
>> 2.23.0
>>
