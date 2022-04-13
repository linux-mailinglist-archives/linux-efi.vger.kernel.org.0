Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA84FFAF7
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiDMQKO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiDMQKN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 12:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD9D66472D
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649866070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOkajocQ8odh3i+hVeTJ63TIENzeAVOjDB6rWovHQzA=;
        b=UHIRHKdaNGk4SBrBx7HwHJXCuwjgGgSa/Vw0YYtzSnCRFsNgcqSfOw2rYwtmfv/COUkxKr
        d+eBqd23BIB+AcbGQwIHN7FwHpXQcDDYiBRKYhCIi66AvbmgYXebfIZ03gMI5BegmHRUpG
        OnY+xppIf9JF5ZUlBtbSwDOGZwXfKXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-ZcHOfVyXPCKiuAPBKZtPtA-1; Wed, 13 Apr 2022 12:07:49 -0400
X-MC-Unique: ZcHOfVyXPCKiuAPBKZtPtA-1
Received: by mail-wm1-f69.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so3030027wmp.3
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 09:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QOkajocQ8odh3i+hVeTJ63TIENzeAVOjDB6rWovHQzA=;
        b=fgxgylO6rAyKmMv0jW10AMJGpSn5A87668a5snOSQFkAqL2iOEoPwLwta3g1XMGC2j
         EzwkqbJI3li65ATSuMuO+MDLLBVLxBwXMjIGk6o3dvzm6aWK4KoZ828zkaX3Iu3Iou3A
         9RNLUIcabgyRAeBH/NPiVdsHHE1Xu3MedErsjYf1IjEbNDXB0PjQ9Y1da/GVTz+Ay1wV
         t4Et0GQKOkKFXUdU/+J1cctxL7TjT2jmC025mmQW7howsx/dPM7HHdZUu9nLeJ8fH6Op
         DLy1+FjyP+sujtYlRDpPn/ZX5/qzJjQuYOWZ3Z13DyxQDhJWGcVf4kuS+Dga1/grp+Hi
         epJQ==
X-Gm-Message-State: AOAM530sJuz6nQ56kt/aHbZl6VXaeFuxAuzEJejKM5UqVSkR6aeVKqFS
        D48BzfId0vzqY06hQQUNvw0+No3azhQdaaJTMnGjY3oRvDSM6TqyCVgmGhxlaUtsyuCywlIUB90
        cLm8AgP699x0XyQu5vjhQ
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr33002762wrn.116.1649866068379;
        Wed, 13 Apr 2022 09:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymHGhx5mZYHX4qc0LA34JUWjZS8Rn5QEmfvMvUVt0DpiviRON0T5cX/n3xjfGY/yDNO9s2GQ==
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr33002738wrn.116.1649866068071;
        Wed, 13 Apr 2022 09:07:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2895911wml.10.2022.04.13.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:07:47 -0700 (PDT)
Message-ID: <dd197d57-ce40-82f6-fa5f-c0450b39e23f@redhat.com>
Date:   Wed, 13 Apr 2022 18:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
 <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
 <cfcf9f82-7e5f-58b6-7b47-9ac552832596@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cfcf9f82-7e5f-58b6-7b47-9ac552832596@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 13.04.22 17:36, Dave Hansen wrote:
> On 4/13/22 04:30, Kirill A. Shutemov wrote:
>>> 2) Fast boot; after boot, all memory will slowly but steadily get
>>>    accepted in the background. After a while, all memory is accepted and
>>>    can be signaled to user space.
> ...
>> Frankly, I think option 2 is the worst one. You still CPU cycles from the
>> workload after boot to do the job that may or may not be needed. It is an
>> half-measure that helps nobody.
> 
> Let's not be too hyperbolic here.  "Worst" is entirely subjective and it
> totally depends on your perspective and what you care about.

Right. Some people might want to start their workload as soon as the
pain is really over. Some might want to have a functional system before
that, others might not care.

> 
> There are basically four options:
> 
>  * Accept everything in early boot
>  * Accept with deferred page free
>  * Accept with kthread after boot
>  * Accept on demand
> 
> and four things that matter:
> 
>  * Code complexity
>  * Time to a shell prompt
>  * CPU/Memory waste
>  * Deterministic overhead
> 
> Did I miss any?

Nothing that comes to mind.

> 
> News flash: none of the options wins on all the things that matter.
> We're going to have to pick one (or maybe two).  I'm also not horribly
> convinced that there's a problem here worth solving, especially one that
> requires surgery in the core of the buddy allocator.
> 
> This is essentially making a performance argument: it takes too long to
> boot if we go with a simpler solution.  Yet, I haven't seen any data.  I
> think we need to go with the simplest approach(es) until there's some
> actual data to guide us here.

Simplest meaning: accept everything during early boot and don't touch
core-mm/buddy code, correct?

> 
> Here's another way to look at it:
> 
>> https://docs.google.com/spreadsheets/d/1Fpv0Yp0CTF5_JXHR2pywvNtImTwUVGTxDMlJ5t8qiis/edit?usp=sharing
> 


-- 
Thanks,

David / dhildenb

