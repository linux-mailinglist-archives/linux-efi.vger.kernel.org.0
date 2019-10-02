Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1DAC8F46
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfJBRDz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 13:03:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfJBRDy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 13:03:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so20528331wrx.10
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2019 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNYLGJx+lu9+SgPr9a/2JABv2HQmtSq9Qr99wIga2I8=;
        b=rNrSpN2fIml21+JUO1szkLdGWyZora2ylQ6bw5F7f6ogf4DamBuc3Xq6GoKoTawH+G
         8Gn9nGylOrnQYYzu0IiorMdMNunHOEvIi7ZKh49gsQV9PUWdjCMMuxAd6zHDKao+Uu4X
         7npGmKdct0a0u8DCW7XocS5rpPhBi6hf6U5yZinYSbdal+++tjG2N9sLY9R9DtuMUEfr
         kjrazD0vJy1kDoTR3HufHNQLJ1J75VZU+KgunYObAvCkFJhzK18MT5ZH6Jp1dQ3SmXQ2
         +h8Mk4lFiAfMuMOu1URy375g2NLitC7Ymi2hmW027ZxoaBL3BZ4NcRkOxNMkhfR3z6EQ
         cWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNYLGJx+lu9+SgPr9a/2JABv2HQmtSq9Qr99wIga2I8=;
        b=o0EOd035+4Fs7nH/OCY3/svZhC5RRZ6S5ACAyE/n/Al1W0tBYzBT6DowflGQUU7oe7
         K3GH/jaRrWcgKRpf4d77fKQ/rEzSKvOy10i/kh+Urr2pn0dGNBEUqJYPSdB03akSgaR7
         xU7BpTz5YW3U1Dn3ckVOOpLbTe9VD2MsU8k0mFuDX0qvcTLZHoQ19bJlvONKnv+T6b82
         Q9Dn3li08X5lZhKxutqLSnutRtBTqXlAnf7cBi1+gkrMmn8sk4w9tJcmIeb0Pu2FjIyD
         Cp/H+youQ5b1hrMN0/OcDMBnJsOXjf7H8zXC7uLXu6b6U9tYNnXjFKC1UvXAg56aheca
         3ZLA==
X-Gm-Message-State: APjAAAU1EB3Et0vbHHGQ1z/08Bd3sDs6aeq//gzklTwPvoSxrYBYCe4d
        LqaQBKRb8ltJcxqx1dlq/hV7WPrOlPCFIAIJ
X-Google-Smtp-Source: APXvYqxzw0EIk5yjsnYERrcIwhF9r+RUPl1ghTs6gf7rl1+mx8FjpN331RcRW3IfXOwMM5mqABvN/g==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr3517743wrq.343.1570035831778;
        Wed, 02 Oct 2019 10:03:51 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:51 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 2/7] efivar/ssdt: don't iterate over EFI vars if no SSDT override was specified
Date:   Wed,  2 Oct 2019 18:58:59 +0200
Message-Id: <20191002165904.8819-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The kernel command line option efivar_ssdt= allows the name to be
specified of an EFI variable containing an ACPI SSDT table that should
be loaded into memory by the OS, and treated as if it was provided by
the firmware.

Currently, that code will always iterate over the EFI variables and
compare each name with the provided name, even if the command line
option wasn't set to begin with.

So bail early when no variable name was provided. This works around a
boot regression on the 2012 Mac Pro, as reported by Scott.

Fixes: 475fb4e8b2f4 ("efi / ACPI: load SSTDs from EFI variables")
Cc: <stable@vger.kernel.org> # v4.9+
Cc: Octavian Purdila <octavian.purdila@intel.com>
Tested-by: Scott Talbert <swt@techie.net>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8d3e778e988b..69f00f7453a3 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -267,6 +267,9 @@ static __init int efivar_ssdt_load(void)
 	void *data;
 	int ret;
 
+	if (!efivar_ssdt[0])
+		return 0;
+
 	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
 
 	list_for_each_entry_safe(entry, aux, &entries, list) {
-- 
2.20.1

