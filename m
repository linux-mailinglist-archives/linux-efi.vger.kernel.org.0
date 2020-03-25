Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC9192EA9
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCYQu0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 12:50:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24043 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbgCYQuZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Mar 2020 12:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585155024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGAgbqjF64gagaSYbf8hIWOAlP7Z/+xy71Y8V8xNnww=;
        b=XR29i5G/dFuqShcxR9j+mE2/55UmaawKp+/9rcgpX+jVN2wy6rMw1K1c/ltMePxBENXnP3
        uCDzlcD3oojR5Cr8aBWJpd6w3z/z1nhpGUloFJmqqpPivk6QnIVzYFLjcStJ3vbETLHKQn
        y03G+biO6oIHCNAT31P33pYpzz4dqpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-whIdwmOmPK2AJoNJZsmjZA-1; Wed, 25 Mar 2020 12:50:23 -0400
X-MC-Unique: whIdwmOmPK2AJoNJZsmjZA-1
Received: by mail-wr1-f72.google.com with SMTP id b2so985823wrq.8
        for <linux-efi@vger.kernel.org>; Wed, 25 Mar 2020 09:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGAgbqjF64gagaSYbf8hIWOAlP7Z/+xy71Y8V8xNnww=;
        b=ES2jwe4EQAQKa65IRyP9C0f0Y+um4GwM3C8YCxVaPK1bWz4q3cggQ8CAXwu1ZVncZX
         ux3na32nuuty15aSB2xp2JniOlf5ka9aXaj7q/v9li5y5HPS2AdfIM++faRInnQyycjQ
         lxvyT/vt7BDzLbaCNG4nTRPtPyy8gXbvWTI1PlgqBRYsITh9Ry9BPrla41pfn8pZ6FYP
         vQgls0MRina1EIrSWgnCoEGUQRN3K3EXe1F+ys8UO3u18UWHhx2ijugV0Q6Eu0RxYRVi
         zR0KYHmz14M2S6ZcYwkxZ9LwPLUvPzjEPF+IaEJ/gQKPb5ogZqhMpe3MZimTv1LOOVGF
         /7/A==
X-Gm-Message-State: ANhLgQ3YOeU+R+DVozh8TcJ38fejvNQrvnqLgAnMZC7kg+nYpuiRC2uf
        OOdKavMWxb2zHL1B5XCDl97nT5S7+atrkFWS1uYntNbGovJ5rhu93zhTtG6Bw9/y10lRKMDgqEV
        mODVteKGJE4aTwLXQ8f/8
X-Received: by 2002:a1c:1904:: with SMTP id 4mr4263247wmz.21.1585155021771;
        Wed, 25 Mar 2020 09:50:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvx1Vuu3nNlI6E1pc7bO4eCSqtL2lv6Y9OhLuiZYASd7HG5OkQjemuvFa8yhOYFTWAwl3oiBg==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr4263226wmz.21.1585155021545;
        Wed, 25 Mar 2020 09:50:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id i1sm33556433wrq.89.2020.03.25.09.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:50:20 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
 <20200320020028.1936003-1-nivedita@alum.mit.edu>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dcb1bfb1-9663-f149-a29c-87e5a6c6c2f0@redhat.com>
Date:   Wed, 25 Mar 2020 17:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320020028.1936003-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 3/20/20 3:00 AM, Arvind Sankar wrote:
> This series is against tip:efi/core.
> 
> Patches 1-9 are small cleanups and refactoring of the code in
> libstub/gop.c.
> 
> The rest of the patches add the ability to use a command-line option to
> switch the gop's display mode.
> 
> The options supported are:
> video=efifb:mode=n
>          Choose a specific mode number
> video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
>          Specify mode by resolution and optionally color depth
> video=efifb:auto
>          Let the EFI stub choose the highest resolution mode available.
> 
> The mode-setting additions increase code size of gop.o by about 3k on
> x86-64 with EFI_MIXED enabled.

Thank you for adding me to the Cc. I will add these to my personal
tree, which I test semi-regular on various hardware.

I've only looked at patches 10 - 14 and a quick glance these look
good to me.

I was worried that you would maybe always enumerate the modes or
some such, but I see that you have structured things in such a way
that if the new kernel cmdline options are not used no extra EFI
calls are made, which make me very happy!

This way we do not need to worry about this patch-set tripping up
buggy firmware (which is quite likely to be out there somewhere)
by making new, previously unused, EFI calls.

Regards,

Hans






> 
> Changes in v2 (HT lkp@intel.com):
> - Fix __efistub_global attribute to be after the variable.
>    (NB: bunch of other places should ideally be fixed, those I guess
>    don't matter as they are scalars?)
> - Silence -Wmaybe-uninitialized warning in set_mode function.
> 
> Arvind Sankar (14):
>    efi/gop: Remove redundant current_fb_base
>    efi/gop: Move check for framebuffer before con_out
>    efi/gop: Get mode information outside the loop
>    efi/gop: Factor out locating the gop into a function
>    efi/gop: Slightly re-arrange logic of find_gop
>    efi/gop: Move variable declarations into loop block
>    efi/gop: Use helper macros for populating lfb_base
>    efi/gop: Use helper macros for find_bits
>    efi/gop: Remove unreachable code from setup_pixel_info
>    efi/gop: Add prototypes for query_mode and set_mode
>    efi/gop: Allow specifying mode number on command line
>    efi/gop: Allow specifying mode by <xres>x<yres>
>    efi/gop: Allow specifying depth as well as resolution
>    efi/gop: Allow automatically choosing the best mode
> 
>   Documentation/fb/efifb.rst                    |  33 +-
>   arch/x86/include/asm/efi.h                    |   4 +
>   .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
>   drivers/firmware/efi/libstub/efistub.h        |   8 +-
>   drivers/firmware/efi/libstub/gop.c            | 489 ++++++++++++++----
>   5 files changed, 428 insertions(+), 109 deletions(-)
> 
> 
> base-commit: d5528d5e91041e68e8eab9792ce627705a0ed273
> 

