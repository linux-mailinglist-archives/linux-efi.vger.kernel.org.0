Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941A4751E34
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jul 2023 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjGMKFh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjGMKFW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 06:05:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BC270B;
        Thu, 13 Jul 2023 03:05:19 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC72E1EC0874;
        Thu, 13 Jul 2023 12:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689242717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7Fga6nMHDneASJyJWOa5x3oZX4NUZq8wtQ0fIf5FLj4=;
        b=W52Gq0eGyy6yNbH6krdvGsssZlsvLb7eBA5g6ZLUqDKLYkwQAm8QfhZhGcx3zqz4BrN7Ij
        4l4BDqqiQTcVbr70vX2vUz3Hgrd0JDULRole3q68e2q6gx50rwHSnRFaVsoSIAZsf6ouxP
        BAD9mtJ14mnP8dG27LIcpioWnlkPa9o=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PPrSclreo3ew; Thu, 13 Jul 2023 10:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689242715; bh=7Fga6nMHDneASJyJWOa5x3oZX4NUZq8wtQ0fIf5FLj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4wQOL+pIIf61EeJSKTohfApZiu6Tin3+i2YS8q9H6pzBcgSq7Irq9K/mRsBETmUS
         jiWIku6eR2dFBvxbhEzEMTbGazY7+A/OzeWvrLhR/glAsvDNzkubay0Ny0d6o7bLvL
         nEuXhlr5oT/RdAIpkAiKKqNfVNDCOrJTSzaQ/WhwomO4P8DfrczJAWfvyt/ivnKwiu
         rBDb2rIOvCgpOE+MyQ5XJSDjW+KQP4UCqIIWg8S3qQ4hKja9pr7r+y1yRAid9nUovq
         ZRTp4MO3VXQyzRVnsQcRmWv+YvowxCQ901T+YW2FqyyzX+4HrkvG/a2XkU8dFMzKCe
         qtWdZ8FyzXKp4ek0xauEvkX30VGGfuu/1aVUDXIN1I7pVeDc6e/ddPP2bCrgS0qZ2l
         wCNmtxBZJzTT21+k0w3Yqv8RrlBt6lvrAjad7PvnCFaI7oPDcbwnrgqk8+cDn52BIL
         aKz/U3v+4ZaN75K6JYb8H+x7PpjtB66aG1YOPgrU0MnhBvemLna1NYumW0pzvb9uov
         jdRiTdR3VHEqKt3GTPup0AVH+7ROO0BISJIjsewZG61Km/yE5S1O9qUekAydF5noTs
         3VZXDVy+zGGwFo3oz8DdUP5Z5AMM5saQG96TNV3t2zWeiD+O6jfQ7L/yQzB2IqW8bj
         cfGF5yXKu6EBwZt/TOIoDuoc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B15540E0034;
        Thu, 13 Jul 2023 10:05:02 +0000 (UTC)
Date:   Thu, 13 Jul 2023 12:04:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tao Liu <ltao@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601072043.24439-1-ltao@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
>  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)

Ok, pls try this totally untested thing.

Thx.

---
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3c..fefe27b2af85 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -404,13 +404,20 @@ void sev_enable(struct boot_params *bp)
 	if (bp)
 		bp->cc_blob_address = 0;
 
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
 	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
+	/* Recheck the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
