Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB19564BF34
	for <lists+linux-efi@lfdr.de>; Tue, 13 Dec 2022 23:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLMWQV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Dec 2022 17:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLMWQU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Dec 2022 17:16:20 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086F261E;
        Tue, 13 Dec 2022 14:16:19 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3DA93419E9E1;
        Tue, 13 Dec 2022 22:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3DA93419E9E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1670969773;
        bh=VHdI9Xh1NeCJLb26KKJ6iPHrz7yjmrTEO99iPDQ8hOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnxsAh0bWjBhi8jpakZlMTltzOdtMY8Hl7y+QB5nDB7Wy3p2vddA/8zfqAuPeGnwC
         hm5z/9G8k3w8+6vs9bkz5ej8HTm0j9TtIWT97YSArkyf7bDjXuOUFSPwLRYqF8EgFF
         7BM9jXbNdmCPKFKU5BWgEKV3FdSP6X655J9mR6jc=
MIME-Version: 1.0
Date:   Wed, 14 Dec 2022 01:16:13 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Peter Jones <pjones@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 00/24] x86_64: Improvements at compressed kernel stage
In-Reply-To: <20221213181336.fjyxagxkjtq3jchl@redhat.com>
References: <cover.1668958803.git.baskov@ispras.ru>
 <20221213180317.qoy2l3mcpjparocq@redhat.com>
 <20221213181336.fjyxagxkjtq3jchl@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e28ce5943937225517d460dabda6f8e5@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-12-13 21:13, Peter Jones wrote:
> On Tue, Dec 13, 2022 at 01:03:17PM -0500, Peter Jones wrote:
>> On Tue, Nov 22, 2022 at 02:12:09PM +0300, Evgeniy Baskov wrote:
>> > This patchset is aimed
>> > * to improve UEFI compatibility of compressed kernel code for x86_64
>> > * to setup proper memory access attributes for code and rodata sections
>> > * to implement W^X protection policy throughout the whole execution
>> >   of compressed kernel for EFISTUB code path.
>> 
>> Hi Evgeniy,
>> 
>> I've tested this patch set on hardware and QEMU+MU firmware, and it
>> works for me with a couple of minor issues:
>> 
>> - on one machine that has the DXE protocol but not the EFI one, we get
>>   an error because the firmware doesn't support EFI_MEMORY_RP
>> - on QEMU I'm seeing the size of "(unsigned long)_head - image_base"
>>   wind up as 0, which leads to an EFI_INVALID_PARAMETER on the
>>   clear_memory_attributes() call.
>> 
>> In both cases the system winds up working, but with unnecessary 
>> console
>> output.
> 
> I just realized I've overstated here - I haven't actually hit the first
> problem on x86, only on ARM, where we don't currently use this code.  I
> discovered it in grub, and checked your patch set to see if you had the
> same issue I did.  That said, "in both cases the system winds up
> working" is probably still true - in that the edk2 code supports
> EFI_MEMORY_RP on x86 but not ARM, so x86 won't hit the issue when using
> DXE unless someone cooks up another implementation.  Nevertheless I
> believe the patch to fix it is correct and should be applied.
> 
> Thanks!

Hi,

Thank you for testing and fixes!

I have also discovered one issue with v3, that can only be hit when
booting with grub -- there's one kernel_add_identity_map() missing in
the get_acpi_srat_table() function, before header->length is read.
So I'll prepare the v4 soon and include your new patches there.

Thanks,
Evgeniy Baskov
