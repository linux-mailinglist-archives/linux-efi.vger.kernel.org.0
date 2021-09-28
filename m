Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47A41B97C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbhI1VmQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 17:42:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhI1VmP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 17:42:15 -0400
Received: from zn.tnic (p200300ec2f13b200371079131a9f19c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:3710:7913:1a9f:19c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 185C51EC06C1;
        Tue, 28 Sep 2021 23:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632865234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3zAlBZi1O1Z7iGiOtlzR59oObKF3oTwf3vRM6tWoLcY=;
        b=K5Ca7t9hqqMM2deF0li2lbysEHXsHTs91GSL2ZqKLhzfX9w19AiIGCNaZ3Y63sCu3hsepG
        fIbQEa5D8HQEE2RRoDDCLkqS/Fxfaghkv3CiOoHYu4QVTSTfUfcSzUHkFkeeRHlHYg9afU
        kuT2sPlWmWHkAbKxJ37GJ775LHgIgQc=
Date:   Tue, 28 Sep 2021 23:40:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v4 0/8] Implement generic cc_platform_has() helper
 function
Message-ID: <YVOLzMwyXP3ZSR0F@zn.tnic>
References: <20210928191009.32551-1-bp@alien8.de>
 <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
 <YVN7vPE/7jecXcJ/@zn.tnic>
 <7319b756-55dc-c4d1-baf6-4686f0156ac4@linux.intel.com>
 <YVOB3mFV1Kj3MXAs@zn.tnic>
 <695a3bf6-5382-68df-3ab5-8841b777fca2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695a3bf6-5382-68df-3ab5-8841b777fca2@linux.intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 28, 2021 at 02:01:57PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Yes. But, since the check is related to TDX, I just want to confirm whether
> you are fine with naming the function as intel_*().

Why is this such a big of a deal?!

There's amd_cc_platform_has() and intel_cc_platform_has() will be the
corresponding Intel version.

> Since this patch is going to have dependency on TDX code, I will include
> this patch in TDX patch set.

Ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
