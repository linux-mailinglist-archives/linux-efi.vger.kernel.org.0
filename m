Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA352C473
	for <lists+linux-efi@lfdr.de>; Wed, 18 May 2022 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiERUXN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 May 2022 16:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242489AbiERUXM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 May 2022 16:23:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4328023F380;
        Wed, 18 May 2022 13:23:11 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A6DB1EC03AD;
        Wed, 18 May 2022 22:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652905385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kiP3CsxtGQt01zP15K1kxQEOaD5Egp8vF87dwKeKYL8=;
        b=cfQxvj7SaeAWQCQZgNDAuheCGIvEi/o+BwUKpBXlQCx98/tzP4S1cxFICjF3KCwG83r3mO
        tMgfYDjND/mIZQ0JHd2wD1TBCBrPqUWd4BMCiw0dw8M3Gm2435TeQVnQPiM3tnaj4Ww1+6
        C2VzC/gIXuOFBVRrGEMeRkVj1TG1SAw=
Date:   Wed, 18 May 2022 22:23:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <YoVVpRBGp23ZOMVf@zn.tnic>
References: <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
 <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
 <CAD2FfiHe3hCSNHEA0mSWPbH4LEWhj+FgxkhO83U1GgYEJR6wrw@mail.gmail.com>
 <YoSlzqSGLrQ+jdnD@zn.tnic>
 <CAPcyv4jv52nv=Q=gm783ysU8D56iHzh9-UJrqqkgUve0f_kyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4jv52nv=Q=gm783ysU8D56iHzh9-UJrqqkgUve0f_kyZw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 18, 2022 at 11:28:49AM -0700, Dan Williams wrote:
> On Wed, May 18, 2022 at 12:53 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, May 16, 2022 at 09:39:06AM +0100, Richard Hughes wrote:
> > > This is still something consumers need; at the moment users have no
> > > idea if data is *actually* being encrypted.
> >
> > As it was already pointed out - that's in /proc/cpuinfo.
> 
> For TME you still need to compare it against the EFI memory map as
> there are exclusion ranges for things like persistent memory. Given
> that persistent memory can be forced into volatile "System RAM"
> operation by various command line options and driver overrides, you
> need to at least trim the assumptions of what is encrypted to the
> default "conventional memory" conveyed by platform firmware / BIOS.

So SME/SEV also has some exceptions to which memory is encrypted and
which not. Doing device IO would be one example where you simply cannot
encrypt.

But that wasn't the original question - the original question is whether
memory encryption is enabled on the system.

Now, the nodes way of describing what is encrypted and what not is
not enough either when you want to determine whether an arbitrary
transaction is being done encrypted or not. You can do silly things
as mapping a page decrypted even if the underlying hardware can do
encryption and every other page is encrypted and still think that that
page is encrypted too. But that would be a lie.

So the whole problem space needs to be specified with a lot more detail
as to what exact information userspace is going to need and how we can
provide it to it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
