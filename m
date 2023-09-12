Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0079C8D1
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjILH5v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjILHvM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 03:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB8C10D7
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694505022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mzVy3Mc/7bAQAhf4c1iHjdctfZReLCkKlOdBdE9Gi0=;
        b=h47eXwVyN8fbHGwediTQ4qIEfH+JkLYcV+JdZOKVuo/M/Nh/381PLkXHmEqQEIKYLYb03R
        NhDBETi0McjyB1+UfDYYaF+EGvrggH1ZE27IHVFS1f9a0M+vlbxCrr8YtlIri7mVRLeqQm
        BIvVy8xLxhUcEAh5uegvKRhMvRn37n8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-LB97EvGPNKCTWmpS1DKuRQ-1; Tue, 12 Sep 2023 03:50:21 -0400
X-MC-Unique: LB97EvGPNKCTWmpS1DKuRQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401db25510fso40629135e9.1
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 00:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505020; x=1695109820;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mzVy3Mc/7bAQAhf4c1iHjdctfZReLCkKlOdBdE9Gi0=;
        b=u5kC0nhcl2FDS3AYvm0or1dLOC/3d2UIqprwaYqXDOYQccmMfFZxhvNcx8bSw6SuJ6
         JI0E5FJF8on5xfRpNaYjdUeT8hfD4E9gS8MvHzGPJBbXjyScGbJ1mhcdozgLcXI29eLT
         jMkwHFTEhgfasseEBLcdGtIohX9h61ptQEtrOUGQIpWCDkCNjrdGfnHwIVEfNfOn9inG
         Dl2biJAPQBgaLDTKQEmWOE9CXKtFaYe8/0eYsE/KYFi3IDEfTxEmQLChdP5CynUGR+LL
         z2MEKch8cBnygvHJllKBkhArrjdD99KlUL0lAS3FdhPdJFHAFCMDDHMFKMrVvj4lfjGa
         Fljg==
X-Gm-Message-State: AOJu0YxcCHO9Z5x09bFI1bU2jTlqXxGJKsQgKpG8ci660Um3gaCvF5wg
        wk02LdffO8js0j5NT+5PvD/3fpolg73YUk46ZkKhkKG8JsTMg5de1w7o56rtR1loRi3sTJ+YQH5
        gQZ5ByNgwXeD3Jb1CuE19
X-Received: by 2002:a05:600c:b59:b0:402:8896:bb7b with SMTP id k25-20020a05600c0b5900b004028896bb7bmr10597651wmr.6.1694505020028;
        Tue, 12 Sep 2023 00:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWb5KPPue011J3X0eD1sW7gLSQXGBULtIBQ0OCAIfXnbwUsDGLY2yVip/HeBg+JEeYAy53ww==
X-Received: by 2002:a05:600c:b59:b0:402:8896:bb7b with SMTP id k25-20020a05600c0b5900b004028896bb7bmr10597627wmr.6.1694505019623;
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05600c1e0700b0040303a9965asm9212894wmb.40.2023.09.12.00.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
Message-ID: <ea1bc666-69ca-9ae4-36cf-cb3d852a0558@redhat.com>
Date:   Tue, 12 Sep 2023 09:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to
 access unaccepted memory
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230911112114.91323-1-adrian.hunter@intel.com>
 <20230911112114.91323-2-adrian.hunter@intel.com>
 <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
 <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1c736ca3-36e2-3225-2f98-e51149c468ef@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12.09.23 09:47, Adrian Hunter wrote:
> On 12/09/23 10:19, David Hildenbrand wrote:
>> On 11.09.23 13:21, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
>>> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
>>> need to accept memory before it can be used.
>>>
>>> Do not let /proc/vmcore try to access unaccepted memory because it can
>>> cause the guest to fail.
>>
>> Oh, hold on. What are the actual side effects of this?
>>
>> Once we're in the kdump kernel, any guest is already dead. So failing a guest doesn't apply, no?
>>
> Unaccepted Memory is used by virtual machines.  In this case the guest
> has kexec'ed to a dump-capture kernel, so the virtual machine is still
> alive and running the dump-capture kernel.

Ah, I got lost in TDX host semantics. So what you're saying, if we 
(guest) are reading unnaccepted memory we will get zapped. Makes sense.

-- 
Cheers,

David / dhildenb

