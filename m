Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6B79C813
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjILHU2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjILHU1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 03:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3929E78
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694503182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcEya9HqsW3o+5ldQKv7HTPg9J+Z7fGPS0QxHHzAjY0=;
        b=EInQwufjK6X2hqSzpyD8lfb5B2tmW/zoFx+AlU0aAHMZEvvGmd1QCfuwH588gEdIqojYi9
        BaSbNH/5nNf02s5wkBEpdPlmUrVQzEqFDBjuy4glPqUTmj8JGN/mYDlVlovLni7m35fQiI
        6cRWXcnqWmbYsOOgySLJjDvPjX7+A+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-NyNakQmhOHeUOrHf9wZLIg-1; Tue, 12 Sep 2023 03:19:41 -0400
X-MC-Unique: NyNakQmhOHeUOrHf9wZLIg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402cba95486so41753305e9.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 00:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503180; x=1695107980;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcEya9HqsW3o+5ldQKv7HTPg9J+Z7fGPS0QxHHzAjY0=;
        b=cp+Kveed8y9qlPwrGwc7/Re865amAQ28jOe5DZgrjSESePDHJWytt6VFLBb9kktsEb
         S6/Pup6q2SFdgqpYnukAQ/TFvTCKDV1QMcTM1sT1VzAe6mPjx02+ryYgP8bdIb3O0LJS
         knv6tdAW3jQygmyZNC0fuYh99b2xyC2Fy+NhYIxNyeItt8D9gWypWjxcgbnOjD8bIh8B
         PkpwQve00rMUhuMLAYgTKKbO1+VrLxukTyipKM7tlS1ERKIrg15zr8AYaz5qh+WIK4YK
         pZL8X0ErfX8jipryWQq/RwuHv+wCBp6vape7dZ7qhkoTSGstyq7U2GIC7riSjM5CkmXQ
         v8hg==
X-Gm-Message-State: AOJu0Ywo3AcI8FGSL0B72M0/4TB66kBlVOGMWNL15FaYgq44j6591oRg
        C35DBg883PPaDSec+fKa1mCFteVQc+Mpg7c6gXnvgKOF4iMPeNDpvIsLrC4ajZ7xvbMzP8WCrEz
        NgrZ79tI/oo4ZSr7slt8O
X-Received: by 2002:a1c:7c0e:0:b0:401:6800:703c with SMTP id x14-20020a1c7c0e000000b004016800703cmr11272015wmc.21.1694503180596;
        Tue, 12 Sep 2023 00:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBHMbRtiRZlVheP6qVSb8MqZ6oMl+4dwmRZR30fLEhp0pib6sKRWhTtFCZOTZU2I6KyZfYPg==
X-Received: by 2002:a1c:7c0e:0:b0:401:6800:703c with SMTP id x14-20020a1c7c0e000000b004016800703cmr11271987wmc.21.1694503180236;
        Tue, 12 Sep 2023 00:19:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003fc02e8ea68sm15188204wmk.13.2023.09.12.00.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:19:39 -0700 (PDT)
Message-ID: <96f124d6-c1f2-adb3-1d3b-8329e85ff099@redhat.com>
Date:   Tue, 12 Sep 2023 09:19:38 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911112114.91323-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11.09.23 13:21, Adrian Hunter wrote:
> Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory"), whereby a virtual machine may
> need to accept memory before it can be used.
> 
> Do not let /proc/vmcore try to access unaccepted memory because it can
> cause the guest to fail.

Oh, hold on. What are the actual side effects of this?

Once we're in the kdump kernel, any guest is already dead. So failing a 
guest doesn't apply, no?

-- 
Cheers,

David / dhildenb

