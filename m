Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A351DE7D
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352035AbiEFR66 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351577AbiEFR66 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 13:58:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B986D3AB;
        Fri,  6 May 2022 10:55:13 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-002-247-254-212.2.247.pool.telefonica.de [2.247.254.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 367B91EC01B5;
        Fri,  6 May 2022 19:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651859708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrS6zMRai2e5YLLJbn36HLgL1yxwpiepU+QWEjmX0NA=;
        b=oy+cicerrACsFn7WKW0lodO2FEe5WV4r9TEhbjCDKaBcAwZAlWHVNS8ucEFsvq6jCZ9Vhd
        WukviSu8bAQZfzmHpwH98RuQT1NF9lzEENQ8Uz9+K7re6b9/iWYWq+eSEVmiEiyLYXQc4b
        DwqLl2CqnSyUAcAokdFBagYxYISWJ9U=
Date:   Fri, 06 May 2022 17:55:05 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, daniel.gutson@eclypsium.com,
        "H. Peter Anvin" <hpa@zytor.com>, alex.bazhaniuk@eclypsium.com,
        hughsient@gmail.com, Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_0/8=5D_x86=3A_Show_in_sysfs_i?= =?US-ASCII?Q?f_a_memory_node_is_able_to_do_encryption?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com> <YnKr+aMf4PspDpHZ@zn.tnic> <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com> <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com> <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
Message-ID: <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
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

On May 6, 2022 4:00:57 PM UTC, Dan Williams <dan=2Ej=2Ewilliams@intel=2Ecom=
> wrote:
>On Fri, May 6, 2022 at 8:32 AM Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>>
>> On 5/6/22 05:44, Borislav Petkov wrote:
>> >> Dave Hansen pointed those out in a previuos patch serie, here is the
>> >> quote:
>> >>
>> >>> CXL devices will have normal RAM on them, be exposed as "System RAM=
" and
>> >>> they won't have encryption capabilities=2E  I think these devices w=
ere
>> >>> probably the main motivation for EFI_MEMORY_CPU_CRYPTO=2E
>> > So this would mean that if a system doesn't have CXL devices and has
>> > TME/SME/SEV-* enabled, then it is running with encrypted memory=2E
>> >
>> > Which would then also mean, you don't need any of that code - you onl=
y
>> > need to enumerate CXL devices which, it seems, do not support memory
>> > encryption, and then state that memory encryption is enabled on the
>> > whole system, except for the memory of those devices=2E
>>
>> CXL devices are just the easiest example to explain, but they are not
>> the only problem=2E
>>
>> For example, Intel NVDIMMs don't support TDX (or MKTME with integrity)
>> since TDX requires integrity protection and NVDIMMs don't have metadata
>> space available=2E
>>
>> Also, if this were purely a CXL problem, I would have expected this to
>> have been dealt with in the CXL spec alone=2E  But, this series is
>> actually driven by an ACPI spec=2E  That tells me that we'll see these
>> mismatched encryption capabilities in many more places than just CXL
>> devices=2E
>
>Yes, the problem is that encryption capabilities cut across multiple
>specifications=2E For example, you might need to consult a CPU
>vendor-specific manual, ACPI, EFI, PCI, and CXL specifications for a
>single security feature=2E

So here's the deal: we can say in the kernel that memory encryption is ena=
bled and active=2E  But then all those different devices and so on,  can or=
 cannot support encryption=2E IO devices do not support encryption either, =
afaict=2E And there you don't have node granularity etc=2E So you can't do =
this per node thing anyway=2E Or you do it and it becomes insufficient soin=
 after=2E

But that is not the question - they don't wanna say in fwupd whether every=
 transaction was encrypted or not - they wanna say that encryption is activ=
e=2E And that we can give them now=2E=20

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
