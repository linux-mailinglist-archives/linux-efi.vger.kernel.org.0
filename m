Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C279BE8F
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbjIKVR6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 17:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjIKIns (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 04:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28621A2
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694421778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1O9Hjy9rHsZrvC8iggQtpHWHNRqlOhd3zFoat4Zny8=;
        b=U6ta0ll9tmSEeD4BoznOOBRE3pUMEMbnYbswe068QjkH3YzrSN3ZQzMUifFcGBdfzFOLl4
        ErYmFqDSD5JegfdnzGxN4QXsTX2ONOOZlH2dZyufwITUK+HKLAKYcey1w8OWAn/lfJKmJt
        9JBxDTx4uhUIK8SuP2TAAAJvnNZ8KFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-lNo4gFMVM5KDkp1iaaN4NA-1; Mon, 11 Sep 2023 04:42:54 -0400
X-MC-Unique: lNo4gFMVM5KDkp1iaaN4NA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402c46c4a04so31450295e9.2
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421773; x=1695026573;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1O9Hjy9rHsZrvC8iggQtpHWHNRqlOhd3zFoat4Zny8=;
        b=rhXaglaaegmDhaw52kmSw007FGdkY8pWT1suxpqdqaRJ1jlVV1dD6g1ILGx1zw9HlC
         /DYSqRkejvGV5eML+Afi2MxlmKcJZgoHViWHHcXLDu/V7YMkL6spJrgpTB1Bgf02MRLu
         Ppy8fxetJ+s17HSrdCrJmy6h4mSJ+3sJS0FwiMjO+99R4zTqhOGo2qCWjeQUfghBinq/
         cmdSSYOWTNI2JLUP0A9sDxt02W07IxhX6l3hFmpmu5ObRzYCP1FdyFFzdD0jlxO0d1Gy
         FhuApn7MhGFrc3qi3S8Xiv/XuPG031CsgaQLFeJpvVRSKqHHCAd8ATTe6vDEhedtb9rT
         Bdhw==
X-Gm-Message-State: AOJu0YzEuTYx/1wR4XaJv16YS7crwhF4K5VFZLL3CcGx5oNqycubIXL5
        KlR6hJnLJcfKHGqZ3oN88SGIZxsmSkdJz+iP+nqY7NKJQmV+BOpiEGxZuW465rTl/8V9xgIyFwZ
        WZYK9ixKRJ5kFsapzmdvN
X-Received: by 2002:a1c:ed0b:0:b0:3fc:21:2c43 with SMTP id l11-20020a1ced0b000000b003fc00212c43mr7346851wmh.13.1694421773453;
        Mon, 11 Sep 2023 01:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8aoBWfTO9D3ZTCmaaRT0GwaH8BSrY/roXA5t7CzHxEaXPavXU1Y6T8UuPI7Q1KEVVmKAG3w==
X-Received: by 2002:a1c:ed0b:0:b0:3fc:21:2c43 with SMTP id l11-20020a1ced0b000000b003fc00212c43mr7346817wmh.13.1694421772969;
        Mon, 11 Sep 2023 01:42:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003fee849df23sm9372755wmk.22.2023.09.11.01.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:42:52 -0700 (PDT)
Message-ID: <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
Date:   Mon, 11 Sep 2023 10:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11.09.23 10:41, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
>> On 06.09.23 09:39, Adrian Hunter wrote:
>>> Support for unaccepted memory was added recently, refer commit
>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>> a virtual machine may need to accept memory before it can be used.
>>>
>>> Do not map unaccepted memory because it can cause the guest to fail.
>>>
>>> For /proc/vmcore, which is read-only, this means a read or mmap of
>>> unaccepted memory will return zeros.
>>
>> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
>> to the information whether memory of the first kernel is unaccepted (IOW,
>> not its memory, but the memory of the first kernel it is supposed to expose
>> via /proc/vmcore)?
> 
> There are few patches in my queue to few related issue, but generally,
> yes, the information is available to the target kernel via EFI
> configuration table.

I assume that table provided by the first kernel, and not read directly 
from HW, correct?

-- 
Cheers,

David / dhildenb

