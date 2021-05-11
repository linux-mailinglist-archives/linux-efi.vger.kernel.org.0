Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAC37B066
	for <lists+linux-efi@lfdr.de>; Tue, 11 May 2021 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEKU7R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 May 2021 16:59:17 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:41739 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhEKU7R (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 May 2021 16:59:17 -0400
Received: from [192.168.0.7] (ip5f5aeee8.dynamic.kabel-deutschland.de [95.90.238.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A8CAE61E646CA;
        Tue, 11 May 2021 22:58:09 +0200 (CEST)
Subject: Re: efivarfs fails with `No such device` when EFI runtime is missing
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <b075e45e-365a-dafb-503c-615c41168b0d@molgen.mpg.de>
Message-ID: <706be699-7f79-391c-bbac-a4b3820511d8@molgen.mpg.de>
Date:   Tue, 11 May 2021 22:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <b075e45e-365a-dafb-503c-615c41168b0d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[Use Ard’s current email, and add other maintainers]

Am 11.05.21 um 22:55 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> I migrated a 32-bit GNU/Linux installation from BIOS to EFI. Trying to 
> edit the entries in UEFI’s Boot Manager with `efibootmgr`, I got the error:
> 
>     EFI variables are not supported on this system
> 
> `sudo modprobe efivarfs` fails with
> 
>     No such device
> 
> After several tries, I found
> 
>     [    0.000000] efi: No EFI runtime due to 32/64-bit mismatch with 
> kernel
> 
> logged by Linux, and then I found the Stack Overflow thread *How could 
> 32bit kernel read efivars from 64bit UEFI?* [1].
> 
> I would have thought, setting EFI variables is just directly writing to 
> some storage. But probably not.
> 
> Could the error message for the efivarfs load failure be improved, that 
> *device* means the runtime service (if I am not mistaken)?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://stackoverflow.com/questions/46610442/how-could-32bit-kernel-read-efivars-from-64bit-uefi 
