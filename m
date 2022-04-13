Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B105D4FFB1B
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiDMQZS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDMQZQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 12:25:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100592E083
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 09:22:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r2so2830675ljd.10
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EsxSjVG8kNa20sGc7UpfrBrGphyqTawiJapJvuQafrs=;
        b=XdJ/dmKaqAlkeNmwHqVM6mC0GRFNdyHrqfVtwzNO4hqerVqgJWXDDNFBhdov8vLwKV
         PcNSkxa5aMFJNAAmvJVKGgl8l9HfbioaOSEWqaUx2eDF7mHVRZ2Pvvdq9uUco6g6F4QS
         KO02pXC98R/2tEy0DWmUmr0N8OBg5OF/UBBGtZeX/yaqRqxMC94FuG48VUl6vA/wpMC0
         t2nwrne8NcmmC2wuCHugdPqdlgRLr1lM8Ew0yqpU/rwsVAtgZA0rYxA+AHFWX2OLn8rE
         I8/t3oT9BfUnxStoGwO7D4lFmtW7OcaJmDVHP55MKJuDAVYmchiwVAtrAuk197PppbKa
         SW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsxSjVG8kNa20sGc7UpfrBrGphyqTawiJapJvuQafrs=;
        b=X9YMuuOYtbaJ0FMglG27jBKKr6tR/+fV/HIBZeWeUvy6tBOl9iMTMpt2O4IJB1YtqR
         LK3LGozDRJD3V7LMbCDAwwa9emXJWQoP8eH6kpT26J+h+JuQX05s7b+mYzNHIkWoNPAA
         2J7mmG5PobnBS99mUiiMgM9bGV6D/cX0ldRAqlbY6hIG/+Pp77fGe5GUhPilPXMseRgo
         R98kGxnVNMCbO3MJlyf+zYIWa4hqc+ToCg/DF5I0mG+0yX1jSx5XVqf0beCC4MbxHTFs
         srnvaOh+pPxSDFulOsdbvtZ/5rVfVX5YpcQtf1G72BLanpXnPXCwvcbGEYME+kZx7QCc
         Jmdw==
X-Gm-Message-State: AOAM533AueRBKQJABSR+yHDwA+Bgml9dZD6YKCAR2YuyGL4SIo/6HIm9
        dTg6u3llLfbCxiXSMZl9sptf0Q==
X-Google-Smtp-Source: ABdhPJxItrR8spBKK0GKnFxBDIgY0Ti2eyMcpmcgx5QL2y7Tgx8HR9MxVY8Qex9KNQICbLsriZt2ig==
X-Received: by 2002:a05:651c:a0e:b0:249:90c8:453d with SMTP id k14-20020a05651c0a0e00b0024990c8453dmr26224552ljq.399.1649866973168;
        Wed, 13 Apr 2022 09:22:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z24-20020a19e218000000b0046bbc65356bsm720143lfg.183.2022.04.13.09.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:22:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ADB2E104197; Wed, 13 Apr 2022 19:24:26 +0300 (+03)
Date:   Wed, 13 Apr 2022 19:24:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <20220413162426.3sy6kjkaqvdgdbl6@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
 <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
 <cfcf9f82-7e5f-58b6-7b47-9ac552832596@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfcf9f82-7e5f-58b6-7b47-9ac552832596@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 08:36:52AM -0700, Dave Hansen wrote:
> On 4/13/22 04:30, Kirill A. Shutemov wrote:
> >> 2) Fast boot; after boot, all memory will slowly but steadily get
> >>    accepted in the background. After a while, all memory is accepted and
> >>    can be signaled to user space.
> ...
> > Frankly, I think option 2 is the worst one. You still CPU cycles from the
> > workload after boot to do the job that may or may not be needed. It is an
> > half-measure that helps nobody.
> 
> Let's not be too hyperbolic here.  "Worst" is entirely subjective and it
> totally depends on your perspective and what you care about.
> 
> There are basically four options:
> 
>  * Accept everything in early boot
>  * Accept with deferred page free
>  * Accept with kthread after boot
>  * Accept on demand
> 
> and four things that matter:
> 
>  * Code complexity
>  * Time to a shell prompt
>  * CPU/Memory waste
>  * Deterministic overhead
> 
> Did I miss any?

"Time to shell" is not equal to "time to do the job". Real workloads do
stuff beyond memory allocations. But, yes, it is harder quantify.

> News flash: none of the options wins on all the things that matter.
> We're going to have to pick one (or maybe two).  I'm also not horribly
> convinced that there's a problem here worth solving, especially one that
> requires surgery in the core of the buddy allocator.
> 
> This is essentially making a performance argument: it takes too long to
> boot if we go with a simpler solution.  Yet, I haven't seen any data.  I
> think we need to go with the simplest approach(es) until there's some
> actual data to guide us here.
> 
> Here's another way to look at it:
> 
> > https://docs.google.com/spreadsheets/d/1Fpv0Yp0CTF5_JXHR2pywvNtImTwUVGTxDMlJ5t8qiis/edit?usp=sharing

The link is view-only.

AFAICS, complexity of the kthread approach is on par or greater comparing
to on-demand. You need coordination between allocator and the thread.
It can be hard to hit right balance for the kthread between being CPU hog
and not providing enough accepted memory.

-- 
 Kirill A. Shutemov
