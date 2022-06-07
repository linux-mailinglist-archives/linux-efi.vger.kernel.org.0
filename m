Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95655405EA
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbiFGRcS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiFGRbX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 13:31:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9311CA3B
        for <linux-efi@vger.kernel.org>; Tue,  7 Jun 2022 10:28:50 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y188so2793682ybe.11
        for <linux-efi@vger.kernel.org>; Tue, 07 Jun 2022 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5Ny4vgpruxYpshg53Ln1+iWeupUNnsukjnUC5UYdOM=;
        b=BBJq9HytOh8xqxG1MIN1sKtwK93Z7XU0MrDJECq3md+sm3yv1Xd5ltQXskFQhI9cME
         iqcZ9LmhLZmyYaUghSjx79Y3A9LnqA8BoWAQaDvZPU2hEkMar5IWHpM6xzZg/BYj/SOO
         pKQokFSBBVEHE1fF81pZ9o0aayaFRGoalN4PoaGghXIx66v8ke+Qu8TkXYoVgIg1Whi6
         Y41JGO1oBbH2l//UapjVIss2VHKyFlwqVipz08haTjCsWor+ebXOuLOQN1ZFmGxHwTzk
         8Ls8CmFF+wACLiX04kX8dUmr+Drp1mnOCz/GLvyFC6jMMGeARI1pnpk6sT2ZJ5OBPKPU
         4Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5Ny4vgpruxYpshg53Ln1+iWeupUNnsukjnUC5UYdOM=;
        b=0kIzZBvwR80ttaTPsp4mFmkUylHuS5P5GvzLzEyi5QK6mzbPognm9Fq4Q7a603XGtL
         LGi8VPpILqB2btncxplmHYYLReT01Yu9lSItPTBzc0g6Zp6VITu0wIB0+9YhM840kXsc
         /+0OTNcUXxIJhjOlxf24P2IuldRrvLeLLK/M5pKSdOaHpsiMiqQyQCTG8vjUJ2w19GtC
         FKAd4lT71ySfJD4X17QxhXKohDjpxAK++XncsivkyFbgzu7z0BSQqLoTpnKSHu/ols+/
         qB6EvJwcFCarbt0K3TtPDRsBPILIdv1d84a66un3lN9dFKFClc+LLPEAOEboV9D6Vcap
         EMMg==
X-Gm-Message-State: AOAM533IUyFEkN0AQy48ZyhEfLmPPseffIgJG/eZ68vOLv0spOAUYwYq
        J8IYQzSRBYp6rna8gTwf68knlc7ucjTFo/aJrxmIEg==
X-Google-Smtp-Source: ABdhPJyCEAFCNtMQmhR5UYxtFrfEzTiCy9SVm2wDE9nWaR1to3z/P80hc9CgpRNlzwlULqatodrIZhEznz2u+MaX8VE=
X-Received: by 2002:a05:6902:2d1:b0:64d:de34:b776 with SMTP id
 w17-20020a05690202d100b0064dde34b776mr30363589ybh.215.1654622929315; Tue, 07
 Jun 2022 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com> <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name> <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic> <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com> <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
 <19ac7bbc-82f1-8350-8638-163303d682b1@amd.com> <CAAH4kHbPyCAxwQgqPpgDQ3bEioHZ+WboUMGTHazxC9f9jEEwWg@mail.gmail.com>
In-Reply-To: <CAAH4kHbPyCAxwQgqPpgDQ3bEioHZ+WboUMGTHazxC9f9jEEwWg@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 7 Jun 2022 10:28:37 -0700
Message-ID: <CAAH4kHYn=pyFC8ZZ08hY0rBDL9g4XBnxbMVXtwdju4qCLMetuA@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> free -k parses /proc/meminfo for MemFree and SwapFree in
> /proc/meminfo, so it sounds like it should also add in UnacceptedMem.
> We'll try that. Thanks.
>

Testing error on my part. Was using an adaptation of an old patch set.
With Brijesh's SEV-SNP support adapted to this version on top of
SEV-SNP guest patch series v12, I have no trouble with passing our
memtouch test.

Reference: https://github.com/deeglaze/amdese-linux/tree/v12unaccepted-v5

-- 
-Dionna Glaze, PhD (she/her)
