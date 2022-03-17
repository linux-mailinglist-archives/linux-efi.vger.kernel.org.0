Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05364DCF34
	for <lists+linux-efi@lfdr.de>; Thu, 17 Mar 2022 21:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiCQUWG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Mar 2022 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCQUWG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Mar 2022 16:22:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B405133DAC
        for <linux-efi@vger.kernel.org>; Thu, 17 Mar 2022 13:20:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g24so7544239lja.7
        for <linux-efi@vger.kernel.org>; Thu, 17 Mar 2022 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ByaGDxG5X1KUgztH3SIHl92iZntE1/kLAfg0SkefsmM=;
        b=EjumO/osdajILuAhSqSQ/Da7QJir8FzyqTQFbc4UpDaN9fXvRfiv40LZLT+eA7gkRB
         3vrFp/3jfymjknQthDrJSkB7xwoAOJvsz5Di0hyjlAaE9gN3uxJTEwY9XyMaCjozjoVc
         HJC0mUBHn0IlY0e7CK/wBrjxwXuJPdYWxPSteqHXsHHQSWOZ0f9MLWUtNY1JHrSc3gJ9
         oxFmp2K8l/AnAaP3yd3LR+9tPCxgtg+5YNpkIsyFWyvAdd/pDdzg6/VBo/pOHywTahXB
         bZW50vBFEwtpEAkIYgnseTsBUvSdfqcEbIBWmWkh9gGTDgrOtN0oRmFiO3hBahEVXDEB
         ijZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByaGDxG5X1KUgztH3SIHl92iZntE1/kLAfg0SkefsmM=;
        b=ClKMmorEjMxYgDGlVQUAgQRKiGiRk4sI+89VkKkeu87BenuoE0pDYCCVLrpi3vZanx
         HFZcI/yaLtsIWYB072O6A9jmKIKy29G7c3uHl/Vy6eglWCxuQ/YohqqoOqqsKJNe/wy9
         AGrfBvpULDCUt72fpvaYyRC1Z0fTVdcucqZIgRGBRl90Qv/VljLnfcKD2ypGT05S5zl4
         r1E0uMGYptxLsNCrNHLq9AUQIJKQjeA2uN5n4HpJIu8yMnEZy5XCE3vI717mjszwNUT4
         XFvm/fXpFyoi/32pCzuKHd5qGxpkZ5KoK00QeGEbUfVskQ+2Pv/bAcrxbsRVP88Ze/1u
         J8sg==
X-Gm-Message-State: AOAM533+9fuE+C/kqOjFLhiJ2oyuZmh3rYWd2pc6CNE3mQC42pUAq8yQ
        LVNDPR18zfbYo+Ua9/nrObbcLn43go7cyHZwTqii8g==
X-Google-Smtp-Source: ABdhPJwDEfWHv2pGVJTBNzJFj6FyJ5V3aLxhQdKByl4OEnifeiYrk0bX3nPrSRiG85pauGo4XpR1S23j9NY/aPe/dHg=
X-Received: by 2002:a2e:9e81:0:b0:248:7c35:385a with SMTP id
 f1-20020a2e9e81000000b002487c35385amr4103253ljk.527.1647548447219; Thu, 17
 Mar 2022 13:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-33-brijesh.singh@amd.com> <CAMkAt6pO0xZb2pye-VEKdFQ_dYFgLA21fkYmnYPTWo8mzPrKDQ@mail.gmail.com>
 <20220310212504.2kt6sidexljh2s6p@amd.com> <YiuBqZnjEUyMfBMu@suse.de>
 <CAMkAt6r==_=U4Ha6ZTmii-JL3htJ3-dD4tc+QBqN7dVt711N2A@mail.gmail.com> <23728EEA-37B8-478E-9576-DBFD6FE2A294@suse.de>
In-Reply-To: <23728EEA-37B8-478E-9576-DBFD6FE2A294@suse.de>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 17 Mar 2022 14:20:35 -0600
Message-ID: <CAMkAt6qeSYbsGCsgu0+mfYoYVxS25OMoRYzhEebFvfZzNkxOaA@mail.gmail.com>
Subject: Re: [PATCH v12 32/46] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
To:     Boris Petkov <bp@suse.de>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, linux-efi@vger.kernel.org,
        linux-coco@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
        Jim Mattson <jmattson@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, brijesh.ksingh@gmail.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marc Orr <marcorr@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 17, 2022 at 7:11 AM Boris Petkov <bp@suse.de> wrote:
>
> On March 14, 2022 5:34:42 PM UTC, Peter Gonda <pgonda@google.com> wrote:
> >I was also thinking about adding a vcpu run exit reason for
> >termination. It would be nice to get a more informative exit reason
> >than -EINVAL in userspace. Thoughts?
>
> Absolutely - it should be unambiguously clear why we're terminating.
>
> --
> Sent from a small device: formatting sux and brevity is inevitable.

Great, I can work on that too.
