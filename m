Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A13B2F6F
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFXM5J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFXM5J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Jun 2021 08:57:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5FC061574;
        Thu, 24 Jun 2021 05:54:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c1e00b0ee742129e64455.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1e00:b0ee:7421:29e6:4455])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 935E01EC034B;
        Thu, 24 Jun 2021 14:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624539288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=exWGaN5nlDIIfjw6LKdL5i6bEdP3AlfmgKU5Qi35VZs=;
        b=OH1tJ1FWIwOyqk5pV85F5ISFN32aCDPduQ56E4e2jBVYcAbLhc0k5JTE+UAy+Gb/l4bjer
        2TbZqRl2XDUp7GrXFn0hfpBqzyIwDdJKoBHOLDBPQ3gyuslhsDz2N/IZaxZ/JW9Kqam6h6
        qOAkZxpCS9rabjOWu5AiS3lx0aUfhL0=
Date:   Thu, 24 Jun 2021 14:54:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <YNSAlJnXMjigpqu1@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-21-brijesh.singh@amd.com>
 <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624123447.zbfkohbtdusey66w@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 24, 2021 at 07:34:47AM -0500, Michael Roth wrote:
> Well, that's sufficient for the boot/compressed->uncompressed parameter
> passing, but wouldn't actual bootloaders still need something in
> setup_data/setup_header to pass in the CC blob (for things like non-EFI
> environments/containers)? I was under the impression that using
> boot_params directly was more of a legacy/ad-hoc thing, is that
> accurate?

/me goes and rereads your early mail.

I'm more confused.

You're talking about parsing an EFI table early which contains the
ccblob and in it is the CPUID page.

Now above you say, "non-EFI environments".

I'm guessing you want to support both so you want to either parse an EFI
table on EFI environments or pass the blob in a different way in non-EFI
envs. Yes, no?

Also, you want to pass the previously parsed CPUID page address to
kernel proper. For that I suggested to use boot_params.

What else?

How about you explain in a lot more detail what exactly the requirements
and the use cases are so that we can have a common base to discuss it
on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
