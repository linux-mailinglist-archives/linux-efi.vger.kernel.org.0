Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86F5170B2
	for <lists+linux-efi@lfdr.de>; Mon,  2 May 2022 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385382AbiEBNmY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 May 2022 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385341AbiEBNmX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 May 2022 09:42:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E7DF19
        for <linux-efi@vger.kernel.org>; Mon,  2 May 2022 06:38:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq30so25333181lfb.3
        for <linux-efi@vger.kernel.org>; Mon, 02 May 2022 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DcMGZbv7z3p/v1eaiOcddW90mQtWVDMmjqmh18TpdpI=;
        b=UGAWAyJUXoavkDZu/6uiyPyXQTdFJov3kbe74IyPdqB8tJNB1DkzhUq18MRTgb7Geg
         J1Vpjhyolal+iggBoo5jcEznptqbOvyFBOWCfImJ+5EcVzC20xDOZ8Ve6PAuXTafyIas
         0pLWBUR2ievavlNtXwDxDcP5QZFb8k6nNyibG8HKsPGqBEmZSMaWqKSz1uoFDUkiT22v
         N8nqHaek4ehCqRhJn6rBX30mRbm3knHnTzXmMrPhz5xXFRSI2jjOtq9zbx2ILyrGQagv
         yQRRnzHGMfswyQfLASHEEUMggmLvmdnRge0KT78jvbMsxyU29Cy5spwAxnapnip9DhJQ
         UXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DcMGZbv7z3p/v1eaiOcddW90mQtWVDMmjqmh18TpdpI=;
        b=ZuIJloPxnvymPD6aHZpfarROcJiIkfB8MqBfrWHzVItIBD2ZFu0tLCpKOeJJsRrG+J
         PgH/4Qj4JsneLo+/XbwYKtDYfqBOZKUJR4tUolvJr76FkuS4kBXRrem7fwuBNgvjBPzu
         wrEwwS4FLUnq0OR5S7oUUq7NVT1Rw4F3nTsmGC7QpjEkjEDqwKRU/s6wXEOSuRQIee7U
         egkEKZzdQ8Gkqqz9Z71wo9TYZElnZLLVFPKhnC28OXd1CC8joDMijfATiOQ8q5ST0ZeM
         6/e5QwUs+Pecdd1Ze/7v5bxZ+qe7OL/awUbAI+aiooNW6boj9faWWSSWfzIz5lqAzjQj
         TDCQ==
X-Gm-Message-State: AOAM533NXp0PvnXCYQgiwXpKdGg6lBMJiO0+cQ4KzBuBjM4mDQ9EpRiy
        sMDSyENsnaAlXbSNw2L8bncPtQ==
X-Google-Smtp-Source: ABdhPJwKLan9oIQwmL4/yFUO5pWv5jwZqmLJ0VZW89luPSjNXnrV7OWnfCjA79YKn2buk4EZYnbTPw==
X-Received: by 2002:a05:6512:400e:b0:450:e09d:c9a6 with SMTP id br14-20020a056512400e00b00450e09dc9a6mr9413485lfb.243.1651498728392;
        Mon, 02 May 2022 06:38:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e86d5000000b0024cac53a82csm1046025ljj.0.2022.05.02.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:38:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F1167104AD8; Mon,  2 May 2022 16:40:31 +0300 (+03)
Date:   Mon, 2 May 2022 16:40:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv5 05/12] efi/x86: Implement support for unaccepted memory
Message-ID: <20220502134031.roylivc3icazuk5h@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-6-kirill.shutemov@linux.intel.com>
 <YmvDqgcyKOgLYNrT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmvDqgcyKOgLYNrT@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 29, 2022 at 12:53:30PM +0200, Borislav Petkov wrote:
> > +	/*
> > +	 * If unaccepted memory is present allocate a bitmap to track what
> > +	 * memory has to be accepted before access.
> > +	 *
> > +	 * One bit in the bitmap represents 2MiB in the address space:
> > +	 * A 4k bitmap can track 64GiB of physical address space.
> > +	 *
> > +	 * In the worst case scenario -- a huge hole in the middle of the
> > +	 * address space -- It needs 256MiB to handle 4PiB of the address
> > +	 * space.
> > +	 *
> > +	 * TODO: handle situation if params->unaccepted_memory has already set.
> 
> "... is already set."
> 
> And when is that TODO taken care of? Later patch or patchset?

No, not yet. kexec is not a priority at the moment. It will come later.

-- 
 Kirill A. Shutemov
