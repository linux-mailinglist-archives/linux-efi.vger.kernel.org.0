Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36A57A681
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiGSS3q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiGSS3p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 14:29:45 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85E459B8
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 11:29:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31caffa4a45so150371727b3.3
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unVD5D8mS78cV9OKwyoa/aVTA3h/WCQeocLsIDcTU88=;
        b=rlMp77yoX+jT3kAt/7isGFNXeCnY0JRyS/SjLKC2TnslQLVrLpBU/diTiP/scVZ0nm
         q0bRaxcxP+Mw3rUeQJBRKBfqgUMpNSg3XvWlFlKvNVo1/RWzse/NtMZbHyTEyqasjVrE
         ZGBNQ1hsyidPWe5J3G/PRh3S45vmu9vyEYflq5nKzjNotlQ8A60EN+KadQHUJNKaMI5m
         RdH1zhZgjsxuejJO+HqHon93uFWcbZQH4s/hWG3Ziu2e73+SNwGoDAinIVeqRl2NiP6h
         ytUAXES0ePRtPCBE+XQbyBq5Yeg+Oos35Ho7JkeaArhRDyQ8KKTXOQ39iSfbw2ATJHZw
         t72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unVD5D8mS78cV9OKwyoa/aVTA3h/WCQeocLsIDcTU88=;
        b=TnILZv3juPHgBQPl1pCAUVYyjjdb7r981cTGUoHjEjeRv8Ug4qyukPU6jkT4ZnanAX
         5Z/xQZStLoGrSXm8PPLVExkj50j24sJDtdprFeu0e+gbHjDEPeY3mPJWQG0tGtNiw4jb
         cuhSc00yiyudJJ2uOSacLNvnCc3l0TCfxok+pCMnHiLkLuKtqDT8xiatHglNveaLv6th
         hTImldwz5Z1vFrk2HZWl9gkAYcqwzWlDZx+shYLsFE5kx/AY7fggGZ23zjR4+zN+mGY5
         QZWZn+KHx0nQefGbyldLCv4DUnA76s7oomDnW43nQtCW/z5es968xNkQSWxsi3PjEq5M
         nEyg==
X-Gm-Message-State: AJIora/ZmT/h9/CT+XoKR1STqIW3ox4IojEzmsPDsoos7YY7snrd+bBw
        IaA5Hz62mIe+kcv788+jFNPgUGyblejzoIygYJMInQ==
X-Google-Smtp-Source: AGRyM1sp8r4DKDqp+3bXLyIEl1rWuq4duyZZsvEEp5+awBcKu+U0NNFWJYr396qMNpgLQ2YVHwSleitEY6cw3zveH98=
X-Received: by 2002:a81:a1ca:0:b0:31e:58d4:e724 with SMTP id
 y193-20020a81a1ca000000b0031e58d4e724mr5943209ywg.486.1658255383950; Tue, 19
 Jul 2022 11:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com> <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com> <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com> <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com> <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
In-Reply-To: <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 19 Jul 2022 11:29:32 -0700
Message-ID: <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Gonda <pgonda@google.com>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > > I think we should make it obvious from a kernel image if it supports
> > > unaccepted memory (with UTS_VERSION or other way).
> > >
>
> Something I didn't address in my previous email: how would the UEFI
> know where the kernel is to parse this UTS_VERSION out when it's
> booting a bootloader before Linux gets booted?
>

How about instead of the limited resource of UTS_VERSION, we add a
SETUP_BOOT_FEATURES enum for setup_data in the boot header? That would
be easier to parse out and more extensible in the future.
https://www.kernel.org/doc/html/latest/x86/boot.html?highlight=boot

This can contain a bitmap of a number of features that we currently
need manual tagging for, such as SEV guest support, SEV-SNP guest
support, TDX guest support, and (CONFIG_UNACCEPTED_MEMORY, TDX) or
(CONFIG_UNACCEPTED_MEMORY, SEV-SNP).
The VMM, UEFI, or boot loader can read these from the images/kernels
and have the appropriate behavior.

-- 
-Dionna Glaze, PhD (she/her)
