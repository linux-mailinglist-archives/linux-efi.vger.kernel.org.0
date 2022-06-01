Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909C539FFC
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbiFAJAj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 05:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351148AbiFAJAa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 05:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93FCF5FF22
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654074028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47e42rnIYaU6sJqvrI7HnnRd2dfzcghd2QGgfknq5Gw=;
        b=B4GOV2DVy+ciGbiEMpmzQvXARh+SkwiEXKF6Ydh8qPq0k0f7/ecGcFzI7uzS4fEItMxP++
        nF59PnZ2sJsXxDaeUzde4iHE0df2W1Zt9gLMsC9bCdJ3oQ35UkrTZ7ANRx/SQCSML2jtRG
        rkMXdhlcF0zVYqx/1TXhmDljKdxrDH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-YDW51q4iP3GkJUuloBBj1A-1; Wed, 01 Jun 2022 05:00:26 -0400
X-MC-Unique: YDW51q4iP3GkJUuloBBj1A-1
Received: by mail-wr1-f72.google.com with SMTP id e7-20020adfa747000000b0020fe61b0c62so146153wrd.22
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=47e42rnIYaU6sJqvrI7HnnRd2dfzcghd2QGgfknq5Gw=;
        b=XQ4NPQikno9pGUHCnDxvt96619b1eAyCmsPQCcwlzYgP3C+FfV/H5BsljKRY0RbKVB
         dVBj0nWU9hYEqlwt3DoK8Nmb0U91YiSXEZawRX4lFmdyalo0xtbQ2MruPx/jS9OqOPdV
         HnKQjGg1+oZFs0xVYkcYeAFe7R0HnFJyGZT44GDuUpWaV5AVFaRYDbkIhcKKAfofjA9l
         XLxROmDG6KXkcPuCH0frD8juyP0wRSFgPi1Z2KgnUvlsDpH4Hj7ilvUWg4AMnGrJ/Nu8
         Yvj7KOoxuweZjA8xq9D0A5T0ET/rXGBidGeh91bgGhLs1GNBtgoTb6/PSPB5KZX724eg
         uPjg==
X-Gm-Message-State: AOAM532decbatgr+Enfx/dHMZIMlzeR8h6jS9vl8ts10YJGKLwGwspzM
        /MBVfE9DfDBjHH8CnpHivyNuqapXx364c2WtZx9i/bLyrqwymDLLNHpNweIaCsTNBSilZ/ESeJy
        /Pbm0RnU+GOXA4oHl+7OU
X-Received: by 2002:a5d:6d0a:0:b0:20f:ecc9:2819 with SMTP id e10-20020a5d6d0a000000b0020fecc92819mr34366342wrq.666.1654074025598;
        Wed, 01 Jun 2022 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJFJMguj1HytJIpfb+YPwV4xImpt7pcmIEp7Y330tAofv7dZyg6rYBGjWbJBVTyfbKbEYsog==
X-Received: by 2002:a5d:6d0a:0:b0:20f:ecc9:2819 with SMTP id e10-20020a5d6d0a000000b0020fecc92819mr34366292wrq.666.1654074025277;
        Wed, 01 Jun 2022 02:00:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id h1-20020a056000000100b0020c5253d8casm992951wrx.22.2022.06.01.02.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:00:24 -0700 (PDT)
Message-ID: <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
Date:   Wed, 1 Jun 2022 11:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
In-Reply-To: <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> Currently allocate_e820() only interested in the size of map and size of
> memory descriptor to determine how many e820 entries the kernel needs.
> 
> UEFI Specification version 2.9 introduces a new memory type --
> unaccepted memory. To track unaccepted memory kernel needs to allocate
> a bitmap. The size of the bitmap is dependent on the maximum physical
> address present in the system. A full memory map is required to find
> the maximum address.
> 
> Modify allocate_e820() to get a full memory map.

Usually we use max_pfn, if we want to know the maximum pfn that's
present in the system (well, IIRC, excluding hotunplug).

How exactly will this (different?) maximum from UEFI for the bitmap
interact with

max_pfn = e820__end_of_ram_pfn();

from e820 in existing code

?

-- 
Thanks,

David / dhildenb

