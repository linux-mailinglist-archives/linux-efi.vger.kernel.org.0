Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5DD6B65A7
	for <lists+linux-efi@lfdr.de>; Sun, 12 Mar 2023 13:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLMCA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 12 Mar 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCLMB7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 12 Mar 2023 08:01:59 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D331ABC7;
        Sun, 12 Mar 2023 05:01:56 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 95EEF44C100F;
        Sun, 12 Mar 2023 12:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 95EEF44C100F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678622513;
        bh=YQ/KPBa3imZVjPC7T6FodEbR+OnkZJA2A+cOn9tXZGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s2llQEZ0DbgMNZG2NdGQAbEn3KQWNd8WfDVYQDULzih1QMjDzfHyNEPu8FykRcBAf
         wkk/573ixqFeQkq4sCsuhrAOScHAiWlzviC6Wm22UpJUfcGGxUaNNhbn0qGf0sTnNU
         YkfqrvQhMyMHby2Kz1+VVXNglmHuLc2DKcIY4Oss=
MIME-Version: 1.0
Date:   Sun, 12 Mar 2023 15:01:53 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v4 20/26] x86/build: Make generated PE more spec compliant
In-Reply-To: <CAMj1kXFFsxUWRjLzWpz5qWWA4VaVnC0hYodLOxBoR_kDf=x8=Q@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <2dd706f95dd4fbb24de534b5fdedf7b740d1bac0.1671098103.git.baskov@ispras.ru>
 <CAMj1kXGu0uFynyt=MostXo58A4f4Zu6cFFiSShFZChU5LWt1ZQ@mail.gmail.com>
 <f5aaddbe13211c3a3d6d879675ebcaf8@ispras.ru>
 <CAMj1kXFFsxUWRjLzWpz5qWWA4VaVnC0hYodLOxBoR_kDf=x8=Q@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b649071c0a919c284de79b74201e4438@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-11 20:31, Ard Biesheuvel wrote:
> On Sat, 11 Mar 2023 at 16:02, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> On 2023-03-10 18:17, Ard Biesheuvel wrote:
>> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> >>
>> >> Currently kernel image is not fully compliant PE image, so it may
>> >> fail to boot with stricter implementations of UEFI PE loaders.
>> >>
>> >> Set minimal alignments and sizes specified by PE documentation [1]
>> >> referenced by UEFI specification [2]. Align PE header to 8 bytes.
>> >>
>> >> Generate PE sections dynamically. This simplifies code, since with
>> >> current implementation all of the sections needs to be defined in
>> >> header.S, where most section header fields do not hold valid values,
>> >> except for their names. Before the change, it also held flags,
>> >> but now flags depend on kernel configuration and it is simpler
>> >> to set them from build.c too.
>> >>
>> >> Setup sections protection. Since we cannot fit every needed section,
>> >> set a part of protection flags dynamically during initialization.
>> >> This step is omitted if CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set.
>> >>
>> >> [1]
>> >> https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v83.docx
>> >> [2]
>> >> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
>> >>
>> >> Tested-by: Peter Jones <pjones@redhat.com>
>> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> >
>> > I would prefer it if we didn't rewrite the build tool this way.
>> >
>> > Having the sections in header.S in the order they appear in the binary
>> > is rather useful, and I don't think we should manipulate the section
>> > flags based on whether CONFIG_DXE_MEM_ATTRIBUTES is set. I also don't
>> > think we need more than .text / .,data (as discussed in the other
>> > thread on linux-efi@)
>> >
>> > Furthermore, I had a look at the audk PE loader [0], and I think it is
>> > being overly pedantic.
>> >
>> > The PE/COFF spec does not require that all sections are virtually
>> > contiguous, and it does not require that the file content is
>> > completely covered by either the header or by a section.
>> >
>> > So what I would prefer to do is the following:
>> >
>> > Sections:
>> > Idx Name          Size     VMA              Type
>> >   0 .reloc        00000200 0000000000002000 DATA
>> >   1 .compat       00000200 0000000000003000 DATA
>> >   2 .text         00bee000 0000000000004000 TEXT
>> >   3 .data         00002200 0000000000bf2000 DATA
>> >
>> > using 4k section alignment and 512 byte file alignment, and a header
>> > size of 0x200 as before (This requires my patch that allows the setup
>> > header to remain unmapped when running the stub [1])
>> >
>> > The reloc and compat payloads are placed at the end of the setup data
>> > as before, but increased in size to 512 bytes each, and then mapped
>> > non-1:1 into the RVA space.
>> >
>> > This works happily with both the existing PE loader as well as the
>> > audk one, but with the pedantic flags disabled.
>> >
>> 
>> This makes sense. I'll change this patch to use this layout and
>> to keep sections in headers.S before sending v5. (and I guess I'll
>> make the compressed kernel a part of .text). I have a few questions
>> though:
>> 
>> This layout assumes having the local copy of the bootparams as
>> in your RFC patches, right?
>> 
> 
> Indeed. Otherwise, the setup header may not have been copied to memory
> by the loader.
> 
>> Can I keep the .rodata -- 5th section fits in the section table
>> without much work?
>> 
> 
> You could, but at least the current PE/COFF loader in EDK2 will map it
> read/write, as it only distinguishes between executable sections and
> non-executable sections.
> 

At least it will slightly improve security for some implementations
(e.g. audk, while being overly strict support RO sections)

>> Also, why .reloc is at offset 0x2000 and not just 0x1000, is there
>> anything important I am missing? I understand that is cannot be 0
>> and should be aligned on page size, but nothing else comes to my
>> mind...
>> 
> 
> That was just arbitrary, because the raw allocations of reloc and
> compat are also allocated towards the end. But I guess starting at
> 0x1000 for .reloc makes more sense so feel free to change that.

Thanks for clarifications!
