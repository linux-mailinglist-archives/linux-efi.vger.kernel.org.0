Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220B35170A5
	for <lists+linux-efi@lfdr.de>; Mon,  2 May 2022 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiEBNkI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 May 2022 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385368AbiEBNkF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 May 2022 09:40:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306115702
        for <linux-efi@vger.kernel.org>; Mon,  2 May 2022 06:36:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w1so25293064lfa.4
        for <linux-efi@vger.kernel.org>; Mon, 02 May 2022 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sPNChsGYk7kHE/rCDooMX11EJCDPE+Ox4AJuqojjAS4=;
        b=oMyzTIQDDDkGSqMMk6jcH3Jg3mOWazFOFwqR8EyExlL855INKMIuaBkCZwvdgRpQSD
         biuD4BmyhgnU+ANzhEkwdNHyFuPiASTFGfXH7JoHfMhBtseilEctTctKHd1Z5QYpIeyh
         XCBKI9nH1N78fYzf8GPhsTsXjmLO8rakFYZrfwhEpi9DGSBHuyM7Kyzd7RCTX53lpQV2
         AAgicbO0zVpm57tZpTUKqHTOhO/EJQ9lQ16JCpzBQasFSbKey6Q9NKDvke2t9g+Su53U
         XrVFnmOMFo0w1Fu6ajlfu9QgB04IgkrRWFpyWkdh+dnaXEjEmg6QDV7a4CYqhpLi/K7r
         jzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sPNChsGYk7kHE/rCDooMX11EJCDPE+Ox4AJuqojjAS4=;
        b=M7Pyy2C1DTPutK/mRGDt3ebimL1wP/NtudRzKA8nkn4hbEedK04wq6rvvOkF943XUZ
         72B4Uum8X4aZqg51b04hCAwhp8uajNDcjBCiFD486hq+jltdjSMayw9hjlEtWGj7llV7
         lMajTTrbcyDyGsJLLg+2MKhYPpadRoGRyU+enNSI+HDIlq0b7mhQbQGYMMLfceQgIOhH
         5o/xCT2UDXAybfPHzHiyGiOJqpXx81WT1qNGbbKtOV4VRpcw4e6LaQ94LxvOofJQj1Bx
         tl8NrFb04Cdt6KgTug3PhRoRkw/xMnrGqSt+zdUwy91Db7SIjeUGD6JfeXUgN7U7GW/6
         e8Rg==
X-Gm-Message-State: AOAM531wx1bVVt7yJMqr9DGs6MrPICB8N00MLu4pzu0HvJRzX7FTmeMO
        UWASxkQpMBmFuVr0XrVohaqgQQ==
X-Google-Smtp-Source: ABdhPJxn5B/JuXc6CCfatjGdv/+EBL9v9FlbJORmKz12IPtE+wybn1otAHjNPLgeBTtopFpf2dEoaA==
X-Received: by 2002:a05:6512:3986:b0:472:4f5:33a0 with SMTP id j6-20020a056512398600b0047204f533a0mr8679514lfu.341.1651498587285;
        Mon, 02 May 2022 06:36:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18-20020ac25d72000000b0047255d210e2sm704383lft.17.2022.05.02.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:36:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6096C104AD8; Mon,  2 May 2022 16:38:10 +0300 (+03)
Date:   Mon, 2 May 2022 16:38:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wander Lairson Costa <wander@redhat.com>
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 04/12] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <20220502133810.gvmaqxvspzdvzrhv@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-5-kirill.shutemov@linux.intel.com>
 <YmvExncBpvDdfTjd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmvExncBpvDdfTjd@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 29, 2022 at 07:58:14AM -0300, Wander Lairson Costa wrote:
> On Mon, Apr 25, 2022 at 06:39:26AM +0300, Kirill A. Shutemov wrote:
> 
> [snip]

As I said in the commit message, all that code added by the patch is copy
of the battle-tested code from the main kernel. I'm not sure what the
value of these review comment. Hm?

-- 
 Kirill A. Shutemov
