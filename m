Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAE174E28
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 16:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCAP6B (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 10:58:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42146 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAP6B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 10:58:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id z11so610372wro.9;
        Sun, 01 Mar 2020 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iroZ9Pow8ipGPXa1xqXyS4xbrWQ/m46THJdhapkwZPs=;
        b=HCQhYVjzECHNBFYfaOYgrLshl4w/1m8c+dZQ364hYNxIVguVcKk2RtlliqFNwRXzWT
         p8MBfqTtJNQDFQ0hfOI0e7uyIrJEC63D+Ji79SwTPHdtEcPjeOjJRFjEEUhmUn/KphLr
         69VOo4fbqmOBvLgRdk5Qj2pVEbqksJjjKS9gGSqjbq7I515MMDdRI/zFjH3k5xWBqVBj
         IPV38+4wCNvyPy5JLMxxO1eDp0KOfSSVERK6fSrvltLmh07BaNI2Ro6VcycIQgMgk/Yl
         BYvHztsSDd6Is6Ovao1Zv19TpF8Uo8GYsvyBup1TF+GHRofb+yLmU3f/Z+2vewQvR0IY
         zqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iroZ9Pow8ipGPXa1xqXyS4xbrWQ/m46THJdhapkwZPs=;
        b=Ypbn2i+6ZwPYego/VorX+fkfKos80PsSpKbi0Oxic50y1ngIUExWWGx3CrGTFYjz0S
         fBaEQ16y8Uj3hDMIdwcJoWuoKYfwSjyICTazzinfH+Jt2srISsD3gat0Lh73PceiK/zz
         9AunSxvnEeezpiG7X5mR/Sy9Yu+rhi/wH5Iaeq3DoOfUgZpTHV86hF4Zoo5q5QcmFjYC
         6c2zqKvj99oe3w5tKzJcGa9tnqN+s1jWEQCykkdKHZN7o18oK9akY5nzh672t/2+4Eyl
         mHgeeHMmwo3Ag4LUBAWCVvoNAavJv3nAi353eftOuRjPCwm0x97AOVm6fpwOhItTdawA
         7Kzg==
X-Gm-Message-State: APjAAAWRnQCk4jFVQEuggW77vTrjHrgYrUnBx0sdp1Mm9Qip1q+mvsX9
        URQPnL/3a+3G8N1cWA/gN6Kz9MQL
X-Google-Smtp-Source: APXvYqzf2dAKXnrWa85zHdtNOtLGTd2I3HDiJGeZMCNQtLRqVoSE/QuTdyn8SPzHqmG3yu64it04jw==
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr17088478wrx.142.1583078277700;
        Sun, 01 Mar 2020 07:57:57 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d89:1500:857:2082:e9c3:b57])
        by smtp.gmail.com with ESMTPSA id b16sm18257181wrq.14.2020.03.01.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 07:57:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust EFI entry to removing eboot.c
Date:   Sun,  1 Mar 2020 16:57:48 +0100
Message-Id: <20200301155748.4788-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit c2d0b470154c ("efi/libstub/x86: Incorporate eboot.c into libstub")
removed arch/x86/boot/compressed/eboot.[ch], but missed to adjust the
MAINTAINERS entry.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: arch/x86/boot/compressed/eboot.[ch]

Rectify EXTENSIBLE FIRMWARE INTERFACE (EFI) entry in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Ard, please pick this patch for your linux-next branch.
applies cleanly on next-20200228, do not apply on current master

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b04505e7c3..4ce510b8467a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6383,7 +6383,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 S:	Maintained
 F:	Documentation/admin-guide/efi-stub.rst
 F:	arch/*/kernel/efi.c
-F:	arch/x86/boot/compressed/eboot.[ch]
 F:	arch/*/include/asm/efi.h
 F:	arch/x86/platform/efi/
 F:	drivers/firmware/efi/
-- 
2.17.1

