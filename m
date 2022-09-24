Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695A5E8860
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 06:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIXEiJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Sep 2022 00:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIXEiJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Sep 2022 00:38:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3C153A6D;
        Fri, 23 Sep 2022 21:38:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so1838948ply.2;
        Fri, 23 Sep 2022 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=nTLi6l79HpTEgUnSbGgwukC3QVuAIMwlZ0IfS0Hhzsg=;
        b=VXMHSS7Hs6xrO//MvIJGdxe3qIDJumot3WvVpZxhqKFilT4c15zUVBuiFbBHWQHYNj
         ubvRWJ4C8a/1Yp5V1z3bTSK2SdHgzQT/Sr7ePL/2BI0WLkKYkzHSIDc9R9LGVadBXTp2
         SxiCTOYbUMEJHHwrHWb0ONOwDU/vIew8yKV5WNBOWb2ynJHNNoupP3nRYeoxBZKxD8n/
         DT919FCriR9v/FXKVBCpN2dLcwAqrGSVrjjPCHTszJMUJdJ/hkpfEcXpeaZ3LXdB+Nm8
         k4IMrUVPawVFmN7Db89DTJ7VkvicIMSDoWDL8GX0DyCU1yVX/lphgj2Q9NPF6xe0vYGZ
         v5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=nTLi6l79HpTEgUnSbGgwukC3QVuAIMwlZ0IfS0Hhzsg=;
        b=NsKyvCBI1uNdLX4jCuAL3kt+GsIvQrpBCeWHMZAgYtl8TZFI5O71cjTh/rbv4w6+JT
         R0CljVPZrI/LWeSIq/ztUNwlow0tA97NdSh876eINFw7lMayTJkTdf7pgepf3O+mAqCU
         ZpgwbwiCOuY6SjKN2Sh6vtfYN2Y98stSHwfN/NZ3tdkRhaNrubJLBtYoktY0qgG1A+7l
         jxhOyahGqv/Nae0oeygBk871SQEahIsYSMZ4y4DwFQgGc95RrT+O4B92HDw/dAbxgx3G
         BCublvd1rOTg53OEQ06ZZMQpH/ncKcXyKJNRue1erCbdDGyrH8N7iIB/i0BzGWklO6JX
         G8rw==
X-Gm-Message-State: ACrzQf3opdN6UrUvyB4EOYABosFxUvqKOMQLF7KLkSadboDCAeUt2rTD
        hY8tc3rX+ry6nmVnxOX7c0M=
X-Google-Smtp-Source: AMsMyM7FzuV3oH4+OIE3yft3VuKhV6VCEEPcciaH4VwrG2wXXOvCsnGuj7++7FGVggcfAoZa9IPlYQ==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr25196333pjb.96.1663994287416;
        Fri, 23 Sep 2022 21:38:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0016be834d54asm4610654pll.306.2022.09.23.21.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 21:38:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3970db3-1ded-da2e-84a0-754810c15183@roeck-us.net>
Date:   Fri, 23 Sep 2022 21:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
 <20220924000954.hhaghgkrb6h33nvq@box.shutemov.name>
 <ca72bdfb-9868-162f-63d5-f778dd03db22@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ca72bdfb-9868-162f-63d5-f778dd03db22@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/23/22 17:12, Dave Hansen wrote:
> On 9/23/22 17:09, Kirill A. Shutemov wrote:
>> On Fri, Sep 23, 2022 at 03:17:30PM -0700, Dave Hansen wrote:
>>> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
>>> even have NX support.  Even PAE builds that support NX have to contend
>>> with things like EFI data and code mixed in the same pages where W+X
>>> is unavoidable.
>>>
>>> The folks still running X86_32=y kernels are unlikely to care much about
>>> NX.  That combined with the fundamental inability fix _all_ of the W+X
>>> things means this code had little value on X86_32=y.  Disable the checks.
>> Maybe downgrade the check to a warning for X86_32=y?
> 
> But for this EFI case, we really don't want the warning.  It's unfixable.
> 
> I'm also not sure we want to go to the trouble to properly silence the
> warning in these unfixable cases.  There was an argument elsewhere in
> the thread that we really shouldn't be warning on things that we don't
> have full intentions to fix.  I buy that argument.

Yes, there are already way too many such useless warnings around.
Please don't add more of them.

Guenter
