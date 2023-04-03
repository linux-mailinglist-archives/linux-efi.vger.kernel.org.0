Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA36D49D9
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjDCOlw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDCOlw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 10:41:52 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A4017AFC;
        Mon,  3 Apr 2023 07:41:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7FC7F3200988;
        Mon,  3 Apr 2023 10:41:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 10:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680532908; x=
        1680619308; bh=gznKa3yGoCt8Goz7+aNTxbO0je1v7BnetZnQWLBv3m8=; b=o
        TMzF3h8fqD4Hr+u+SGzGA0Ur8/Y9/Q3c4AroJGsrzhp4CXEXhjDFvHF2D7Ga4JO0
        0mTvQAy+T6cULh0bota0uXvyC/4XBLkbcVGLofAiJwZ+NNDNqXa2VDxnXaKwEoMy
        RvCoSbvfOo1WqsA5DnvD/Tir9EteclNV0b29Cs89PpUZ07AzJBbi7I/4cV3YoPZr
        UUPYfkU3Udzi+8lmmL64Xvm17yOUVvJvNHnn7CFFG/WzAGdg6ldrFqbykEDavhBv
        Q3CGSj78QyAbRM7a63UuNHbX1tfl5iOu7Ta542SCXiuT4CZpfGFGi6PKWdn+HPoO
        PswQfqT4BUuywllAqtq9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680532908; x=1680619308; bh=gznKa3yGoCt8G
        oz7+aNTxbO0je1v7BnetZnQWLBv3m8=; b=bShkCqZGwS8zZdhXEPHQ3r7MVQ8bx
        hnsGYGDvOjuEQOzHg109pbmfwEumWtDJqakrlDry6IrpCOnOTL9RtAGkhs6IYGty
        Ao+UQq+ACegOHgkQrBqw8cgfb8m4naRsPto1xPRqVU9wZ0qcIuR+NMvo+XmYX8cM
        Ka0I+BS58Wec1nb4iiXMgBSGuo+XMW1bTn54B8GlRRwz0Q/n7omrMPI+UEdWmW4e
        2IJpXRxTxISwm+STIgF4YPISYem1K5Cb7NloDeFLl3Zdo238yvPOdCZRzDkaiJ/v
        08QTXzvw22othm6tqHDgOq9J5xo7L/0DzgGrGksg8N0DINQMm4sZnwTJg==
X-ME-Sender: <xms:q-UqZFPWOjPmyuthpKHN0aVg57ao-2qg8oRrOenYiHZlxRqgdeKIng>
    <xme:q-UqZH_vFYPpH0QLX696cqgZAgPn2ZXJx_SWPChdQ9mCi9CZw8qKBa9PNk1wDRkh2
    ONvY5f74MGVohXg1i4>
X-ME-Received: <xmr:q-UqZERr92dmZDBZlZEKLvYtcWlPdxLYYVdgLTawY09j56j-Uklx6AdAAAXf3uDmJrm2bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:q-UqZBswS661F4t4lfp7xhOMCCtggYM-DhBxOhrAINANc9e9AthhcA>
    <xmx:q-UqZNeBY8JkuDRX1MqJBE35XLU-QRIfhPs5ygpjE_4jCsMD7vLkxw>
    <xmx:q-UqZN0OINDMQS7vtEJKu0vH0nD-TByna4pmReKqiQm5I0hbPF9abw>
    <xmx:rOUqZJogSkHGBd6YCXCIQdgfK6kg0TIXg0dS1kT-5qmaCprKED2DBw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 10:41:46 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 29EE210D7B3; Mon,  3 Apr 2023 17:41:45 +0300 (+03)
Date:   Mon, 3 Apr 2023 17:41:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 04/14] mm/page_alloc: Add sysfs handle to accept
 accept_memory
Message-ID: <20230403144145.wss3nudvyyd4xtih@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-5-kirill.shutemov@linux.intel.com>
 <4c319a60-c1fb-fe43-65be-9729f0261dab@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c319a60-c1fb-fe43-65be-9729f0261dab@suse.cz>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 03, 2023 at 03:43:32PM +0200, Vlastimil Babka wrote:
> On 3/30/23 13:49, Kirill A. Shutemov wrote:
> > Write amount of memory to accept into the new sysfs handle
> > /sys/kernel/mm/page_alloc/accept_memory.
> > 
> > Write 'all' to the handle to accept all memory in the system.
> > 
> > It can be used to implement background memory accepting from userspace.
> > It is also useful for debugging.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Somewhat similarly to patch 3, I'd think we don't need this patch in
> mainline without clear usecases first, although it's good to post for
> testing/debugging.

I thought about it as a way to implement #3 from 02/14 commit message:
users who want to accept all memory in background can use the mechanism.

But, again, we can leave out until later.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
