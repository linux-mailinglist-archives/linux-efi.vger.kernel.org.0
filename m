Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7153D9F9D
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2019 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395425AbfJPV4o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 17:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395417AbfJPV4o (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:44 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E8A21D7D;
        Wed, 16 Oct 2019 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263003;
        bh=8Em2bsmIAcI/tf3Ihod02Uq15PYbjOQsMAOdNwSUvTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcPXBAAKzTiqlPdXsQ6seV/3ICMFLT4Qpban1IyigTKtBzCfgt5P65YO37F3O3v7L
         115jhdnO1eOvCapNQ9BaQqyro7pZpDiSZHsimnEjBD2DlbvkVt3NAF4Lug3PEgGRwn
         a/Nxgs84SkUIknWDgtafhvNOTO2ig+7SHUOFlD0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Talbert <swt@techie.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 43/65] efivar/ssdt: Dont iterate over EFI vars if no SSDT override was specified
Date:   Wed, 16 Oct 2019 14:50:57 -0700
Message-Id: <20191016214832.914076532@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit c05f8f92b701576b615f30aac31fabdc0648649b upstream.

The kernel command line option efivar_ssdt= allows the name to be
specified of an EFI variable containing an ACPI SSDT table that should
be loaded into memory by the OS, and treated as if it was provided by
the firmware.

Currently, that code will always iterate over the EFI variables and
compare each name with the provided name, even if the command line
option wasn't set to begin with.

So bail early when no variable name was provided. This works around a
boot regression on the 2012 Mac Pro, as reported by Scott.

Tested-by: Scott Talbert <swt@techie.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.9+
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Dave Young <dyoung@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Fixes: 475fb4e8b2f4 ("efi / ACPI: load SSTDs from EFI variables")
Link: https://lkml.kernel.org/r/20191002165904.8819-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/efi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -266,6 +266,9 @@ static __init int efivar_ssdt_load(void)
 	void *data;
 	int ret;
 
+	if (!efivar_ssdt[0])
+		return 0;
+
 	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
 
 	list_for_each_entry_safe(entry, aux, &entries, list) {


