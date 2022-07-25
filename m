Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB657FF18
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jul 2022 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiGYMji (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Jul 2022 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiGYMjU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Jul 2022 08:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56BAA1AD9C
        for <linux-efi@vger.kernel.org>; Mon, 25 Jul 2022 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658752757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WHFuKmZPQedoN55ZoH0FtL+rcxDT0vItFUzM4he2I8=;
        b=Ja+fxrjVL3uiVS/qw0a5nXMJhTsXzUpwuYey5kWuUifgbRl9Wr/vc9WeX9ofBIPxjqm8oS
        hFNj5KdB3UPsZYa/YE0xAEM0MsVpW4ozlx92Eef96Per6v9Y6yc0C+32nMTJRrvgDrMofa
        s/UDmv7RlosZ1jUMYYVFiZm+0vYFCOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-Yat6uLd3P9CeZZ0-l1471g-1; Mon, 25 Jul 2022 08:39:00 -0400
X-MC-Unique: Yat6uLd3P9CeZZ0-l1471g-1
Received: by mail-wm1-f69.google.com with SMTP id t25-20020a1c7719000000b003a3564fa721so1873275wmi.2
        for <linux-efi@vger.kernel.org>; Mon, 25 Jul 2022 05:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3WHFuKmZPQedoN55ZoH0FtL+rcxDT0vItFUzM4he2I8=;
        b=7pda3OOGpQgBAekP0eG4yuOr4SMVJ1iEPFYItZ+l+0ccmuPX2lHi6kEzjkeywWIO+q
         PxKJ8lcEYbagJb6ddNmX6iSbbrrAukyGvJDUFRx4OlFwQOz24STtjrtS74YtAGxD86+/
         dqrGsan0BxFZLm1n8ewrAUDnjo26Qq74W3cAVWciKPLFj7MKZrszIviawzkSjhUdsW2e
         jYIUL5tlLK9dw9W3GFdPKo8f7b/jGPriP8EBXP1y9Yyej0omrSrlw0u4oqQzdhUZUJ1V
         2PwmCTwsIknck/1Xcpp6x7NRmTQku9Qa776OOQVDCWjnye/KZnYvjoeOo0yjjNOoPd82
         mQaw==
X-Gm-Message-State: AJIora8ZuRoVoeewFKf78vqRb8E48dmA/0OeoOorzZ/b25IbEpquVieG
        FcZaUqeUjHAOP2PLaQhQhZjF0IHzBJby8YbdN0PeJ5sIRkORcrxle80PHguh6ZyAP/k2pNHybUJ
        rInocDaQRlkRkhavd7a5i
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr7365136wmq.140.1658752739748;
        Mon, 25 Jul 2022 05:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTnXfTssXHtYtWUqP9z+lS8oior8tLmN08lGBELo1Up+/gD5Avnva+lrhKtPOFyww/a8mGKA==
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr7365095wmq.140.1658752739261;
        Mon, 25 Jul 2022 05:38:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0? (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de. [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm11691804wrv.94.2022.07.25.05.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 05:38:58 -0700 (PDT)
Message-ID: <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
Date:   Mon, 25 Jul 2022 14:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <Yt6LOD9Ae2NqyG1N@zn.tnic>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yt6LOD9Ae2NqyG1N@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 25.07.22 14:23, Borislav Petkov wrote:
> On Fri, Jul 22, 2022 at 12:30:36PM -0700, Dave Hansen wrote:
>> Sure does...  *Something* has to manage the cache coherency so that old
>> physical aliases of the converted memory don't write back and clobber
>> new data.  But, maybe the hardware is doing that now.
> 
> Let's hope.
> 
>> Yeah, that two-tier system is the way it's happening today from what
>> I understand. This whole conversation is about how to handle the >4GB
>> memory.
> 
> Would it be possible to pre-accept a bunch of mem - think "pre-fault" -
> from userspace?
> 
> I.e., I'm thinking some huge process is going to start in the VM, VM
> userspace goes and causes a chunk of memory to be pre-accepted and then
> the process starts and runs more-or-less smoothly as the majority of its
> memory has already been "prepared".
> 
> Or does that not make any sense from mm perspective?
> 

The less core-MM code to handle unaccepted memory the better. Meaning,
that any kind of additional pre-acceptance (in addition to what we have
here) needs good justification.

-- 
Thanks,

David / dhildenb

