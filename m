Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5985576
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2019 23:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfHGVzb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Aug 2019 17:55:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41581 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbfHGVza (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Aug 2019 17:55:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so87941699eds.8
        for <linux-efi@vger.kernel.org>; Wed, 07 Aug 2019 14:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5+wIUr/HaJM43d8fA/LrXEAYNKGeyhiwTGst6n7bnUA=;
        b=S+88qoc+g6wzj3hrt7y2qhbKUklpphZTMG42vG5nRN8vsXIq+AFp5ymx/j+2Nzs0+W
         02oIVkUD0hIcLklJ655TtfJpqh2x66oy8r9hgH+1yNO9N4iEaCZdIF2u+QyBCII5YHyQ
         i/XiJWPgW1W46UgekDlqY4TszR+gwLezBoCf564ueVYrz17kKG4jC33VryVk45YnnQLZ
         bgb9DEiuQeLPqSsIBq4Eygx7hnq51P+Cs6nhwwyRoFDZnk0kQJRxjaoTVe4ddQKAFSYn
         0k0P+XnvTe5zLfYrMwH2P09cm5VABhrKKyplwBQq+XWk4Wv5wCPW9KizThkRR7nusGNz
         l7Gw==
X-Gm-Message-State: APjAAAWcQ2L3iMXgp+wjkD4qH5SShDh3ARRS0lYJ38i/1KNgXPY0biw4
        bpqQD3RTONLXFHp2OK47XDpQPkjOjs0=
X-Google-Smtp-Source: APXvYqyX+iMBVh4FhlK75KcTYyvggbCA98eMfzjqiwe5OZetGQgOOCgj+JXkLY3kETlxZO9TlFFxfQ==
X-Received: by 2002:a50:c94b:: with SMTP id p11mr12276976edh.301.1565214928212;
        Wed, 07 Aug 2019 14:55:28 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 11sm12681eje.81.2019.08.07.14.55.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 14:55:27 -0700 (PDT)
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
 <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
 <CAKv+Gu9nEM5D877YD+N8tSN0sON6rR3f+Tc-9bg5u==+9Q2meA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <259b18e9-6ccb-7a96-42f2-360dda488698@redhat.com>
Date:   Wed, 7 Aug 2019 23:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9nEM5D877YD+N8tSN0sON6rR3f+Tc-9bg5u==+9Q2meA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 05-08-19 18:01, Ard Biesheuvel wrote:
> On Sun, 4 Aug 2019 at 19:12, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 04-08-19 17:33, Ard Biesheuvel wrote:
>>> Hi Hans,
>>>
>>> On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
>>>> tablet I noticed that it does not boot on this device.
>>>>
>>>> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
>>>> events from the final event log in the TCG2 log")
>>>>
>>>> And I can confirm that reverting just that single commit makes
>>>> the TW90 boot again.
>>>>
>>>> This machine uses AptIO firmware with base component versions
>>>> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
>>>> a Teclast X80 Pro which is also CHT based and also uses AptIO
>>>> firmware with the same base components. But it does not reproduce
>>>> there. Neither does the problem reproduce on a CHT tablet using
>>>> InsideH20 based firmware.
>>>>
>>>> Note that these devices have a software/firmware TPM-2.0
>>>> implementation, they do not have an actual TPM chip.
>>>>
>>>> Comparing TPM firmware setting between the 2 AptIO based
>>>> tablets the settings are identical, but the troublesome
>>>> TW90 does have some more setting then the X80, it has
>>>> the following settings which are not shown on the X80:
>>>>
>>>> Active PCR banks:           SHA-1         (read only)
>>>> Available PCR banks:        SHA-1,SHA256  (read only)
>>>> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
>>>> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
>>>>
>>>> I have the feeling that at least the first 2 indicate that
>>>> the previous win10 installation has actually used the
>>>> TPM, where as on the X80 the TPM is uninitialized.
>>>> Note this is just a hunch I could be completely wrong.
>>>>
>>>> I would be happy to run any commands to try and debug this
>>>> or to build a kernel with some patches to gather more info.
>>>>
>>>> Note any kernel patches to printk some debug stuff need
>>>> to be based on 5.3 with 166a2809d65b reverted, without that
>>>> reverted the device will not boot, and thus I cannot collect
>>>> logs without it reverted.
>>>>
>>>
>>> Are you booting a 64-bit kernel on 32-bit firmware?
>>
>> Yes you are right, I must say that this is somewhat surprising
>> most Cherry Trail devices do use 64 bit firmware (where as Bay Trail
>> typically uses 32 bit). But I just checked efibootmgr output and it
>> says it is booting: \EFI\FEDORA\SHIMIA32.EFI so yeah 32 bit firmware.
>>
>> Recent Fedora releases take care of this so seamlessly I did not
>> even realize...
>>
> 
> OK, so we'll have to find out how this patch affects 64-bit code
> running on 32-bit firmware. The only EFI call in that patch is
> get_config_table(), which is not actually a EFI boot service call but
> a EFI stub helper that parses the config table array in the EFI system
> table.

Ok, the problem indeed is the new get_efi_config_table() helper, it
does not make any calls, but it does interpret some structs which
have different sized members depending on if the firmware is 32 or 64 bit.

I've prepared a patch fixing this which I will send out after this mail.

Regards,

Hans

