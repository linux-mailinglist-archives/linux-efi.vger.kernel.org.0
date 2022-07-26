Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A958154A
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGZObH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiGZObE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 10:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8534C7643
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658845860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gr7dw0e3vkHCOc9kW8UEU5CieYdDfZtmZu7Qeg3pxlU=;
        b=cvrR5GIn8DgNAJxePWXnBUMEtjcvhO4ZKiYprt1tOyG0b5gQyLOWHfVFQ/hb5P3JXYNPBL
        wbgHvuUzLq9vboYv6FlJvFCuSl2rmy7GC1MEhJd5f6zFiYKrahrI4NYSHbmeRnSdcQLWQ8
        Q4Mtz8fU5ALtCjmabmKsFyjFM0Kg1q8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-OB61hIlUN5ycfXMYLIuw5A-1; Tue, 26 Jul 2022 10:30:59 -0400
X-MC-Unique: OB61hIlUN5ycfXMYLIuw5A-1
Received: by mail-wm1-f71.google.com with SMTP id 189-20020a1c02c6000000b003a2d01897e4so7727561wmc.9
        for <linux-efi@vger.kernel.org>; Tue, 26 Jul 2022 07:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gr7dw0e3vkHCOc9kW8UEU5CieYdDfZtmZu7Qeg3pxlU=;
        b=OwZrzbFWNJ3NWlY5yAjFEZ83QqCBnHh14Vp+7+01KYcTtlIwIK6HdH795zZyPZARVN
         /kB9qCkhxpy45v/QmLMM9p6V6qgIOGE2tR8sJhF/6ZLs6Q/gUyA8NPO5VLG4xEaY4x5B
         2VLdP9UYHRXwZ+bZwCj20aCCcyPW3W1kvxqbMoHIW+SJGgyRZRBc6pBjjj85vSkS6N6b
         7TnlnYT6BIz3rexyA2PNOKVo7ZQKiKWs6TReb9/vj7iyHQyuIY6SwM0HxudlQy+wN0Qm
         WUCLPt1Ihyx7BxnQNfGATQP2KWL5iYEdUAm19uhKXXDXhhnKXVHxcXMRjJgAuNNSCT8U
         4z2A==
X-Gm-Message-State: AJIora/2ArEX7+asM5gcJCHgdtZ54Goey6GGN5UiRICMrg2Z4MNHDS1P
        YXPYiyvhZoIV+3Twv5z2Z6Oj+HVb5UDqG4Gom+aP9ZOsW1fYj97UCxUtCa4qBRRpiAoWg9a+M/b
        N3e80H4EO9fCdePpZWY82
X-Received: by 2002:a7b:c3cc:0:b0:3a3:8ec:d69 with SMTP id t12-20020a7bc3cc000000b003a308ec0d69mr25694581wmj.78.1658845857802;
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8k0/X43EXk3DBk+CZ8uyrXpNOynm2gCY+Qrl/OkI5JufZYaMneweAdNpBJGa8v5GHTMBxdg==
X-Received: by 2002:a7b:c3cc:0:b0:3a3:8ec:d69 with SMTP id t12-20020a7bc3cc000000b003a308ec0d69mr25694552wmj.78.1658845857423;
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id v11-20020adfe4cb000000b0021e6b62fde2sm10429441wrm.59.2022.07.26.07.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
Message-ID: <fb58de71-a255-364b-5d32-1c839ed4a5c2@redhat.com>
Date:   Tue, 26 Jul 2022 16:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic> <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
 <Ytr4FCV2xPGUBLqs@zn.tnic> <707ca113-c2a2-8fe2-a22c-5be13adc7bb4@intel.com>
 <Yt6LOD9Ae2NqyG1N@zn.tnic> <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
 <Yt6SL8+nr1ESSZDh@zn.tnic>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yt6SL8+nr1ESSZDh@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 25.07.22 14:53, Borislav Petkov wrote:
> On Mon, Jul 25, 2022 at 02:38:57PM +0200, David Hildenbrand wrote:
>> The less core-MM code to handle unaccepted memory the better. Meaning,
>> that any kind of additional pre-acceptance (in addition to what we have
>> here) needs good justification.
> 
> I actually mean to have a user interface to have the core code
> pre-accept. I.e., interface to what will be already there anyway.
>

Ah, got it. The "issue" with ordinary prefaulting in user space is that
you'll also end up zeroing the memory. But yeah, it should just accept a
bunch of memory.

> Or is that frowned upon too?

I was assuming you'd want some additional interface that only accept
memory without actually temporarily allocating it.

-- 
Thanks,

David / dhildenb

