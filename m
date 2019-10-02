Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52942C48EE
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJBH5a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 03:57:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40591 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfJBH5a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 03:57:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so18421462wru.7
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2019 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvsUcL/p4vIyxeM7cuuM7NxzFG4ZxETWErIwO2hhQ0Y=;
        b=rMC6EQ/swdSjAn7aSqT6GGmPXyX+fv/SA9KWhOvooZUPiugGOxmUwKOw1FWJ80gGHd
         6xI4NL+hT8bkUeEwoJQVIpDxm0GtGYdpG5vaP+9mfF3/VDzqpQmyPoIXrZbSf8QDdloy
         L+NgFTDQyVBunEAXNmoVnZT0PH2f4mLHik/wRvbsxieEyAJh2D+PIE6XGhHNI1/R/sDF
         ib8MVhCd5Neft8zmsN8d6ocjxFbWwHiUhDhpHE+8OIOwwFCwiakP/Wb45HwQI2z0A+1+
         Z0f6bqz+t1CbZ7c3wywwvNP7RJyYhI4ckcY0lO1aIdD4X5UE0JBJzfa5y57CTQ6N4t+E
         NEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvsUcL/p4vIyxeM7cuuM7NxzFG4ZxETWErIwO2hhQ0Y=;
        b=ZOYB8i9U4KMKEEfNQt/mVvnJb3PtLUsjJrL0NljNE5UNsda3+9ZpLumUhYrlQd8qtZ
         b2ytbPBoFKj0fX80UzyEqcfA6gkAAFK58XpLt9y16EN/HrU7djXjVj2VLRgy5zBZBVYt
         S5QUSZXKt5i7k44EVHx6dkOJYJPJ9S/FEfL+bwxJA3CLMR4bOjJ9rJKF/X28HCXUxjP0
         wftwuiDIcdT9qjpqnc7pb+RFgRrzPLnIW+cExtni/ma6Bd768kSf2mOl7lY+lWvkjv5B
         Kf4P7MnUxhUCMY71/ggsQXfy1/kB7VV0y5Zaw7L+KI+M/GkyN6NCDSwrovWiHIOlO69v
         uNPg==
X-Gm-Message-State: APjAAAWfRA4AXAotzP6OU4jIIDxRDnBJxZzvYYyVBiatJGDHJHTOHVKf
        dhMjP8e8eVUai/BjIYAsrfmhQyd4B1MrXm28OWxcu2Lr1jE=
X-Google-Smtp-Source: APXvYqx8GyA6vwt10WUeF6QM6u4wFBtFe/mLTgUjHQTsWiM3rSDe+Lqv+r1oL1UmmpZNfQq45XNfdO3cOv2AzTTdJXI=
X-Received: by 2002:adf:fe88:: with SMTP id l8mr1448415wrr.32.1570003047271;
 Wed, 02 Oct 2019 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <D6FD0BFD-0934-4D9B-986C-89ED5CF13FE5@m3y3r.de>
In-Reply-To: <D6FD0BFD-0934-4D9B-986C-89ED5CF13FE5@m3y3r.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 2 Oct 2019 09:57:15 +0200
Message-ID: <CAKv+Gu9MbOzYKBOOWppXBb7XQX=ra2cyVTDTNBdj6GBFuBXXBw@mail.gmail.com>
Subject: Re: 5.3.1: x86: efi stub seems to fail to load initrd file
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2 Oct 2019 at 00:42, Thomas Meyer <thomas@m3y3r.de> wrote:
>
> Hi,
>
> I've got this old x86 MacBookPro1,1 and I wanted to switch to systemd-boot.
>
> systemd-boot works fine but the Linux efistub somehow fails to load the initrd, sadly the monitor seems to be switched off/no backlight after systemd-boot menu selection and Linux kernel starting efifb.
>
> Any ideas what could be the culprit?
> I tried to boot with efi=nochunk but same result.
>
> I tried to understand what systemd boot does for file loading and what libefistub does, it looks very similar.
>
> So any ideas and hints are welcome what is maybe wrong in my setup.
>
> When I embedded the initramfs in the kernel, boot of Linux and system works correctly.
>
> Ps: all efi_printk seems to be lost in the kernel. Is there a way to transfer this into the kernel somehow?
>

Unfortunately not. Do you actually see the output? (which may require
removing 'quiet' from the command line) If so, can you capture it with
your phone camera perhaps?
