Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD52F2A9661
	for <lists+linux-efi@lfdr.de>; Fri,  6 Nov 2020 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgKFMqf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 Nov 2020 07:46:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKFMqf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 Nov 2020 07:46:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6CkLWY099280;
        Fri, 6 Nov 2020 06:46:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604666781;
        bh=86PyDEAGqhTlwQYgakhBuJ6yxMtyDVOfU+4SvvgVLH4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iOPvJyEqx81hPfSNxpbLVH1B49X75y6mM0M8awv4dbpq4SMSPV3V5D+7ZqDs3b58j
         kaXzqVmeJvP7wA6DC+c/KT3ww+OzFgE15Jj3MtIVYTJwFbJS41wteWHoht8TB8AibN
         EZFWnYevQBpVLoKc5/Xl5YfY0riPSmK3V5eJlygQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6CkLbr030568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 06:46:21 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 06:46:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 06:46:21 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6CkGqe084078;
        Fri, 6 Nov 2020 06:46:17 -0600
Subject: Re: [PATCH v1 00/18] Refactor fw_devlink to significantly improve
 boot time
To:     Saravana Kannan <saravanak@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201106050940.GG16469@pendragon.ideasonboard.com>
 <CAGETcx-rvTuEmJUsf6qP3WkPLOh6m6cy8E_LsJPoGejNOXrdcw@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <cf3f5bdc-caf5-82ac-daa3-8b48122306c1@ti.com>
Date:   Fri, 6 Nov 2020 14:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-rvTuEmJUsf6qP3WkPLOh6m6cy8E_LsJPoGejNOXrdcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 06/11/2020 10:36, Saravana Kannan wrote:
> On Thu, Nov 5, 2020 at 9:09 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> Hi Saravana,
>>
>> Thank you for working on this !
>>
>> On Wed, Nov 04, 2020 at 03:23:37PM -0800, Saravana Kannan wrote:
>>> The current implementation of fw_devlink is very inefficient because it
>>> tries to get away without creating fwnode links in the name of saving
>>> memory usage. Past attempts to optimize runtime at the cost of memory
>>> usage were blocked with request for data showing that the optimization
>>> made significant improvement for real world scenarios.
>>>
>>> We have those scenarios now. There have been several reports of boot
>>> time increase in the order of seconds in this thread [1]. Several OEMs
>>> and SoC manufacturers have also privately reported significant
>>> (350-400ms) increase in boot time due to all the parsing done by
>>> fw_devlink.
>>>
>>> So this patch series refactors fw_devlink to be more efficient. The key
>>> difference now is the addition of support for fwnode links -- just a few
>>> simple APIs. This also allows most of the code to be moved out of
>>> firmware specific (DT mostly) code into driver core.
>>>
>>> This brings the following benefits:
>>> - Instead of parsing the device tree multiple times (complexity was
>>>    close to O(N^3) where N in the number of properties) during bootup,
>>>    fw_devlink parses each fwnode node/property only once and creates
>>>    fwnode links. The rest of the fw_devlink code then just looks at these
>>>    fwnode links to do rest of the work.
>>>
>>> - Makes it much easier to debug probe issue due to fw_devlink in the
>>>    future. fw_devlink=on blocks the probing of devices if they depend on
>>>    a device that hasn't been added yet. With this refactor, it'll be very
>>>    easy to tell what that device is because we now have a reference to
>>>    the fwnode of the device.
>>>
>>> - Much easier to add fw_devlink support to ACPI and other firmware
>>>    types. A refactor to move the common bits from DT specific code to
>>>    driver core was in my TODO list as a prerequisite to adding ACPI
>>>    support to fw_devlink. This series gets that done.
>>>
>>> Tomi/Laurent/Grygorii,
>>>
>>> If you can test this series, that'd be great!
>>
>> I gave it a try, rebasing my branch from v5.9 to v5.10-rc2 first. On
>> v5.10-rc2 the kernel dies when booting due to a deadlock (reported by
>> lockdep, so hopefully not too hard to debug). *sigh*. Fortunately, it
>> dies after the fw_devlink initialization, so I can still report results.
> 
> Phew! For a sec I thought you said fw_devlink was causing a deadlock.
> 
>>
>> Before your series:
>>
>> [    0.743065] cpuidle: using governor menu
>> [   13.350259] No ATAGs?
>>
>> With your series applied:
>>
>> [    0.722670] cpuidle: using governor menu
>> [    1.135859] No ATAGs?
>>
>> That's a very clear improvement :-)
> 
> Thanks for testing. Great to hear it's helping!
> 
>> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I'll add it to my v2 series.

I've tried your series on top of
521b619acdc8 Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
on am571x-idk

Before:
[    0.049395] cpuidle: using governor menu
[    1.654766] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    2.315266] No ATAGs?
[    2.315317] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    2.315327] hw-breakpoint: maximum watchpoint size is 8 bytes.
...
[    6.549595] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    6.557794] VFS: Mounted root (ext4 filesystem) on device 179:26.
[    6.574103] devtmpfs: mounted
[    6.577749] Freeing unused kernel memory: 1024K
[    6.582433] Run /sbin/init as init process


after:
[    0.049223] cpuidle: using governor menu
[    0.095893] audit: type=2000 audit(0.040:1): state=initialized audit_enabled=0 res=1
[    0.102958] No ATAGs?
[    0.103010] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.103020] hw-breakpoint: maximum watchpoint size is 8 bytes.
...
[    3.518623] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    3.526822] VFS: Mounted root (ext4 filesystem) on device 179:26.
[    3.543128] devtmpfs: mounted
[    3.546781] Freeing unused kernel memory: 1024K
[    3.551463] Run /sbin/init as init process

So, it's much better. Thank you.
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
