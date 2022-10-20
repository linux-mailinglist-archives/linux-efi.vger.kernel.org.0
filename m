Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AF606193
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 15:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJTN0A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiJTNZ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 09:25:57 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59E12E0CF;
        Thu, 20 Oct 2022 06:25:53 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 34092419E9D1;
        Thu, 20 Oct 2022 13:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 34092419E9D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666272351;
        bh=GYMsH9Ebnzm8SQXW7t4gkTpMsom8GVugJZf/83SavjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4pusa818gjPOeCIBizSl2dpha4ZAejZRM/j2KGgrOL928umWHsxYUBhoXN8oCU7b
         mi5S/8q5L/GeYCtz8JmGORRslfFBIRCcESgWneZb1fHTWrnDB785iUvicIaG2saGZZ
         xtB9KM3V7w5SORbpCnGm9Ahzi7ZqheoIaSptjNnA=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 16:25:51 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/16] x86/boot: Set cr0 to known state in trampoline
In-Reply-To: <7dce2b16-c652-8b6d-5594-d110c8ac4645@citrix.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
 <7dce2b16-c652-8b6d-5594-d110c8ac4645@citrix.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e217cff7752088baca2485f691e62d72@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-10-19 10:44, Andrew Cooper wrote:
> On 06/09/2022 11:41, Evgeniy Baskov wrote:
>> diff --git a/arch/x86/boot/compressed/head_64.S 
>> b/arch/x86/boot/compressed/head_64.S
>> index d33f060900d2..5273367283b7 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -619,9 +619,8 @@ SYM_CODE_START(trampoline_32bit_src)
>>  	/* Set up new stack */
>>  	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
>> 
>> -	/* Disable paging */
>> -	movl	%cr0, %eax
>> -	btrl	$X86_CR0_PG_BIT, %eax
>> +	/* Disable paging and setup CR0 */
>> +	movl	$(CR0_STATE & ~X86_CR0_PG), %eax
> 
> Why here?  WP is ignored when PG is disabled.
> 
> ~Andrew

PG is enabled lower in this function, so WP can also be set there,
it should not make any difference. The only important thing is that
WP supposed to be set in trampoline code.

If you think, that it would be more logical to set PG and WP
simultaneously, I can change it to be that way.

Thanks,
Evgeniy Baskov
