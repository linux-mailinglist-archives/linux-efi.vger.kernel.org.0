Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18385518EA7
	for <lists+linux-efi@lfdr.de>; Tue,  3 May 2022 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiECUZj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 May 2022 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiECUZZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 May 2022 16:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49DDD2DAB2
        for <linux-efi@vger.kernel.org>; Tue,  3 May 2022 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651609311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuOARFW3gYZOmM4Y4nSXFBD8lHm6BchzW975izB6OwE=;
        b=GdKnFqtuPA3KC6z+SxW2vtsto1MyY6d4wJX1VMpz75l/kZliI6RHRMm7MHkYSwl9degigO
        3Dgst+laCyDMWUJvrFm7gX2AT4LJNeGvwRQ1PYmtrjnYfo9r28SK/2O/NhlgOC7TCDejBB
        jAZaI6U+LtdSoUSmRxJTygwNnpcNN9Y=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ZMVhvIcKNDGkUaZS1erxiw-1; Tue, 03 May 2022 16:21:09 -0400
X-MC-Unique: ZMVhvIcKNDGkUaZS1erxiw-1
Received: by mail-ot1-f70.google.com with SMTP id 53-20020a9d0eb8000000b00605d4aa1e35so7693498otj.23
        for <linux-efi@vger.kernel.org>; Tue, 03 May 2022 13:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XuOARFW3gYZOmM4Y4nSXFBD8lHm6BchzW975izB6OwE=;
        b=Baq8DpTre74w1fzgI3ZKogX1d1+p/ckv5IoJjJcPZn7un/NLgtgDufvjMYF/HM3VcR
         je47FFkJOe3hc/hi9ltbvzsqHqCPHJYq3f02I7ukoG5adY+5T97Cw4dAL6LI8EhLN5qP
         Xy2Q7aX4FUIQNgeTqDJjYu4WFwa4/7radGlK6GN5gObkeb0AaW0gDos0f+7SMSUTlkN3
         8PCbzgeuZ8o9BDqsL6KngoIaygdf684Ajon3B7tuQcqPgoJsCl4pmEtrAQqBBgqwtFJu
         a8FG1G1wg82ww0o5WJkDSqYcJIzwEboRn8aXuy2pfRr0KfXPWda8pes9sQ2R+s10iZmq
         nf+Q==
X-Gm-Message-State: AOAM530dM+gNrHnXw6TC5GGrkK7bvph40OzSNlNnVS9NfUpqO2zJMbfd
        bcRL227VYcjYInsQiMtXPTfkQJsepxpEJOxbu9HLqJhMz9jANFmU7RiJHVV11w6ViUZavYicNF/
        sVIwstC3yGNRvaUGeq6Ol
X-Received: by 2002:a05:6808:14d3:b0:325:ed6b:e748 with SMTP id f19-20020a05680814d300b00325ed6be748mr2683321oiw.105.1651609267928;
        Tue, 03 May 2022 13:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKRbb5OLkMV2UmDQ1VLpoVhTPJwDt2cIVnFXrIsYyzxEIudxX/SPJKn8BJ62U+FH4qM5Vz5Q==
X-Received: by 2002:a05:6808:14d3:b0:325:ed6b:e748 with SMTP id f19-20020a05680814d300b00325ed6be748mr2683301oiw.105.1651609267392;
        Tue, 03 May 2022 13:21:07 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id w11-20020a4adecb000000b0035eb4e5a6cesm5328939oou.36.2022.05.03.13.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 13:21:06 -0700 (PDT)
Message-ID: <2bb92a84-18f4-d007-9465-fdc19f6f1c86@redhat.com>
Date:   Tue, 3 May 2022 22:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv5 02/12] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


>  
> +/*
> + * Page acceptance can be very slow. Do not call under critical locks.
> + */
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		if (PageUnaccepted(page + i))
> +			__ClearPageUnaccepted(page + i);
> +	}
> +}

What was the rationale of leaving PageUnaccepted() set on sub-pages when
merging pages?

I'd just clear the flag when merging and avoid the loop here. You could
even assert here that we don't have any PageUnaccepted() on tail pages.

-- 
Thanks,

David / dhildenb

