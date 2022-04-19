Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8205071CB
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiDSPbL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiDSPbK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 11:31:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4313F2B
        for <linux-efi@vger.kernel.org>; Tue, 19 Apr 2022 08:28:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y11so3431977ljh.5
        for <linux-efi@vger.kernel.org>; Tue, 19 Apr 2022 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPYkjAqB00Xxjikyucyrlisswxv3Uu4wKk4/LnVwWm8=;
        b=ET2dFk9aXbq+2du32xy0VJqQN1YDmZMLNM/xlOZkTY4XHyGVyzEkvOVxE5UmMLn+Wp
         YExIWYqo2rtEyCEv7QIXQpM20AA/xQeiAysy34JEPURNAMpqA3JBsOu604Lh2hPw+5/c
         E8hHPr0WCvb8dYnwnsNbVYuWCbGAv89QMKUDiEDqUFibiIWuzAAUPttZxNrbO1S9BV0s
         pzFdWnmFKbNVmXjSAKIB3rCAgGPKQ4U8YVKtVEgIrKpuK3oVlT8ntMSJQx+py4vFhPCq
         X8dRTTTGhxkUJqDhgSE8/4qnvNyK9Eg09cY3Oj7ufQ+uVc9YgodTclsGipgsgT1AZ5Nm
         BdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPYkjAqB00Xxjikyucyrlisswxv3Uu4wKk4/LnVwWm8=;
        b=xAl3rcbjFgu0jLyWiWBh8UzIjzqjnt1HZFFBmNO2OjyzpiAthJ3lz53+BEJljS8J6Y
         w2s9SdVKLlkFj17b21P85JG5QjvAGw3WfkN96cL+Xb3aBOjp3whoTLSm7Lz8DPgwyjMl
         l1C3g13raJ4UYmKAvrjn78zaNolFHRt1MiOxA1He6zppK5+SURKseAImu6M3HKQqhjv8
         pXWcSL9vICFWJLvkBUhnWtlRFL9Rql2SWOzaADwIN2NuvVY920RzOBL4grm25kNVSReh
         eri83g6/ohokk0oqXI8nxTcimV4WN4T5s93FreWSjkR9aA0nk9z3HCgrIElWDiUB3jxr
         sIeA==
X-Gm-Message-State: AOAM532MEBAXXfqQI1uBrz/BIc9/SqQOpdbhOv7H8T7OVfiSkFNiCA79
        R24A02gSujjEjp2yeBu4r3gC9xaMNNKWz9GE
X-Google-Smtp-Source: ABdhPJxFgaQNwsrkGsQvpbSc49Nh0VBtkIBJACRSpLsWn2p7SstiY+esd57CVUrx8BbP8cSpEJr3cw==
X-Received: by 2002:a2e:84cc:0:b0:247:e395:7948 with SMTP id q12-20020a2e84cc000000b00247e3957948mr10253293ljh.499.1650382105629;
        Tue, 19 Apr 2022 08:28:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e5-20020a196745000000b0046b8b922c1csm1543311lfj.158.2022.04.19.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:28:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 140FE103C63; Tue, 19 Apr 2022 18:30:02 +0300 (+03)
Date:   Tue, 19 Apr 2022 18:30:02 +0300
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
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
Message-ID: <20220419153002.ffh2ybdl7x2mm7zw@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
 <Yl5nSSC4HpSWqfY7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl5nSSC4HpSWqfY7@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 19, 2022 at 09:39:53AM +0200, Borislav Petkov wrote:
> On Tue, Apr 19, 2022 at 02:50:15AM +0300, Kirill A. Shutemov wrote:
> > I find it strange that you go after <linux/bitmap.h> which has limited
> > exposure while <linux/acpi.h> and <linux/efi.h> are there already.
> 
> Funny you should mention that:
> 
> https://lore.kernel.org/r/YlCKWhMJEMUgJmjF@zn.tnic
> 
> I *have* been working towards that but it's a losing whack-a-mole game
> when you and others keep adding new stuff.
> 
> So no, we won't take a pile of changes and let the maintainer clean it
> up afterwards.
> 
> > What do you want me to do here?
> 
> I think the stuff coming from the linux/ namespace you can simply copy
> into a header in compressed/, like I've done with efi.h.

Hm. Dave was worried about having copies of _find_next_bit() and
__bitmap_*() inside compressed/.

How do we rectify code duplication and making decompresser self-contained?
Do we care about multiple copies of the same code in the kernel?
Do we care about keeping them in sync?

> > // <asm/bitops.h>
> 
> The asm/ stuff can be put into a shared/ namespace header like the io
> stuff you did.
> 
> > As 1 bit represents 2M, not all chunks can be represented in the bitmap
> > and they have to be accepted. But the *goal* is to record unaccepted
> > memory into bitmap. Some accepting is a side effect.
> > 
> > The early_accept_memory() name is just wrong.
> 
> Ok, how about process_unaccepted_memory(). It should be generic enough.

Sounds good.

-- 
 Kirill A. Shutemov
