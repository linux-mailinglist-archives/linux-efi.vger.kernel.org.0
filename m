Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01194B6C82
	for <lists+linux-efi@lfdr.de>; Tue, 15 Feb 2022 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiBOMn7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Feb 2022 07:43:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiBOMn0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 15 Feb 2022 07:43:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274E1111B5
        for <linux-efi@vger.kernel.org>; Tue, 15 Feb 2022 04:42:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f37so10321030lfv.8
        for <linux-efi@vger.kernel.org>; Tue, 15 Feb 2022 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bZ/hPvhB6l/GT98IyjxTlesdblulBOqx0t8aw3A0jHw=;
        b=uJNVxw9rQQ9Ric3MtAGmVVmQ9e9tx8jQSgqxtiLH6Tj9yRS0M5phMpCdbQO2CuS6Lo
         2HGd2G5RWhNEhynYJ75YmyD3ubNHBr+EmixSyhOVAAc1UFQlJYdRqEZ9tyVhySlGZVE7
         dAd0xOczoO+SD/q/GWS5j625mh91rbBwm1JR6GZHaUA/Ox9usN2kusbueTAnKHUJ6kjf
         fk7v8g69zom2gOxNIPReCCZP0/wysVgPU1aXmkvq6tMliKexaCj588lYYxM2fkBbdADt
         T+UPbUVFQeVZzDNCmcWzvU9c5LGMxOlCAWo3RDuQeVVxuK30MNLWblvyBbxH/cfOpYTh
         OVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZ/hPvhB6l/GT98IyjxTlesdblulBOqx0t8aw3A0jHw=;
        b=EqbEhNEvwOVR+MwzXUFahaVq/IF7Sp+JMYAiOgR/voQgzM+woxrvL30HnFVG1cZ+vK
         FX+/dDRn83wO7ipoWt7qn9iLkXcaI/mD0y26eNG4wST/hzqcIDl3Z+10P22pUFhHdv9I
         Kj4ZCcBlWsDNURmXJD1MiXMFm7lHKvzYW/TgAuW34u3XECHtQIHBK84UuzL2p3DSHSQQ
         TZHhfK30Hl1l5L2f95AJ3TXV7qTXk6b1U/ceoyiXfdDqVo2cmqOqr3jprelSF4OnayfC
         cQKr8/z5KNP6YNGIkcmzZncDVv3lc6NEUE2slb6gmtvzuure+KdVbDc1aEIqlmkF7k+P
         55Kg==
X-Gm-Message-State: AOAM530TreXEBU2nP8dBeI7aggFZ4ESRoCK12gJIuDiyly6va3aBG07z
        iyW0COgcopl4mxpDbrx9rtvNKQ==
X-Google-Smtp-Source: ABdhPJxentoESgiyNbBHAOr5c+HaAA+la7EJnNo75HfMC7ZWYPBFxfJ60zcCmBwrME44zYZL66IF7A==
X-Received: by 2002:a19:6549:: with SMTP id c9mr3066138lfj.150.1644928958898;
        Tue, 15 Feb 2022 04:42:38 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bf10sm4394566ljb.130.2022.02.15.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:42:37 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6DD81103F44; Tue, 15 Feb 2022 15:43:31 +0300 (+03)
Date:   Tue, 15 Feb 2022 15:43:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <20220215124331.i4vgww733fv5owrx@box.shutemov.name>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
 <YgZ427v95xcdOKSC@zn.tnic>
 <0242e383-5406-7504-ff3d-cf2e8dfaf8a3@amd.com>
 <Ygj2Wx6jtNEEmbh9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygj2Wx6jtNEEmbh9@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 13, 2022 at 01:15:23PM +0100, Borislav Petkov wrote:
> On Fri, Feb 11, 2022 at 11:27:54AM -0600, Brijesh Singh wrote:
> > > Simply have them always present. They will have !0 values on the
> > > respective guest types and 0 otherwise. This should simplify a lot of
> > > code and another unconditionally present u64 won't be the end of the
> > > world.
> > >
> > > Any other aspect I'm missing?
> > 
> > I think that's mostly about it. IIUC, the recommendation is to define a
> > new callback in x86_platform_op. The callback will be invoked
> > unconditionally; The default implementation for this callback is NOP;
> > The TDX and SEV will override with the platform specific implementation.
> > I think we may able to handle everything in one callback hook but having
> > pre and post will be a more desirable. Here is why I am thinking so:
> > 
> > * On SNP, the page must be invalidated before clearing the _PAGE_ENC
> > from the page table attribute
> > 
> > * On SNP, the page must be validated after setting the _PAGE_ENC in the
> > page table attribute.
> 
> Right, we could have a pre- and post- callback, if that would make
> things simpler/clearer.
> 
> Also, in thinking further about the encryption mask, we could make it a
> *single*, *global* variable called cc_mask which each guest type sets it
> as it wants to.

I don't think it works. TDX and SME/SEV has opposite polarity of the mask.
SME/SEV has to clear the mask to share the page. TDX has to set it.

Making a single global mask only increases confusion.

-- 
 Kirill A. Shutemov
