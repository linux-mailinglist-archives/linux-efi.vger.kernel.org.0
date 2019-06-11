Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB93CE99
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2019 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfFKOY7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jun 2019 10:24:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43886 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbfFKOY7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jun 2019 10:24:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so20371688edb.10
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2019 07:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lq54XoUUkvm7cR+T3gDZyIvL7X/r+IA4m/7jXjFDr+E=;
        b=IiDOKGd/pXB2JsDNrea0zJp+cePBobycb3MNzCR19U9Jz6eK6efJ50icZRVAwJAYSy
         N5jHccNg28otv/CTIGQE9AoE0KlndFWjhfHaIAzuW+8usnjsS4reeNIFTsQvf7SEOt+O
         P+hQc43llvTpMIEhS0xpT/QAKYBr7KonMk1z75GM3o+p2R5TuQ6NdEBeNh1btzYVi3CD
         Bf8K646GfnFa4soqY88FmJd/evuAcCMd1POvEU0wZz5yKo3pr2zxPs7Sq2ctnH/OoFyH
         8NWAJnJ622BWoMddTKVrINAHZ/6nVgjjVoHgGla7SjV8UpoB1ewcY3zYfgK8kXj/zOfx
         1k3A==
X-Gm-Message-State: APjAAAWRAMaUYuUJxeANOy8FPGdAl35M7mKwE8zDNPpCve+WMKmGs5mT
        ZCFRykXzMmv89jUq0BPLizIF4w==
X-Google-Smtp-Source: APXvYqxswKorgdJq3Y5rc5HxvlH/pRvn6x4sun7qDAL3IBVycAvGGx4R2j5EkZZju718VEMVIxJm4w==
X-Received: by 2002:a17:906:398:: with SMTP id b24mr36489091eja.78.1560263097845;
        Tue, 11 Jun 2019 07:24:57 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w18sm2303546eji.44.2019.06.11.07.24.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 07:24:56 -0700 (PDT)
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation
 bits
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>
References: <20190529154635.2659-1-hdegoede@redhat.com>
 <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
 <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
Date:   Tue, 11 Jun 2019 16:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 11-06-19 16:04, Ard Biesheuvel wrote:
> On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
>>> reserved. These bits are now used to indicate if the image needs to be
>>> rotated before being displayed.
>>>
>>> The efifb code does not support rotating the image before copying it to
>>> the screen.
>>>
>>> This commit adds a check for these new bits and if they are set leaves the
>>> fb contents as is instead of trying to use the un-rotated BGRT image.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
> 
> BTW should we make sure that this patch and the efi-bgrt patch get
> merged at the same time?

The 2 patches are related but merging them at the same time is not
necessary.

> I guess the net result is just that we get
> rid of some error in the log, but a rotated BMP will be ignored
> otherwise.

Right, worse case (if the bmp fits pre-rotation) it will be displayed
rotated. Note on the one machine I'm aware of which uses these bits
the bmp does not fit pre-rotation, so we end up triggering:

error:
         memunmap(bgrt_image);
         pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
}

Which this patch replaces with hitting:

         if (bgrt_tab.status & 0x06) {
                 pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
                 return;
         }

Instead. So at least on the one machine I know of this is 99% cosmetic.

> Or is it relevant for userland in some other way?

No.

Regards,

Hans
