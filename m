Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3E41B6F9
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbhI1TMD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbhI1TMB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 15:12:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8EC06161C;
        Tue, 28 Sep 2021 12:10:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b20078349fd04295260b.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7834:9fd0:4295:260b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 394BC1EC067E;
        Tue, 28 Sep 2021 21:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632856218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=GCnPTyFFnPSLiurFbR8iLYuDvIM/ZylVNPX31loBg1U=;
        b=PgysYne7oRqig38Wg3EljqkqTDirqwkPAzRh5HiMtoiV+jJbJHTdrk3tVWUMlO9AliXjoI
        QYxOn8YzMjaQP86uf/uYhrT2bAzVSbUmsndVFpCY5/rue9vmSI/Ae0ek/NbRQmmnCheeB1
        XkhBbUOn81FbH/ZWzpMG01inkCayyvg=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Subject: [PATCH v4 0/8] Implement generic cc_platform_has() helper function
Date:   Tue, 28 Sep 2021 21:10:01 +0200
Message-Id: <20210928191009.32551-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's v4 of the cc_platform_has() patchset with feedback incorporated.

I'm going to route this through tip if there are no objections.

Thx.

Tom Lendacky (8):
  x86/ioremap: Selectively build arch override encryption functions
  arch/cc: Introduce a function to check for confidential computing
    features
  x86/sev: Add an x86 version of cc_platform_has()
  powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
  x86/sme: Replace occurrences of sme_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_active() with cc_platform_has()
  x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
  treewide: Replace the use of mem_encrypt_active() with
    cc_platform_has()

 arch/Kconfig                                 |  3 +
 arch/powerpc/include/asm/mem_encrypt.h       |  5 --
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 +
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++
 arch/powerpc/platforms/pseries/svm.c         |  5 +-
 arch/s390/include/asm/mem_encrypt.h          |  2 -
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/io.h                    |  8 ++
 arch/x86/include/asm/kexec.h                 |  2 +-
 arch/x86/include/asm/mem_encrypt.h           | 12 +--
 arch/x86/kernel/Makefile                     |  6 ++
 arch/x86/kernel/cc_platform.c                | 69 +++++++++++++++
 arch/x86/kernel/crash_dump_64.c              |  4 +-
 arch/x86/kernel/head64.c                     |  9 +-
 arch/x86/kernel/kvm.c                        |  3 +-
 arch/x86/kernel/kvmclock.c                   |  4 +-
 arch/x86/kernel/machine_kexec_64.c           | 19 +++--
 arch/x86/kernel/pci-swiotlb.c                |  9 +-
 arch/x86/kernel/relocate_kernel_64.S         |  2 +-
 arch/x86/kernel/sev.c                        |  6 +-
 arch/x86/kvm/svm/svm.c                       |  3 +-
 arch/x86/mm/ioremap.c                        | 18 ++--
 arch/x86/mm/mem_encrypt.c                    | 55 ++++--------
 arch/x86/mm/mem_encrypt_identity.c           |  9 +-
 arch/x86/mm/pat/set_memory.c                 |  3 +-
 arch/x86/platform/efi/efi_64.c               |  9 +-
 arch/x86/realmode/init.c                     |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
 drivers/gpu/drm/drm_cache.c                  |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
 drivers/iommu/amd/init.c                     |  7 +-
 drivers/iommu/amd/iommu.c                    |  3 +-
 drivers/iommu/amd/iommu_v2.c                 |  3 +-
 drivers/iommu/iommu.c                        |  3 +-
 fs/proc/vmcore.c                             |  6 +-
 include/linux/cc_platform.h                  | 88 ++++++++++++++++++++
 include/linux/mem_encrypt.h                  |  4 -
 kernel/dma/swiotlb.c                         |  4 +-
 40 files changed, 310 insertions(+), 129 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
 create mode 100644 arch/x86/kernel/cc_platform.c
 create mode 100644 include/linux/cc_platform.h

-- 
2.29.2

