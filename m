Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A02FEBC7
	for <lists+linux-efi@lfdr.de>; Thu, 21 Jan 2021 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbhAUN1h (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Jan 2021 08:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732198AbhAUNZZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Jan 2021 08:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611235438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvCR/SJT7x/0z+1fK/OgzO3ZsWGWZSRqQrMopnsNWp8=;
        b=T+7BZodwH+s5uNb6IgziWkF2rTEj8/CI9DjoNaI8nvlQ9Nqzi24xA3yXBm7B/1iPEq3KMz
        pojsXC6+BragRoFK4CJ75+2VQ9Ji6fo5iw8VFLrgi26OezYha8pS2imRgMqtQpOVokI8L8
        4kkz/8bbL1/gt8kJRUJaxIiYlf34Xnk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-J9WuCmi8P26ZE2Gb7qeXEQ-1; Thu, 21 Jan 2021 08:23:56 -0500
X-MC-Unique: J9WuCmi8P26ZE2Gb7qeXEQ-1
Received: by mail-wr1-f69.google.com with SMTP id g17so1008491wrr.11
        for <linux-efi@vger.kernel.org>; Thu, 21 Jan 2021 05:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvCR/SJT7x/0z+1fK/OgzO3ZsWGWZSRqQrMopnsNWp8=;
        b=d6eD15arXQKFR4ufMD/qvKRoeYVcaM3y205TUwOUCExWNwKDkOwQGZVX6xKMgdspwA
         gX7jA87YYbdH8gY+07wZj4edQPMuIpiRlvFOm6OW3+za9pmvD5X+y9yFQC4zt4g7fI5P
         xDi/wv0OZdruQ0Y0ba9jf+ZOrcWgYQrWRegC+p0L+ujvs+UIhyNJltMLcJPWj/4LuHLS
         eBP2/VxA7K7pzxTeXg+gIwcLH77JapH07lAZZRq0fcpM6tm6tg1K1fGO6db9QhRgKtQy
         Rw/0FgNPKhBp3HBybVoxjVPvj50TYmUX9o+qkNDM/228DT8nSIqUPjwIpYvvLkzflNtI
         aSXQ==
X-Gm-Message-State: AOAM5319yuk9PuaueLmBr+Zu6niiV7VSwrHPYUlQx75WsVDPkndTc3d6
        kKg3g1T0LHz37tXVbxuPsXDcGHjL9ByKNG/Lb49cyWU5uXJwJakvbKnfSCwRHk/hBfv7uvW3Y7t
        lY8HN5bXEmYzGF7S3nNTJ
X-Received: by 2002:adf:c18d:: with SMTP id x13mr14020222wre.128.1611235435256;
        Thu, 21 Jan 2021 05:23:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+HMrNE/GzNA0eRvoWZynPl2cm00oo1pYl3yrQV7e/rEXRQYgFCSqJngzxT5WNmFeOF92XUQ==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr14020198wre.128.1611235435102;
        Thu, 21 Jan 2021 05:23:55 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d30sm9999764wrc.92.2021.01.21.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 05:23:54 -0800 (PST)
Subject: Re: [RFC PATCH 00/17] objtool: add base support for arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20210120173800.1660730-1-jthierry@redhat.com>
 <CAMj1kXHO0wgcZ4ZDxj1vS9s7Szfpz8Nz=SAW_=Dnnjy+S9AtyQ@mail.gmail.com>
 <186bb660-6e70-6bbf-4e96-1894799c79ce@redhat.com>
 <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <6e21cd51-017e-2135-ed9d-33a60f22a457@redhat.com>
Date:   Thu, 21 Jan 2021 14:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHznGnN2UEai1c2UgyKuTFCS5SZ+qGR6VJwyCuccViw_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 1/21/21 12:08 PM, Ard Biesheuvel wrote:
> On Thu, 21 Jan 2021 at 11:26, Julien Thierry <jthierry@redhat.com> wrote:
>>
>> Hi Ard,
>>
>> On 1/21/21 10:03 AM, Ard Biesheuvel wrote:
>>> Hello Julien,
>>>
>>> On Wed, 20 Jan 2021 at 18:38, Julien Thierry <jthierry@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> This series enables objtool to start doing stack validation on arm64
>>>> kernel builds.
>>>
>>> Could we elaborate on this point, please? 'Stack validation' means
>>> getting an accurate picture of all kernel code that will be executed
>>> at some point in the future, due to the fact that there are stack
>>> frames pointing to them. And this ability is essential in order to do
>>> live patching safely?
>>>
>>> If this is the goal, I wonder whether this is the right approach for
>>> arm64 (or for any other architecture, for that matter)
>>>
>>> Parsing/decoding the object code and even worse, relying on GCC
>>> plugins to annotate some of the idioms as they are being generated, in
>>> order to infer intent on the part of the compiler goes *way* beyond
>>> what we should be comfortable with. The whole point of this exercise
>>> is to guarantee that there are no false positives when it comes to
>>> deciding whether the kernel is in a live patchable state, and I don't
>>> see how we can ever provide such a guarantee when it is built on such
>>> a fragile foundation.
>>>
>>> If we want to ensure that the stack contents are always an accurate
>>> reflection of the real call stack, we should work with the toolchain
>>> folks to identify issues that may interfere with this, and implement
>>> controls over these behaviors that we can decide to use in the build.
>>> In the past, I have already proposed adding a 'kernel' code model to
>>> the AArch64 compiler that guarantees certain things, such as adrp/add
>>> for symbol references, and no GOT indirections for position
>>> independent code. Inhibiting optimizations that may impact our ability
>>> to infer the real call stack from the stack contents is something we
>>> might add here as well.
>>>
>>
>> I'm not familiar with toolcahin code models, but would this approach be
>> able to validate assembly code (either inline or in assembly files?)
>>
> 
> No, it would not. But those files are part of the code base, and can
> be reviewed and audited.
> 

That means that every actor maintaining their own stable version of the 
kernel have to do their own audit when they do backports (assuming the 
audit would be done for upstream) to be able to provide a safe 
livepatching feature in their kernel.

>>> Another thing that occurred to me is that inferring which kernel code
>>> is actually live in terms of pending function returns could be
>>> inferred much more easily from a shadow call stack, which is a thing
>>> we already implement for Clang builds.
>>>
>>
>> I was not familiar with the shadow call stack. If I understand correctly
>> that would be a stack of return addresses of function currently on the
>> call stack, is that correct?
>>
>> That would indeed be a simpler approach, however I guess the
>> instrumentation has a cost. Is the instrumentation also available with
>> GCC? And is this instrumentation efficient enough to be suitable for
>> production builds?
>>
> 
> I am not aware of any plans to enable this in GCC, but the Clang
> implementation is definitely intended for production use (it's a CFI
> feature for ROP/JOP mitigation)
> 

I think most people interested in livepatching are using GCC built 
kernels, but I could be mistaken (althought in the long run, both 
compilers should be supported, and yes, I realize the objtool solution 
currently only would support GCC).

I don't know how feasible it will be to get it into GCC if people decide 
to go with that. Also, now that I think about it, it will probably come 
with similar limitations as stackframes where the unwinder would need to 
know when/where the shadow call stack is unavailable for some reason and 
the stack trace is not reliable. (it might be a bit simpler to audit 
than stack frame setting and maybe have less limitations, but I guess 
there will still be cases where we can't rely on it)

-- 
Julien Thierry

