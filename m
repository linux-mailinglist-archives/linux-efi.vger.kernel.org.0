Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E11FC55D
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 12:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfKNLcT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 06:32:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbfKNLcS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 06:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573731138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGPDOxJmq8wLYBcctg35/K5PZf59EHJV9VNjXKlhwZM=;
        b=S0Emo7sIIo6RXz24av+bDI+R5rH2RQ466Bm8F6eH645lvJEV46P9hvd2expoP8HOktRomf
        DQHFa/KKdMPlILAjOJZ9sJh3LwsAxE6UOQpWSfCgq8zYlDHfj6nX9+U7A1hHtyEbCxNiac
        PNCB3GItHSvMqMour4yxummkIUMjRgk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-3aWSyki-PH-_OJuWCkClxQ-1; Thu, 14 Nov 2019 06:32:15 -0500
Received: by mail-wr1-f70.google.com with SMTP id q12so4245359wrr.3
        for <linux-efi@vger.kernel.org>; Thu, 14 Nov 2019 03:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZt45pQgw79xE9XzgdJC+yG0nkXIvZyJYcV8pb1nd04=;
        b=lTRxu/IQOBjuaE02nUvSHZvhAVhLp8xdt8GTn3D03IA/S1iNDzulNjgzvY2cpBRsgL
         WopwBtlSs4RIaSmoeW9DezVlhMPMtqLUF2109yeoUgYR/1G6UFrM9qMoXPx4trHv9W4u
         VwINA1TaTDW6zW5KYlv/2mpMZbZv5T0BUI1s7KLSM9LrZKA5PjU2W3Vz/Loh8GKWuHxi
         qmp7AbDTILkjYlapzxHBUY5VQBghWDxD0GmQ2OU6axHTYq6HnRlYhNY8ByimfI6gcSxp
         X08dKV4Vug3RGAsDExYNTyLAChWoKL3xXVQHhqHgxs6XqHYXfwn8e/7WTNPsj9BJhf0y
         bV8A==
X-Gm-Message-State: APjAAAVK77AnG5Ls7ep65mRxclDiKd97ayUnEdHrt9vM9c38W5CMm6Eh
        RUvuW9WZTqaNkPOVEX+SoajfZrcx2VAfdcDd8twwMAoCaCDuUv8qi77SHWOHpFlwDjWyQ9luAQk
        MojdIAvfbohFwnSXsHI64
X-Received: by 2002:a7b:c748:: with SMTP id w8mr7892859wmk.114.1573731133958;
        Thu, 14 Nov 2019 03:32:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqb+wuHoXkrqv7G9jT1s8K11NZRcID1zCY+N4NxoahPNLiVW38bJon4GNLKPoo8ktQX+wLDg==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr7892833wmk.114.1573731133769;
        Thu, 14 Nov 2019 03:32:13 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 205sm13554570wmb.3.2019.11.14.03.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 03:32:12 -0800 (PST)
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
 <20191011152920.GQ16384@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b09922ec-a71e-c1ca-adcc-15f7fd02c2f4@redhat.com>
Date:   Thu, 14 Nov 2019 12:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191011152920.GQ16384@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: 3aWSyki-PH-_OJuWCkClxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11-10-2019 17:29, Luis Chamberlain wrote:
> On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
>> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmwa=
re_loader/Makefile
>> index 0b2dfa6259c9..fec75895faae 100644
>> --- a/drivers/base/firmware_loader/Makefile
>> +++ b/drivers/base/firmware_loader/Makefile
>> @@ -3,7 +3,7 @@
>>  =20
>>   obj-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback_table.o
>>   obj-$(CONFIG_FW_LOADER)=09+=3D firmware_class.o
>> -firmware_class-objs :=3D main.o
>> +firmware_class-objs :=3D main.o fallback_platform.o
>>   firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback.o
>=20
> Why not just:
>=20
> firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) +=3D fallback_platform.o
>=20
>>   obj-y +=3D builtin/
>> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firm=
ware_loader/fallback.h
>> index 21063503e4ea..c4350f2e7cc2 100644
>> --- a/drivers/base/firmware_loader/fallback.h
>> +++ b/drivers/base/firmware_loader/fallback.h
>> @@ -66,4 +66,6 @@ static inline void unregister_sysfs_loader(void)
>>   }
>>   #endif /* CONFIG_FW_LOADER_USER_HELPER */
>>  =20
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags);
>> +
>=20
> Inline this if not defined.
>=20
>>   #endif /* __FIRMWARE_FALLBACK_H */
>> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/=
base/firmware_loader/fallback_platform.c
>> new file mode 100644
>> index 000000000000..7e9d730e36bf
>> --- /dev/null
>> +++ b/drivers/base/firmware_loader/fallback_platform.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/efi_embedded_fw.h>
>> +#include <linux/property.h>
>> +#include <linux/security.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "fallback.h"
>> +#include "firmware.h"
>> +
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags)
>> +{
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>=20
> And we can do away with this eyesore.

Ok will fix for the next version.

> Otherwise looks good!

Thanks.

Regards,

Hans

