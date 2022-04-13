Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A24FF4F1
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiDMKjY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiDMKi5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 06:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9D65AA5B
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649846176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gww3nqiIUaE/hiebhaeJWaOYoxyisvc31A4eZ4yYvpw=;
        b=A+Xk0jGBie9kE/U0C7Xcr0BJTFTQ/cfdHMIq6FBVl89O/+FSI+n6dtn9QzwUrsNUPAglIk
        9xwB160IA+X8mAhbRV7s13ZEK03r3EVnvvf3A58TPUgA7UWX7kofA0zkh0ZPtj7TkiTBXe
        EL8eBSCJQ7txeuCuukzKv5cb82CRMH4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-kvIvLq58PGCtuxIjCPXjig-1; Wed, 13 Apr 2022 06:36:15 -0400
X-MC-Unique: kvIvLq58PGCtuxIjCPXjig-1
Received: by mail-wm1-f71.google.com with SMTP id n17-20020a05600c501100b0038e731cf5e1so665336wmr.2
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 03:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Gww3nqiIUaE/hiebhaeJWaOYoxyisvc31A4eZ4yYvpw=;
        b=exBul3R8J0qhN0nzxtwm7Rxvac05FasPxUPSTnjFw6vxlULPk3f8m8dly6lEQprZWO
         w4YhB9S9myczbTpbYf8GgwPt7DG585ZaIWj78nA9M13TybmJr0T63LpNWk6aWHb7qF0x
         Owmjkt4Cjrt8t7FcaL+mY6DQZPQk5x7OeTgYXX2UB1BrsFaDBiDA9zJnP45ogDODSRDK
         1Wu5IfWM/Os6AIbT2LKVVIn4skwTkEHPKOZFwxF7w9+6tl9ZE6Ucl+HFhCmjKtLnsyvv
         /FU+Mk+726BajBc5OHEBaozBQYPwmQyOS36HtoR+0qilm7XTSCRAKoXXzvEBNbsWKK5w
         KjZw==
X-Gm-Message-State: AOAM532Ljb5v/vTGoHb9D5Gl0uiRZqwiMPHr/O1c3OpR1hxu4tFTgxKW
        dhjnecXq6wdencHNLs8ILldqJriakP8Jnz/2B3JG3oQgpEdLheOm0hsnLqyaYVQDeyZamhqUvq+
        70nSagMtZGH95ivbHTMOn
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr31433826wrc.474.1649846174383;
        Wed, 13 Apr 2022 03:36:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQSMzkkc8N52AEUPOHLS9vbDtk6f23iQd0OLo4NpbTx/HV7xfp7bReFl1jssMbbsElB6nYvQ==
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr31433796wrc.474.1649846174092;
        Wed, 13 Apr 2022 03:36:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm2255442wmq.42.2022.04.13.03.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:36:13 -0700 (PDT)
Message-ID: <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
Date:   Wed, 13 Apr 2022 12:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12.04.22 18:08, Dave Hansen wrote:
> On 4/12/22 01:15, David Hildenbrand wrote:
>> Can we simply automate this using a kthread or smth like that, which
>> just traverses the free page lists and accepts pages (similar, but
>> different to free page reporting)?
> 
> That's definitely doable.
> 
> The downside is that this will force premature consumption of physical
> memory resources that the guest may never use.  That's a particular
> problem on TDX systems since there is no way for a VMM to reclaim guest
> memory short of killing the guest.

IIRC, the hypervisor will usually effectively populate all guest RAM
either way right now. So yes, for hypervisors that might optimize for
that, that statement would be true. But I lost track how helpful it
would be in the near future e.g., with the fd-based private guest memory
-- maybe they already optimize for delayed acceptance of memory, turning
it into delayed population.

> 
> In other words, I can see a good argument either way:
> 1. The kernel should accept everything to avoid the perf nastiness
> 2. The kernel should accept only what it needs in order to reduce memory
>    use
> 
> I'm kinda partial to #1 though, if I had to pick only one.
> 
> The other option might be to tie this all to DEFERRED_STRUCT_PAGE_INIT.
>  Have the rule that everything that gets a 'struct page' must be
> accepted.  If you want to do delayed acceptance, you do it via
> DEFERRED_STRUCT_PAGE_INIT.

That could also be an option, yes. At least being able to chose would be
good. But IIRC, DEFERRED_STRUCT_PAGE_INIT will still make the system get
stuck during boot and wait until everything was accepted.

I see the following variants:

1) Slow boot; after boot, all memory is already accepted.
2) Fast boot; after boot, all memory will slowly but steadily get
   accepted in the background. After a while, all memory is accepted and
   can be signaled to user space.
3) Fast boot; after boot, memory gets accepted on demand. This is what
   we have in this series.

I somehow don't quite like 3), but with deferred population in the
hypervisor, it might just make sense.

-- 
Thanks,

David / dhildenb

