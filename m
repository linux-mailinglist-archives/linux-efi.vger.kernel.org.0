Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57616B661E
	for <lists+linux-efi@lfdr.de>; Sun, 12 Mar 2023 14:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCLNJq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLNJp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 09:09:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C52B43463;
        Sun, 12 Mar 2023 06:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A636BB80B18;
        Sun, 12 Mar 2023 13:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71BC433EF;
        Sun, 12 Mar 2023 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678626581;
        bh=zpK9i8XKBBg5JEkBeTqmxsaKteRDVFwSDrc4OljoyZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ckqs/1VTjkSooQourOo6xMn+IY6kmtvJ/M2ztEdBcYMiFZvwyHEzvHuf8gQhdkEsX
         /1VdHtd4eROmttnVxqSm9uOf7Ljz9xPlzNk6ZB28jgWFLjpnq1DoNE6zk3UBLDhn6I
         XnRnfgQRtgI+JF8vC7mDJSJMJbA3dQve91oEGF7RxmrwyX2e2QW9Xw0SGEVwTXe0C8
         whxN1QUQUX0n/bTSmkltJGmQjjLXMmUsU7HLjewLi2F0envYx1ElhV3HRZufrXI9mq
         QHEQNouO1qwPnfKuFffmAe6rtG7/DT52L8Cl/JfRS/7LTmZnqmTvCmbzs60ATmZaRx
         Qhvf4CKhI+B4Q==
Received: by mail-lj1-f175.google.com with SMTP id f16so9962618ljq.10;
        Sun, 12 Mar 2023 06:09:41 -0700 (PDT)
X-Gm-Message-State: AO0yUKWtxxs3ewLdkBanR+wLRoLPgsKrDwuzwo5W2xfQ6jGPKojKaZdG
        z37yVDwBeWRElJd2ELkrzw/cnnppkRyV7diAOjU=
X-Google-Smtp-Source: AK7set/gQXR5qduHS0DxBTO5eOMVLNGBNeG5PMWGAVAnasCEuM7PbXleRK5OUizbnlexyFEN6AxWwVFD8/CvwwpVx9k=
X-Received: by 2002:a2e:a268:0:b0:295:ba26:8ad4 with SMTP id
 k8-20020a2ea268000000b00295ba268ad4mr9650783ljm.2.1678626579386; Sun, 12 Mar
 2023 06:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <2dd706f95dd4fbb24de534b5fdedf7b740d1bac0.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com>
 <f5aaddbe13211c3a3d6d879675ebcaf8@ispras.ru> <CAMj1kXFFsxUWRjLzWpz5qWWA4VaVnC0hYodLOxBoR_kDf=x8=Q@mail.gmail.com>
 <b649071c0a919c284de79b74201e4438@ispras.ru>
In-Reply-To: <b649071c0a919c284de79b74201e4438@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 12 Mar 2023 14:09:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGK=z_taR2__RrCEDTE_F=+dbiXb_9HTCyG9R7iOp+yoA@mail.gmail.com>
Message-ID: <CAMj1kXGK=z_taR2__RrCEDTE_F=+dbiXb_9HTCyG9R7iOp+yoA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 12 Mar 2023 at 13:02, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-11 20:31, Ard Biesheuvel wrote:
> > On Sat, 11 Mar 2023 at 16:02, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> On 2023-03-10 18:17, Ard Biesheuvel wrote:
> >> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >> >>
> >> >> Currently kernel image is not fully compliant PE image, so it may
> >> >> fail to boot with stricter implementations of UEFI PE loaders.
> >> >>
> >> >> Set minimal alignments and sizes specified by PE documentation [1]
> >> >> referenced by UEFI specification [2]. Align PE header to 8 bytes.
> >> >>
> >> >> Generate PE sections dynamically. This simplifies code, since with
> >> >> current implementation all of the sections needs to be defined in
> >> >> header.S, where most section header fields do not hold valid values,
> >> >> except for their names. Before the change, it also held flags,
> >> >> but now flags depend on kernel configuration and it is simpler
> >> >> to set them from build.c too.
> >> >>
> >> >> Setup sections protection. Since we cannot fit every needed section,
> >> >> set a part of protection flags dynamically during initialization.
> >> >> This step is omitted if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
> >> >>
> >> >> [1]
> >> >> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
> >> >> [2]
> >> >> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
> >> >>
> >> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >> >
> >> > I would prefer it if we didn't rewrite the build tool this way.
> >> >
> >> > Having the sections in header.S in the order they appear in the binary
> >> > is rather useful, and I don't think we should manipulate the section
> >> > flags based on whether CONFIG_DXE_MEM_ATTRIBUTES is set. I also don't
> >> > think we need more than .text / .,data (as discussed in the other
> >> > thread on linux-efi@)
> >> >
> >> > Furthermore, I had a look at the audk PE loader [0], and I think it is
> >> > being overly pedantic.
> >> >
> >> > The PE/COFF spec does not require that all sections are virtually
> >> > contiguous, and it does not require that the file content is
> >> > completely covered by either the header or by a section.
> >> >
> >> > So what I would prefer to do is the following:
> >> >
> >> > Sections:
> >> > Idx Name          Size     VMA              Type
> >> >   0 .reloc        00000200 0000000000002000 DATA
> >> >   1 .compat       00000200 0000000000003000 DATA
> >> >   2 .text         00bee000 0000000000004000 TEXT
> >> >   3 .data         00002200 0000000000bf2000 DATA
> >> >
> >> > using 4k section alignment and 512 byte file alignment, and a header
> >> > size of 0x200 as before (This requires my patch that allows the setup
> >> > header to remain unmapped when running the stub [1])
> >> >
> >> > The reloc and compat payloads are placed at the end of the setup data
> >> > as before, but increased in size to 512 bytes each, and then mapped
> >> > non-1:1 into the RVA space.
> >> >
> >> > This works happily with both the existing PE loader as well as the
> >> > audk one, but with the pedantic flags disabled.
> >> >
> >>
> >> This makes sense. I'll change this patch to use this layout and
> >> to keep sections in headers.S before sending v5. (and I guess I'll
> >> make the compressed kernel a part of .text). I have a few questions
> >> though:
> >>
> >> This layout assumes having the local copy of the bootparams as
> >> in your RFC patches, right?
> >>
> >
> > Indeed. Otherwise, the setup header may not have been copied to memory
> > by the loader.
> >
> >> Can I keep the .rodata -- 5th section fits in the section table
> >> without much work?
> >>
> >
> > You could, but at least the current PE/COFF loader in EDK2 will map it
> > read/write, as it only distinguishes between executable sections and
> > non-executable sections.
> >
>
> At least it will slightly improve security for some implementations
> (e.g. audk, while being overly strict support RO sections)
>

Yeah, but more common loaders will put the compressed data in a
writable region. I'd prefer to have a simple and common baseline where
we always just use R-X for all text and rodata, and RW- for everything
else.
