Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E467172C9
	for <lists+linux-efi@lfdr.de>; Wed, 31 May 2023 02:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjEaA6m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 May 2023 20:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEaA6l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 May 2023 20:58:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E23F3;
        Tue, 30 May 2023 17:58:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-256e1d87998so679547a91.3;
        Tue, 30 May 2023 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685494720; x=1688086720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWKTx1C1busGH1n86mFA2gXYIdrkaqudVwHZXoCwcUY=;
        b=Wc8Dk4toURb+GT/VEX8u/ZPyAeWW0viHsBDstcpqO7X3e2/blZHuN1+hmZJS+cl5oP
         bRV1ZSAobyuH/GVbroK8S5fQ+vcSsXZtyyGF8PtrVyS3KWmhtC1e/0pN2yyqrrKmWMyu
         oyrXQNAbInrdlWmPC7t4wsa0BwtX1ssd5sd32idOI2cuL0f0ICybsuPNZtKjqh1bZ5RY
         Cn5aeyib36tc1wO52dckv/VhJAkwJAU4er9DdKf+rKkyJMjoS0A2vE8hEGZy2foKKvNi
         Y2szGXUSLGg3gc5Z1VFH+/PmXsrKxsxJvM31zTpEEfhsQcMnM3P84P2Tw3Sx5ZCnvEEO
         /5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685494720; x=1688086720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWKTx1C1busGH1n86mFA2gXYIdrkaqudVwHZXoCwcUY=;
        b=ay1zfR3ccXVOpfwI/DWn1Ae11kppVbc9oQ+yXyZg29W0BysY/jwti/aVQ+KZdhLAan
         gYS7bKmBhYLhiRxbSGCj7FrUnGMEvfvyb+rhoe0n6+WNpTQCT1nVftNNtapiOFzhBvCc
         TeKKQ6AG5bf76YLqTIk4kbPFy4SZbzIaYnCOpnV2C45W33sOg508TLgLwvOq27v1tfD2
         lVYhSx63tS2yHon6fjvIShPSS4uye5PYBaNB8ZUGgQXtS8qcXAf6sT38/jhQujS9Cfte
         Gi6QhFzzLBaibXgAm+KUL0j3gKU8aTjtnj1g/QaDRtYJrrr4d71d3wUKs9BlFGavY3oP
         tWiA==
X-Gm-Message-State: AC+VfDzeQS+b/cP3/56EYpMBQbJ5Vdy3Nd5tE2opZIpEXxGSCikjmI67
        OKgDIHnCvDFjJM2X8tN2oUE=
X-Google-Smtp-Source: ACHHUZ4S2eRbHGgRedMQgARSsQzR4FeyiMo2BgeRkIMvEiZvtHs3TgFqX5xzfyeRHHllfISc6pH4zQ==
X-Received: by 2002:a17:90b:2301:b0:256:797b:5039 with SMTP id mt1-20020a17090b230100b00256797b5039mr4202403pjb.9.1685494719614;
        Tue, 30 May 2023 17:58:39 -0700 (PDT)
Received: from localhost ([192.55.54.50])
        by smtp.gmail.com with ESMTPSA id fs19-20020a17090af29300b0024744818bc5sm22404pjb.9.2023.05.30.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:58:39 -0700 (PDT)
Date:   Tue, 30 May 2023 17:58:37 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [PATCHv12 9/9] x86/tdx: Add unaccepted memory support
Message-ID: <20230531005837.GA1808127@ls.amr.corp.intel.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
 <20230518231434.26080-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518231434.26080-10-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 19, 2023 at 02:14:34AM +0300,
"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> Hookup TDX-specific code to accept memory.
> 
> Accepting the memory is the same process as converting memory from
> shared to private: kernel notifies VMM with MAP_GPA hypercall and then
> accept pages with ACCEPT_PAGE module call.
> 
> THE implementation in core kernel uses tdx_enc_status_changed(). It
> already used for converting memory to shared and back for I/O
> transactions.

Because unaccepted memory reported in e820 means private[1], MAP_GPA isn't
needed to accept memory. (Or are you seeing TDX KVM/qemu issue?)

[1]TDX Virtual Firmware Design Guide.
7.2.1 Memroy Type in TD Resrouce HOB. Table 7-1: Mmeory Typein TD Resource HOB.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
