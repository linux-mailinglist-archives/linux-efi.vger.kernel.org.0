Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13B12A71C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Dec 2019 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfLYJuQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Dec 2019 04:50:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34063 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfLYJuQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Dec 2019 04:50:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so21522177wrr.1;
        Wed, 25 Dec 2019 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyeEBPr9x2675SHEugYKlyIE05mvLrBQq6PrEF5BABs=;
        b=V4ifU4ONtD1g9nsVaQ/MWUNJwEbMrr4s6wBf6SWQHpm3UTdmGw1hsFF/zEM/Oavk+2
         QuZV6AFy2c57pCy61mv8o7sw2JYQwieI7PWr8TogG1ecXaWJ8X+srYxuOCugGSoqWc4O
         c/XDpdkyFnxHOZ52K2XC4mcOcEkt6YbdX2Ag8DTWGVF/N5nedOfpbcaLSqPWYO5jvBlQ
         43hIhv3HC+0IU69CsafmXF24nkSMD72Aq29JAlnj9nRGDuSet2onU7x3de8uKZuFofiD
         fMqSiEt5KhFWinV2q829iab6GkHI+uEjYNAeE+Pr/+Kp5Vo4YR1+xeVUYpN08QCZ9EHT
         M35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyeEBPr9x2675SHEugYKlyIE05mvLrBQq6PrEF5BABs=;
        b=GB0cC9erswMpbxNbleC1P6X8vM/84wq3BL+UYclXsOl/fl12cRrLBhUD6BgJNPcwdt
         qXL+3xywW7yzeW/6syo2WhpCeieq7CXxXqayGn9o05vcdnybBK3uI6i4EFIQI2mKUGWH
         T+yX4slz8jdGKhQTnY4ZXxr5SHHpA71tBPndhFJdNO/mHAMqTiFUvt8pEQJoZGFGBYkM
         I2kmneYonhxPS0FFWFZ0+RjLajuADDnEuN8ee/hkF3+X6p2IpfeLXyOWbGsm03zV+ulp
         makWzhi2e+Bn0xreQ0bjq+UwQHa6WQDOUpLAPviqK0w6JbzqjPzEOrpKXmPKWT/HzdGb
         uxBw==
X-Gm-Message-State: APjAAAXtyic/WNzeIhwO9+XR1uXHHy+x8B/YGz7KlJkh2JHqiyfT8xCA
        bzeUQOBBBEtHLgplRKimhTM=
X-Google-Smtp-Source: APXvYqyp7gnRFb8K2+78RItUBwmkbuwDHR6GtyyAmDJnOdpuS2snRsIxSaHOkquoMdpm/Iukg1+TwQ==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr41041070wrx.109.1577267413971;
        Wed, 25 Dec 2019 01:50:13 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o4sm26836834wrw.97.2019.12.25.01.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 01:50:13 -0800 (PST)
Date:   Wed, 25 Dec 2019 10:50:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [GIT PULL 0/3] EFI fixes for v5.5
Message-ID: <20191225095011.GA73981@gmail.com>
References: <20191224132909.102540-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224132909.102540-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit a470552ee8965da0fe6fd4df0aa39c4cda652c7c:
> 
>   efi: Don't attempt to map RCI2 config table if it doesn't exist (2019-12-10 12:13:02 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
> 
> for you to fetch changes up to 77217fcc8e04f27127b32825376ed508705fd946:
> 
>   x86/efistub: disable paging at mixed mode entry (2019-12-23 16:25:21 +0100)
> 
> ----------------------------------------------------------------
> Some more fixes for the EFI subsystem:
> - Ensure that the EFI framebuffer earlycon uses WC attributes on x86 (Arvind)
> - Another mixed mode fix from Hans, for the RNG code this time.
> - Fix mixed mode boot from OVMF, by disabling paging at entry.
> 
> ----------------------------------------------------------------
> Ard Biesheuvel (1):
>       x86/efistub: disable paging at mixed mode entry
> 
> Arvind Sankar (1):
>       efi/earlycon: Fix write-combine mapping on x86
> 
> Hans de Goede (1):
>       efi/libstub/random: Initialize pointer variables to zero for mixed mode
> 
>  arch/x86/boot/compressed/head_64.S    |  5 +++++
>  drivers/firmware/efi/earlycon.c       | 16 +++++++---------
>  drivers/firmware/efi/libstub/random.c |  6 +++---
>  3 files changed, 15 insertions(+), 12 deletions(-)

Applied to tip:efi/urgent, thanks Ard!

	Ingo
