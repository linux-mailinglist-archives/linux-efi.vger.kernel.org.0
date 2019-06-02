Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669BC3247B
	for <lists+linux-efi@lfdr.de>; Sun,  2 Jun 2019 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFBRfY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Jun 2019 13:35:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52435 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBRfY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Jun 2019 13:35:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so1684725wms.2;
        Sun, 02 Jun 2019 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sWCRIklLFBXTt0bnRxaUiwVvT1YaJACTZVbU1fMH6B0=;
        b=nTLNQ6LVqWTjVjVFXbbHCRXLtHzWxrgWZsEvRmzv443UtD+7E1ZL3FaNviCNXMWMnB
         BuFAThv3eAagGfXPJMrNeVkGuUDhC+xyCChMTICvoXjplwiLv/vJPboFG7zLrB1V+tsC
         OzybnhIc4pWgKGkR8o9vxnrEgxbHyhj9TYH5Ei0QthXforwsrilanj9ZrbMpH0RDxkoU
         fbtQp7OsDQ8DJzXgzqJGb3t41bQjXsavy4890kj+br6yWyjYefgojxSD5S1bjzuyG20e
         M5ATFTpeCM8JjldkImG7L8y1XLqJhEtuVOeAP8VEM+CzJVag9wNNNhhX/9ou7ylu7rt8
         aXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=sWCRIklLFBXTt0bnRxaUiwVvT1YaJACTZVbU1fMH6B0=;
        b=nn65ds72tXj/FBshhwFjHBtPW8T4i++vG9C59Su8i2EyejvHZ4jsZq8J+srSS+CWmA
         a5BWhUQXlWMELMsYDbrMQnhvCY+O71TMuaYkMQSTYkDcOAaxMW3704ozjc5rB0Rlkc8F
         Mdk9hsSN+ueNLLTLs9v6A/TPTyMsQ+HBfQLNhu1nsEME19DchvHvWNbeZFoMWwIytCdq
         Li/mDn69LVAovWYYQxkiJJXCySXtxA09myWnZ+h7T6SDwvyYr1mqKnCtBvYm0brEzT8S
         jBeqEfPVo1r5XWW1zykWe50Kur4G6r/QrTA71BdtpyVs07Y5chTI+3/wIZX7TO2p5OS0
         5UfQ==
X-Gm-Message-State: APjAAAUsy7ET5RushX5JS4ZCRA246s/bAcgFBLDlgqlkKQmBd4yHBwsl
        DCn/diDyXlQ0mtD2C6yAjbdtwBR3
X-Google-Smtp-Source: APXvYqxwfEZx7GAXNNtdmdH4YIL4QNbAfi2S07GZ1+JcxoCWDyFAkHuCcmFgf8d7DiE6zsI/xP1Mlw==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr11772113wmd.75.1559496921973;
        Sun, 02 Jun 2019 10:35:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s14sm8613594wmh.7.2019.06.02.10.35.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 10:35:21 -0700 (PDT)
Date:   Sun, 2 Jun 2019 19:35:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <20190602173519.GA29372@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 88447c5b93d98be847f428c39ba589779a59eb83 efi: Allow the number of EFI configuration tables entries to be zero

Two EFI fixes: a quirk for weird systabs, plus add more robust error 
handling in the old 1:1 mapping code.

 Thanks,

	Ingo

------------------>
Gen Zhang (1):
      efi/x86/Add missing error handling to old_memmap 1:1 mapping code

Rob Bradford (1):
      efi: Allow the number of EFI configuration tables entries to be zero


 arch/x86/platform/efi/efi.c    | 2 ++
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 arch/x86/platform/efi/quirks.c | 3 +++
 drivers/firmware/efi/efi.c     | 3 +++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..a7189a3b4d70 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..08ce8177c3af 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,13 +84,15 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
-		return NULL;
+		return efi_mm.pgd;
 	}
 
 	early_code_mapping_set_exec(1);
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
@@ -138,10 +140,11 @@ pgd_t * __init efi_call_phys_prolog(void)
 		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 
-out:
 	__flush_tlb_all();
-
 	return save_pgd;
+out:
+	efi_call_phys_epilog(save_pgd);
+	return NULL;
 }
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index feb77777c8b8..632b83885867 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -513,6 +513,9 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 	void *p, *tablep;
 	struct efi_setup_data *data;
 
+	if (nr_tables == 0)
+		return 0;
+
 	if (!efi_setup)
 		return 0;
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..521a541d02ad 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -636,6 +636,9 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 	void *config_tables;
 	int sz, ret;
 
+	if (efi.systab->nr_tables == 0)
+		return 0;
+
 	if (efi_enabled(EFI_64BIT))
 		sz = sizeof(efi_config_table_64_t);
 	else
