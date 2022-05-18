Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CA52B449
	for <lists+linux-efi@lfdr.de>; Wed, 18 May 2022 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiERHwz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 May 2022 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiERHwx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 May 2022 03:52:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC361D0E4;
        Wed, 18 May 2022 00:52:53 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 903F21EC0666;
        Wed, 18 May 2022 09:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652860367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gUc3S3Gcatvt5eEi+z7OKNcWBrt7L039MRb0Fapa9rg=;
        b=WyIYPFDdDPaRV9LCi7UZ3Z46r1RXVEfi+ihmhgCPEF7cdGk8pAW8wQ7lt8OqOVoz05Wd1w
        XQHMnhFBhTguaXpbCYdLe23xw93WsOXOkhfY+ShAaok+Za9L9zn8bXRvCHYIlJQgyTPR7N
        gsMLIlVEozKbPeChEI3wjYU/oc/WLTY=
Date:   Wed, 18 May 2022 09:52:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
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
        alex.bazhaniuk@eclypsium.com, Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <YoSlzqSGLrQ+jdnD@zn.tnic>
References: <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic>
 <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
 <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
 <CAD2FfiHe3hCSNHEA0mSWPbH4LEWhj+FgxkhO83U1GgYEJR6wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD2FfiHe3hCSNHEA0mSWPbH4LEWhj+FgxkhO83U1GgYEJR6wrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 16, 2022 at 09:39:06AM +0100, Richard Hughes wrote:
> This is still something consumers need; at the moment users have no
> idea if data is *actually* being encrypted.

As it was already pointed out - that's in /proc/cpuinfo.

> I think Martin has done an admirable job going down the rabbit hole
> to add this functionality in the proper manner -- so it's actually
> accurate and useful for other use cases to that of fwupd.

Only after I scratched the surface as to why this is needed.

> At the moment my professional advice to people asking about Intel
> memory encryption

Well, what kind of memory encryption? Host, guest?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
