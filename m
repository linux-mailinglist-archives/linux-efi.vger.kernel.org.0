Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9644730D4C3
	for <lists+linux-efi@lfdr.de>; Wed,  3 Feb 2021 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhBCIMr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Feb 2021 03:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232613AbhBCIMg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Feb 2021 03:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612339868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Huq6tfU+kDDL1exMPNWAbCb858jufvEInD0eW8A0Yo=;
        b=NkmcRBUkYOiGyPedvI+AtyBd/g0EFGcmzPWtR5OJEkV+lveICKy0U7hQnvhteKiH1JKJNi
        6Ct2buAe1662FRJ4BoQ4DUGlWbf/JaCBgB56rL+CXliKrdg0JjFN4WrlCIF7ETLmLhpZ1o
        LWCa2wyMLkd+SS1nvk4pexpIedmAc3I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-BIB30dqtPxGVTfFUr1VTDw-1; Wed, 03 Feb 2021 03:11:06 -0500
X-MC-Unique: BIB30dqtPxGVTfFUr1VTDw-1
Received: by mail-wr1-f69.google.com with SMTP id h18so14044834wrr.5
        for <linux-efi@vger.kernel.org>; Wed, 03 Feb 2021 00:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Huq6tfU+kDDL1exMPNWAbCb858jufvEInD0eW8A0Yo=;
        b=Sz8WKh5QJ9JmhutQy1wto1QZJqFBGSPZs5hTNAnAW52wuaCPXFGLbFftDkFW7QRaIj
         vQ+xsQSbgip7iuL5ilgWHtrLqfM+s0VFd3PbxKgPm6/RE6xj+vERBL4wGFbCOhrOxfRO
         tBqFHeikxJZDQfoAKbwkc6Yk2uW9c9yFQ/xaZq3Ekc/D5+WPnGaV7erlaNZEj/8zRqpc
         zr7LNUGUww1+gfBr61IhnJqcvjqhJnHKdJeCHspdf/7zX/6Z2qnjxEtdw5917sbmNBGR
         WYRcqNYLH9hjxCO8DCV1hL8eU6Szm24fnSr1Ien9XBrdGtEAgpQaH+9Q5j7x4Wj3/5Ek
         tLBw==
X-Gm-Message-State: AOAM530wFkGP+YuDfp6+NPc/F1sXhEH7GSKYTNZ1jozVS1cxY+mObwQK
        HlZSBtKLCjDhj967SyWV3X9KqaSg9yhz7NxVz5Q9NHAUX41kl7x8y2+AS0RyFwZFX7MJiG5WdUw
        S3NeG82nAywEkmHmkWBkq
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr1572560wmg.108.1612339865390;
        Wed, 03 Feb 2021 00:11:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyor899BoErX+lNV6jwHugO2N82UM+DD4bmFtKm617J/dNiWTcXQvxuZH381L0jowogxpvzow==
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr1572547wmg.108.1612339865171;
        Wed, 03 Feb 2021 00:11:05 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y63sm1590188wmd.21.2021.02.03.00.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:11:04 -0800 (PST)
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
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
        Bill Wendling <morbo@google.com>, swine@google.com,
        yonghyun@google.com
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <e3db542d-c1ff-ffea-60c0-f8dcc0dfb054@redhat.com>
Date:   Wed, 3 Feb 2021 09:11:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/3/21 12:01 AM, Nick Desaulniers wrote:
> On Tue, Feb 2, 2021 at 12:57 AM Julien Thierry <jthierry@redhat.com> wrote:
>>
>>
>>
>> On 2/2/21 12:17 AM, Nick Desaulniers wrote:
>>> On Mon, Feb 1, 2021 at 1:44 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>>
>>>> On Fri, Jan 29, 2021 at 10:10:01AM -0800, Nick Desaulniers wrote:
>>>>> On Wed, Jan 27, 2021 at 3:27 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>>>>
>>>>>> On Wed, Jan 27, 2021 at 02:15:57PM -0800, Nick Desaulniers wrote:
>>>>>>>> From: Raphael Gault <raphael.gault@arm.com>
>>>>>>>>
>>>>>>>> This plugins comes into play before the final 2 RTL passes of GCC and
>>>>>>>> detects switch-tables that are to be outputed in the ELF and writes
>>>>>>>> information in an ".discard.switch_table_info" section which will be
>>>>>>>> used by objtool.
>>>>>>>>
>>>>>>>> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
>>>>>>>> [J.T.: Change section name to store switch table information,
>>>>>>>>          Make plugin Kconfig be selected rather than opt-in by user,
>>>>>>>>          Add a relocation in the switch_table_info that points to
>>>>>>>>          the jump operation itself]
>>>>>>>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>>>>>>>
>>>>>>> Rather than tightly couple this feature to a particular toolchain via
>>>>>>> plugin, it might be nice to consider what features could be spec'ed out
>>>>>>> for toolchains to implement (perhaps via a -f flag).
>>>>>>
>>>>>> The problem is being able to detect switch statement jump table vectors.
>>>>>>
>>>>>> For a given indirect branch (due to a switch statement), what are all
>>>>>> the corresponding jump targets?
>>>>>>
>>>>>> We would need the compiler to annotate that information somehow.
>>>>>
>>>>> Makes sense, the compiler should have this information.  How is this
>>>>> problem solved on x86?
>>>>
>>>> Thus far we've been able to successfully reverse engineer it on x86,
>>>> though it hasn't been easy.
>>>>
>>>> There were some particulars for arm64 which made doing so impossible.
>>>> (I don't remember the details.)
>>
>> The main issue is that the tables for arm64 have more indirection than x86.
> 
> I wonder if PAC or BTI also make this slightly more complex?  PAC at
> least has implications for unwinders, IIUC.
> 
>>
>> On x86, the dispatching jump instruction fetches the target address from
>> a contiguous array of addresses based on a given offset. So the list of
>> potential targets of the jump is neatly organized in a table (and sure,
>> before link time these are just relocation, but still processable).
>>
>> On arm64 (with GCC at least), what is stored in a table is an array of
>> candidate offsets from the jump instruction. And because arm64 is
>> limited to 32bit instructions, the encoding often requires multiple
>> instructions to compute the target address:
>>
>> ldr<*>  x_offset, [x_offsets_table, x_index, ...]  // load offset
>> adr     x_dest_base, <addr>          // load target branch for offset 0
>> add     x_dest, x_target_base, x_offset, ...  // compute final address
>> br      x_dest        // jump
>>
>> Where this gets trickier is that (with GCC) the offsets stored in the
>> table might or might not be signed constants (and this can be seen in
>> GCC intermediate representations, but I do not believe this information
>> is output in the final object file). And on top of that, GCC might
>> decide to use offsets that are seen as unsigned during intermediate
>> representation as signed offset by sign extending them in the add
>> instruction.
>>
>> So, to handle this we'd have to track the different operation done with
>> the offset, from the load to the final jump, decoding the instructions
>> and deducing the potential target instructions from the table of offsets.
>>
>> But that is error prone as we don't really know how many instructions
>> can be between the ones doing the address computation, and I remember
>> some messy case of a jump table inside a jump table where tracking the
>> instruction touching one or the other offset would need a lot of corner
>> case handling.
>>
>> And this of course is just for GCC, I haven't looked at what it all
>> looks like on Clang's end.
> 
> Sure, but this is what production unwinders do, and they don't require
> compiler plugins, right?  I don't doubt unwinders can be made simpler
> with changes to toolchain output; please work with your compiler
> vendor on making such changes rather than relying on compiler plugins
> to do so.
> 

I think there is a small confusion. The plugin nor the data it generates 
is not to be used by a kernel unwinder. It's here to allow objtool to 
assess whether the code being checked can be unwound (?) reliably (not 
omitting functions). Part of this is checking that a branch/jump in a 
function does not end up in some code that is not related to the 
function without setting up a call frame.

This is about static validation rather than functionality.

>>> I think the details are pertinent to finding a portable solution.  The
>>> commit message of this commit in particular doesn't document such
>>> details, such as why such an approach is necessary or how the data is
>>> laid out for objtool to consume it.
>>>
>>
>> Sorry, I will need to make that clearer. The next patch explains it a
>> bit [1]
>>
>> Basically, for simplicity, the plugin creates a new section containing
> 
> Right, this takes a focus on simplicity, at the cost of alienating a toolchain.
> 
> Ard's point about 3193c0836f20 relating to -fgcse is that when
> presented with tricky cases to unwind, the simplest approach is taken.
> There it was disabling a compiler specific compiler optimization, here
> it's either a compiler specific compiler plugin (or disabling another
> compiler optimization).  The pattern seems to be "Objtool isn't smart
> enough" ... "compiler optimization disabled" or "compiler plugin
> dependency."
> 
>> tables (one per jump table) of references to the jump targets, similar
>> to what x86 has, except that in this case this table isn't actually used
>> by runtime code and is discarded at link time. I only chose this to
>> minimize what needed to be changed in objtool and because the format
>> seemed simple enough.
>>
>> But I'm open on some alternative, whether it's a -fjump-table-info
> 
> Yes, I think we could spec out something like that.  But I would
> appreciate revisiting open questions around stack validation (frame
> pointers), preventing the generation of jump tables to begin with
> (-fno-jump-tables) in place of making objtool more robust, or
> generally the need to depend on compiler plugins.
> 

I'll give it a try at least for the arm64 side.

Thanks,

-- 
Julien Thierry

