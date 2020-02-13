Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E329415BA18
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 08:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgBMHej (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 02:34:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35097 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgBMHej (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 02:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581579277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9BGDicXDOJpiAMof1DkWOo8fg4EMDptitGj3wEyiAg=;
        b=fICsdVGBvPgekv270N9FsMxWdcSuq2nRpmhf3JdvRVmmwnnhrptzN1+GTVy7yldeyDlT4e
        07IbC8c9QHD5jclc9DYcUcSYJYYI3qGSCvpnpJFU9PujylqKWEirfqTTR3P0+2nyHpB6PD
        fd31mciNyHy9g0xycTr7+1j9sDBj62I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-2eVQVWGLOAO_lY-Zu72MdQ-1; Thu, 13 Feb 2020 02:34:35 -0500
X-MC-Unique: 2eVQVWGLOAO_lY-Zu72MdQ-1
Received: by mail-wm1-f70.google.com with SMTP id g26so1658769wmk.6
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 23:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9BGDicXDOJpiAMof1DkWOo8fg4EMDptitGj3wEyiAg=;
        b=RyrcvR/Iac0ha/35EEH+QYAgTJs3t2NV02qMZ6/KuBCbIjgxTxOp7HRfB+RfASVqCd
         ZhH+cGwLxArP/Hc9/YcWoSt9Q1ZDrtXKhr13YAQfDb+NKQy0nS7QLNZ+p9PX/umDSuxE
         ARhl34dT61dXkErw5rPX42JABWwZLoVuX30IHexp2iUVd5WoD3i6X2ERkdsjh8e/UBSQ
         pGpbWlSK56uqOvkxW2/JPUU0hHMEKUVLKbGm/YFYH2Uv2a9sutMGskslUCU1bTMGCsyf
         2eJ24I8K8vXH+8eQcq6dOXDD4s+xHRCxiroplayoNDbEi9BefLx0+GAYPWIXVW0bnWtF
         6nlg==
X-Gm-Message-State: APjAAAWjG4NuRwVXVk8c55RrMxK2+Mxwb5/N3Eaucr4FRy5iclrgMfcZ
        nT2ruCKtfwOukYuyhCaK6+PgYCXZ0/iSiMIwWgNZZZuhGVMHJhfOAHkNR3dN+HPIhHXCWWhkE3V
        H4p9U+bYqJgPXs+V2Y591
X-Received: by 2002:adf:f64b:: with SMTP id x11mr19749595wrp.355.1581579274607;
        Wed, 12 Feb 2020 23:34:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxc8PC+YAjxMzhOVTwEvqM55UpU8U0yjQl6NCkPhoK/Wx34RxOzT+XY7zfgg2B6PvaGfZVAXA==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr19749579wrp.355.1581579274425;
        Wed, 12 Feb 2020 23:34:34 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id a8sm1896254wmc.20.2020.02.12.23.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:34:33 -0800 (PST)
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
 <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
 <20200212215717.GA958135@rani.riverdale.lan>
 <20200213003449.GA1190065@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9c0a89ff-a460-3cf3-0723-b57f85790458@redhat.com>
Date:   Thu, 13 Feb 2020 08:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213003449.GA1190065@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2/13/20 1:34 AM, Arvind Sankar wrote:
> On Wed, Feb 12, 2020 at 04:57:19PM -0500, Arvind Sankar wrote:
>> However, I'm also getting confused about how mixed-mode works at all if
>> we have more than 4Gb RAM, which it seems we want to support as we take
>> pains to allocate a stack below 4Gb for the thunk. But in this case, the
>> kernel text and stack could be above 4Gb physically, so rather than
>> using a 1:1 map we'd need to find some space in the low 4Gb of virtual
>> addresses to map those, but I don't see where we do this? Also, that
>> dynamically allocated variable_name could be above 4G as well.
> 
> Verified in QEMU that mixed mode crashes if physical RAM can extend
> above 4G. Are there any such real devices in existence? Should we check
> that and disable runtime services if so?

AFAIK mixed-mode is mostly used on Bay Trail and maybe on one or 2 Cherry
Trail devices. Bay Trail does not go above 2G RAM and Cherry Trail does not
go above 4G RAM so in practice this should not be a problem.

I guess we could/should still document this somewhere ?  Or maybe add a check
just for the sake of correctness?

Regards,

Hans

