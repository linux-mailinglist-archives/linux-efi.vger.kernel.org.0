Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4310746
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2019 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfEAKx6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 May 2019 06:53:58 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:55229 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfEAKx6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 1 May 2019 06:53:58 -0400
Received: from [192.168.1.5] (x590c9ba2.dyn.telefonica.de [89.12.155.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 365DA604E364E;
        Wed,  1 May 2019 12:53:56 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: UEFI Fast Boot or Quick Boot for MS Windows also for Linux?
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <082b8964-7173-3a4e-b67d-24df13945617@molgen.mpg.de>
Date:   Wed, 1 May 2019 12:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear Linux folks,


According to `systemd-analyze` the UEFI firmware on several systems, for 
example the laptop Dell Latitude E7250 and the desktop board MSI B350M 
MORTAR, take over ten seconds to initialize.

     $ systemd-analyze
     Startup finished in 11.193s (firmware) + 1.558s (loader) + 4.155s 
(kernel) + 2.007s (userspace) = 18.914s
     graphical.target reached after 1.983s in userspace

Talking to other people, I heard, Microsoft Windows since version 8 can 
activate some fast/quick boot mode in the firmware.

I haven’t even found the specification for that mode. It could be 
something like [1], but I do not think it is:

> Fast Boot is a feature in BIOS that reduces your computer boot time. If
> Fast Boot is enabled:
> 
> •   Boot from Network, Optical, and Removable Devices are disabled.
> •   Video and USB devices (keyboard, mouse, drives) won't be available
>     until the operating system loads.

Some other sources [2] say, that MS Windows just uses hibernation to 
boot quicker, but I do not think this is it, because with hibernation 
there should be also a ten seconds delay, right?

Do you know more about this mode, and how it works? Could it be 
implemented for Linux?


Kind regards,

Paul


[1]: 
https://www.intel.com/content/www/us/en/support/articles/000006699/mini-pcs.html
