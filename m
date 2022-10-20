Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A5605EC3
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJTLXV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiJTLXT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 07:23:19 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1647C5096;
        Thu, 20 Oct 2022 04:23:18 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id CD5F2419E9C7;
        Thu, 20 Oct 2022 11:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CD5F2419E9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666264996;
        bh=JSJsZe6/71Z81WHPKaHYPDomkrzHejx2StTWNfL7FaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CO7qefBXOON0y0sUSW5zZ/L19hjPwUJewa5YGxft6oZGUHTBHrykxzgid6P6A1/0s
         NtgOqwGtrOZIzjPxvyBW5HpfwL7R6yblFNAVkDbSBTiNOBOmggH+5fu7zE3l4CTCVJ
         nZJI0mtNwSAX2tR/gMcpurkz/az+2WHZI9DazG2w=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 14:23:16 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/16] x86/boot: Set cr0 to known state in trampoline
In-Reply-To: <CAMj1kXHUiBO0d926eWTtWZp_hvwHsVLzzn+fdS1EYoXHxpH+iA@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
 <CAMj1kXHUiBO0d926eWTtWZp_hvwHsVLzzn+fdS1EYoXHxpH+iA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3591ec1f2195095effd08e11fe45986b@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-10-19 10:06, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Ensure WP bit to be set to prevent boot code from writing to
>> non-writable memory pages.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/head_64.S | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/head_64.S 
>> b/arch/x86/boot/compressed/head_64.S
>> index d33f060900d2..5273367283b7 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -619,9 +619,8 @@ SYM_CODE_START(trampoline_32bit_src)
>>         /* Set up new stack */
>>         leal    TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
>> 
>> -       /* Disable paging */
>> -       movl    %cr0, %eax
>> -       btrl    $X86_CR0_PG_BIT, %eax
> 
> Why do we no longer care about CR0's prior value?

I think we don't need to preserve any of those flags
(we nether use floating point instructions nor call EFI functions
with this cr0 value) and it's better to set cr0 to the well-known
state. CR0 is also being set to the constant value while switching
from protected to long mode, so it is already done in one of the
code paths.

If I am missing something, let me know,
I will change it to only set WP and clear PG.

> 
>> +       /* Disable paging and setup CR0 */
>> +       movl    $(CR0_STATE & ~X86_CR0_PG), %eax
>>         movl    %eax, %cr0
>> 
>>         /* Check what paging mode we want to be in after the 
>> trampoline */
>> --
>> 2.35.1
>> 
