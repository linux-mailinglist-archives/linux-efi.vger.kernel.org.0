Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC979A5AA
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjIKILE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjIKILD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 04:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D4CF2
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694419789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OE5jHWIoTi0oDDOVSbCQAUkm2GG93rVvkvjC/9s+zDo=;
        b=KWIIgAC1S2/3x63tiausX3L2lAowr/B/rsJgovCKBRAFS2tz59MwWN+p0IBM2cE0LKXu4l
        0LDUjPJTgpJts/czq4frOiwBT6NnluTk/RFXskktkK+swd9jgI8UYlCnN/LvaDOVnfRbao
        fmZNKyGWxYGBbTHFZENOCU6roE+s1eM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-4tphpZjpMG2ddJr8rsgRjg-1; Mon, 11 Sep 2023 04:09:48 -0400
X-MC-Unique: 4tphpZjpMG2ddJr8rsgRjg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-402ccac9b1eso30432595e9.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 01:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419787; x=1695024587;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5jHWIoTi0oDDOVSbCQAUkm2GG93rVvkvjC/9s+zDo=;
        b=GoHHUpDiFXtltct0kxEDLvdwiEO3TCtsGNwiAu6L12MIUU/xSHkAixgHlNClBhs5Eo
         eQYwFTWTKoAuvQxNkePqBE7mpWrH1Xtv2MErZkAAfYGLvA0aXyxtc8fuOnWRgWDgeA7E
         iGM2NypXcrR7YS1UW52M5wTxnKgPr8t8T0b/zSFrF/ig+lrFF5OM96uiDhm7R2R8NeAs
         QsxkatpCJ5mR8UuoHxA5VesX8eDDXGjG5boooPS5sunD+nASOnhqdVrPVgnHLpRlLHKp
         TrA7m2xcrXPPLqfMQ7glMO0R8MO4HGsCEhI9wNiaAsWW0KYXnHwrRVuVyzal5XQZYeFb
         0TXA==
X-Gm-Message-State: AOJu0YxHu2FFiWSUdY7jJT3OACaZhfyfS05GwHtaNOyZX5I9RON5MR2c
        8Xlo8XtdcorBuSDOJxwqiGVibcl6YBXRZPZ6P4yfiQbzDc0H1OzxOzG6jeOQMoG9qFBC+6G/Hg0
        JCFnX5qZMAA2wSQno20Xy
X-Received: by 2002:a7b:cd97:0:b0:3f6:9634:c8d6 with SMTP id y23-20020a7bcd97000000b003f69634c8d6mr7756896wmj.18.1694419786957;
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP/fXfkIDU6FsZ0+ujLPL6eiYP/U8dRfUXceL70QbvmQvHtk7DVWUJv4/1OPaMnnx/ifbxFQ==
X-Received: by 2002:a7b:cd97:0:b0:3f6:9634:c8d6 with SMTP id y23-20020a7bcd97000000b003f69634c8d6mr7756871wmj.18.1694419786499;
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004030c778396sm3452549wmb.4.2023.09.11.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:09:46 -0700 (PDT)
Message-ID: <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
Date:   Mon, 11 Sep 2023 10:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
 <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
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

On 07.09.23 16:46, Dave Hansen wrote:
> On 9/7/23 07:25, Kirill A. Shutemov wrote:
>> On Thu, Sep 07, 2023 at 07:15:21AM -0700, Dave Hansen wrote:
>>> On 9/6/23 00:39, Adrian Hunter wrote:
>>>> Support for unaccepted memory was added recently, refer commit
>>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>>> a virtual machine may need to accept memory before it can be used.
>>>>
>>>> Do not map unaccepted memory because it can cause the guest to fail.
>>> Doesn't /dev/mem already provide a billion ways for someone to shoot
>>> themselves in the foot?  TDX seems to have added the 1,000,000,001st.
>>> Is this really worth patching?
>> Is it better to let TD die silently? I don't think so.
> 
> First, let's take a look at all of the distro kernels that folks will
> run under TDX.  Do they have STRICT_DEVMEM set?

For virtio-mem, we do

	config VIRTIO_MEM
		...
		depends on EXCLUSIVE_SYSTEM_RAM

Which in turn:

	config EXCLUSIVE_SYSTEM_RAM
		...
		depends on !DEVMEM || STRICT_DEVMEM


Not supported on all archs, but at least on RHEL9 on x86_64 and aarch64.

So, making unaccepted memory similarly depend on "!DEVMEM || 
STRICT_DEVMEM" does not sound too far off ...


-- 
Cheers,

David / dhildenb

