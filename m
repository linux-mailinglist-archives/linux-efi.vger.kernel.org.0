Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044ED4498B9
	for <lists+linux-efi@lfdr.de>; Mon,  8 Nov 2021 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhKHPvW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Nov 2021 10:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241076AbhKHPvW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Nov 2021 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636386517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtwGeQksANjxXUD8kTJkumxHFxaoo+uKZKYpwUro+u0=;
        b=iCrUlS7nBsO621G7XF0syfnI2s0azKkPBoFAlZ1HY+2uRtYMqtKGvNqVtOR9ED5FVVBDzC
        LLAXXFffugI6h+hfjqJn66W2nCuRDQpXzH/FJu0LpgWR6J5LpUP1ud7S0UJfkKcm7miSJA
        PAmQN/5heV/2S+7f3YR7geFBd3AjgGY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ODfWb43cMwuss_8XoA8gEA-1; Mon, 08 Nov 2021 10:48:36 -0500
X-MC-Unique: ODfWb43cMwuss_8XoA8gEA-1
Received: by mail-ed1-f71.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so15190453edd.11
        for <linux-efi@vger.kernel.org>; Mon, 08 Nov 2021 07:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FtwGeQksANjxXUD8kTJkumxHFxaoo+uKZKYpwUro+u0=;
        b=ErzXglkaQzu7L80hXY+Yy9dp+wojUQwZ/QPC1e8PKu1+aqrM64C/0hxNhAR5vHniUM
         4faYF0NsxINJsutupVOzeRDEbBUdZkxRDZv8sRrDy+JgL1J7/0spCdcl+Br3S+Ficljv
         z83jV6Bc00YafSZl51uojEFcpbm7iNuN7PjXi1cgafEb/D2XOTk2gpu4J4tBFH7k2+wV
         T/VO+5qRvk6MbOMs2OMxQJBGSxrHilE6cbBrXAbO4B6njA8xThA9woYYu4l38UV0BGfW
         dXToOMvG5A7hcmyUcRGWE4PojpdzXrk2pXAdreMYVZWO1eEiFus+09rPbjEoR7LeE0yT
         JdiQ==
X-Gm-Message-State: AOAM533jfnQlFMUPJjlbpeNd4MUkIzFXadBl9qgdKMflbt0LVOklD+D+
        6ax6QfuBdgg7dsdPLtYGA+6BnGfzLoBWUWiwzgJEDAcr1ftyrGU+HSDmff2Gdzd4MF3aVxt37YN
        XwgcG1kFJh0xJiUGmkNcN
X-Received: by 2002:a17:906:d196:: with SMTP id c22mr284004ejz.231.1636386514997;
        Mon, 08 Nov 2021 07:48:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtb9YLNfiqr9xl8w+/gcHV4f+pRqMHXso6LnfoUbKlBGUIXkI0Lyz6aADTJ+R2wXEPO4HdEg==
X-Received: by 2002:a17:906:d196:: with SMTP id c22mr283967ejz.231.1636386514765;
        Mon, 08 Nov 2021 07:48:34 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id hp3sm8468706ejc.61.2021.11.08.07.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:48:34 -0800 (PST)
Message-ID: <a9cdcaa6-e933-2859-04f7-21392a9ac5ce@redhat.com>
Date:   Mon, 8 Nov 2021 16:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 02/13] platform/x86: dmi_device_properties: Add setup info
 for boards with a CHT Whiskey Cove PMIC
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211030182813.116672-1-hdegoede@redhat.com>
 <20211030182813.116672-3-hdegoede@redhat.com>
 <CAHp75VeXJauH1YQZxYvRWucDwsP_RF5T5yiwpMcB-r4O60ZPJQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeXJauH1YQZxYvRWucDwsP_RF5T5yiwpMcB-r4O60ZPJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Andy,

Thank you for your feedback.

On 10/30/21 23:56, Andy Shevchenko wrote:
> On Sat, Oct 30, 2021 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Add a new "intel,cht-wc-setup" string property to the "INT34D3:00"
>> i2c_client for the Whiskey Cove PMIC found on several Cherry Trail
>> based devices. At least 3 setups are known:
>>
>> 1. The WC PMIC is connected to a TI BQ24292i charger, paired with
>>    a Maxim MAX17047 fuelgauge + a FUSB302 USB Type-C Controller +
>>    a PI3USB30532 USB switch, for a fully functional Type-C port
>>
>> 2. The WC PMIC is connected to a TI BQ25890 charger, paired with
>>    a TI BQ27520 fuelgauge, for a USB-2 only Type-C port without PD
>>
>> 3. The WC PMIC is connected to a TI BQ25890 charger, paired with
>>    a TI BQ27542 fuelgauge, for a micro-USB port
>>
>> Which setup is in use cannot be determined reliably from the ACPI tables
>> and various drivers (extcon-intel-cht-wc.c, i2c-cht-wc.c, ...) need
>> to know which setup they are dealing with.
> 
> If it's internal property only, I would rather expect it to start with
> 'linux,' as DWC3 does. And it's also USB related.
> 
> ...
> 
>> +       PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq24292i,max17047,fusb302,pi3usb30532"),
> 
>> +       PROPERTY_ENTRY_STRING("intel,cht-wc-setup", "bq25890,bq27520"),
> 
>  Besides that I'm not sure about the name of the property, maybe
> 'linux,cht-wc-usb-chips' or alike? And since it's a list, can we make
> it a string array?
> 

So now that I also have a yogabook to test on it has become clear that
we really need to treat each device-model/board with a cht-wc PMIC
differently in the various cht-wc MFD cell drivers.

So instead of using device-properties (patch 1 + 2 from this series)
I've chosen to add a intel_cht_wc_get_model( helper to:
drivers/mfd/intel_soc_pmic_chtwc.c

Which uses DMI matching (in a shared place so that we need the DMI
table only once) and returns an enum value which represents all
known boards.

Regards,

Hans

