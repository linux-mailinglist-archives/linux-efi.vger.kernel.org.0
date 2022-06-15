Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B599954CC1D
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jun 2022 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiFOPDi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jun 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiFOPDg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jun 2022 11:03:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F293206E
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 08:03:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d18so13614273ljc.4
        for <linux-efi@vger.kernel.org>; Wed, 15 Jun 2022 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZUiH7xUjYjG63QUOQNlcHltjn5KoG/fwg1/o9vk8ew=;
        b=gmM5PYGKhtiKN/GQbdXDENmVjVligh9DIPiQkG8g9EDUaaAsjjHXs85qVkWWbbgi+B
         nszrQbXgZRqTwAgSVchLmIr1m8NPS9bv1EsKB+/xz7kNOjgnEcOt3TRr3ysREOzDAeRh
         bEnhDJ1ESjIS6/vP+qs+svbNVimu+a8X1ilLtTXxAt2+7vonJ+je4mAzwOZe0I5DBayV
         LaifTuCEM8AsEcmaD0lCMRhjg/POC/AoBLOb1N+6qWIrQl+g55UKPUvA0EgFMmu7yl4S
         ygVcSI0g+8rzQy4hxPbmjMblUCycMgOwWgGfW7dOebiG5auWZDOu0mAq02s1hm6IBcs3
         ipIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZUiH7xUjYjG63QUOQNlcHltjn5KoG/fwg1/o9vk8ew=;
        b=p69K49JEGtAQlMW9HssSGwT3Lbjio6G/I74xRyWWg5tPwTcuGLF4rgrj34jl2wolJ0
         MnY3Gpnz117scGRmwEKmTT/dVQG9q6ATfgzE45emskEI7jEAN6fscerWOXRDeapT5lpR
         Y0q8O4XJLPUGkphODO6K3mV7+ji7748pZvaDqbP5SYGnbOn6s4oUoirmhk7tsU5u4f7K
         7Ut8B3aJElKHxYnQXYEhZzYx+TEN65G1ZLjhcYjhHNZbysTbwuKY0/j7VC2a8GZX5d3G
         rWIkQjTJdacTt73coKRPG4V9Aiwk872RJdiYynIcb6xhM89vgT7lO3zGCO3NaqeBz0tT
         asWA==
X-Gm-Message-State: AJIora9oUhGTyk/NBuMLBmgbAhTykiovh7pmKtOuFvG6Noj/uPxQ4yc5
        dX1J/JQz30sngnCcrx6V/cVOcA==
X-Google-Smtp-Source: AGRyM1uaqkfz9EUjbtFXt3ETq72/vRGrVuX/XEUXnzqPAo5EoI+iVXmhnWWWeIjIy+Gowg+91p1KrQ==
X-Received: by 2002:a2e:22c6:0:b0:258:fd28:b253 with SMTP id i189-20020a2e22c6000000b00258fd28b253mr85119lji.418.1655305406697;
        Wed, 15 Jun 2022 08:03:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k13-20020a2e92cd000000b002556e77236dsm1670253ljh.62.2022.06.15.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:03:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EFD7A103B9F; Wed, 15 Jun 2022 18:05:34 +0300 (+03)
Date:   Wed, 15 Jun 2022 18:05:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 05/14] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <20220615150534.ylkref3runa4kmyj@box.shutemov.name>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-6-kirill.shutemov@linux.intel.com>
 <YqmyQZa4CTHkH3gT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqmyQZa4CTHkH3gT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 15, 2022 at 12:19:45PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 14, 2022 at 03:02:22PM +0300, Kirill A. Shutemov wrote:
> > Pull functionality from the main kernel headers and lib/ that is
> > required for unaccepted memory support.
> > 
> > This is preparatory patch. The users for the functionality will come in
> > following patches.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/boot/bitops.h                   | 40 ++++++++++++
> >  arch/x86/boot/compressed/align.h         | 14 +++++
> >  arch/x86/boot/compressed/bitmap.c        | 43 +++++++++++++
> >  arch/x86/boot/compressed/bitmap.h        | 49 +++++++++++++++
> >  arch/x86/boot/compressed/bits.h          | 36 +++++++++++
> >  arch/x86/boot/compressed/compiler.h      |  9 +++
> >  arch/x86/boot/compressed/find.c          | 54 ++++++++++++++++
> >  arch/x86/boot/compressed/find.h          | 80 ++++++++++++++++++++++++
> >  arch/x86/boot/compressed/math.h          | 37 +++++++++++
> >  arch/x86/boot/compressed/minmax.h        | 61 ++++++++++++++++++
> >  arch/x86/boot/compressed/pgtable_types.h | 25 ++++++++
> 
> That's quite a lot of duplicated code; is there really no way so share
> this?

Code duplication also make me uncomfortable. But that what Borislav wanted
to see. efi.h in the boot stub which copies bulk of <linux/efi.h> also
sets the trend in the direction.

Alternative is creating a subset of headers that can be used in both in
main kernel and boot stub. It is more complex and doesn't allow for short
cuts that can be made on copy if you know the context it is used in.

It also sounds painfully similar to uapi/ project. I'm not sure we want to
go this path.

-- 
 Kirill A. Shutemov
