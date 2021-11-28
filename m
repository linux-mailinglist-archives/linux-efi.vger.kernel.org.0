Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BBC460590
	for <lists+linux-efi@lfdr.de>; Sun, 28 Nov 2021 10:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357063AbhK1J61 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Nov 2021 04:58:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357212AbhK1J41 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Nov 2021 04:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638093191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46iYRFJVxEl7Q54CoIPD2LT3/f4Emo7d2PE1/uhIF0E=;
        b=C3zOLKkWJz3jqfFTCjLIIZIQYh/t2QjOXFC0KhLULwuMFgHNnKO+G9q3TuQSi/p7QTIXeN
        fzyTYqK64h0LXv+1GOwSd/5nV546lsTJVI2A5rSq6XL1OI+F0Nwbphck7vYB+Iq2QO3uPz
        ZSrp9xnnCs3wl4Xv++haBfHTWdKq2kI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-6coWC3b-NJOm8kO7Nf1vxw-1; Sun, 28 Nov 2021 04:53:09 -0500
X-MC-Unique: 6coWC3b-NJOm8kO7Nf1vxw-1
Received: by mail-ed1-f70.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so11280112ede.0
        for <linux-efi@vger.kernel.org>; Sun, 28 Nov 2021 01:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=46iYRFJVxEl7Q54CoIPD2LT3/f4Emo7d2PE1/uhIF0E=;
        b=qdicfSeQbu+Y+9otcC18NWYPznPQf6LzYg+0ULI/Y9c2eQ/XL77f6geBDoGFdpamDG
         0zHrAVmEfyVHfEFp5dChzjqs6lN2UEincjsJViMorj+TnDq3dAqmIkiSWtG61YXqjpJT
         3VxZ28+JOdBzH3WZFEB8mP9MZgIkWIsuhtb6MY9ccg6vPZrJT4ErGF5Bz8xwK7IHgnPT
         3fUSX/QUAYg4l8N93GX5zddiMHLM1T9/tOabghkXezDWGb+ELovaWOBwoPm+JOLLX+C/
         K2sD89bAx4bMV4dym2mkVdbcZYyz+vS3dmyhk4bTLeljhzEn0GQptoD8tXooQ26neJnN
         ifmQ==
X-Gm-Message-State: AOAM532zhBtAFopvBrO2JVdZym2MPL5jTQjayZMuax9aHmyYYSJYXKFG
        W+uXD6QvnW/kh2EJf0SfLMmYiT4Eb8GZnK66cdhILaRKxI4uGCXS/Zuz//FkYrb8fkYKp9Vq8hg
        pSevPRWs6mjSKU7SsmWeA
X-Received: by 2002:a17:906:788:: with SMTP id l8mr50597923ejc.548.1638093187941;
        Sun, 28 Nov 2021 01:53:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPU/LDAbdbnCqEDs5hHt7m3Ne48l8FCBQpugmNlF5u5inOtqfjkaoRgqNeB8vix/j6A4+lFg==
X-Received: by 2002:a17:906:788:: with SMTP id l8mr50597904ejc.548.1638093187785;
        Sun, 28 Nov 2021 01:53:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r13sm6999064edo.71.2021.11.28.01.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 01:53:07 -0800 (PST)
Message-ID: <75f4e158-3099-b138-8412-d3a987622c0a@redhat.com>
Date:   Sun, 28 Nov 2021 10:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 14/20] mfd: intel_soc_pmic_chtwc: Add
 intel_cht_wc_get_model() helper function
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-15-hdegoede@redhat.com>
 <CAHp75Ve=UkSF_fTjJSkAKgxV3hdzGbT5Hqzxi0ACu-Q-=rF3Qw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Ve=UkSF_fTjJSkAKgxV3hdzGbT5Hqzxi0ACu-Q-=rF3Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11/16/21 12:18, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Tablet / laptop designs using an Intel Cherry Trail x86 main SoC with
>> an Intel Whiskey Cove PMIC do not use a single standard setup for
> 
> does not

designs ... do not. Design_s_ so more then one, so "do not" is correct.

<snip>

>> +}
>> +EXPORT_SYMBOL_GPL(intel_cht_wc_get_model);
> 
> Are you planning to use EXPORT_SYMBOL_GPL_NS()? If not, please consider it.

This will be gone in v3, since this info is now stored in struct intel_soc_pmic
as requested by Chanwoo.

Regards,

Hans


