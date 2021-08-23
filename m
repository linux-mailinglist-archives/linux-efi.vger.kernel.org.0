Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F233F4479
	for <lists+linux-efi@lfdr.de>; Mon, 23 Aug 2021 06:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhHWEwy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Aug 2021 00:52:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhHWEwx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 23 Aug 2021 00:52:53 -0400
Received: from zn.tnic (p200300ec2f07d90037f6d6bcf935006e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d900:37f6:d6bc:f935:6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 457801EC0464;
        Mon, 23 Aug 2021 06:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629694326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c1G7QTpcEx3Qr+cJbGLD7TPXvN9RsA/K/gThPK83ye0=;
        b=Ck+qOI9Ub1piyF92cJ1Rj1I8T2Htrehc2lYwvWMzCZOXfnoaTLDafVfQ1j45Mu4VHpGKye
        9YOX1vzz2FoSzluNSKhf3WLDYIFyz/XZPlgl9BH5wxwphLSM4OYJTzozTKAZ1PgaidjC+I
        3z99tbaejNJLEA0DdcbbXothdDMBVyE=
Date:   Mon, 23 Aug 2021 06:52:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 24/36] x86/compressed/acpi: move EFI config
 table access to common code
Message-ID: <YSMpn14wu/5FsRiM@zn.tnic>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-25-brijesh.singh@amd.com>
 <YR42323cUxsbQo5h@zn.tnic>
 <20210819145831.42uszc4lcsffebzu@amd.com>
 <YR6QVh3qZUxqsyI+@zn.tnic>
 <20210819234258.drlyzowk7y3t5wnw@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819234258.drlyzowk7y3t5wnw@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 06:42:58PM -0500, Michael Roth wrote:
> In v5, I've simplified things to just call efi_find_vendor_table() once
> for ACPI_20_TABLE_GUID, then once for ACPI_TABLE_GUID if that's not
> available. So definitely doesn't sound like what you are suggesting here,
> but does at least simplify code and gets rid of the efi_foreach* stuff. But
> happy to rework things if you had something else in mind.

Ok, thanks. Lemme get to that version and I'll holler if something's
still bothering me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
