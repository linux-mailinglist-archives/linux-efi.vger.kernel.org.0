Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516863BA96F
	for <lists+linux-efi@lfdr.de>; Sat,  3 Jul 2021 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGCQWb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Jul 2021 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGCQWa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Jul 2021 12:22:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AECC061762;
        Sat,  3 Jul 2021 09:19:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f289e0085c7d3fefeb66b8e.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:9e00:85c7:d3fe:feb6:6b8e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1282F1EC047F;
        Sat,  3 Jul 2021 18:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625329195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=upKFgpUh0zZ782nZABcY/RNBj8bd/OadOyw5te8iHZc=;
        b=NudzYXsG646/+XcrvCCfobxDIXDqoINAGQsj0E1AkwVZlvZjqXEC4Q/LmnHdK/BN54pmaw
        JFsqB2fy+zUTz07NLLpEzLpX8tb+BSpe+VA0CqnOJO8wCl7siWJe7RndUF0FD5wSiMEe/r
        qnuIbLGmBy99uqaqdSvureQd8IDQa2A=
Date:   Sat, 3 Jul 2021 18:19:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com, Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH Part1 RFC v3 22/22] virt: Add SEV-SNP guest driver
Message-ID: <YOCOIy1AW5RUfbx4@zn.tnic>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-23-brijesh.singh@amd.com>
 <YNxzJ2I3ZumTELLb@zn.tnic>
 <46499161-0106-3ae9-9688-0afd9076b28b@amd.com>
 <YN4DixahyShxyyCv@zn.tnic>
 <5b4d20db-3013-4411-03b9-708dd18dbe64@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b4d20db-3013-4411-03b9-708dd18dbe64@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 01, 2021 at 04:32:25PM -0500, Brijesh Singh wrote:
> The spec definition is present in include/linux/psp-sev.h but sometime
> we don't expose the spec defs as-is to userspace.

Why?

Having such undocumented and maybe unwarranted differences - I still
don't see a clear reason why - is calling for additional and unnecessary
confusion.

> Several SEV/SEV-SNP does not need to be exposed to the userspace,
> those which need to be expose we provide a bit modified Linux uapi for
> it, and for SEV drivers we choose "_user" prefix.

Is that documented somewhere?

Because "user" doesn't tell me it is a modified structure which is
different from the spec.

> e.g
> a spec definition for the PEK import in include/linux/psp-sev.h is:
> struct sev_data_pek_cert_import {
> 	u64 pdh_cert_address;  /* system physical address */
> 	u32 pdh_cert_len;
> 	u32 reserved;
> 	...
> };
> 
> But its corresponding userspace structure def in include/uapi/linux/psp-sev.h is:
> struct sev_user_data_pek_cert_import {
> 	__u64 pek_cert_uaddr; /* userspace address */
> 	__u32 pek_cert_len;
> 	...
> };

And the difference is a single "u32 reserved"?

Dunno, from where I'm standing this looks like unnecessary confusion to
me.

> The ioctl handling takes care of mapping from uaddr to pa and other
> things as required. So, I took similar approach for the SEV-SNP guest
> ioctl. In this particular case the guest request structure defined in
> the spec contains multiple field but many of those fields are managed
> internally by the kernel (e.g seqno, IV, etc etc).

Ok, multiple fields sounds like you wanna save on the data that is
shovelled between kernel and user space and then some of the fields
don't mean a thing for the user API. Ok.

But again, where is this documented and stated clear so that people are
aware?

Or are you assuming that since the user counterparts are in

include/uapi/linux/psp-sev.h
	^^^^

and it being an uapi header, then that should state that?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
