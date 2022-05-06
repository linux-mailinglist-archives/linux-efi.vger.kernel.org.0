Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C151DF6E
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbiEFTF5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiEFTF5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 15:05:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E227868313;
        Fri,  6 May 2022 12:02:12 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-002-247-254-212.2.247.pool.telefonica.de [2.247.254.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B87B01EC0426;
        Fri,  6 May 2022 21:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651863727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8fVcWLqPFG6/0kPKgTD+h7VgiMOQivyi/yzrWDL31E=;
        b=QcEfbINsxQXGmb/lPhWm6hiBU4SyfpGvhd0wkxxntZDP7ynpTevpNVvJIYEZzXegdL5Jhe
        dYv/chRkNgyID97Ya33eCDNS4Dgk1/2xJWPpbp9ozV/xUeWODkGvV6HLMzbqchi7qIJfp9
        kra0g1/NjXuMvYmH/3hRFkUuapJjZcc=
Date:   Fri, 06 May 2022 19:02:03 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>, daniel.gutson@eclypsium.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_0/8=5D_x86=3A_Show_in_sysfs_i?= =?US-ASCII?Q?f_a_memory_node_is_able_to_do_encryption?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com> <YnKr+aMf4PspDpHZ@zn.tnic> <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com> <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com> <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com> <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de> <6abea873-52a2-f506-b21b-4b567bee1874@intel.com> <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de> <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
Message-ID: <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On May 6, 2022 6:43:39 PM UTC, Dave Hansen <dave=2Ehansen@intel=2Ecom> wrot=
e:
>On 5/6/22 11:25, Boris Petkov wrote:
>> On May 6, 2022 6:14:00 PM UTC, Dave Hansen <dave=2Ehansen@intel=2Ecom>
>> wrote:
>>> But, this interface will *work* both for the uniform and
>>> non-uniform systems alike=2E
>> And what would that additional information that some "node" -
>> whatever "node" means nowadays - is not encrypted give you?
>
>Tying it to the node ties it to the NUMA ABIs=2E  For instance, it lets
>you say: "allocate memory with encryption capabilities" with a
>set_mempolicy() to nodes that are enumerated as encryption-capable=2E

I was expecting something along those lines=2E=2E=2E

>Imagine that we have a non-uniform system: some memory supports TDX (or
>SEV-SNP) and some doesn't=2E  QEMU calls mmap() to allocate some guest
>memory and then its ioctl()s to get its addresses stuffed into EPT/NPT=2E
> The memory might be allocated from anywhere, CPU_CRYPTO-capable or not=
=2E
> VM creation will fail because the (hardware-enforced) security checks
>can't be satisfied on non-CPU_CRYPTO memory=2E
>
>Userspace has no recourse to fix this=2E  It's just stuck=2E  In that cas=
e,
> the *kernel* needs to be responsible for ensuring that the backing
>physical memory supports TDX (or SEV)=2E
>
>This node attribute punts the problem back out to userspace=2E  It gives
>userspace the ability to steer allocations to compatible NUMA nodes=2E  I=
f
>something goes wrong, they can use other NUMA ABIs to inspect the
>situation, like /proc/$pid/numa_maps=2E

That's all fine and dandy but I still don't see the *actual*, real-life us=
e case of why something would request memory of particular encryption capab=
ilities=2E Don't get me wrong  - I'm not saying there are not such use case=
s - I'm saying we should go all the way and fully define properly  *why* we=
're doing this whole hoopla=2E

Remember - this all started with "i wanna say that mem enc is active" and =
now we're so far deep down the rabbit hole=2E=2E=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
