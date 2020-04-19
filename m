Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7D1AF9A4
	for <lists+linux-efi@lfdr.de>; Sun, 19 Apr 2020 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDSLlD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Apr 2020 07:41:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57071 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725910AbgDSLlC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 19 Apr 2020 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587296461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xZ16oAmSILdhGtU4ge95WgHjx5p6hqhzB4a6jpj1OF4=;
        b=NE9mvKvkPu+8MMHjKQ/cqd6S3R0IUW4qiD9L1lea6yMendQ+QmMHsoy0sjRwKD/DD9wQIW
        kZz11Z9xsH7ONIB1LVVrlsiGQsfyWctZmv0NpGHc8ZXoDc5DuWtdOd2f+AlSq9NbAQBEjf
        Pjkvm8JrgGroovVemc47c9lheQME3iY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-xg1GMeY_NFeSJWzq5RX0Lg-1; Sun, 19 Apr 2020 07:40:57 -0400
X-MC-Unique: xg1GMeY_NFeSJWzq5RX0Lg-1
Received: by mail-wr1-f71.google.com with SMTP id g7so3089656wrw.18
        for <linux-efi@vger.kernel.org>; Sun, 19 Apr 2020 04:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xZ16oAmSILdhGtU4ge95WgHjx5p6hqhzB4a6jpj1OF4=;
        b=AmYQmSy93tuQjZA2xqf8CdDqEp3fHR2CiRe0zCcX2L0AmU88QeyMyU1yzb5zaungjX
         l+I46hJrl2o0FRpbJfK33gFw2SL0Lh7ZgL7EjJ0ObTK4aeSKpxlKZf3MxRqN5RSd09rw
         DbpTcrUxJuom2r+B0t/tvmKm/ae4dEJWDAZ5FBT/+dwNVrECmTC/kerPFgz9dmmsr+lm
         kShnVZ+tsLWt9ZO7gu8Sqafdkbj2KLPkmk/QFk18uGyDJcV4M4U8+m5I4GidaaW4x/NA
         4QBF8zT+EzJpkkRFuuzNRrO86LkgRkaC/wRCT/TRLyh3p0mFRKJwgdBYM2O6iK74uhkf
         OMHQ==
X-Gm-Message-State: AGi0PubmEIHyEwuZQTEJbt3Y9V9jET7tETTvG1Cg0dtYBbjwUZq31XWY
        sIkWMqxpjs+JHlb25Q49tMg7j+x2XuuZ47lX3kIhLMJiZ+QvveA2yq0Lee1qtdGTl5d+VqvDN9G
        hLuHYFv8X9qTMyZoXtOwM
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr12613597wmk.154.1587296456102;
        Sun, 19 Apr 2020 04:40:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIeB+TN8SAmzMc0j+EDPZyajAoLR+ZSivYhRIVndRpX3QI6+D648TJyBZQIX40VlEl+FjyufA==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr12613588wmk.154.1587296455927;
        Sun, 19 Apr 2020 04:40:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i25sm15401393wml.43.2020.04.19.04.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:40:55 -0700 (PDT)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, russianneuromancer@ya.ru
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Starting with kernel 5.6 deleting efibootmgr entries no longer works
 (efivarfs regresson)
Message-ID: <bf17f4c7-f7a8-01c1-f7a9-bf0a499c502c@redhat.com>
Date:   Sun, 19 Apr 2020 13:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

I got a bug report by email that "grub-install" was throwing errors
on 32 bit UEFI (64 bit kernel, mixed mode) systems starting with 5.6 .
After that I noticed that the Fedora installer also threw an error about
it being unable to setup the bootloader (which I could luckily skip), this
was also a 32 bit UEFI mixed-mode system.

So I've been running some tests with efibootmgr from the shell. Adding
new entries works, but removing an entry involves unlinking the EFI var
for the old which fails, here is the relevant part from a strace run:

unlink("/sys/firmware/efi/efivars/Boot0000-8be4df61-93ca-11d2-aa0d-00e098032b8c") = -1 EINVAL (Invalid argument)

With kernel 5.5 the same unlink succeeds, I guess this is also the
cause for the grub-install and Fedora 32 installer errors. At least
the Fedora 32 install error was seen on a system which already had
a "Fedora" efibootmgr entry, so likely the installer tried to remove
the old entry first and that caused the failure.

I've also tried removing efibootmgr entires on a 64 bit UEFI system running
5.6.4 and that works fine. On 32 bit UEFI mixed-mode systems the problem
persists with 5.7-rc1.

Ard, any idea where to start with pinpointing the cause of this
regression ?

Regards,

Hans

