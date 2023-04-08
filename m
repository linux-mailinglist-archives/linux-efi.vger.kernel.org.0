Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814E6DBBBD
	for <lists+linux-efi@lfdr.de>; Sat,  8 Apr 2023 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDHPJO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 8 Apr 2023 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHPJN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 8 Apr 2023 11:09:13 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B263581;
        Sat,  8 Apr 2023 08:09:12 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A23EF44C1018;
        Sat,  8 Apr 2023 15:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A23EF44C1018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1680966550;
        bh=GGK8J8ROSB8RdorZJID1wyP7viogzq8rSNKxlSR5gEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkW7h3uFhxQENtEMvCwovNUZ1V5vIFL8XJpjCB48UfQQGAejq4BVt/MLhg63AQv1Y
         OGvcwUsx4UxnIaB2MLHzeZsqzpE7WesfbUSqVKMuqmEhn7ivRlPVrxeecwAKFmBZy8
         iUMLvkw+Ip6OHkVgxitYXHED+eupzRK3q7iaJWjQ=
MIME-Version: 1.0
Date:   Sat, 08 Apr 2023 18:09:10 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 03/27] x86/boot: Set cr0 to known state in trampoline
In-Reply-To: <20230405175441.GFZC214WxyhULbtl3P@fat_crate.local>
References: <cover.1678785672.git.baskov@ispras.ru>
 <63368ff665956a64f07aee9bc863b70c86b8b0c8.1678785672.git.baskov@ispras.ru>
 <20230405175441.GFZC214WxyhULbtl3P@fat_crate.local>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6910b36b28213b4b47bd3173d7be47f3@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-04-05 20:54, Borislav Petkov wrote:
> On Tue, Mar 14, 2023 at 01:13:30PM +0300, Evgeniy Baskov wrote:
>> Ensure WP bit to be set to prevent boot code from writing to
>> non-writable memory pages.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/head_64.S | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/head_64.S 
>> b/arch/x86/boot/compressed/head_64.S
>> index 03c4328a88cb..01fa42d31648 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -660,9 +660,8 @@ SYM_CODE_START(trampoline_32bit_src)
>>  	pushl	$__KERNEL_CS
>>  	pushl	%eax
>> 
>> -	/* Enable paging again. */
>> -	movl	%cr0, %eax
>> -	btsl	$X86_CR0_PG_BIT, %eax
>> +	/* Enable paging and set CR0 to known state (this also sets WP flag) 
>> */
>> +	movl	$CR0_STATE, %eax
> 
> This sets a lot more than WP. Why?

Because there are code paths where cr0 state is not initialized
(e.g. the EFISTUB code path) and it's better to know it exactly.
Although we don't actually care about MP, ET, NE and AM flags, but they
should be all supported, so the choice was arbitrary. Also they are 
already
initialized to this value on one code path -- when the kernel started 
its
execution via startup_32.

Thanks.
