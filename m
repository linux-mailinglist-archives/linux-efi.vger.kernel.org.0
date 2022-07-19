Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713C57A871
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiGSUpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiGSUpY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 16:45:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE5252A6;
        Tue, 19 Jul 2022 13:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A944B81D4F;
        Tue, 19 Jul 2022 20:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A39C341D9;
        Tue, 19 Jul 2022 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658263519;
        bh=is8+ILmv9PejEMf4YjQ/EARYt+ria3kqCNvGVtOmbyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TF5U96gC1H5J4OrMSrDKgmZyB5uc/XphUOWbKMbJnxayFYXmqy9U0annagiK1Lrww
         kMnoog99PZLyFGuCmst1LjRa3A+igB4SQQtOhT27n9rNi3z3g4K1WE64ntqxZjv2vh
         k/kz6eKQ8VgzwurgemKgs9PnDlqVkNrgYIi7MbAC3Wbf7o3BHERBZu0yGYViXn4EHq
         MjlEZg/EAxSqoTOQIqp/hdqMTyPcjcH4EVZz5vnUxRzfeK8UHMPgPgEeYZqYKNtPWl
         NtU/Awbn7557SdeWBWIEbxOJL/rsBecuXSPyt1b+srrACu7ksrSaPiG6F+0N3fSa1h
         HNlHaIUCq5SSQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-10bd4812c29so33555576fac.11;
        Tue, 19 Jul 2022 13:45:19 -0700 (PDT)
X-Gm-Message-State: AJIora8rejmL37IxbD3I3KEzr1eJa7jU/x1aV5FkkJwl7xHsAx5PbZ8z
        v8Eafrog5yw3rylye4j0+uLI8gpOavUwCosboXk=
X-Google-Smtp-Source: AGRyM1sICwjAXSPoZhvHV3Kl2TfNBu9m6a+FLzUR2NSmzL9dkb7rG0rM0A03qKW8n7Vjdtf9rfc5bQfPyzgPrD82OAc=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr766142oab.126.1658263517968; Tue, 19
 Jul 2022 13:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com> <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com> <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com> <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com> <YtcCWfCQuEsVhH6W@zn.tnic>
In-Reply-To: <YtcCWfCQuEsVhH6W@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 19 Jul 2022 22:45:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
Message-ID: <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 19 Jul 2022 at 21:14, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 19, 2022 at 11:29:32AM -0700, Dionna Amalie Glaze wrote:
> > How about instead of the limited resource of UTS_VERSION, we add a
> > SETUP_BOOT_FEATURES enum for setup_data in the boot header? That would
> > be easier to parse out and more extensible in the future.
> > https://www.kernel.org/doc/html/latest/x86/boot.html?highlight=boot
> >
> > This can contain a bitmap of a number of features that we currently
> > need manual tagging for, such as SEV guest support, SEV-SNP guest
> > support, TDX guest support, and (CONFIG_UNACCEPTED_MEMORY, TDX) or
> > (CONFIG_UNACCEPTED_MEMORY, SEV-SNP).
> > The VMM, UEFI, or boot loader can read these from the images/kernels
> > and have the appropriate behavior.
>
> I think for stuff like that you want loadflags or xloadflags in the
> setup header.
>

Please, no. Let's not invent Linux/x86 specific hacks to infer whether
or not the kernel is capable of accepting memory when it is perfectly
capable of telling us directly. We will surely need something
analogous on other architectures in the future as well, so the setup
header is definitely not the right place for this.

The 'bootloader that calls EBS()' case does not apply to Linux, and
given that we are talking specifically about confidential computing
VMs here, we can afford to be normative and define something generic
that works well for us.

So let's define a way for the EFI stub to signal to the firmware
(before EBS()) that it will take control of accepting memory. The
'bootloader that calls EBS()' case can invent something along the
lines of what has been proposed in this thread to infer the
capabilities of the kernel (and decide what to signal to the
firmware). But we have no need for this additional complexity on
Linux.
