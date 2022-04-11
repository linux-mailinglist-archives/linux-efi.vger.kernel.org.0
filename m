Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB72E4FB64F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiDKIuL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiDKIuE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 04:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D1C3EBAD
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649666858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO5/uXu6trmQnelozguxiW34fXYut6Mlb4fdD2t6SEU=;
        b=EMfGSGoEPUa57MHJNNJL/lS2d/NUBXqM8TtRYzwA8NeUSSeIPotQmq/epZDYUrUvXHdj0k
        ruUICm5dt5XkOrofTRT6MJtXsZ1SsT6vEPCcYnOL0K3HIOLiuBu9y29ZUO0By14vtp+Bqv
        0E+BVEByp95EPWkJiHByXVSV7xAdUTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-cBhFBTbnPXGtbpe3NryTnQ-1; Mon, 11 Apr 2022 04:47:37 -0400
X-MC-Unique: cBhFBTbnPXGtbpe3NryTnQ-1
Received: by mail-wm1-f70.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so4123986wmi.9
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 01:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xO5/uXu6trmQnelozguxiW34fXYut6Mlb4fdD2t6SEU=;
        b=QaCxGWPPwcSQvRt/bRSTX0s7e0LvARd++YxwcEOgUexfvDS5DQyRXXFtmzdwfJmFgT
         C63unQgIhFwB2t/mVIXNsIH7YkUO8D8MRhT8dJOxYI9Nj/C0ycImEdMv4z576Iu7NDck
         CZxvWG0Tmb6rmyS3i6z9Bv6j9Nc2r8oTsu0X0Prwd9Yc9tsl59Q+LEH9BcKQ8Lh+BqN4
         vAzwoO0VLAPDVs/P4s7JcPCfqzOfd1kSG5Tlw+A/XzdIABZFduwsBR0fWK+roPC5wwW+
         zCfhs36MJZIQV8F7Xd7mQtRP8bHD5gBpEa4BDTYZ2OKNI4jDfY2/VQlZXBOOQC0HrrLn
         xETQ==
X-Gm-Message-State: AOAM531QyJvj1C7hs0GiTGJf3D0zSonA56uLDQKfNWwIAtHaXiPFrm3S
        TWZ+YuhTaMyM+N+KUVwwqIB2eCM5WggdRP54WRo3g14GQPWSQqYGw29GLU17XTpw3xxosoV1QnF
        8JeIb06h8tSu7/QCNg7uz
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id u6-20020adfdb86000000b00205bccf8cbfmr23524561wri.346.1649666856071;
        Mon, 11 Apr 2022 01:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU4i8tDZK4R8SDfWHRx/HMVMKbJaFD0rR9CAx62zvu90I37i9CuXip3i2xbgqxkZ/aEv7AAg==
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id u6-20020adfdb86000000b00205bccf8cbfmr23524547wri.346.1649666855817;
        Mon, 11 Apr 2022 01:47:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:aa00:2064:15bd:222d:3a02? (p200300cbc703aa00206415bd222d3a02.dip0.t-ipconnect.de. [2003:cb:c703:aa00:2064:15bd:222d:3a02])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000184400b00207a55f712asm3352085wri.37.2022.04.11.01.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:47:35 -0700 (PDT)
Message-ID: <1837b625-c63d-9feb-ec98-3b4c7b0040b4@redhat.com>
Date:   Mon, 11 Apr 2022 10:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>
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
 <767c2100-c171-1fd3-6a92-0af2e4bf3067@intel.com>
 <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220409155423.iv2arckmvavvpegt@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

>>>  	if (fpi_flags & FPI_TO_TAIL)
>>>  		to_tail = true;
>>>  	else if (is_shuffle_order(order))
>>> @@ -1149,7 +1192,8 @@ static inline void __free_one_page(struct page *page,
>>>  static inline bool page_expected_state(struct page *page,
>>>  					unsigned long check_flags)
>>>  {
>>> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>> +	if (unlikely(atomic_read(&page->_mapcount) != -1) &&
>>> +	    !PageUnaccepted(page))
>>>  		return false;
>>
>> That probably deserves a comment, and maybe its own if() statement.
> 
> Own if does not work. PageUnaccepted() is encoded in _mapcount.
> 
> What about this:
> 
> 	/*
> 	 * page->_mapcount is expected to be -1.
> 	 *
> 	 * There is an exception for PageUnaccepted(). The page type can be set
> 	 * for pages on free list. Page types are encoded in _mapcount.
> 	 *
> 	 * PageUnaccepted() will get cleared in post_alloc_hook().
> 	 */
> 	if (unlikely((atomic_read(&page->_mapcount) | PG_unaccepted) != -1))
> 		return false;
> 
> ?
> 

Please don't. Keep the usage of PG_* details inside page-flags.h


-- 
Thanks,

David / dhildenb

