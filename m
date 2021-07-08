Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218183BF720
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jul 2021 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGHI4S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jul 2021 04:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231236AbhGHI4R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jul 2021 04:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625734416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIPcM/AEt6CFgVLe5U5Gt1G0R6Bu5ZtRDH8h8xxqSLM=;
        b=SH3t12shlDdzBs865ZPodI9fv3qpRueZAr4V6/d+UXs+KKsXscn7CZf/qyuwFUehozR4OB
        pQh3d2tE8RPw/hjsjtwuLUxS/ooqE7s+SN4rKDxTSknjClDm2EcqJOA4L/bPJDcArj905f
        GFnWXxDOviN5x96sVs9GpdieAZAvTXA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-bZgr8LI_PFOPbX_jBbTxrw-1; Thu, 08 Jul 2021 04:53:34 -0400
X-MC-Unique: bZgr8LI_PFOPbX_jBbTxrw-1
Received: by mail-ed1-f70.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so2907252edu.17
        for <linux-efi@vger.kernel.org>; Thu, 08 Jul 2021 01:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gIPcM/AEt6CFgVLe5U5Gt1G0R6Bu5ZtRDH8h8xxqSLM=;
        b=U2nTxCJgA6kBWgMEnJNYgyyQ1L/9uwfdhjckF56MZLL+xUAyfvfUAkTmIc3TAL4uAP
         1DZhWGhRK/zENlD8quPSDvlB4bH7Kr+Q+iIOhNwNoX5XztX6VOCxTB58310eoaa+BVIS
         2tOAx1Zhc4e3+AU60To7kBSv06y8SVq3Ev7VUVoBfbCb0j/LGm47kipxIXvvGOW+K6wX
         xK6qt+m6QkDd118j24XZtLASXjHROMyREwy4yFPsqeC3XpW0L4bM5EVwt30elq7SWv1c
         k6GEB2Tsq2nN3qaz8kmrZW83jsVPky/hyfYd6Peii/7tJh36odyTnp6TXWVVyDu+wH0w
         CXAw==
X-Gm-Message-State: AOAM531QTXywVxtwrMb+IbR7PSVg7+yqAZBieKyw2Y110Ebsc4elwA/v
        Cg0ucgZtc/YyheB2s4sZJ5TrhEqwlKrgNkJHAChkDoVV18zagWpVt8vEIYGoljJ2YgVPLcqSg9K
        FsLT86PvgBus52CbvCR/X
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr36763711edu.380.1625734413608;
        Thu, 08 Jul 2021 01:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx/+0c8nIU7pwYBojXCHzTNcV8ZCk6Cqibqq/t9wTBQKxs+CGQcGK3UP/Yf8+cmhDD/LkdhQ==
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr36763691edu.380.1625734413381;
        Thu, 08 Jul 2021 01:53:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u17sm853904edt.67.2021.07.08.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 01:53:32 -0700 (PDT)
Subject: Re: [PATCH Part1 RFC v4 04/36] x86/mm: Add sev_feature_enabled()
 helper
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-5-brijesh.singh@amd.com> <YOa8TlaZM42+sz+E@work-vm>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6c68c70-ac6e-07f2-c24e-f1c892080eab@redhat.com>
Date:   Thu, 8 Jul 2021 10:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOa8TlaZM42+sz+E@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 08/07/21 10:50, Dr. David Alan Gilbert wrote:
>> +enum sev_feature_type {
>> +	SEV,
>> +	SEV_ES,
>> +	SEV_SNP
>> +};
> Is this ....
> 
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index a7c413432b33..37589da0282e 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -481,8 +481,10 @@
>>   #define MSR_AMD64_SEV			0xc0010131
>>   #define MSR_AMD64_SEV_ENABLED_BIT	0
>>   #define MSR_AMD64_SEV_ES_ENABLED_BIT	1
>> +#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
> Just the same as this ?
> 

No, it's just a coincidence.

Paolo

