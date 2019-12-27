Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7373412BBAA
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 23:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfL0WpD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 17:45:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbfL0WpD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 17:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577486701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSAm4SacMV7LrVbIZgHNPaTxQvom2Z7SvCkmieLXHT4=;
        b=cBGnZBczM7TmOzrXOEB5GOhzH6qUr3qOvHj/8SsyfWxMhoFbt1pV2OphekZ2Wt3CZX+0uH
        KyYtctKWG+3DcrjFhFcJxmn8K0n8IabP6y3s4zPIlYaDrRJJqE258W9WEN1LGRmjqRVyNy
        L3/zNJTkeXHqHzabLEl/IRp2ognr1w4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-62CNJhkANbyXShbLAJeUeg-1; Fri, 27 Dec 2019 17:44:55 -0500
X-MC-Unique: 62CNJhkANbyXShbLAJeUeg-1
Received: by mail-wr1-f69.google.com with SMTP id b13so14459039wrx.22
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 14:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nSAm4SacMV7LrVbIZgHNPaTxQvom2Z7SvCkmieLXHT4=;
        b=WQvczlCMNjPMroRf86rWD70BAj4AMdq8MDhWgkJJrVUfSoOkkm258EGel+cn/o7s0v
         THXWBUMmNypi3UhIJjIyoMicoFfVUdcJW+RL82FHocntywm3xf5Q57DcVpo84huj4dSL
         ovAK120ZEXgLSMCmHf4o2rOwtWyqzl/jU/3rokhFC83Er4QYQouGq68CCuMjJ0W1uU4y
         v3FzB99EOfM7txE7TffjmfWvkCU+wTIyyOub0u2QNyFERrWKxl1D3hYZpx/dN4gGYwqw
         OAtY2XteesP8gBVp6YvNUqG8gAw3Ss+feabkvJTVFhLH8XM/qG/wgQ7MtLdD8HhfSAw5
         d76Q==
X-Gm-Message-State: APjAAAWYlVATkK5ZVP6kEHKbYXFCDzWJNLb8GyrWWuIXPUdHemyv19kM
        qUL2W34qNAp65U9ESBIp4ybl2FnwV9uGeMKwt7vVv5YXOnC8ouHgLCCS5XJEzk+DNh01Myoxu2/
        4I0vi1+1roX2y4Aj0kwJH
X-Received: by 2002:a5d:4386:: with SMTP id i6mr52406299wrq.63.1577486694057;
        Fri, 27 Dec 2019 14:44:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTV78q1+6EaJ64kpdklMGbakmKQqf+MRM5WcFATYZxCDV1vPcuBJVpoDS/9Guw9U0SKd/Z8A==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr52406291wrq.63.1577486693881;
        Fri, 27 Dec 2019 14:44:53 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id p15sm12550083wma.40.2019.12.27.14.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 14:44:53 -0800 (PST)
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
 <463b0b17-3be7-697e-1227-5d3df52996d6@redhat.com>
 <CAKv+Gu-wk5qBOGuoLx6v7Zo41dOZ5oNL3oBCnyT858DY7JCuhw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <82ad1878-85e3-f893-1c8d-ade0225b2074@redhat.com>
Date:   Fri, 27 Dec 2019 23:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-wk5qBOGuoLx6v7Zo41dOZ5oNL3oBCnyT858DY7JCuhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 25-12-2019 15:42, Ard Biesheuvel wrote:
> On Tue, 24 Dec 2019 at 20:34, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> On 12/18/19 6:01 PM, Ard Biesheuvel wrote:
>>> The various pointers we stash in the efi_config struct which we
>>> retrieve using __efi_early() are simply copies of the ones in
>>> the EFI system table, which we have started accessing directly
>>> in the previous patch. So drop all the __efi_early() related
>>> plumbing, except for the access to a boolean which tells us
>>> whether the firmware is 64-bit or not.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> I synced my personal tree yesterday to 5.5-rc3 + the most
>> recent version (as of yesterday afternoon) of your
>> efistub-x86-cleanup-v3 branch on top.
>>
>> This has been working fine on a bunch of devices, but it fails
>> on a Teclast X89 Bay Trail (mixed mode) device. When reverting all
>> the commits from your efistub-x86-cleanup-v3 branch one by one, things
>> start working again after reverting this one.
>>
> 
> Oops again. And thanks again for taking the time to test this stuff.
> 
> Could you please try the branch below and check whether it fixes it?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-core-mm-fix

This seems to fix the issue, the Teclast X89 boots again and I've
also tested this on 2 other devices (one mixed mode Bay Trail one 64 bit
Cherry Trail device).

If I want to also test them, how do the 2 new series you've just posted come
into the mix here? :

"[PATCH 0/3] efi/x86: clean up and simplify runtime call wrappers"
"[PATCH 0/3] efi/x86: righten memory protections at runtime"

Regards,

Hans

