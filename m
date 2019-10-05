Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650E6CC931
	for <lists+linux-efi@lfdr.de>; Sat,  5 Oct 2019 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfJEJxk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Oct 2019 05:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfJEJxi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Oct 2019 05:53:38 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AE71882FB
        for <linux-efi@vger.kernel.org>; Sat,  5 Oct 2019 09:53:37 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id w12so5686056eda.6
        for <linux-efi@vger.kernel.org>; Sat, 05 Oct 2019 02:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TT+gPwEwmW+zFxrJh0O9g568TTXNfZtDWLTnBvu+Q0=;
        b=k9VXg7qrxwaXrsODKmqH2fLuAPMos6/o6gRHgzbFJtDdxvtuWROQY0vdCBWKnX/aV5
         a6TtF9FKlfvnufLxU0wl+GbaR6t5PMQLN+NL320AgQvN7GnZyTH1Rm/wcJVbO922wq2P
         Tgiw2ae5p1xt0MGtzLmAK8YhKZRkQF9FiEI6t2Ch7oQsMXePiH6RPNXjTBjFqlEml9Bb
         B/UKFljTxOEj9OfUDlW1te6v5qkaQ3azO/Nki09uAzI5xbT5p6lfUTZVRSnPCAnIpMO/
         KtMVDf+5Yblf2nKTFWmaiQyRZSK4Pij9t3aOfN1V0Q6DOe5iQQ5noFTtQ6JYvaQF0lEG
         6DYg==
X-Gm-Message-State: APjAAAXhrGIBSZz9vpgzz1bRtKcvSgnKHkrZoKuw8ukeAZEcYnK70VZf
        ZJXx2RfXEY3iFse2zanLIFBtRK8ajFDnE2Sip7KjdS64PuuZDTFlt0cVstLXQvZD337oGQApU0Z
        wlhyE1GMNfuRPoMvhEZwb
X-Received: by 2002:a50:ac0d:: with SMTP id v13mr19492077edc.189.1570269216371;
        Sat, 05 Oct 2019 02:53:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZOxlWwMcBg7l7MOzB/AEriI2yXyATuHMn4uTP960+sqT3K43d/RA7nIyKJE/vnMnlvyaS+g==
X-Received: by 2002:a50:ac0d:: with SMTP id v13mr19492050edc.189.1570269216115;
        Sat, 05 Oct 2019 02:53:36 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id ba28sm1752166edb.4.2019.10.05.02.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 02:53:35 -0700 (PDT)
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com> <20191004231733.GF22365@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c75ceb3a-799a-378a-dbff-c4c4f57575b4@redhat.com>
Date:   Sat, 5 Oct 2019 11:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004231733.GF22365@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dmitry,

On 05-10-2019 01:17, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
>> In some cases the platform's main firmware (e.g. the UEFI fw) may contain
>> an embedded copy of device firmware which needs to be (re)loaded into the
>> peripheral. Normally such firmware would be part of linux-firmware, but in
>> some cases this is not feasible, for 2 reasons:
>>
>> 1) The firmware is customized for a specific use-case of the chipset / use
>> with a specific hardware model, so we cannot have a single firmware file
>> for the chipset. E.g. touchscreen controller firmwares are compiled
>> specifically for the hardware model they are used with, as they are
>> calibrated for a specific model digitizer.
>>
>> 2) Despite repeated attempts we have failed to get permission to
>> redistribute the firmware. This is especially a problem with customized
>> firmwares, these get created by the chip vendor for a specific ODM and the
>> copyright may partially belong with the ODM, so the chip vendor cannot
>> give a blanket permission to distribute these.
>>
>> This commit adds a new platform fallback mechanism to the firmware loader
>> which will try to lookup a device fw copy embedded in the platform's main
>> firmware if direct filesystem lookup fails.
>>
>> Drivers which need such embedded fw copies can enable this fallback
>> mechanism by using the new firmware_request_platform() function.
> 
> Why would drivers not want to fetch firmware from system firmware if it
> is not present on disk? I would say let driver to opt-out of this
> fallback, but default request_firmware() should do it by default.

Only few devices / device-drivers have / need firmware which is
embedded in the system-fw. Checking for this introduces an extra call
in the firmware-loader path and the firmware-loader maintainer have
requested to make this opt-in, rather then opt-out, so that these changes
do not impact the many many other drivers which do not need this.

To be precise so far only the 2 touchscreen drivers for which patches
are in this series are known to benefit from this approach. So since this
is somewhat of a special case opt-in makes more sense then opt-out.

Regards,

Hans


