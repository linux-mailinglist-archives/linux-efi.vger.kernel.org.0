Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3F49CBC0
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 15:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiAZODw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiAZODw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 09:03:52 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB8C06161C
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 06:03:51 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p5so71522376ybd.13
        for <linux-efi@vger.kernel.org>; Wed, 26 Jan 2022 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KgAy15DDMAR2vjy8MiwG/RlJLyeMSxdmZmAbGV8zyZo=;
        b=DuizcgPMiu9eosVBoNVF9GXmy/vOHlsyPY4EPNeMMFbDaxS4YbjLG2k3mZuPyZp6nf
         mwFunqVxw0K+rEwzgUyTXfdvmL5BeLj26bqEJQ5veR0aakcJ78+I2l5VZqLFNLs9nCec
         6ffY5vozp4KqeyHfj1dSwlC5t72zaZMoMUoLB7iKNaTa4LNVwHB8AfYmBB86NdbN2nsP
         dv0UPQJzy5A02W0TAONv6Rn5Q9uyz/UWeKWfKPAu4n7G5yQPfYEZfMoE7+HRY/N/zpjU
         qksxBQX2M7uHcfVpSH28kwZvNv2srrULTX2ONPPpjSyMqODUgLOOOEzpAeD8870RvkWs
         W6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KgAy15DDMAR2vjy8MiwG/RlJLyeMSxdmZmAbGV8zyZo=;
        b=Worzy/ueGpUZF4GUYBl9HhGJXx3r874xnhxLrhdV1gBK84qeclWznDYES5vgZq7w8e
         vdbYDjd+FeqTB7fSi2kXAfOywp9WWikbMeEunbWVLVtXfu7BHoJpkHmajGelHzlvgAn9
         nzzlUbtLQm8Siu66BUDMqU7+1ssfIMUnBiplJRDA2DYSkWshv5vQXcugD8ZT4uduOQsL
         lc/77+NGDDDb9jXgPw7H6HaqSqAKwctHL4HMMrDsJsiDA2fx1kyMcbLLpzJqVy6PX4Td
         kISRY/D48d2z9/4338uMHCrT+lMqdZVoXPU3WRZOgtIg4BgsDbW6DAjz1oBeiqz8tG9G
         bGQg==
X-Gm-Message-State: AOAM533+ToANPz9OqE+ZQwvpr3IXixy3MeviMbhiKIy/gVivE9g4jC/+
        CCqfzgvdj6Xgd4zwUJYBgj/7LTZ6eCSJ+dogKyaK0g==
X-Google-Smtp-Source: ABdhPJxG2AiuBT6jF9/C4OMbB5sFSeC1iGSmdOO8xUnGvYsnanamPg5zDFyS9LKTGkMtjjtvdQEY1gfURY0fRsUqNGc=
X-Received: by 2002:a25:b305:: with SMTP id l5mr30998617ybj.393.1643205831097;
 Wed, 26 Jan 2022 06:03:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:1756:0:0:0:0:0 with HTTP; Wed, 26 Jan 2022 06:03:50
 -0800 (PST)
In-Reply-To: <CAKgze5Z7U0R+HJ8_GajUsspYw+52+i2MW75KBGVOmE8zmT_BDQ@mail.gmail.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
 <20220113213027.457282-4-martin.fernandez@eclypsium.com> <eea2c529-b874-58e6-f0b2-1483cc7e30a6@intel.com>
 <CAKgze5Z7U0R+HJ8_GajUsspYw+52+i2MW75KBGVOmE8zmT_BDQ@mail.gmail.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Wed, 26 Jan 2022 11:03:50 -0300
Message-ID: <CAKgze5ba429M=Aad9qBNL+CZLCVF09LQ6ZwXCT2jc86vDggp6g@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> On 1/14/22, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 1/13/22 1:30 PM, Martin Fernandez wrote:
>>> +/*
>>> + * Update crypto capabilities in a range
>>> + */
>>> +static u64 __init __e820__range_update_crypto(struct e820_table *table,
>>> +					      u64 start, u64 size,
>>> +					      enum e820_crypto_capabilities crypto_capable)
>>
>> This looks like an almost pure copy-and-paste of a 70-line function.
>> That's not the end of the world, but it does seem like a place where
>> refactoring is in order.

Introducing a for_each to iterate over the table is one of the
improvements I'm thinking of. Do you think it's a good idea to
introduce it in this patch (changing all the relevant for loops for
this new for_each) or should I do it in a separate patch?
