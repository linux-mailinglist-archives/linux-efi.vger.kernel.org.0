Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336741B8A1
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 22:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbhI1Uur (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 16:50:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:10739 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242572AbhI1Uug (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 16:50:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="310352163"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="310352163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:48:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="554299062"
Received: from oogunmoy-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.221.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:48:48 -0700
Subject: Re: [PATCH v4 0/8] Implement generic cc_platform_has() helper
 function
To:     Borislav Petkov <bp@alien8.de>
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
References: <20210928191009.32551-1-bp@alien8.de>
 <80593893-c63b-d481-45f1-42a3a6fd762a@linux.intel.com>
 <YVN7vPE/7jecXcJ/@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7319b756-55dc-c4d1-baf6-4686f0156ac4@linux.intel.com>
Date:   Tue, 28 Sep 2021 13:48:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVN7vPE/7jecXcJ/@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/28/21 1:31 PM, Borislav Petkov wrote:
> On Tue, Sep 28, 2021 at 12:19:49PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Intel CC support patch is not included in this series. You want me
>> to address the issue raised by Joerg before merging it?
> 
> Did you not see my email to you today:
> 
> https://lkml.kernel.org/r/YVL4ZUGhfsh1QfRX@zn.tnic

Just read it. If you want to use cpuid_has_tdx_guest() directly in
cc_platform_has(), then you want to rename intel_cc_platform_has() to
tdx_cc_platform_has()?

> 
> ?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
