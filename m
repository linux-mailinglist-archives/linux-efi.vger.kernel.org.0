Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42711AFA3C
	for <lists+linux-efi@lfdr.de>; Sun, 19 Apr 2020 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDSMzg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Apr 2020 08:55:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgDSMzg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 19 Apr 2020 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587300934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPen57uZEuFJrdx5EuSsH3ijNJHpUMaNJatHKY5D+1g=;
        b=aWGD3kNC3bCZbpsciXXei+LHWxIfgmBFfpjr+gsmV8C/O+rm7VWpzXbTLADONSWFULcJgA
        axCVevvJi5usgpJVF9GHu6KOJyyVdTyjP2K4pv8c9shN6uTQUUcpmJVxf8au848HvW8UHM
        wmbcaut2vFkO/nuEsnWFSD7MoVbZ8MA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-aKypNcSAMCi_mDbiq_2g8A-1; Sun, 19 Apr 2020 08:55:31 -0400
X-MC-Unique: aKypNcSAMCi_mDbiq_2g8A-1
Received: by mail-wr1-f72.google.com with SMTP id u4so4041974wrm.13
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 05:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FPen57uZEuFJrdx5EuSsH3ijNJHpUMaNJatHKY5D+1g=;
        b=Y0J/FSneAHIJeD4BcxJSQ5lyxKzudNQJ9Nxj9nP/tNjLFafV9/yH7sb/MauEFVz1gS
         Tgr/jHKKvBEUFzZFbdjJaA5kHTydbCAowpT18q0Rk3lISrmlEKOMbZ65zeOMAXAIuvhS
         8e6NakfXFZ//50o9VqErJcBWhuD2QhdhrkvudsTD1xkZTYRJJSYD670keOFvm2+CLMsh
         1QqXHAWnYqAiv6QTCFPNIGuPpByGoXJnFqrl+jQg/N30zBxKXPZ9KIMzAeLhLXTOORhE
         U0/Re6IckexzFHe9xq28p533lyXUFm9xZoStDiR70Ez+Uhv5HMvbkSPwfNh6BoCF0Mgv
         ZfGg==
X-Gm-Message-State: AGi0PuYLETCUNqSwiMtfbTBnFcoEAqvDdCsLcOXBtJCqBvINNbKXIIif
        x2H6dnlGJxCOcv03E0FbEIjCBsv2jlVA6MybkRrKmlBp1uEoHXaWFjGcNLd5hZjb+AIKfXGnax7
        wW91aMGWLQ7N5IEugfqLg
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr12352287wmc.74.1587300929673;
        Sun, 19 Apr 2020 05:55:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgsSIX1MmngKTwvjijBRh1Z5Mk4XbfgYQ7DyT8P69D43yjbVHas7ib1Tl+RQNomyt2c0Kt2w==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr12352273wmc.74.1587300929475;
        Sun, 19 Apr 2020 05:55:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y9sm15189934wmm.26.2020.04.19.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 05:55:28 -0700 (PDT)
Subject: Re: Starting with kernel 5.6 deleting efibootmgr entries no longer
 works (efivarfs regresson)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, russianneuromancer@ya.ru
References: <bf17f4c7-f7a8-01c1-f7a9-bf0a499c502c@redhat.com>
 <CAMj1kXEdjqph0d96o6j=avT+Zt41ibegiyTKHK+RCmGaZVeTpA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <caf85ef9-5231-9d2f-356b-375a46c2cb42@redhat.com>
Date:   Sun, 19 Apr 2020 14:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEdjqph0d96o6j=avT+Zt41ibegiyTKHK+RCmGaZVeTpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 4/19/20 1:59 PM, Ard Biesheuvel wrote:
> On Sun, 19 Apr 2020 at 13:41, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> I got a bug report by email that "grub-install" was throwing errors
>> on 32 bit UEFI (64 bit kernel, mixed mode) systems starting with 5.6 .
>> After that I noticed that the Fedora installer also threw an error about
>> it being unable to setup the bootloader (which I could luckily skip), this
>> was also a 32 bit UEFI mixed-mode system.
>>
>> So I've been running some tests with efibootmgr from the shell. Adding
>> new entries works, but removing an entry involves unlinking the EFI var
>> for the old which fails, here is the relevant part from a strace run:
>>
>> unlink("/sys/firmware/efi/efivars/Boot0000-8be4df61-93ca-11d2-aa0d-00e098032b8c") = -1 EINVAL (Invalid argument)
>>
>> With kernel 5.5 the same unlink succeeds, I guess this is also the
>> cause for the grub-install and Fedora 32 installer errors. At least
>> the Fedora 32 install error was seen on a system which already had
>> a "Fedora" efibootmgr entry, so likely the installer tried to remove
>> the old entry first and that caused the failure.
>>
>> I've also tried removing efibootmgr entires on a 64 bit UEFI system running
>> 5.6.4 and that works fine. On 32 bit UEFI mixed-mode systems the problem
>> persists with 5.7-rc1.
>>
>> Ard, any idea where to start with pinpointing the cause of this
>> regression ?
>>
> 
> Can you start by trying this patch please?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=9461aa3b44ac21668100067939d24a6ffa810eae

Cool, I can confirm that this fixes deleting boot entries with
efibootmgr.

Regards,

Hans


p.s.

In Torvald's tree this seems to have gotten a different commit-id:
a4b81ccfd4caba017d2b84720b6de4edd16911a0

