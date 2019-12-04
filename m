Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0E11339C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfLDSSD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:18:03 -0500
Received: from foss.arm.com ([217.140.110.172]:60486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731879AbfLDSSC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Dec 2019 13:18:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0220731B;
        Wed,  4 Dec 2019 10:18:02 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5083F718;
        Wed,  4 Dec 2019 10:18:00 -0800 (PST)
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, mark.rutland@arm.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        d.hatayama@fujitsu.com, kexec@lists.infradead.org
References: <20191204145233.11962-1-ardb@kernel.org>
 <20191204171744.o3ijdspnelqn5fgd@gabell>
From:   James Morse <james.morse@arm.com>
Message-ID: <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com>
Date:   Wed, 4 Dec 2019 18:17:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204171744.o3ijdspnelqn5fgd@gabell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Masa,

On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> 
> After applied your patch, the LPI tables are marked as reserved in
> /proc/iomem like as:
> 
> 80300000-a1fdffff : System RAM
>   80480000-8134ffff : Kernel code
>   81350000-817bffff : reserved
>   817c0000-82acffff : Kernel data
>   830f0000-830fffff : reserved # Property table
>   83480000-83480fff : reserved # Pending table
>   83490000-8349ffff : reserved # Pending table
> 
> However, kexec tries to allocate memory from System RAM, it doesn't care
> the reserved in System RAM.

> I'm not sure why kexec doesn't care the reserved in System RAM, however,

Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
tables being overwritten by kexec.

Which version of kexec-tools are you using? Could you try:
https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem


> if the kexec behaivor is right, the LPI tables should not belong to
> System RAM.

> Like as:
> 
> 80300000-830effff : System RAM
>   80480000-8134ffff : Kernel code
>   81350000-817bffff : reserved
>   817c0000-82acffff : Kernel data
> 830f0000-830fffff : reserved # Property table
> 83480000-83480fff : reserved # Pending table
> 83490000-8349ffff : reserved # Pending table
> 834a0000-a1fdffff : System RAM
> 
> I don't have ideas to separete LPI tables from System RAM... so I tried
> to add a new file to inform the LPI tables to userspace.

This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
is kdump can't touch it, as you've told it this isn't memory.

As these tables are memory, mapped by the linear map, I think Ard's patch is the right
thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
it honour all second level entries.


Thanks,

James
