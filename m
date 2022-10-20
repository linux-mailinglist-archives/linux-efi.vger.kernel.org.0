Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58044605E83
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJTLNI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJTLNH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 07:13:07 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A141E0451;
        Thu, 20 Oct 2022 04:13:06 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id B1913419E9C7;
        Thu, 20 Oct 2022 11:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B1913419E9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666264384;
        bh=Vzl/zXUMMGbEKj/S8AF15wH6J143avkWXBRh1JpAXNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ttG/TNbPNg+eoZL3NzW76ndIeZcOn0XU6KbIdikucrd+nJs2ItqOTPEQ+C7uydvO7
         lUCJ46wuMEcWoa0K3Re2N58amW3tSiXT8gRCkybit0LLwmeFnQlPT+mW1KEIzKFJvQ
         XoIuY50aJ/WBzrstbJL+FczBaPCtHCowbklADM90=
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 14:13:04 +0300
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
Subject: Re: [PATCH 01/16] x86/boot: Align vmlinuz sections on page size
In-Reply-To: <CAMj1kXGUvUwy__wD-DtHtpVMoCJsc=G2mvWLe2a7ib2ckqzpow@mail.gmail.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <27a078f43742063cc30e706b196fb5fff5d5c37e.1662459668.git.baskov@ispras.ru>
 <CAMj1kXGUvUwy__wD-DtHtpVMoCJsc=G2mvWLe2a7ib2ckqzpow@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <be5a5bc936ca62fa0e25781375c8c2ed@ispras.ru>
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

On 2022-10-19 10:01, Ard Biesheuvel wrote:
> On Tue, 6 Sept 2022 at 12:41, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> To protect sections on page table level each section
>> needs to be aligned on page size (4KB).
>> 
>> Set sections alignment in linker script.
>> 
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/vmlinux.lds.S | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S 
>> b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 112b2375d021..6be90f1a1198 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -27,21 +27,27 @@ SECTIONS
>>                 HEAD_TEXT
>>                 _ehead = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .rodata..compressed : {
>> +               _compressed = .;
> 
> Why are you adding these?

It is used for address compressed kernel blob during memory protection 
setup.
Although it can be addressed via different symbols, I though that 
addressing
sections data in a common way (through linker generated symbols) would 
be better.
I can remove or mention the change in commit message (for now I will do 
the latter).

> 
>>                 *(.rodata..compressed)
>> +               _ecompressed = .;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
> 
> On other EFI architectures, we only distinguish between R-X and RW-
> regions, and alignment between .rodata and .text is unnecessary. Do we
> really need to deviate from that here?

I though that leaving a huge compressed kernel blob executable is
undesirable, so I decided to split it out. I can make it either RW- or 
R-X
if it would be more acceptable.

> 
> 
>>         .text : {
>>                 _text = .;      /* Text */
>>                 *(.text)
>>                 *(.text.*)
>>                 _etext = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .rodata : {
>>                 _rodata = . ;
>>                 *(.rodata)       /* read-only data */
>>                 *(.rodata.*)
>>                 _erodata = . ;
>>         }
>> +       . = ALIGN(PAGE_SIZE);
>>         .data : {
>>                 _data = . ;
>>                 *(.data)
>> --
>> 2.35.1
>> 
