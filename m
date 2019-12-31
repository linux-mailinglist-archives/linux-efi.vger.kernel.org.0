Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0743112DB05
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLaSvA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 13:51:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:35419 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfLaSvA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Dec 2019 13:51:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 10:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,380,1571727600"; 
   d="scan'208";a="269961815"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Dec 2019 10:50:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1imMba-000BPs-Rw; Wed, 01 Jan 2020 02:50:58 +0800
Date:   Wed, 1 Jan 2020 02:50:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-efi@vger.kernel.org
Subject: [RFC PATCH efi] efi/x86: efi_old_memmap_phys_prolog() can be static
Message-ID: <20191231185046.unv4fm6jejz7nfjt@f53c9c00458a>
References: <202001010259.nnaop2UM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001010259.nnaop2UM%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Fixes: 68f6b351cf93 ("efi/x86: split off some old memmap handling into separate routines")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 efi_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index a72bbabbc5953..211899fb1ce2c 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -74,7 +74,7 @@ static void __init early_code_mapping_set_exec(int executable)
 
 void __init efi_old_memmap_phys_epilog(pgd_t *save_pgd);
 
-pgd_t * __init efi_old_memmap_phys_prolog(void)
+static pgd_t * __init efi_old_memmap_phys_prolog(void)
 {
 	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
 	pgd_t *save_pgd, *pgd_k, *pgd_efi;
