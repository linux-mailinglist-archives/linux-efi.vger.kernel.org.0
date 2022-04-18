Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE2505EDF
	for <lists+linux-efi@lfdr.de>; Mon, 18 Apr 2022 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiDRUZi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Apr 2022 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiDRUZh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Apr 2022 16:25:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BF2ED51
        for <linux-efi@vger.kernel.org>; Mon, 18 Apr 2022 13:22:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b21so25925138lfb.5
        for <linux-efi@vger.kernel.org>; Mon, 18 Apr 2022 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLWlEzJdMk6tuaRzUj9I+DP1OAyBtJ6ETvbVsO93HOU=;
        b=yZIHcmsAVppuK5qGX6G7Ih1KsaYwCGYPWcLwUZ27iXpxzXC8ZDAaHgGx5sYhn9MaCP
         xmLMaguzDZIuQDxf+3nkkYN3A5yqEEx48BjaZ0e6az1nMfgAklIa3Os763c4R+X+N6el
         QaYjjkSK2R8mjyRoG2lpWhBp5IOolBIOsRov4CLNh+OfkZDYKvgvTneU6MFu+rau3Wk5
         bkLeeQKm54yRp+3IuYfgQdJwuNhEovhToYoM9FNb4pNcSLZ+NSYUtbPsqQS1mvxdlUPN
         2InIBy8S//cm7hYkWhSU5Hk0FsYBts2vpIF6rafJ0L7gGOIfM+MEvGH3gfvM57loO7W9
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLWlEzJdMk6tuaRzUj9I+DP1OAyBtJ6ETvbVsO93HOU=;
        b=nE138veozAuUiVZhPIMRv0sax8HRHLLP0Ziy73T3MkVY0QFLTyuF2cDta3nYynyuNK
         dIl3b1qRds6oCe7KpWLpZDlQCzz/l8SIqtYTQ5TWfphaxuX/NkORHywlMbfQfFwl5Y/g
         8+DHND+jtVWom/MJjhMaaZ44ygIo+PwqXb+0qo/9QtyAxKSp7HSt9LjfzxU3X+VoIKwM
         iqLwQBj2dZ7HleOjhH/IKzRXdD5psobY1k4m1DLL7PonefxeZ7wHkYnOpq9Ja56pdCxX
         6rpkwBoq6DTbA9NrHmboZgW4MSZyrTeiB64GiqB+7CS0oIySXV1VyxTx+nw820n8wqgp
         t7tA==
X-Gm-Message-State: AOAM5327YFcjoPBPA8WsK285vXE3iMlsuNYVUYoxKd7QwWmvkwtlcnlY
        KeGXUSY+MiWFYR6oq8fNMdCrlg==
X-Google-Smtp-Source: ABdhPJznQzqX7bRzuIcLKDjKwu+NX1wiOv40zQz/yldUBixOb1SSMsMrFJrGumBZeV0L5NkatxL6aw==
X-Received: by 2002:a05:6512:ac9:b0:470:e6d0:1bd8 with SMTP id n9-20020a0565120ac900b00470e6d01bd8mr7300071lfu.614.1650313375515;
        Mon, 18 Apr 2022 13:22:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1-20020a0565120c0100b00447a7c10e4dsm1313059lfu.31.2022.04.18.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:22:54 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 64BF5103A61; Mon, 18 Apr 2022 23:24:31 +0300 (+03)
Date:   Mon, 18 Apr 2022 23:24:31 +0300
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
Message-ID: <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl2UHOQ4iZJ29k0q@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 18, 2022 at 06:38:52PM +0200, Borislav Petkov wrote:
> > Could you explain what rules are?
> 
> Library-like stuff like types.h, linkage.h, etc we could include for now
> but including linux/kernel.h which pulls in everything but the kitchen
> sink is bad.

<linux/bitmap> doesn't include <linux/kernel.h> or similar things.
Is it okay for now?


> > Hm. accept_or_mark_unaccepted()?
> 
> What's wrong with early_accept_memory()?

But the goal of the function is not to accept the memory, but mark it
as unaccepted in the bitmap. Your proposal is more confusing, not less.

> > > Immediately? As opposed to delayed?
> > 
> > Yes. Otherwise accept is delayed until the first allocation of the memory.
> 
> Yes, put that in the comment pls.

Okay.

> memory, but it is not
> > 1:1 match. Unaccepted memory can be present without memory ecnryption if
> > data secruty and integrity guaranteed by other means.
> 
> Really?
> 
> Please elaborate. I thought memory acceptance is a feature solely for
> TDX and SNP guests to use.

Conceptionally, it is just memory that requires additional action before
it can be accessed. Yes, at the moment TDX and SEV are the only users.
It is implementation detail that TDX and SEV use memory encryption.

> > <asm/mem_encrypt.h> is very AMD SME/SEV centric.
> 
> So?
> 
> > I'm not sure it need to exist in the way it is now.
> 
> I'm not sure what your argument actually is for having yet another
> separate header vs putting it in a header which already deals with that
> stuff.

Because I don't think it is a good fit. Frankly, even <asm/coco.h> fits
better, although I'm no a fan either.

Do we have file shortage? I would rather keep it separate.

> > Okay, I will move it into a separate function, but it has to be called
> > from allocate_e820() because it allocates and free the map.
> 
> You mean, you want for allocate_e820() to call this new function because
> both allocate and free?
> 
> Might have to explain what you mean here exactly.

Both allocate_e820() and handling unaccepted memory requires access to the
efi memory map. We only need the size of memory map for e820, while
unaccepted memory requires walking the map. We can serve both by
requesting the map from the firmware once. It requires allocation and
freeing memory for the map.

Makes sense?

-- 
 Kirill A. Shutemov
