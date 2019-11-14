Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D21DEFCF9A
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNUWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 15:22:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfKNUWW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Nov 2019 15:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573762941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uy3A6U6GvNwW+cUqKR9ufgvAvkKicayB8WolhnR61T4=;
        b=hxM3nCcs+w//T/is0XHd+Ehf0VAeh79Yqw9dka0aB+xhfniZARBQaOpE/rPS89e7yGoDNt
        0vl1ZYzPly6wr1ZA8bRBEYJzZIIVghhViZIuPh02Hd9Q0Bh5ZUFw9/JRhDXTmfonBXI3vE
        NgsvWSFGPUMMUPQJ4ThtNpT5lM68Y9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-1hXdA-D-OjytWo-TvNoJLg-1; Thu, 14 Nov 2019 15:22:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id l184so4817237wmf.6
        for <linux-efi@vger.kernel.org>; Thu, 14 Nov 2019 12:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0SJkjpv2HDiNEvyxxMCbTsKg4OElpw2hmJNuwbm1+Ww=;
        b=i8eeK6Ar4W870v2weOTyykBaSoqgU1CYFFpSwj1L4ep6ZXfGogYdzZBOvbK0NZjrjE
         JQ5miKOIul9482b0m3UuJIMl+jJpkRX/qQcOArsX838DTbRlGC/8wAZeoPTag7f7LtXN
         iGb8O8TsGZEnoIPpyjDVQ/i2hgdhk4LzM5y5y41cmRCVFwgK7Lvh6KNNn5t4Bn4W+4zF
         tXqSbshA4KOm6kEMrg1V+MeS7UYYHPwDPiHQpUv/WKlJTKM9wtWsvuISqNwukYT9s9iD
         PZ4AEk6YRwAmul9+z9MmhYHE7aPsj1Lkz7uiiKs28sCkyu1ZAJhmeqrisrL9mGbjcjzR
         vYJA==
X-Gm-Message-State: APjAAAWebkxDDDL0fMY/8NTNNa8eO4xVR9f3/Cb2Fz0pbuj2WxQh4JTD
        G175CMe60wEQ28UOvSj6IzVWEFwGj7Q6iskGT0pyVQd+HNNqOc5+kPiIfGFfRmNRhSceFcj1JjX
        HsU4Iv+vUrL7yakShSk9e
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr10102320wrn.243.1573762938820;
        Thu, 14 Nov 2019 12:22:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqygsYdJkry0Z47hzZeZ3TwxuZ7J/7WDsvabqCKzND6L18gyI7cuvLtuHwYFk1oQ9yauwGVucw==
X-Received: by 2002:adf:ec4b:: with SMTP id w11mr10102293wrn.243.1573762938627;
        Thu, 14 Nov 2019 12:22:18 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a11sm7617992wmh.40.2019.11.14.12.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 12:22:17 -0800 (PST)
Subject: Re: [PATCH v7 3/8] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Scott Branden <scott.branden@broadcom.com>,
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
 <20191004145056.43267-4-hdegoede@redhat.com>
 <20191011150227.GO16384@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d7956159-87b9-06ec-4f8b-291389324178@redhat.com>
Date:   Thu, 14 Nov 2019 21:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191011150227.GO16384@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: 1hXdA-D-OjytWo-TvNoJLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11-10-2019 17:02, Luis Chamberlain wrote:
> On Fri, Oct 04, 2019 at 04:50:51PM +0200, Hans de Goede wrote:
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firm=
ware_loader/fallback.c
>> index 62ee90b4db56..665b350419cb 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_fl=
ags)
>>   =09=09return false;
>>   =09}
>>  =20
>> -=09if ((opt_flags & FW_OPT_NOFALLBACK))
>> +=09if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
>>   =09=09return false;
>>  =20
>>   =09/* Also permit LSMs and IMA to fail firmware sysfs fallback */
>> @@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_=
flags)
>>    * interface. Userspace is in charge of loading the firmware through t=
he sysfs
>>    * loading interface. This sysfs fallback mechanism may be disabled co=
mpletely
>>    * on a system by setting the proc sysctl value ignore_sysfs_fallback =
to true.
>> - * If this false we check if the internal API caller set the @FW_OPT_NO=
FALLBACK
>> - * flag, if so it would also disable the fallback mechanism. A system m=
ay want
>> - * to enfoce the sysfs fallback mechanism at all times, it can do this =
by
>> - * setting ignore_sysfs_fallback to false and force_sysfs_fallback to t=
rue.
>> + * If this false we check if the internal API caller set the
>           ignore_sysfs_fallback set to true or force_sysfs_fallback is
> =09 set to false

I do not think that that is correct, looking at the code the order of
checks is:

=09if (fw_fallback_config.ignore_sysfs_fallback)
=09=09BAIL

=09if (opt_flags & FW_OPT_NOFALLBACK_SYSFS)
=09=09BAIL

=09if (fw_fallback_config.force_sysfs_fallback)
=09=09DO_FALLBACK (and return)

=09if (!(opt_flags & FW_OPT_USERHELPER))
=09=09BAIL

=09DO_FALLBACK

So the original comment seems correct as FW_OPT_NOFALLBACK trumps / has
higher prio then force_sysfs_fallback.

Anyways I do not believe that fixing up/rewording this comment (if it needs
fixing) belongs in the commit/patch. This patch is purely about renaming
FW_OPT_NOFALLBACK to FW_OPT_NOFALLBACK_SYSFS, the lines changed in this
chunk are not changed, they are merely re-word/line-wrapped with the
exception of fixing the enfoce typo to enforce, as mentioned in the
commit message.

Regards,

Hans

