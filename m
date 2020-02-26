Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE0170C11
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBZXAd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 18:00:33 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43777 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXAd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 18:00:33 -0500
Received: by mail-qk1-f175.google.com with SMTP id q18so1290568qki.10;
        Wed, 26 Feb 2020 15:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHYj+O/qh1kBo1YiRfJeU7Abu30ml9Md3owcr+1Ym3Y=;
        b=kKBXcECDEDCew1tb1DGtrfkb810VMYr6IEdrU7BqsTrh0F7f4EY208UtitLjRKxUxu
         qr+Zn9y7Rzarb2GDqhDtFfxbA4ptvMR4FSjukLQyGF2+d4xPiM/6mNU0sKaIK5U5PxvV
         091izlszbBqqR9yoFL9e0xOFhAW+C68jFnvjct4AC3pXCWgGGzGgOS0GOLkVTvT7YQpd
         PySzrWmWQ0p5H2ngr3PrDSAzOdQZdmMODhcOLNTuzKBPMsMdYaObKJCfnOy4jrHnlSUn
         jEu5tVBTiT+7HNcV/tD3+hPrNLLIalPQUiVO64pCFpnFQKyKW+rVXjByhERgXieTSl2n
         ymbw==
X-Gm-Message-State: APjAAAU22YQcj5nWDttMJXsXqU63hGDgxEh14hxW0TpxIoEKC3ZMDftM
        4DojjlrCgt452yyI/k1viIW4/FVwWyI=
X-Google-Smtp-Source: APXvYqxV5oNcZdY2AqXhQWx216TtudZgMXFIGqSFmEeMwhfm1WVUMMux2lHJ6K3hSO/KQnVyM6Ogng==
X-Received: by 2002:a05:620a:1088:: with SMTP id g8mr1869004qkk.66.1582758032389;
        Wed, 26 Feb 2020 15:00:32 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t2sm1965323qkc.31.2020.02.26.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:00:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Small fix to boot-time GDT handling
Date:   Wed, 26 Feb 2020 18:00:30 -0500
Message-Id: <20200226230031.3011645-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226204515.2752095-1-nivedita@alum.mit.edu>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ingo, I noticed a potential problem with the GDT handling code that I
had submitted. This patch (based on tip:efi/core) should address that.

Thanks.

Changes from v1: The 64-bit version had the same problem, fix that too.

Arvind Sankar (1):
  x86/boot/compressed: Fix reloading of GDTR post-relocation

 arch/x86/boot/compressed/head_32.S | 9 ++++-----
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.24.1

