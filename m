Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6C53A94F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354906AbiFAOja (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 10:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354952AbiFAOj2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 10:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E78533E26
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654094362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlU0tkzpCjcg/jU3LgCOcXpRFl3qkGqk9lVl6FW9S+g=;
        b=T3lLK89+tCok2oiaNJSiZBSncEZtYjmnOl/e5+nrPhcmiStbyNe6+A8ok7E25fl3Eda3rA
        BajBq/dTwZTasUz5zrBJdCWoIXS/xgiWYlnwNqH1NL2JPfq2Yp9F8tS33Zf4nrisPs+FZF
        Lm+gX7CljDof55uNm1A5TwfTTiFz8Dk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-jTwZdIqNOVGD7-Gt3FvAIA-1; Wed, 01 Jun 2022 10:39:20 -0400
X-MC-Unique: jTwZdIqNOVGD7-Gt3FvAIA-1
Received: by mail-wr1-f71.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso344616wrd.16
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 07:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qlU0tkzpCjcg/jU3LgCOcXpRFl3qkGqk9lVl6FW9S+g=;
        b=UnJsKyBEh8r5igAmMfrpWlVQwIYi2P6Bq5A4Yb7lI9Iw4SOTNl4wMybS78WdQdiEnG
         WZ0umw3tHUvIF2pqac7VkKT1UG5+6gCHUPDWNDQamfoBpWbbAijNl3y7mor6OX0ZOhsU
         gBy8SjDjrldvoWxeRIxGXMpjK85m7KVLCFjN678B1wrnwo0se2Oq09bTQwSMSE042BCP
         1iGQPOE2KtRYYT3bYMREdI1xqXQ56rOBE8+k5MjM9UB8SVEjbuNHYKsaYmUkuJXPsOnm
         5XVrPoglXxHEAd8/fXOz1Baie9+NYE36egaxY+SBjbqYRkwGfPBo4A+N8yHQrElQAUMt
         kRMQ==
X-Gm-Message-State: AOAM530zk/fsoV+auj4ehPoLQqc17dekNLxEqQ/R+8ahkMVI3kqiXY9j
        Uc0YuoQS3wXLjxbmIQTiOv65lDaoY3PB6XmCGHii6KN5LTfHPBnWq2PS56p7uqEAVRDBJTxlIXE
        u5BUzVHh4+kkvQYufoIMx
X-Received: by 2002:a05:600c:1d99:b0:397:482b:429 with SMTP id p25-20020a05600c1d9900b00397482b0429mr28614917wms.130.1654094359707;
        Wed, 01 Jun 2022 07:39:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZmvS/ySSMSACfcbs5N8wx4zgU89IJgDAitfH9pT2OXqot4AKsgn1nc41biOJdFJqGw1r+Pw==
X-Received: by 2002:a05:600c:1d99:b0:397:482b:429 with SMTP id p25-20020a05600c1d9900b00397482b0429mr28614883wms.130.1654094359401;
        Wed, 01 Jun 2022 07:39:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b00397550b387bsm2720288wmh.23.2022.06.01.07.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 07:39:18 -0700 (PDT)
Message-ID: <116f7be4-7b75-a83b-899b-c23b52534b30@redhat.com>
Date:   Wed, 1 Jun 2022 16:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
 <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
 <20220601143515.iavmtysdchirbtel@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220601143515.iavmtysdchirbtel@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 01.06.22 16:35, Kirill A. Shutemov wrote:
> On Wed, Jun 01, 2022 at 11:00:23AM +0200, David Hildenbrand wrote:
>> On 17.05.22 17:34, Kirill A. Shutemov wrote:
>>> Currently allocate_e820() only interested in the size of map and size of
>>> memory descriptor to determine how many e820 entries the kernel needs.
>>>
>>> UEFI Specification version 2.9 introduces a new memory type --
>>> unaccepted memory. To track unaccepted memory kernel needs to allocate
>>> a bitmap. The size of the bitmap is dependent on the maximum physical
>>> address present in the system. A full memory map is required to find
>>> the maximum address.
>>>
>>> Modify allocate_e820() to get a full memory map.
>>
>> Usually we use max_pfn, if we want to know the maximum pfn that's
>> present in the system (well, IIRC, excluding hotunplug).
>>
>> How exactly will this (different?) maximum from UEFI for the bitmap
>> interact with
>>
>> max_pfn = e820__end_of_ram_pfn();
>>
>> from e820 in existing code
>>
>> ?
> 
> I'm not sure I understand the question.

Essentially, if the PFN you calculate here for the bitmap size will
essentially match later max_pfn.

> 
> On EFI system, E820 is constructed based on EFI memory map and size of
> bitmap calculated based of EFI memmap will always be enough to address all
> memory. e820__end_of_ram_pfn() can be smaller than what what we calculate
> as size of memory here, if kernel reserve very top of the memory, but it
> will never be larger.
> 
> Later during the boot we use e820__end_of_ram_pfn() to infer size of
> bitmap and it is safe.
> 


-- 
Thanks,

David / dhildenb

