Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9830BA75
	for <lists+linux-efi@lfdr.de>; Tue,  2 Feb 2021 09:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBBI65 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Feb 2021 03:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231560AbhBBI6z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Feb 2021 03:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612256248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Si/dI5lNziAyVoRmOt6q5oX+Pb8j9QNnXS8AF/vdi/A=;
        b=dVIFp5z8tr0KeRLyqtVybJnY5f5h2Q+KyL+32qDast8dz6+APFfuvrjCwnla2GlB43UnVj
        FFBNcFn85p8ewykURJ0NH5MELg61rza4nreiVHKaf45TGdAzygg0PTUcLdMeRAnmcTFhnu
        eYEbzt362QgMIov4mNEbzKauo/SPDX4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-bXrmTJqDMlq16ajsTIS79w-1; Tue, 02 Feb 2021 03:57:23 -0500
X-MC-Unique: bXrmTJqDMlq16ajsTIS79w-1
Received: by mail-wr1-f69.google.com with SMTP id o17so12197644wrv.4
        for <linux-efi@vger.kernel.org>; Tue, 02 Feb 2021 00:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Si/dI5lNziAyVoRmOt6q5oX+Pb8j9QNnXS8AF/vdi/A=;
        b=ILEbBpILRg4SanPrsEuFgew58m/oF/AuUJSqmd1tjBptkJMy+k0yWY+DAtuRHjYzYG
         d6jv5M/ItiKLwdwR2sON7HEljhnxw+UOWHz6qEKrzxWlC7teYGBqYZJhR2ZPZTxoYYI0
         hz1KdNBRg4xc+m8ek2u4qC9QUc47YolxnDmwMEz/luPQWH1Qi3+W4PKjyF1ae2n26JD+
         VfBcmoTVz9BD3++k3KrBzAj+fs+ulZsP/58QsVygjVvKP4NOVslT71pIdyJqnGJLm8l6
         Xc+B0+kO9h6yUglyjYLRg7WbHRRz7EjE/BDHjYA91B9iiyrLmbpP6N8N9JdGljikBzMT
         ijMA==
X-Gm-Message-State: AOAM532ezyTzrhNylS78mMzdYtzAppvIrbkfrk6Zu7XZTOhYQYRBrdHI
        uOV0pYvmcDtzcmhpKLR0wbgRIf6EENjDfIXFg2ByAygDfaglVGPCl1SHbH4eLdCdRlwiVMQIifM
        9L8gWgOle+R9+FW4eWjYr
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr22178827wrx.69.1612256242136;
        Tue, 02 Feb 2021 00:57:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgPkiIX+L54pamL9Mka7GlGAiN10QTM7Wb7cXKG91/ROpxarDwNpZ+XfHCi6Y0Xzv6dxYUrw==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr22178791wrx.69.1612256241890;
        Tue, 02 Feb 2021 00:57:21 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id i7sm2269412wmq.2.2021.02.02.00.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 00:57:21 -0800 (PST)
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
Date:   Tue, 2 Feb 2021 09:57:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/2/21 12:17 AM, Nick Desaulniers wrote:
> On Mon, Feb 1, 2021 at 1:44 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>
>> On Fri, Jan 29, 2021 at 10:10:01AM -0800, Nick Desaulniers wrote:
>>> On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>>
>>>> On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
>>>>>> From: Raphael Gault <raphael.gault@arm.com>
>>>>>>
>>>>>> This plugins comes into play before the final 2 RTL passes of GCC and
>>>>>> detects switch-tables that are to be outputed in the ELF and writes
>>>>>> information in an ".discard.switch_table_info" section which will be
>>>>>> used by objtool.
>>>>>>
>>>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>>>>>> [J.T.: Change section name to store switch table information,
>>>>>>         Make plugin Kconfig be selected rather than opt-in by user,
>>>>>>         Add a relocation in the switch_table_info that points to
>>>>>>         the jump operation itself]
>>>>>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>>>>>
>>>>> Rather than tightly couple this feature to a particular toolchain via
>>>>> plugin, it might be nice to consider what features could be spec'ed out
>>>>> for toolchains to implement (perhaps via a -f flag).
>>>>
>>>> The problem is being able to detect switch statement jump table vectors.
>>>>
>>>> For a given indirect branch (due to a switch statement), what are all
>>>> the corresponding jump targets?
>>>>
>>>> We would need the compiler to annotate that information somehow.
>>>
>>> Makes sense, the compiler should have this information.  How is this
>>> problem solved on x86?
>>
>> Thus far we've been able to successfully reverse engineer it on x86,
>> though it hasn't been easy.
>>
>> There were some particulars for arm64 which made doing so impossible.
>> (I don't remember the details.)

The main issue is that the tables for arm64 have more indirection than x86.

On x86, the dispatching jump instruction fetches the target address from 
a contiguous array of addresses based on a given offset. So the list of 
potential targets of the jump is neatly organized in a table (and sure, 
before link time these are just relocation, but still processable).

On arm64 (with GCC at least), what is stored in a table is an array of 
candidate offsets from the jump instruction. And because arm64 is 
limited to 32bit instructions, the encoding often requires multiple 
instructions to compute the target address:

ldr<*>  x_offset, [x_offsets_table, x_index, ...]  // load offset
adr     x_dest_base, <addr>          // load target branch for offset 0
add     x_dest, x_target_base, x_offset, ...  // compute final address
br      x_dest        // jump

Where this gets trickier is that (with GCC) the offsets stored in the 
table might or might not be signed constants (and this can be seen in 
GCC intermediate representations, but I do not believe this information 
is output in the final object file). And on top of that, GCC might 
decide to use offsets that are seen as unsigned during intermediate 
representation as signed offset by sign extending them in the add 
instruction.

So, to handle this we'd have to track the different operation done with 
the offset, from the load to the final jump, decoding the instructions
and deducing the potential target instructions from the table of offsets.

But that is error prone as we don't really know how many instructions 
can be between the ones doing the address computation, and I remember 
some messy case of a jump table inside a jump table where tracking the 
instruction touching one or the other offset would need a lot of corner 
case handling.

And this of course is just for GCC, I haven't looked at what it all 
looks like on Clang's end.


> 
> I think the details are pertinent to finding a portable solution.  The
> commit message of this commit in particular doesn't document such
> details, such as why such an approach is necessary or how the data is
> laid out for objtool to consume it.
> 

Sorry, I will need to make that clearer. The next patch explains it a 
bit [1]

Basically, for simplicity, the plugin creates a new section containing 
tables (one per jump table) of references to the jump targets, similar 
to what x86 has, except that in this case this table isn't actually used 
by runtime code and is discarded at link time. I only chose this to 
minimize what needed to be changed in objtool and because the format 
seemed simple enough.

But I'm open on some alternative, whether it's a -fjump-table-info 
option added to compilers with a different format to do the links. The 
important requirement is to be able to know all the candidate targets 
for a "br <reg>" instruction.

[1] https://lkml.org/lkml/2021/1/20/910

Thanks,

-- 
Julien Thierry

