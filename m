Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937652A989
	for <lists+linux-efi@lfdr.de>; Tue, 17 May 2022 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351579AbiEQRpX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 May 2022 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiEQRpV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 May 2022 13:45:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CF4EDD4;
        Tue, 17 May 2022 10:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC11EB81B36;
        Tue, 17 May 2022 17:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C64C34117;
        Tue, 17 May 2022 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652809518;
        bh=Wkrtqr3rOaqaCRASAupK7gEG4fgoea9JOZy/ydbtpwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbMyTYFNAzvAJn7IBKycNxoYEW2j/SSGDuhFClpvpe2tJR3JK0H45xtb43rFwZVUO
         IK24yWGmXP+e5qXaBjsNhFUIFPrV4Xw5PR8hJIQCWBceIJDVhe7rc7Op+uK+nEYi7l
         OuYwpkwYCo1hTv5qVPZBX8Bc4l6WXxS8jFAR04eY=
Date:   Tue, 17 May 2022 10:45:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv6 02/15] mm: Add support for unaccepted memory
Message-Id: <20220517104516.16fb0be5cb28153104b80654@linux-foundation.org>
In-Reply-To: <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
        <20220517153444.11195-3-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 17 May 2022 18:34:31 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> ...
>
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -928,6 +928,14 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PG_offline	0x00000100
>  #define PG_table	0x00000200
>  #define PG_guard	0x00000400
> +#define PG_unaccepted	0x00000800

"For pages that are never mapped to userspace (and aren't PageSlab),
page_type may be used."

Is that true of these pages?

