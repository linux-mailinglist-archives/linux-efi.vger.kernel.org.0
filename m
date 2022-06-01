Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95153A95A
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbiFAOo7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345826AbiFAOo6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 10:44:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146584D9CF
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 07:44:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y29so2243956ljd.7
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LvrIFqHHGXUVgoifCY/oFu21MGkFJUkJFZqNI+NbYR8=;
        b=yUdMxLaD0W66OdCYioHhoD9gW6M1g+oPiTwhz8QjBPsmhZRk+xpyKrrZYMwaBI5XQw
         jZF29wuwBsRx9N/Ef1/0c3+T4sWHE9lfvTYgEsiMHIG8hfjDoNd7eBMVEOq+EIbYfQuq
         9lroUnnbox8DbJ4OUbkF5AFRgPeJFaJ1g5LJcEaThvWz1dkS1fHiHSeV4xE5gOEIuLHP
         WlEqu0rJ8yR1wISJEvp2oCUG3dcfqARrIGtk4Mh6RoKRDLOnG4pjqMoIAoBV5xrkNfba
         ZHu59dGJs7depH3ibMoOoWZRMc0pm9M3SMCETLJJIkFFmHwmz8JyPj1ES6NBP8fjhql2
         x2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LvrIFqHHGXUVgoifCY/oFu21MGkFJUkJFZqNI+NbYR8=;
        b=4Z/S8+1UUTNdj1haH4mM6tyHfyiO91L1DlEczayt5ccCitY/ZLsZrHvidPteTYSyPr
         WaKfNEHq6g6xoL6mX1kYIwgV1Qs+zKoW/BsGLkP94ze6IGw1Uetx/i667l19dpfySqjR
         x4O3FaauK8y0zLeIaxmAgFo3GNRC0q9W2Lk6uY/xdrnB2I3Hd97jLPvfSXVJj41OFddz
         YlKhtCpGV0gDfBjUL+JA5DjbZRwL0DzKFy6w9/SshMDCAFOJ88wFC7xES5Itus/03Aye
         hF0VNwW6d0TEaRS8+sqYqR5/rNH1GiMJch42tShmeB5vSP51f56DvO2AVeBi9F7sPRRy
         SDrQ==
X-Gm-Message-State: AOAM531lw2MLVtQgx3/6LBthlGeHn29Qn3ZLmiJlqOGOxy6qAdib7KPJ
        7LFmaup7jCOxuu7FkRtAG9BGHQ==
X-Google-Smtp-Source: ABdhPJzwTyr7jGZX5uox6FLAvsLwDvePrH2SadM33Ry+s6biX0Ay2qFGDYwW40N2obLPeLIf7Sxg4Q==
X-Received: by 2002:a2e:a176:0:b0:253:dbf1:b023 with SMTP id u22-20020a2ea176000000b00253dbf1b023mr36240386ljl.421.1654094695470;
        Wed, 01 Jun 2022 07:44:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h10-20020ac250ca000000b0047255d2119fsm397178lfm.206.2022.06.01.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:44:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E21D6109789; Wed,  1 Jun 2022 17:46:54 +0300 (+03)
Date:   Wed, 1 Jun 2022 17:46:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
Message-ID: <20220601144654.jtp6t2c6u4su4gwd@box.shutemov.name>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
 <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
 <20220601143515.iavmtysdchirbtel@box.shutemov.name>
 <116f7be4-7b75-a83b-899b-c23b52534b30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116f7be4-7b75-a83b-899b-c23b52534b30@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 01, 2022 at 04:39:16PM +0200, David Hildenbrand wrote:
> On 01.06.22 16:35, Kirill A. Shutemov wrote:
> > On Wed, Jun 01, 2022 at 11:00:23AM +0200, David Hildenbrand wrote:
> >> On 17.05.22 17:34, Kirill A. Shutemov wrote:
> >>> Currently allocate_e820() only interested in the size of map and size of
> >>> memory descriptor to determine how many e820 entries the kernel needs.
> >>>
> >>> UEFI Specification version 2.9 introduces a new memory type --
> >>> unaccepted memory. To track unaccepted memory kernel needs to allocate
> >>> a bitmap. The size of the bitmap is dependent on the maximum physical
> >>> address present in the system. A full memory map is required to find
> >>> the maximum address.
> >>>
> >>> Modify allocate_e820() to get a full memory map.
> >>
> >> Usually we use max_pfn, if we want to know the maximum pfn that's
> >> present in the system (well, IIRC, excluding hotunplug).
> >>
> >> How exactly will this (different?) maximum from UEFI for the bitmap
> >> interact with
> >>
> >> max_pfn = e820__end_of_ram_pfn();
> >>
> >> from e820 in existing code
> >>
> >> ?
> > 
> > I'm not sure I understand the question.
> 
> Essentially, if the PFN you calculate here for the bitmap size will
> essentially match later max_pfn.

Yes, generally. But is can decrease if kernel transit memory from TYPE_RAM
to TYPE_RESERVE. In any case we will not step out of the allocated bitmap.

-- 
 Kirill A. Shutemov
