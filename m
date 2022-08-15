Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80AF594D73
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbiHPBR4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiHPBRT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 21:17:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE091A801
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 14:08:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-32868f43dd6so103617167b3.8
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xtY8G2D96F+0+SkQlxIHRu/YzFBnO7oJKVZE1E2i6CE=;
        b=T+UlcDuGshW/Wrvb8I2bfsuqi3uLSo/KEj/2dcG1scaCe1BmCEp6nwWKtFOC+RKtke
         TFymD4X+iW7efPkL0lOEn9zP5UJ1cYBVAryMrp1hgBS6icx840NK8QKskBNX7wbAiEtF
         dW/QFugI1o7HbO4aznI9osl63Uk6yGlKz73Ib3mAuYRDGpbqXwYWATiQqIwVbsts1jW4
         UpMHoVFEmcJwpezxLr2Jm6nrIVF8UkSZ6oQWniKSbNTQFbKZQdLwARSUb5xvZbGS/FTe
         iNNO0jtAPvVo08Vx2EIZTwNXgjoxoSPyBg2hnXy9SazgSvr8GYOsq+RTnjPCnFbbSeYr
         Ercg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xtY8G2D96F+0+SkQlxIHRu/YzFBnO7oJKVZE1E2i6CE=;
        b=QpZDINfS87wACey+YwDgDkexZPGag+BafXr+oHNvTa/yd8/iuYNfH+FUKH/YORULAK
         hXIjbp/4Uw2oJEm3dxpX/IZ1wb6kUf9f+aJBkG3CF7PNKk77QAME1SzXuHYdgX4og7+L
         eGieuPf6Et31tnQNk6O/kjOqbr2IXzfGcOoqmai26BwB8OCn+U0w2+Wdq1cFc25bZex7
         ae1HxhxZiF3taufr5DhsGch6NFcfcyO117FYlTtamggIJGiZfvPAtL9CrVV17wh5Xs/q
         CVnxY0xkbnMWTIM+VdpNXVj0BN5PcbxskoOAbH9XqK0jiBZnsuGsNNOAOdd1YVOdUSxY
         a08w==
X-Gm-Message-State: ACgBeo1Vpedj3iW03swXRtyr37oZS30DWf7dQzzMRaC98Ufy9wiXJhQB
        vgsFkowrr1hFGrL8GDcFWApNatpU/aRPWicD2uhlKQ==
X-Google-Smtp-Source: AA6agR4/slEjKmTYAamIqy5YLABY94pTV9udVVsZlGMG1xpU/FxKXseywg2I31pPZvCw3WMb/rHSq4PunXVanyqOh0E=
X-Received: by 2002:a81:1b08:0:b0:31e:5f26:8ae9 with SMTP id
 b8-20020a811b08000000b0031e5f268ae9mr15210170ywb.155.1660597710276; Mon, 15
 Aug 2022 14:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com> <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net>
In-Reply-To: <20220810141959.ictqchz7josyd7pt@techsingularity.net>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 15 Aug 2022 14:08:18 -0700
Message-ID: <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

>
>
> The unpredictable performance of the application early in boot may be
> unacceptable and unavoidable. It might take a long time but it could
> eventually generate bug reports about "unpredictable performance early
> in boot" that will be hard to track down unless accept_memory is observed
> using perf at the right time. Even when that does happen, there will need
> to be an option to turn it off if the unpredictable performance cannot
> be tolerated. Second, any benchmarking done early in boot is likely to
> be disrupted making the series a potential bisection magnet that masks a
> performance bug elsewhere in the merge window.

I'm doing some boot performance tests now before I run some workload
memory acceptance latency tests.
Note that this testing is on AMD SEV-SNP, so this patch series on top
of the AMD guest patches v12, plus a
patch Brijesh Singh wrote to define __accept_memory for SEV-SNP
https://github.com/AMDESE/linux/commit/ecae2582666d50ce1e633975d703d2f904183ece

I was getting pretty consistent boot times, only going up slightly as
the memory size increased, but at 256GB, the VM crashes because it
touches some unaccepted memory without first accepting it. 255GB boots
fine.

The stack track is in mm/page_alloc.c. I've done a little
investigation, but I can't account for why there's a hard cutoff of
correctness at 256GB

[    0.065563] RIP: 0010:memmap_init_range+0x108/0x173
[    0.066309] Code: 77 16 f6 42 10 02 74 10 48 03 42 08 48 c1 e8 0c
48 89 c3 e9 3a ff ff ff 48 89 df 48 c1 e7 06 48 03 3d d9 a2 66 ff 48
8d 47 08 <c7> 47 34 01 00 00 00 48 c7 47 38 00 00 00 00 c7 47 30 ff ff
ff ff
[    0.069108] RSP: 0000:ffffffffad603dc8 EFLAGS: 00010082 ORIG_RAX:
0000000000000404
[    0.070193] RAX: ffffdba740000048 RBX: 0000000000000001 RCX: 0000000000000000
[    0.071170] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffdba740000040
[    0.072224] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000000
[    0.073283] R10: 0000000000000001 R11: ffffffffad645c60 R12: 0000000000000000
[    0.074304] R13: 00000000000000a0 R14: 0000000000000000 R15: 0000000000000000
[    0.075285] FS:  0000000000000000(0000) GS:ffffffffadd6c000(0000)
knlGS:0000000000000000
[    0.076365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.077194] CR2: ffffdba740000074 CR3: 0008001ee3a0c000 CR4: 00000000000606b0
[    0.078209] Call Trace:
[    0.078524]  <TASK>
[    0.078887]  ? free_area_init+0x5c1/0x66c
[    0.079417]  ? zone_sizes_init+0x52/0x6c
[    0.079934]  ? setup_arch+0xa55/0xb6d
[    0.080417]  ? start_kernel+0x64/0x65a
[    0.080897]  ? secondary_startup_64_no_verify+0xd6/0xdb
[    0.081620]  </TASK>

>
> --
> Mel Gorman
> SUSE Labs



-- 
-Dionna Glaze, PhD (she/her)
