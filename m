Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90AB447DC
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfFMRCd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 13:02:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfFLXEd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jun 2019 19:04:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so10515909pfy.13
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2019 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0sXEuoXXfB+58oAqB27nyxVJnIR0qxmqN3amvLO4MUI=;
        b=kMu+BVJa981hAatIgUu4yrYi7Q8PVRZO3FdVXL/KM/vtg9zSDoY6QaoYVsgwARCtsB
         8wMNnJZZEbmSLCmDQCZCYinzc3oFyRXDR4yjqyajTfxcaq5mYNvy6US7H9FOyI1ujcE6
         mkifXT6gFQ7lLMNCAiWTrrsyS6n/+tpWDLK+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0sXEuoXXfB+58oAqB27nyxVJnIR0qxmqN3amvLO4MUI=;
        b=bHicq/AebTNU3CtQ+VrOVCxduTMWnzoAkNORZW0asCnwjWuC5a8622xKypEarKjoQZ
         Tt+pewqzAKmdwhYDEmlzHkvpEMk5m6e3YTTTUIhukfY4HXmXbN6u3KgqmRhSInGF8QQx
         F7/9lBBoAlSaTwLUtg1rmBX5ZbDiZNrw9fSIpavsNhoyFO/W7gmyBooMxbf9iFCzN63L
         Jg3kWoYqkrlEA1fhj1tgZdhei2GhdrXJbH/15poSJkwJNTZ8KnkAo0HAO9X1AakjBvTs
         3YRAdY06jo6c+QPvhagDLEQlBzqA+/wP5a9h6aItT/BMLcEE9zflXHgoDy2M7QEG+xKt
         1fGQ==
X-Gm-Message-State: APjAAAWVvCiLRiwKN71MBPT7CPsk1m9N/F0j4RL80mAlFD4zCid6MmhZ
        KynvLVduQvPYRKoED8TinnKXQIuAwOU=
X-Google-Smtp-Source: APXvYqx+XWoFTjG9dZbuolj86wqQOT4Iqef0H+9nNIH/wMPWesoTcaGtVUCDotl0QJH7LYE+KensLw==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr26896771pgi.28.1560380672280;
        Wed, 12 Jun 2019 16:04:32 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id g9sm463989pgs.78.2019.06.12.16.04.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:04:31 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/powernv: Add OPAL API interface to get secureboot state
In-Reply-To: <eaa37bd0-a77d-d70a-feb5-c0e73ce231bf@linux.vnet.ibm.com>
References: <1560198837-18857-1-git-send-email-nayna@linux.ibm.com> <1560198837-18857-2-git-send-email-nayna@linux.ibm.com> <87ftofpbth.fsf@dja-thinkpad.axtens.net> <eaa37bd0-a77d-d70a-feb5-c0e73ce231bf@linux.vnet.ibm.com>
Date:   Thu, 13 Jun 2019 09:04:26 +1000
Message-ID: <87d0jipfr9.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Nayna,

>>> Since OPAL can support different types of backend which can vary in the
>>> variable interpretation, a new OPAL API call named OPAL_SECVAR_BACKEND, is
>>> added to retrieve the supported backend version. This helps the consumer
>>> to know how to interpret the variable.
>>>
>> (Firstly, apologies that I haven't got around to asking about this yet!)
>>
>> Are pluggable/versioned backend a good idea?
>>
>> There are a few things that worry me about the idea:
>>
>>   - It adds complexity in crypto (or crypto-adjacent) code, and that
>>     increases the likelihood that we'll accidentally add a bug with bad
>>     consequences.
>
> Sorry, I think I am not clear on what exactly you mean here.Can you 
> please elaborate or give specifics ?

Cryptosystems with greater flexibility can have new kinds of
vulnerabilities arise from the greater complexity. The first sort of
thing that comes to mind is a downgrade attack like from TLS. I think
you're protected from this because the mode cannot be negotiatied at run
time, but in general it's security sensitive code so I'd like it to be
as simple as possible.

>>   - If we are worried about a long-term-future change to how secure-boot
>>     works, would it be better to just add more get/set calls to opal at
>>     the point at which we actually implement the new system?
>
> The intention is to avoid to re-implement the key/value interface for 
> each scheme. Do you mean to deprecate the old APIs and add new APIs with 
> every scheme ?

Yes, because I expect the scheme would change very, very rarely.

>>   - Under what circumstances would would we change the kernel-visible
>>     behaviour of skiboot? Are we expecting to change the behaviour,
>>     content or names of the variables in future? Otherwise the only
>>     relevant change I can think of is a change to hardware platforms, and
>>     I'm not sure how a change in hardware would lead to change in
>>     behaviour in the kernel. Wouldn't Skiboot hide h/w differences?
>
> Backends are intended to be an agreement for firmware, kernel and 
> userspace on what the format of variables are, what variables should be 
> expected, how they should be signed, etc. Though we don't expect it to 
> happen very often, we want to anticipate possible changes in the 
> firmware which may affect the kernel such as new features, support of 
> new authentication mechanisms, addition of new variables. Corresponding 
> skiboot patches are on - 
> https://lists.ozlabs.org/pipermail/skiboot/2019-June/014641.html

I still feel like this is holding onto ongoing complexity for very
little gain, but perhaps this is because I can't picture a specific
change that would actually require a wholesale change to the scheme.

You mention new features, support for new authentication mechanisms, and
addition of new variables.

 - New features is a bit too generic to answer specifically. In general
   I accept that there exists some new feature that would be
   sufficiently backwards-incompatible as to require a new version. I
   just can't think of one off the top of my head and so I'm not
   convinced it's worth the complexity. Did you have something in mind?

 - By support for new authentication mechanisms, I assume you mean new
   mechanisms for authenticating variable updates? This is communicated
   in edk2 via the attributes field. Looking at patch 5 from the skiboot
   series:

+ * When the attribute EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS is set,
+ * then the Data buffer shall begin with an instance of a complete (and
+ * serialized) EFI_VARIABLE_AUTHENTICATION_2 descriptor.

   Could a new authentication scheme be communicated by setting a
   different attribute value? Or are we not carrying attributes in the
   metadata blob?

 - For addition of new variables, I'm confused as to why this would
   require a new API - wouldn't it just be exposed in the normal way via
   opal_secvar_get(_next)?

I guess I also somewhat object to calling it a 'backend' if we're using
it as a version scheme. I think the skiboot storage backends are true
backends - they provide different implementations of the same
functionality with the same API, but this seems like you're using it to
indicate different functionality. It seems like we're using it as if it
were called OPAL_SECVAR_VERSION.

>>   - What is the correct fallback behaviour if a kernel receives a result
>>     that it does not expect? If a kernel expecting BackendV1 is instead
>>     informed that it is running on BackendV2, then the cannot access the
>>     secure variable at all, so it cannot load keys that are potentially
>>     required to successfully boot (e.g. to validate the module for
>>     network card or graphics!)
>
> The backend is declaredby the firmware, and is set at compile-time. The 
> kernel queriesfirmware on whichbackend is in use, and the backend will 
> not change at runtime.If the backend in use by the firmware is not 
> supported by the kernel (e.g. kernel is too old), the kernel does not 
> attempt to read any secure variables, as it won't understand what the 
> format is. This is a secure boot failure condition, as we cannot verify 
> the next kernel. With addition of new backends in the skiboot, the 
> support will be added to the kernel. Note: skiboot and skiroot should 
> always be in sync with backend support.

Seems reasonable. I'm thinking specifically about the kernel loaded
after skiroot; and yes, on reflection just failing to boot is the only
sensible thing you can do.

Regards,
Daniel

