Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974E041B85C
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhI1Udo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhI1Udo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 16:33:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA5CC06161C;
        Tue, 28 Sep 2021 13:32:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b200371079131a9f19c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:3710:7913:1a9f:19c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 052251EC0758;
        Tue, 28 Sep 2021 22:32:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632861122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qbX+tgbw05504BlKd+vjCTQM+czUsH5nYZVV4FM0DG8=;
        b=PQ4PKcJl3Lyadkflmx+j1VA5OiwXAdXTaEvbm7ew7wHmPI94m7AJwZOzgrvxFt4MxHlIwN
        LDaduODsYvATrWtH3svQYbrndDcAuYcHl9AIp7EwQK4gZbGRwjVVHLxwvW78GbTZv51eLK
        ObLlpU/8EnxkbEHepMYe/Hen7N4ZKDo=
Date:   Tue, 28 Sep 2021 22:31:56 +0200
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
Message-ID: <YVN7vPE/7jecXcJ/@zn.tnic>
References: <20210928191009.32551-1-bp@alien8.de>
 <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 28, 2021 at 12:19:49PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Intel CC support patch is not included in this series. You want me
> to address the issue raised by Joerg before merging it?

Did you not see my email to you today:

https://lkml.kernel.org/r/YVL4ZUGhfsh1QfRX@zn.tnic

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
