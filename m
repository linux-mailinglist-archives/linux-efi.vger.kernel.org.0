Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF274CBFC2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiCCOQf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCCOQf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 09:16:35 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD7218CC65;
        Thu,  3 Mar 2022 06:15:48 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id AB11A40755C1;
        Thu,  3 Mar 2022 14:15:46 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 03 Mar 2022 17:15:46 +0300
From:   baskov@ispras.ru
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
In-Reply-To: <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <773b799354b50adf854837d8a6d54b8f@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-02-28 19:45, Ard Biesheuvel wrote:
> (cc Matt and Peter)
> 
> 
> Thanks for exploring my suggestion to use the DXE services for this.
> 
> Given that this is a workaround for a very specific issue arising on
> PI based implementations of UEFI, I consider this a quirk, and so I
> think this approach is reasonable. I'd still like to gate it on some
> kind of identification, though - perhaps something related to DMI like
> the x86 core kernel does as well.
> 
> I've cc'ed Peter and Matt, who have much more experience dealing with
> these kinds of things on x86 - my experience is mostly based on ARM,
> which tends to be less quirky when it comes to UEFI support, given
> that vendors that implement EFI actually care about being compliant
> (instead of only about getting a windows sticker)
> 
> Matt, Peter, any thoughts?
> 
> 
>> Baskov Evgeniy (2):
>>        efi: declare DXE services table
>>        libstub: ensure allocated memory to be executable
>> 
>>  arch/x86/include/asm/efi.h              |  5 ++
>>  drivers/firmware/efi/libstub/efistub.h  | 53 ++++++++++++++++++++
>>  drivers/firmware/efi/libstub/x86-stub.c | 73 
>> ++++++++++++++++++++++++++--
>>  include/linux/efi.h                     |  2 +
>>  4 files changed, 128 insertions(+), 5 deletions(-)

We now have tested the patch on major platforms, and it works without 
any
issues. But in case of firmware bugs I have changed the code to only
modify attributes if either EFI_MEMORY_RO or EFI_MEMORY_WP is set and
the memory has type EfiGcdMemoryTypeSystemMemory.

I also added option CONFIG_EFI_DXE_MEM_ATTRIBUTES (enabled by default),
to allow this code to be disabled at compile time.

These changes will be sent in version 3 of the patch.

Thanks,
Baskov Evgeniy
