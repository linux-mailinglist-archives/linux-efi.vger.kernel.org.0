Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95E6B5ED4
	for <lists+linux-efi@lfdr.de>; Sat, 11 Mar 2023 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCKRbf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Mar 2023 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCKRbd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Mar 2023 12:31:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858C64277;
        Sat, 11 Mar 2023 09:31:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFCE3B80735;
        Sat, 11 Mar 2023 17:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1CC433AC;
        Sat, 11 Mar 2023 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555888;
        bh=4GGJWsluLq9AizSZlCAwm7WbloXzicd3Q5SdE65NlMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k0+VJUQNHjjdWjiJbH8r9qzJXBSMfPIXGQzIB/4r8FrCPPbhRbfOvjUYKsGLv4Ksq
         XucIJ0d0NqWBw8UD0ApXVD2IZMm2TbFQILosl+jJPk0yyF1d1IdSpFmx+X3YKeFjR3
         qtTrjDEXaUOmM083w/0BGC44Nac4E7pMeFEfsa/X1U044UojmU9xGVn04IJx8T0kZh
         Tyw2dj8Lfo13T15Jj49EKgcsQTvvodxQ6aYUQEl96tvgrByRSjkujJT1f2Y/lDSJFH
         U9W84bEhShK8h8Mj6xc36+C5EWg0u+O2SOV8NXDAE45COC9if5XeXROG7/xckcUXfy
         hXqHFDcVVUHew==
Received: by mail-lf1-f52.google.com with SMTP id r27so10637867lfe.10;
        Sat, 11 Mar 2023 09:31:28 -0800 (PST)
X-Gm-Message-State: AO0yUKWeERzp3Aa32iZu9k3b61iFc3kpAFGajtwAQ5xHDEFHOpu9jdRs
        a9rbb4Xyoc2eL5avji4AWGlFiH5akz9AfTX+SPg=
X-Google-Smtp-Source: AK7set9PibevrP2rAI29WTB597QX3ixcn4XwcIeVNls4N8UlirDlP9VId9xHMdR+rQs71xn58POnHk45A9PrtuHkA8Q=
X-Received: by 2002:ac2:546c:0:b0:4d5:ca42:aee7 with SMTP id
 e12-20020ac2546c000000b004d5ca42aee7mr9082882lfn.7.1678555886509; Sat, 11 Mar
 2023 09:31:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <2dd706f95dd4fbb24de534b5fdedf7b740d1bac0.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com> <f5aaddbe13211c3a3d6d879675ebcaf8@ispras.ru>
In-Reply-To: <f5aaddbe13211c3a3d6d879675ebcaf8@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 11 Mar 2023 18:31:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFFsxUWRjLzWpz5qWWA4VaVnC0hYodLOxBoR_kDf=x8=Q@mail.gmail.com>
Message-ID: <CAMj1kXFFsxUWRjLzWpz5qWWA4VaVnC0hYodLOxBoR_kDf=x8=Q@mail.gmail.com>
Subject: Re: [PATCH v4 20/26] x86/build: Make generated PE more spec compliant
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 11 Mar 2023 at 16:02, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-10 18:17, Ard Biesheuvel wrote:
> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> Currently kernel image is not fully compliant PE image, so it may
> >> fail to boot with stricter implementations of UEFI PE loaders.
> >>
> >> Set minimal alignments and sizes specified by PE documentation [1]
> >> referenced by UEFI specification [2]. Align PE header to 8 bytes.
> >>
> >> Generate PE sections dynamically. This simplifies code, since with
> >> current implementation all of the sections needs to be defined in
> >> header.S, where most section header fields do not hold valid values,
> >> except for their names. Before the change, it also held flags,
> >> but now flags depend on kernel configuration and it is simpler
> >> to set them from build.c too.
> >>
> >> Setup sections protection. Since we cannot fit every needed section,
> >> set a part of protection flags dynamically during initialization.
> >> This step is omitted if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
> >>
> >> [1]
> >> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
> >> [2]
> >> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
> >>
> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >
> > I would prefer it if we didn't rewrite the build tool this way.
> >
> > Having the sections in header.S in the order they appear in the binary
> > is rather useful, and I don't think we should manipulate the section
> > flags based on whether CONFIG_DXE_MEM_ATTRIBUTES is set. I also don't
> > think we need more than .text / .,data (as discussed in the other
> > thread on linux-efi@)
> >
> > Furthermore, I had a look at the audk PE loader [0], and I think it is
> > being overly pedantic.
> >
> > The PE/COFF spec does not require that all sections are virtually
> > contiguous, and it does not require that the file content is
> > completely covered by either the header or by a section.
> >
> > So what I would prefer to do is the following:
> >
> > Sections:
> > Idx Name          Size     VMA              Type
> >   0 .reloc        00000200 0000000000002000 DATA
> >   1 .compat       00000200 0000000000003000 DATA
> >   2 .text         00bee000 0000000000004000 TEXT
> >   3 .data         00002200 0000000000bf2000 DATA
> >
> > using 4k section alignment and 512 byte file alignment, and a header
> > size of 0x200 as before (This requires my patch that allows the setup
> > header to remain unmapped when running the stub [1])
> >
> > The reloc and compat payloads are placed at the end of the setup data
> > as before, but increased in size to 512 bytes each, and then mapped
> > non-1:1 into the RVA space.
> >
> > This works happily with both the existing PE loader as well as the
> > audk one, but with the pedantic flags disabled.
> >
>
> This makes sense. I'll change this patch to use this layout and
> to keep sections in headers.S before sending v5. (and I guess I'll
> make the compressed kernel a part of .text). I have a few questions
> though:
>
> This layout assumes having the local copy of the bootparams as
> in your RFC patches, right?
>

Indeed. Otherwise, the setup header may not have been copied to memory
by the loader.

> Can I keep the .rodata -- 5th section fits in the section table
> without much work?
>

You could, but at least the current PE/COFF loader in EDK2 will map it
read/write, as it only distinguishes between executable sections and
non-executable sections.

> Also, why .reloc is at offset 0x2000 and not just 0x1000, is there
> anything important I am missing? I understand that is cannot be 0
> and should be aligned on page size, but nothing else comes to my
> mind...
>

That was just arbitrary, because the raw allocations of reloc and
compat are also allocated towards the end. But I guess starting at
0x1000 for .reloc makes more sense so feel free to change that.
