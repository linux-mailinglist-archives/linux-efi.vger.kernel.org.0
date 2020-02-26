Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A971709F8
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBZUpS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 15:45:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46218 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBZUpS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 15:45:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so876707qkh.13;
        Wed, 26 Feb 2020 12:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQf5zd7/YhdOToeAJNkRelZw6x4Qcdbamv946AByH+U=;
        b=e/adtSQO+9aBCXa7M/MaAOv4ElqYz/wpv8QtPgVa5eGLWK5OHjLJHUJKOIDfqZU5Fy
         AzcD02O0+JKpfr8bMD4aHCK4f69B4T/K9NFXnDH3BvRSxe3+q3tiNMiu6RuB26aAvpfF
         uqI9d3N/SzOYKTAFy4QMRMquwxoGKMmdqp9bqj45slJl+Rf/oajK3v2cpPKF2/y5JRwc
         /8/nRR0qcXESJMPkU8b44AtmVkJEANXyjlB9aQhXTJB5a6PRoQ10M8cvT1ru3I11Gx+h
         B4f92K2bAA2+v+zp0+URoVYkwph1yo+uNTUGUUo9FDyEK3icONWq6Kt1hVR+0F5nJac6
         +yOA==
X-Gm-Message-State: APjAAAUTBl21/2ArZeG7NvB1fLuO17p2Acp8OYa0sh1Mi/pHlj6Qfm7q
        vXe2utWDqq7c8JethcT1ljHRd4I+QIc=
X-Google-Smtp-Source: APXvYqwEDq8Pw0VtdscjiLGrbQ4rTIOFi4L1CtxrHd22KXkTyDxYAiXYe1/AvO/R/uK2XW+BgN1KFQ==
X-Received: by 2002:a37:947:: with SMTP id 68mr1160077qkj.227.1582749917025;
        Wed, 26 Feb 2020 12:45:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f26sm1651452qtv.77.2020.02.26.12.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:45:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Small fix to boot-time GDT handling
Date:   Wed, 26 Feb 2020 15:45:14 -0500
Message-Id: <20200226204515.2752095-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226142713.GB3100@gmail.com>
References: <20200226142713.GB3100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ingo, I noticed a potential problem with the 32-bit GDT handling code
that I had submitted. This patch (based on tip:efi/core) should address
that.

Thanks.

Arvind Sankar (1):
  x86/boot/compressed/32: Fix reloading of GDTR post-relocation

 arch/x86/boot/compressed/head_32.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.24.1

