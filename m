Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75F705A01
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEPVxt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEPVxs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 17:53:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709572AA;
        Tue, 16 May 2023 14:53:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5195232004ED;
        Tue, 16 May 2023 17:52:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 May 2023 17:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1684273932; x=1684360332; bh=1mTVN0zWdMUI2lVaj0xdpaB12
        1fz73d+fGcmjELhUZk=; b=Kl0XuJ/7rIR0raL3yWB6485sHqvMnmL2RGcc3l/D9
        XK1ozRr20oXtM/pkqnBga8x4OZiLPdkuPeTcya8KxrKOuPaNK5iHbd4Z1EfybFu3
        0DDU9lqBFLxnxgs2FIk0IkREbJWAQj8SQu69lVMsFNSinDaNr7+6YKEGkl0ArOeL
        WjkXcV0svcu/tIpvgKROlYgnBURRbckLIi2BheWDrl22IkmeFR2gVtBeLcYiHP+9
        P4VYisa62yS4Hc8fGJNZur83EFykS5LoZtQBEELJqrPmzbDKV3tnKL1Zg49vLGLP
        g+CA3o3bvf7hNejFutszhr6Jj5xTXDo23+vvjZCejsIQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684273932; x=1684360332; bh=1mTVN0zWdMUI2lVaj0xdpaB121fz73d+fGc
        mjELhUZk=; b=tU+ViBfmK/un/Lo4Z03YcEyAbW/0SFOQJJQx4AsI0E3jnBxx2qh
        3IhxNCJHYBpozyEtOjb4guShzBj+bzhNjwYnaf8WC/xaaaqmzo8h6WBd/AljRtsX
        4vwVFQh1hDr8N8xyZzq+0OKOd3AsfE+ePvrvheZMPnbxiS61ULC7E/aL2Z8Xe9Sm
        P3PSHT4we7zgEtV2JALq1pRJkuUTUVvonLkRNTKfvow6RYAIqHVVr6PZiZ3gW7VW
        3qphfT70JBf7jMKYx45+krDE9y3XOz3bWfEjd6yyg/ZUUVYiOfT+If7yNuQGsP9Y
        heX0TB/zA0TetA7lPy5AKDqoxaA7G2KUkig==
X-ME-Sender: <xms:DPtjZL-ppO_MaUN-_qnvhaoUJQd7rkHmyUEoi-0dzj_bOr2z9j7alg>
    <xme:DPtjZHv8p1-q2AwHqsQAaJx4GgaJr10Ed5wUDIqlvlk6Ook3C55Mq7afAdX2M9YMb
    b72fCkW9OVqJEgTvbs>
X-ME-Received: <xmr:DPtjZJBaIQqCSSJUYo2-_EruuRhrrJ8zmhtSO96wOBsfWPfo2Y9PjkJF2G6YDRc0Jcu9Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefgjeeikefffeefvedugfdtkedvhfdttdei
    feevtdehgefgjeffleelgffggfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:DPtjZHdbNOmxf78SUAuooIpu3DuGASNHWhjOdkZqikBlz9nuv7rXVQ>
    <xmx:DPtjZAOgbxXExWgJrmf5Gvna7DU6dGvROxX4NnMbMDZg2sbus4Qpdw>
    <xmx:DPtjZJlv9AfGLjQ7NrPr0EWMgpB0Gm5-c3sBZUVYMnDzg_rkeyOFVA>
    <xmx:DPtjZEIrRpYB0OxexSbAFrh-6ru_OHFmi5WvxTuOf1g7pf3DZvBCNg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 17:52:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 480C510C8C1; Wed, 17 May 2023 00:52:10 +0300 (+03)
Date:   Wed, 17 May 2023 00:52:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
Message-ID: <20230516215210.pviqojbr5o4hd6bb@box.shutemov.name>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
 <CAMj1kXG488uW=dpvbfvdN1fMZVJ3kCZQoW3UVQJW1F2VEXyxHg@mail.gmail.com>
 <6fe42f66-819c-f2c8-176b-759c1c5a9cf5@intel.com>
 <CAMj1kXHE7_PrW44Y073=4orY6yVST+CHEA7KCo_0z_uRLew6fQ@mail.gmail.com>
 <a7550521-65bf-f9af-ddb0-118602a6340c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7550521-65bf-f9af-ddb0-118602a6340c@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 16, 2023 at 01:03:32PM -0700, Dave Hansen wrote:
> On 5/16/23 11:35, Ard Biesheuvel wrote:
> >>> Does this mean that the kernel maps memory before accepting it? As
> >>> otherwise, I would assume that such an access would page fault inside
> >>> the guest before triggering an exception related to the unaccepted
> >>> state.
> >> Yes, the kernel maps memory before accepting it (modulo things like
> >> DEBUG_PAGEALLOC).
> >>
> > OK, and so the architecture stipulates that prefetching or other
> > speculative accesses must never deliver exceptions to the host
> > regarding such ranges?
> 
> I don't know of anywhere that this is explicitly written.  It's probably
> implicit _somewhere_ in the reams of VMX/TDX and base SDM docs, but heck
> if I know where it is. :)

It is not specific to TDX: on x86 (and all architectures with precise
exceptions) exception handling is delayed until instruction retirement and
will not happen if speculation turned out to be wrong. And prefetching
never generates exceptions.

But I failed to find right away in 5000+ pages of Intel Software
Developer’s Manual. :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
